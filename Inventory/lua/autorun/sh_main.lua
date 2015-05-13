//
/*

	Shared main script
	
	Nautical & Anarchy
	
	5/8/2015
*/

local class = {}

// DarkRP Weapons
class["weapon_ak472"] = "AK-47"
class["weapon_ak47custom"] = "AK-47"
class["weapon_deagle2"] = "Deagle"
class["weapon_fiveseven2"] = "Five Seven"
class["weapon_glock2"] = "Glock"
class["weapon_m42"] = "M4"
class["weapon_mac102"] = "Mac10"
class["weapon_mp52"] = "MP5"
class["weapon_p2282"] = "P228"
class["weapon_pumpshotgun2"] = "Pump Shotgun"
class["ls_sniper"] = "Silenced Sniper"

// DarkRP Utilities
class["weapon_keypadchecker"] = "Keypad Checker"
class["arrest_stick"] = "Arrest Baton"
class["door_ram"] = "Battering Ram"
class["keys"] = "Keys"
class["lockpick"] = "Lockpick"
class["med_kit"] = "Medkit"
class["pocket"] = "Pocket"
class["stunstick"] = "Stunstick"
class["unarrest_stick"] = "Unarrest Baton"
class["weaponchecker"] = "Weapon Checker"

// HL2
class["weapon_357"] = "357"
class["weapon_ar2"] = "Pulse Rifle"
class["weapon_bugbait"] = "Bug Bait"
class["weapon_crossbow"] = "Crossbow"
class["weapon_crowbar"] = "Crowbar"
class["weapon_frag"] = "Frag"
class["weapon_physcannon"] = "Gravity Gun"
class["weapon_pistol"] = "Pistol"
class["weapon_rpg"] = "RPG"
class["weapon_shotgun"] = "Shotgun"
class["weapon_slam"] = "Slam"
class["weapon_smg1"] = "SMG"
class["weapon_stunstick"] = "Stunstick"

// Other
class["gmod_camera"] = "Camera"
class["weapon_fists"] = "Fists"
class["manhack_welder"] = "Manhack Gun"
class["weapon_medkit"] = "Medkit"
class["weapon_physgun"] = "Physics Gun"
class["gmod_tool"] = "Tool Gun"

// FAS 2

// M9K

// Custom
class["grapplinghook"] = "Grappling Hook"


// Global methods 
function ReplaceClassWithName(wepclass)
	return class[wepclass]
end
