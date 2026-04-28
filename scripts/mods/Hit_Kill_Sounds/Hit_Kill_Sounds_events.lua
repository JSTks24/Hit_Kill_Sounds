local HKS = get_mod("Hit_Kill_Sounds")

HKS.HitKillSoundsEvents = {}

-- 引入DamageSettings用于dot伤害检测
local DamageSettings = require("scripts/settings/damage/damage_settings")
-- 引入AttackSettings用于攻击结果检测
local AttackSettings = require("scripts/settings/damage/attack_settings")

-- 内联音效配置
local HIT_SOUNDS = {
    BF1 = {
        normal = {
            "HitSounds/BF1/hitsound_bf1_normal1.wav",
            "HitSounds/BF1/hitsound_bf1_normal2.wav",
            "HitSounds/BF1/hitsound_bf1_normal3.wav",
            "HitSounds/BF1/hitsound_bf1_normal4.wav",
            "HitSounds/BF1/hitsound_bf1_normal5.wav",
        },
        headshot = {
            "HitSounds/BF1/hitsound_bf1_headshot1.wav",
            "HitSounds/BF1/hitsound_bf1_headshot2.wav",
            "HitSounds/BF1/hitsound_bf1_headshot3.wav",
            "HitSounds/BF1/hitsound_bf1_headshot4.wav",
            "HitSounds/BF1/hitsound_bf1_headshot5.wav",
        },
    },
    BF2042 = {
        normal = {
            "HitSounds/BF2042/hitsound_bf2042_normalbase1.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase2.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase3.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase4.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase5.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase6.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase7.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase8.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase9.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase10.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase11.wav",
            "HitSounds/BF2042/hitsound_bf2042_normalbase12.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd1.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd2.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd3.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd4.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd5.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd6.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd7.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd8.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd9.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd10.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd11.wav",
            "HitSounds/BF2042/hitsound_bf2042_normaladd12.wav",
        },
        headshot = {
            "HitSounds/BF2042/hitsound_bf2042_headshotadd1.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd2.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd3.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd4.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd5.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd6.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd7.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd8.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd9.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd10.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd11.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd12.wav",
            "HitSounds/BF2042/hitsound_bf2042_headshotadd13.wav",
        },
    },
    BF6 = {
        normal = {
            "HitSounds/BF6/hit/h_bf6_normal_01.wav",
            "HitSounds/BF6/hit/h_bf6_normal_02.wav",
            "HitSounds/BF6/hit/h_bf6_normal_03.wav",
            "HitSounds/BF6/hit/h_bf6_normal_04.wav",
            "HitSounds/BF6/hit/h_bf6_normal_05.wav",
            "HitSounds/BF6/hit/h_bf6_normal_06.wav",
            "HitSounds/BF6/hit/h_bf6_normal_07.wav",
            "HitSounds/BF6/hit/h_bf6_normal_08.wav",
            "HitSounds/BF6/hit/h_bf6_normal_09.wav",
            "HitSounds/BF6/hit/h_bf6_normal_10.wav",
            "HitSounds/BF6/hit/h_bf6_normal_11.wav",
            "HitSounds/BF6/hit/h_bf6_normal_12.wav",
            "HitSounds/BF6/hit/h_bf6_normal_13.wav",
            "HitSounds/BF6/hit/h_bf6_normal_14.wav",
            "HitSounds/BF6/hit/h_bf6_normal_15.wav",
            "HitSounds/BF6/add/h_bf6_add_01.wav",
            "HitSounds/BF6/add/h_bf6_add_02.wav",
            "HitSounds/BF6/add/h_bf6_add_03.wav",
            "HitSounds/BF6/add/h_bf6_add_04.wav",
            "HitSounds/BF6/add/h_bf6_add_05.wav",
            "HitSounds/BF6/add/h_bf6_add_06.wav",
            "HitSounds/BF6/add/h_bf6_add_07.wav",
            "HitSounds/BF6/add/h_bf6_add_08.wav",
            "HitSounds/BF6/add/h_bf6_add_09.wav",
            "HitSounds/BF6/add/h_bf6_add_10.wav",
            "HitSounds/BF6/add/h_bf6_add_11.wav",
            "HitSounds/BF6/add/h_bf6_add_12.wav",
            "HitSounds/BF6/add/h_bf6_add_13.wav",
        },
        headshot = {
            "HitSounds/BF6/headshot/h_bf6_headshot_01.wav",
            "HitSounds/BF6/headshot/h_bf6_headshot_02.wav",
            "HitSounds/BF6/headshot/h_bf6_headshot_03.wav",
            "HitSounds/BF6/headshot/h_bf6_headshot_04.wav",
            "HitSounds/BF6/headshot/h_bf6_headshot_05.wav",
            "HitSounds/BF6/headshot/h_bf6_headshot_06.wav",
            "HitSounds/BF6/headshot/h_bf6_headshot_07.wav",
            "HitSounds/BF6/headshot/h_bf6_headshot_08.wav",
        },
    },
    BFV = {
        normal = {
            "HitSounds/BFV/hitsound_bfv_normal1.wav",
            "HitSounds/BFV/hitsound_bfv_normal2.wav",
            "HitSounds/BFV/hitsound_bfv_normal3.wav",
            "HitSounds/BFV/hitsound_bfv_normal4.wav",
            "HitSounds/BFV/hitsound_bfv_normal5.wav",
            "HitSounds/BFV/hitsound_bfv_normal6.wav",
            "HitSounds/BFV/hitsound_bfv_normal7.wav",
            "HitSounds/BFV/hitsound_bfv_normal8.wav",
            "HitSounds/BFV/hitsound_bfv_normal9.wav",
            "HitSounds/BFV/hitsound_bfv_normal10.wav",
            "HitSounds/BFV/hitsound_bfv_normal11.wav",
            "HitSounds/BFV/hitsound_bfv_normal12.wav",
        },
        headshot = {
            "HitSounds/BFV/hitsound_bfv_headshot1.wav",
            "HitSounds/BFV/hitsound_bfv_headshot2.wav",
            "HitSounds/BFV/hitsound_bfv_headshot3.wav",
            "HitSounds/BFV/hitsound_bfv_headshot4.wav",
            "HitSounds/BFV/hitsound_bfv_headshot5.wav",
        },
    },
    CODBO6 = {
        normal = {
            "HitSounds/CODBO6/hitsound_BO6_normal1.wav",
            "HitSounds/CODBO6/hitsound_BO6_normal2.wav",
        },
        headshot = {
            "HitSounds/CODBO6/hitsound_BO6_headshot.wav",
        },
    },
    CODMW2019 = {
        normal = {
            "HitSounds/CODMW2019/hitsound_MW2019.wav",
        },
        headshot = {
            "HitSounds/CODMW2019/hitsound_MW2019.wav",
        },
    },
    CODMW3 = {
        normal = {
            "HitSounds/CODMW3/hitsound_MW3.wav",
        },
        headshot = {
            "HitSounds/CODMW3/hitsound_MW3.wav",
        },
    },
    TheFinals = {
        normal = {
            "HitSounds/TheFinals/hitsound_TheFinals_normal2.wav",
            "HitSounds/TheFinals/hitsound_TheFinals_normal3.wav",
            "HitSounds/TheFinals/hitsound_TheFinals_normal4.wav",
        },
        headshot = {
            "HitSounds/TheFinals/hitsound_TheFinals_headshot1.wav",
            "HitSounds/TheFinals/hitsound_TheFinals_headshot2.wav",
            "HitSounds/TheFinals/hitsound_TheFinals_headshot3.wav",
            "HitSounds/TheFinals/hitsound_TheFinals_headshot4.wav",
            "HitSounds/TheFinals/hitsound_TheFinals_headshot5.wav",
        },
    },
}

local KILL_SOUNDS = {
    BF1 = {
        normal = {
            "KillSounds/BF1/killsound_bf1_normal.wav",
        },
        headshot = {
            "KillSounds/BF1/killsound_bf1_headshot.wav",
        },
    },
    BF2042 = {
        normal = {
            "KillSounds/BF2042/killsound_bf2042_normal1.wav",
            "KillSounds/BF2042/killsound_bf2042_normal2.wav",
            "KillSounds/BF2042/killsound_bf2042_normal3.wav",
            "KillSounds/BF2042/killsound_bf2042_normal4.wav",
            "KillSounds/BF2042/killsound_bf2042_normal5.wav",
            "KillSounds/BF2042/killsound_bf2042_normal6.wav",
        },
        headshot = {
            "KillSounds/BF2042/killsound_bf2042_headshot1.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot2.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot3.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot4.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot5.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot6.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot7.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot8.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot9.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot10.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot11.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot12.wav",
            "KillSounds/BF2042/killsound_bf2042_headshot13.wav",
        },
    },
    BF6 = {
        normal = {
            "KillSounds/BF6/k_bf6_normal_v1_01.wav",
            "KillSounds/BF6/k_bf6_normal_v1_02.wav",
            "KillSounds/BF6/k_bf6_normal_v1_03.wav",
            "KillSounds/BF6/k_bf6_normal_v2_01.wav",
            "KillSounds/BF6/k_bf6_normal_v2_02.wav",
            "KillSounds/BF6/k_bf6_normal_v2_03.wav",
        },
        headshot = {
            "KillSounds/BF6/k_bf6_headshot_v1_01.wav",
            "KillSounds/BF6/k_bf6_headshot_v1_02.wav",
            "KillSounds/BF6/k_bf6_headshot_v1_03.wav",
            "KillSounds/BF6/k_bf6_headshot_v1_04.wav",
            "KillSounds/BF6/k_bf6_headshot_v2_01.wav",
            "KillSounds/BF6/k_bf6_headshot_v2_02.wav",
            "KillSounds/BF6/k_bf6_headshot_v2_03.wav",
            "KillSounds/BF6/k_bf6_headshot_v2_04.wav",
        },
    },
    BFV = {
        normal = {
            "KillSounds/BFV/killsound_bfv_normal.wav",
        },
        headshot = {
            "KillSounds/BFV/killsound_bfv_headshot1.wav",
            "KillSounds/BFV/killsound_bfv_headshot2.wav",
            "KillSounds/BFV/killsound_bfv_headshot3.wav",
            "KillSounds/BFV/killsound_bfv_headshot4.wav",
            "KillSounds/BFV/killsound_bfv_headshot5.wav",
            "KillSounds/BFV/killsound_bfv_headshot6.wav",
            "KillSounds/BFV/killsound_bfv_headshot7.wav",
            "KillSounds/BFV/killsound_bfv_headshot8.wav",
            "KillSounds/BFV/killsound_bfv_headshot9.wav",
            "KillSounds/BFV/killsound_bfv_headshot10.wav",
            "KillSounds/BFV/killsound_bfv_headshotadd.wav",
        },
    },
    CODBO6 = {
        normal = {
            "KillSounds/CODBO6/killsound_BO6_normal.wav",
        },
        headshot = {
            "KillSounds/CODBO6/killsound_BO6_headshot1.wav",
            "KillSounds/CODBO6/killsound_BO6_headshot2.wav",
            "KillSounds/CODBO6/killsound_BO6_headshot3.wav",
        },
    },
    CODMW2019 = {
        normal = {
            "KillSounds/CODMW2019/Killsound_MW2019_kill.wav",
        },
        headshot = {
            "KillSounds/CODMW2019/Killsound_MW2019_headshot.wav",
        },
    },
    CODMW3 = {
        normal = {
            "KillSounds/CODMW3/Killsound_MW3_normal.wav",
        },
        headshot = {
            "KillSounds/CODMW3/Killsound_MW3_headshot.wav",
        },
    },
    TheFinals = {
        normal = {
            "KillSounds/TheFinals/killsound_TheFinals_normal.wav",
        },
        headshot = {
            "KillSounds/TheFinals/killsound_TheFinals_headshot.wav",
        },
    },
}

-- 命中间隔控制（秒）
-- 射速过快的武器如果间隔太短会导致请求堆积或播放异常
local HIT_COOLDOWN = 0.08
local last_hit_time = 0

-- 记录unit是否是爆头击杀（用于死亡时判断）
local unit_headshot_kills = {}

-- 去重表：防止AttackReportManager和Damage.deal_damage双重hook导致重复播放
local recent_attacks = {}
local ATTACK_DEDUP_TIME = 0.5  -- 500ms内的相同攻击视为重复

-- 击杀去重表：确保每个unit只播放一次击杀音效
local recent_kills = {}
local KILL_DEDUP_TIME = 0.5  -- 500ms内同一个unit的击杀只播放一次

-- 目标类型检测函数
-- target_setting: "all" | "elite" | "special" | "elite_special_boss"
local function is_target_valid_for_hit(breed_or_nil, target_setting)
    if not target_setting or target_setting == "all" then
        return true
    end

    if not breed_or_nil then
        return false
    end

    local tags = breed_or_nil.tags
    if not tags then
        return false
    end

    if target_setting == "elite" then
        return tags.elite == true
    elseif target_setting == "special" then
        return tags.special == true
    elseif target_setting == "elite_special_boss" then
        return tags.elite == true or tags.special == true or tags.monster == true or tags.captain == true
    end

    return true
end

local function is_target_valid_for_kill(breed_or_nil, target_setting)
    if not target_setting or target_setting == "all" then
        return true
    end

    if not breed_or_nil then
        return false
    end

    local tags = breed_or_nil.tags
    if not tags then
        return false
    end

    if target_setting == "elite" then
        return tags.elite == true
    elseif target_setting == "special" then
        return tags.special == true
    elseif target_setting == "elite_special_boss" then
        return tags.elite == true or tags.special == true or tags.monster == true or tags.captain == true
    end

    return true
end

-- 音效播放通道
local TRACKS = {
    HIT_NORMAL = 1,
    HIT_HEADSHOT = 2,
    KILL_NORMAL = 3,
    KILL_HEADSHOT = 4,
}

local function get_random_sound(sounds)
    if not sounds or #sounds == 0 then
        return nil
    end
    return sounds[math.random(#sounds)]
end

local function play_hit_sound(is_headshot)
    local game = HKS:get("hit_game") or "BF1"
    local volume = HKS:get("hit_volume") or 100
    local sound_type = is_headshot and "headshot" or "normal"
    local sounds = HIT_SOUNDS[game]

    if not sounds then
        HKS:warning("Hit_Kill_Sounds: 未找到游戏 " .. game .. " 的命中音效")
        return
    end

    local sound_list = sounds[sound_type]
    if not sound_list or #sound_list == 0 then
        sound_list = sounds.normal
        if not sound_list or #sound_list == 0 then
            return
        end
    end

    local sound_file = get_random_sound(sound_list)
    if sound_file then
        local track = is_headshot and TRACKS.HIT_HEADSHOT or TRACKS.HIT_NORMAL
        HKS.HitKillSoundsPlayer.play_file(sound_file, track, volume)
    end
end

local function play_kill_sound(is_headshot)
    local game = HKS:get("kill_game") or "BF1"
    local volume = HKS:get("kill_volume") or 100
    local sound_type = is_headshot and "headshot" or "normal"
    local sounds = KILL_SOUNDS[game]

    if not sounds then
        HKS:warning("Hit_Kill_Sounds: 未找到游戏 " .. game .. " 的击杀音效")
        return
    end

    local sound_list = sounds[sound_type]
    if not sound_list or #sound_list == 0 then
        sound_list = sounds.normal
        if not sound_list or #sound_list == 0 then
            return
        end
    end

    local sound_file = get_random_sound(sound_list)
    if sound_file then
        local track = is_headshot and TRACKS.KILL_HEADSHOT or TRACKS.KILL_NORMAL
        HKS.HitKillSoundsPlayer.play_file(sound_file, track, volume)
    end
end

local function can_play_hit()
    local current_time = Managers.time:time("main")
    if current_time - last_hit_time >= HIT_COOLDOWN then
        last_hit_time = current_time
        return true
    end
    return false
end

-- Hook管理器
local hooks = {}
local silenced = {}

HKS.HitKillSoundsEvents.silence_sounds = function(patterns)
    if type(patterns) == "string" then
        silenced[patterns] = true
        return
    end
    for _, sound_name in ipairs(patterns) do
        silenced[sound_name] = true
    end
end

HKS.HitKillSoundsEvents.unsilence_sounds = function(patterns)
    if type(patterns) == "string" and silenced[patterns] then
        silenced[patterns] = nil
        return
    end
    for _, sound_name in ipairs(patterns) do
        if silenced[sound_name] then
            silenced[sound_name] = nil
        end
    end
end

HKS.HitKillSoundsEvents.is_sound_silenced = function(sound_name)
    for pattern in pairs(silenced) do
        if sound_name:match(pattern) then
            return true
        end
    end
    return false
end

HKS.HitKillSoundsEvents.hook_sound = function(pattern, callback)
    if not hooks[pattern] then
        hooks[pattern] = {}
        setmetatable(hooks[pattern], {})
    end
    hooks[pattern]["HKS"] = callback
end

local SOUND_TYPE = table.enum(
    "2d_sound",
    "3d_sound",
    "start_stop_event",
    "external_sound",
    "source_sound",
    "unit_sound",
    "unknown_userdata_sound"
)

local sound_type_map = {
    ["nil"] = SOUND_TYPE["2d_sound"],
    ["boolean"] = SOUND_TYPE["start_stop_event"],
    ["number"] = SOUND_TYPE["source_sound"],
    ["Vector3"] = SOUND_TYPE["3d_sound"],
    ["Unit"] = SOUND_TYPE["unit_sound"],
}

local function get_userdata_type(userdata)
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

local function run_hooks(sound_type, sound_name, position_or_unit_or_id, optional_a, optional_b, flow_unit)
    for pattern, pattern_data in pairs(hooks) do
        local pattern_meta = getmetatable(hooks[pattern])

        if sound_name:match(pattern) then
            for _, fun in pairs(pattern_data) do
                local delta = pattern_meta._last_run and (Managers.time:time("main") - pattern_meta._last_run) or nil

                setmetatable(hooks[pattern], {
                    _last_run = Managers.time:time("main"),
                })

                return fun(sound_type, sound_name, delta, position_or_unit_or_id, optional_a, optional_b, flow_unit)
            end
        end
    end
end

-- 处理攻击结果的内部函数（供add_attack_result和Damage.deal_damage共同使用）
local function handle_attack_result(damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, is_critical_strike)
    -- 只处理有效伤害
    if not damage or damage <= 0 then
        return
    end

    -- 去重检查：防止AttackReportManager和Damage.deal_damage双重hook导致重复播放
    local dedup_key = tostring(attacked_unit) .. "_" .. tostring(attack_result) .. "_" .. tostring(damage)
    local current_time = Managers.time:time("main")
    if recent_attacks[dedup_key] and current_time - recent_attacks[dedup_key] < ATTACK_DEDUP_TIME then
        return  -- 忽略重复攻击
    end
    recent_attacks[dedup_key] = current_time

    -- 检查是否是本地玩家攻击
    local local_player = Managers.player and Managers.player:local_player_safe(1)
    if not local_player or not local_player.player_unit then
        return
    end

    -- AttackReportManager传递的attacking_unit实际上是attacking_unit_owner_unit（玩家unit）
    -- Damage.deal_damage传递的attacking_unit是武器/弹头，需要用attacking_unit_owner_unit判断
    -- 这里attacking_unit应该已经是玩家unit（来自AttackReportManager的情况）
    -- 如果不等于本地玩家unit，则不处理
    if attacking_unit ~= local_player.player_unit then
        return
    end

    -- DoT伤害类型检测（通过damage_profile名称判断）
    -- AttackReportManager不传递damage_type，需要通过damage_profile名称来检测DoT
    local is_dot_damage = false
    if damage_profile and damage_profile.name then
        local profile_name = damage_profile.name:lower()
        if profile_name:find("bleed") or profile_name:find("burn") or profile_name:find("fire") or
           profile_name:find("toxin") or profile_name:find("corruption") or profile_name:find("grimoire") or
           profile_name:find("electrocution") or profile_name:find("warpfire") then
            is_dot_damage = true
        end
    end

    -- 检查是否启用dot伤害命中音效
    local enable_dot_hit = HKS:get("hit_dot")
    if is_dot_damage and not enable_dot_hit then
        return
    end

    -- 获取breed信息
    local unit_data_extension = ScriptUnit.has_extension(attacked_unit, "unit_data_system")
    local breed_or_nil = unit_data_extension and unit_data_extension:breed()

    -- 如果是击杀
    if attack_result == AttackSettings.attack_results.died then
        -- 击杀去重检查：确保每个unit只播放一次击杀音效
        local kill_key = tostring(attacked_unit)
        local current_time = Managers.time:time("main")
        if recent_kills[kill_key] and current_time - recent_kills[kill_key] < KILL_DEDUP_TIME then
            -- 忽略重复击杀
            return
        end
        recent_kills[kill_key] = current_time

        -- 使用hit_weakspot参数判断是否是爆头击杀
        local is_kill_headshot = hit_weakspot == true

        -- 检查目标类型是否有效
        local kill_target_setting = HKS:get("kill_target") or "all"
        if not is_target_valid_for_kill(breed_or_nil, kill_target_setting) then
            -- 清除记录
            unit_headshot_kills[attacked_unit] = nil
            return
        end

        -- 播放击杀音效（所有类型：精英/特殊/怪物/小怪）
        play_kill_sound(is_kill_headshot)
        -- 清除记录
        unit_headshot_kills[attacked_unit] = nil
        return
    end

    -- 检查是否是有效命中结果
    local valid_results = {
        [AttackSettings.attack_results.damaged] = true,
        [AttackSettings.attack_results.toughness_absorbed] = true,
        [AttackSettings.attack_results.toughness_absorbed_melee] = true,
        [AttackSettings.attack_results.toughness_broken] = true,
    }
    if not valid_results[attack_result] then
        return
    end

    -- 检查目标类型是否有效
    local hit_target_setting = HKS:get("hit_target") or "all"
    if not is_target_valid_for_hit(breed_or_nil, hit_target_setting) then
        return
    end

    -- hit_weakspot表示是否命中弱点
    local is_weakspot = hit_weakspot == true

    -- 如果是weakspot命中，记录下来用于死亡时判断是否是爆头击杀
    -- 如果不是weakspot命中，清除该unit的爆头记录
    if is_weakspot then
        unit_headshot_kills[attacked_unit] = true
    else
        unit_headshot_kills[attacked_unit] = nil
    end

    -- 播放命中音效
    if can_play_hit() then
        play_hit_sound(is_weakspot)
    end
end

-- 初始化Damage hook来实现精确命中检测
-- 使用AttackReportManager来在多人模式下也能正确捕获命中事件
HKS.HitKillSoundsEvents.init_damage_hooks = function()
    -- Hook add_attack_result: 在服务器/主机上调用，处理所有攻击
    -- 同时也在客户端上被rpc_add_attack_result调用
    HKS:hook(CLASS.AttackReportManager, "add_attack_result", function(func, self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, is_critical_strike, ...)
        -- 调用原始函数
        func(self, damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, is_critical_strike, ...)

        handle_attack_result(damage_profile, attacked_unit, attacking_unit, attack_direction, hit_world_position, hit_weakspot, damage, attack_result, attack_type, damage_efficiency, is_critical_strike)
    end)

    -- Hook Damage.deal_damage 来处理本地玩家的攻击（因为AttackReportManager不处理本地玩家的攻击）
    -- 在多人模式下，本地玩家的攻击不会调用AttackReportManager:add_attack_result（只在服务器/主机上调用）
    -- 所以需要直接hook Damage.deal_damage来捕获本地玩家的攻击
    local Damage = require("scripts/utilities/attack/damage")
    HKS:hook(Damage, "deal_damage", function(func, unit, breed_or_nil, attacking_unit, attacking_unit_owner_unit, attack_result, attack_type, damage_profile, damage, permanent_damage, tougness_damage, hit_actor, attack_direction, hit_zone_name, herding_template_or_nil, is_critical_strike, damage_type, hit_world_position_or_nil, wounds_shape, instakill, damage_absorbed, ...)
        -- 调用原始函数
        func(unit, breed_or_nil, attacking_unit, attacking_unit_owner_unit, attack_result, attack_type, damage_profile, damage, permanent_damage, tougness_damage, hit_actor, attack_direction, hit_zone_name, herding_template_or_nil, is_critical_strike, damage_type, hit_world_position_or_nil, wounds_shape, instakill, damage_absorbed, ...)

        -- 只处理有效伤害
        if not damage or damage <= 0 then
            return
        end

        -- 检查是否是本地玩家攻击
        local local_player = Managers.player and Managers.player:local_player_safe(1)
        if not local_player or not local_player.player_unit then
            return
        end

        -- 使用attacking_unit_owner_unit判断是否是本地玩家（这是真正的玩家unit）
        -- attacking_unit可能是武器或弹头，而attacking_unit_owner_unit才是真正的玩家
        if attacking_unit_owner_unit ~= local_player.player_unit then
            return
        end

        -- 如果是击杀
        if attack_result == AttackSettings.attack_results.died then
            -- 击杀去重检查：确保每个unit只播放一次击杀音效
            local kill_key = tostring(unit)
            local current_time = Managers.time:time("main")
            if recent_kills[kill_key] and current_time - recent_kills[kill_key] < KILL_DEDUP_TIME then
                return  -- 忽略重复击杀
            end
            recent_kills[kill_key] = current_time

            -- 直接使用hit_zone_name判断是否是爆头击杀
            local is_kill_headshot = false
            if hit_zone_name and breed_or_nil and breed_or_nil.hit_zone_weakspot_types then
                local weakspot_type = breed_or_nil.hit_zone_weakspot_types[hit_zone_name]
                is_kill_headshot = weakspot_type ~= nil and weakspot_type ~= "shield"
            end

            -- 检查目标类型是否有效
            local kill_target_setting = HKS:get("kill_target") or "all"
            if not is_target_valid_for_kill(breed_or_nil, kill_target_setting) then
                unit_headshot_kills[unit] = nil
                return
            end

            -- 播放击杀音效
            play_kill_sound(is_kill_headshot)
            unit_headshot_kills[unit] = nil
            return
        end

        -- 检查是否是有效命中结果
        local valid_results = {
            [AttackSettings.attack_results.damaged] = true,
            [AttackSettings.attack_results.toughness_absorbed] = true,
            [AttackSettings.attack_results.toughness_absorbed_melee] = true,
            [AttackSettings.attack_results.toughness_broken] = true,
        }
        if not valid_results[attack_result] then
            return
        end

        -- 检查目标类型是否有效
        local hit_target_setting = HKS:get("hit_target") or "all"
        if not is_target_valid_for_hit(breed_or_nil, hit_target_setting) then
            return
        end

        -- 判断是否是弱点命中
        local is_weakspot = false
        if hit_zone_name and breed_or_nil and breed_or_nil.hit_zone_weakspot_types then
            local weakspot_type = breed_or_nil.hit_zone_weakspot_types[hit_zone_name]
            is_weakspot = weakspot_type ~= nil and weakspot_type ~= "shield"
        end

        -- dot伤害类型检测（通过damage_type和damage_profile名称双重判断）
        local is_dot_damage = false
        -- 首先尝试使用damage_type检测（更精确）
        local dot_damage_types = {
            [DamageSettings.damage_types.bleeding] = true,
            [DamageSettings.damage_types.burning] = true,
            [DamageSettings.damage_types.toxin] = true,
            [DamageSettings.damage_types.corruption] = true,
            [DamageSettings.damage_types.grimoire] = true,
            [DamageSettings.damage_types.electrocution] = true,
            [DamageSettings.damage_types.warpfire] = true,
        }
        if damage_type and dot_damage_types[damage_type] then
            is_dot_damage = true
        end
        -- 如果damage_type没有检测到，尝试使用damage_profile名称检测
        if not is_dot_damage and damage_profile and damage_profile.name then
            local profile_name = damage_profile.name:lower()
            if profile_name:find("bleed") or profile_name:find("burn") or profile_name:find("fire") or
               profile_name:find("toxin") or profile_name:find("corruption") or profile_name:find("grimoire") or
               profile_name:find("electrocution") or profile_name:find("warpfire") then
                is_dot_damage = true
            end
        end

        -- 检查是否启用dot伤害命中音效
        local enable_dot_hit = HKS:get("hit_dot")
        if is_dot_damage and not enable_dot_hit then
            return
        end

        -- 如果是weakspot命中，记录下来
        if is_weakspot then
            unit_headshot_kills[unit] = true
        else
            unit_headshot_kills[unit] = nil
        end

        -- 播放命中音效
        if can_play_hit() then
            play_hit_sound(is_weakspot)
        end
    end)
end

HKS.HitKillSoundsEvents.init_wwise_hooks = function()
    HKS:hook(
        CLASS.WwiseWorld,
        "trigger_resource_event",
        function(fun, wwise_world, wwise_event_name, position_or_unit_or_id, optional_a, optional_b)
            local var_type = get_userdata_type(position_or_unit_or_id) or type(position_or_unit_or_id)
            local sound_type = sound_type_map[var_type] or var_type

            local hook_result = run_hooks(sound_type, wwise_event_name, position_or_unit_or_id, optional_a, optional_b, Application.flow_callback_context_unit())
            if hook_result == false then
                return
            end

            local sound_is_silenced = HKS.HitKillSoundsEvents.is_sound_silenced(wwise_event_name)

            if sound_is_silenced then
                return
            end

            if sound_type == SOUND_TYPE["2d_sound"] then
                return fun(wwise_world, wwise_event_name)
            elseif sound_type == SOUND_TYPE["3d_sound"] then
                return fun(wwise_world, wwise_event_name, position_or_unit_or_id)
            elseif sound_type == SOUND_TYPE["start_stop_event"] then
                return fun(wwise_world, wwise_event_name, position_or_unit_or_id, optional_a, optional_b)
            elseif sound_type == SOUND_TYPE["source_sound"] then
                return fun(wwise_world, wwise_event_name, position_or_unit_or_id)
            elseif sound_type == SOUND_TYPE["unit_sound"] then
                return fun(wwise_world, wwise_event_name, position_or_unit_or_id, optional_a)
            end
        end
    )

    HKS:hook(
        DialogueSystemWwise,
        "trigger_vorbis_external_event",
        function(fun, self, sound_event, sound_source, file_path, wwise_source_id)
            local sound_type = SOUND_TYPE.external_sound
            local sound_name = file_path:gsub("wwise/externals/", "")

            local hook_result = run_hooks(sound_type, sound_name, wwise_source_id, sound_event, sound_source, Application.flow_callback_context_unit())
            if hook_result == false then
                return
            end

            return fun(self, sound_event, sound_source, file_path, wwise_source_id)
        end
    )
end

HKS.HitKillSoundsEvents.register_kill_hooks = function()
    -- 击杀音效hook
    -- 注意：击杀音效现在由Damage hook处理（因为可以获取更准确的unit引用和爆头信息）
    -- 这里只hook原声音效事件，返回true让原声音效继续播放
    -- 如果需要禁用原声音效，可以返回false

    HKS.HitKillSoundsEvents.hook_sound("play_elite_killed", function()
        -- 击杀音效已由Damage hook处理，这里不做任何操作
        return true
    end)

    HKS.HitKillSoundsEvents.hook_sound("play_special_killed", function()
        -- 击杀音效已由Damage hook处理，这里不做任何操作
        return true
    end)

    HKS.HitKillSoundsEvents.hook_sound("play_monster_killed", function()
        -- 击杀音效已由Damage hook处理，这里不做任何操作
        return true
    end)
end

return HKS.HitKillSoundsEvents
