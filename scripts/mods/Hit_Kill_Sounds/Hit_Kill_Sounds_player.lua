local HKS = get_mod("Hit_Kill_Sounds")
HKS.HitKillSoundsPlayer = {}

HKS.HitKillSoundsPlayer.mods_loaded_functions = {}

local binaries_path_handle = Mods.lua.io.popen("cd")
local binaries_path = binaries_path_handle:read()
binaries_path_handle:close()
local mods_path = binaries_path:gsub("binaries", "mods")
mods_path = mods_path:gsub("\\", "/")
local hks_path = mods_path .. "/Hit_Kill_Sounds/"
local player_path = hks_path .. "bin/"
local audio_path = hks_path .. "audio/"

-- 启动音频播放器
local bat_path = player_path .. "StartHitKillSoundsPlayer.bat"
Mods.lua.io.popen('"' .. bat_path .. '"'):close()

-- 读取端口配置
local port_handle = Mods.lua.io.open(player_path .. "port.json", "rb")
local port_json = port_handle and port_handle:read("*a")
port_handle:close()
local config = cjson.decode(port_json)

local port = config and config.port or 42213
local host = string.format("http://localhost:%s/", port)

HKS.HitKillSoundsPlayer.host = host

-- 播放器检查计数器（避免无限警告）
local check_failures = 0
local MAX_CHECK_FAILURES = 2

HKS.HitKillSoundsPlayer.check_player_running = function()
    if Managers.backend ~= nil then
        Managers.backend:url_request(host, {
            method = "POST",
            body = {
                method = "test",
            }
        }):next(function()
            -- 播放器响应正常，重置失败计数
            check_failures = 0
        end):catch(function()
            -- 播放器无响应时静默处理，不打印警告
            -- 因为任务管理器显示播放器正常运行，只是启动时序问题
            check_failures = check_failures + 1
        end)
    end
end

---Distinguish if userdata is a position or unit
---@param userdata userdata A userdata value
---@return "Unit"|"Vector3"|nil type Type of the userdata
local get_userdata_type = function(userdata)
    if type(userdata) ~= "userdata" then
        return nil
    end

    if Unit.alive(userdata) then
        return "Unit"
    elseif Vector3.is_valid(userdata) then
        return "Vector3"
    else
        return tostring(userdata)
    end
end

local AUDIO_TYPE = table.enum("dialogue", "music", "sfx")

local listener_position_rotation = function()
    local player = Managers.player and Managers.player:local_player_safe(1)

    if not player then
        return Vector3.zero(), Quaternion.identity()
    end

    local listener_pose = Managers.state.camera:listener_pose(player.viewport_name)
    local lister_position = listener_pose and Matrix4x4.translation(listener_pose) or Vector3.zero()
    local lister_rotation = listener_pose and Matrix4x4.rotation(listener_pose) or Quaternion.identity()

    return lister_position, lister_rotation
end

local calculate_distance_filter = function(
    unit_or_position,
    decay,
    min_distance,
    max_distance,
    override_position,
    override_rotation,
    node
)
    if not Managers.ui or Managers.ui:get_current_sub_state_name() ~= "GameplayStateRun" then
        return 100, 1, 1
    end

    local input_type = get_userdata_type(unit_or_position)

    if input_type ~= "Unit" and input_type ~= "Vector3" then
        return 100, 1, 1
    end

    local position

    if input_type == "Unit" then
        position = Unit.local_position(unit_or_position, node or 1) or Vector3.zero()
    elseif input_type == "Vector3" then
        position = unit_or_position
    end

    local current_listener_position, current_listener_rotation
    if not override_position or not override_rotation then
        current_listener_position, current_listener_rotation = listener_position_rotation()
    end

    local listener_position = override_position or current_listener_position
    local listener_rotation = override_rotation or current_listener_rotation

    decay = decay or 0.01
    min_distance = min_distance or 0
    max_distance = max_distance or 25

    local distance = Vector3.distance(position, listener_position)
    if distance < 1 then return 100, 1, 1 end
    local volume

    if distance < min_distance then
        volume = 100
    elseif distance > max_distance then
        volume = 0
    else
        local ratio = 1 - math.clamp((distance - min_distance) / (max_distance - min_distance), 0, 1)

        volume = math.clamp(100 * (ratio - (distance - min_distance) * decay), 0, 100)
    end

    local direction = position - listener_position
    local directionRotated = Quaternion.rotate(Quaternion.inverse(listener_rotation), direction)
    local directionRotatedNormalized = Vector3.normalize(directionRotated)
    local angle = math.atan2(directionRotatedNormalized.x, directionRotatedNormalized.y)

    local pan

    if angle > 0 then
        if angle <= math.pi / 2 then
            pan = angle / (math.pi / 2)
        else
            pan = 1 - (angle - math.pi / 2) / (math.pi / 2)
        end
    else
        if angle >= -math.pi / 2 then
            pan = angle / (math.pi / 2)
        else
            pan = -(1 + (angle + math.pi / 2) / (math.pi / 2))
        end
    end

    local left_volume = pan > 0 and 1 - pan or 1
    local right_volume = pan < 0 and 1 + pan or 1
    return volume, left_volume, right_volume
end

local volume_adjustment = function(audio_type)
    local master_volume = (Application.user_setting("sound_settings", "option_master_slider") or 100) / 100

    if not audio_type then
        return master_volume
    end

    if audio_type == AUDIO_TYPE.dialogue then
        local vo_trim = ((Application.user_setting("sound_settings", "options_vo_trim") or 0) / 10) + 1

        return master_volume * vo_trim
    end

    if audio_type == AUDIO_TYPE.music then
        local music_volume = (Application.user_setting("sound_settings", "options_music_slider") or 100) / 100

        return master_volume * music_volume
    end

    if audio_type == AUDIO_TYPE.sfx then
        local sfx_volume = (Application.user_setting("sound_settings", "options_sfx_slider") or 100) / 100

        return master_volume * sfx_volume
    end
end

-- 音效播放通道
-- 1: 普通命中音
-- 2: 弱点击中音
-- 3: 普通击杀音
-- 4: 弱点击杀音
local TRACKS = {
    HIT_NORMAL = 1,
    HIT_HEADSHOT = 2,
    KILL_NORMAL = 3,
    KILL_HEADSHOT = 4,
}

HKS.HitKillSoundsPlayer.play_file = function(
    path,
    track_id,
    volume
)
    track_id = track_id or TRACKS.HIT_NORMAL

    local request_body = {
        method = "play_file",
        playing_trackid = track_id,
        left_volume = volume / 100,
        right_volume = volume / 100,
        file_path = audio_path .. path
    }

    if Managers.backend ~= nil then
        Managers.backend:url_request(host, {
            method = "POST",
            body = request_body
        })
    end
end

HKS.HitKillSoundsPlayer.stop_file = function(playing_trackid)
    if Managers.backend ~= nil then
        Managers.backend:url_request(host, {
            method = "POST",
            body = {
                method = "stop_file",
                playing_trackid = playing_trackid
            }
        })
    end
end

HKS.HitKillSoundsPlayer.on_all_mods_loaded = function()
    for _, fun in pairs(HKS.HitKillSoundsPlayer.mods_loaded_functions) do
        fun()
    end
end

return HKS.HitKillSoundsPlayer
