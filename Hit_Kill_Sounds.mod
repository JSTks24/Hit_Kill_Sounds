return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Hit_Kill_Sounds` encountered an error loading the Darktide Mod Framework.")

		new_mod("Hit_Kill_Sounds", {
			mod_script       = "Hit_Kill_Sounds/scripts/mods/Hit_Kill_Sounds/Hit_Kill_Sounds",
			mod_data         = "Hit_Kill_Sounds/scripts/mods/Hit_Kill_Sounds/Hit_Kill_Sounds_data",
			mod_localization = "Hit_Kill_Sounds/scripts/mods/Hit_Kill_Sounds/Hit_Kill_Sounds_localization",
		})
	end,
	packages = {},
}
