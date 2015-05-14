//
/*

	Shared main script
	
	Nautical & Anarchy
	
	5/8/2015
*/


local pickupWhitelist = {

	"spawned_weapon",
	"durgz_alcohol",
	"durgz_aspirin",
	"durgz_cigarette",
	"durgz_cocaine",
	"durgz_heroine",
	"durgz_lsd",
	"durgz_weed",
	"durgz_mushroom",
	"durgz_pcp",
	"durgz_water",
}

function CheckEntity(class)
	
	if table.HasValue(pickupWhitelist, class) then
		return true
	else
		return false
	end

end

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

// Durgz
class["durgz_alcohol"] = "Alcohol"
class["durgz_aspirin"] = "Aspirin"
class["durgz_cigarette"] = "Cigarette"
class["durgz_cocaine"] = "Cocain"
class["durgz_heroine"] = "Heroine"
class["durgz_lsd"] = "LSD"
class["durgz_weed"] = "Mary Jane"
class["durgz_mushroom"] = "Mushroom"
class["durgz_pcp"] = "PCP"
class["durgz_water"] = "Water"

// Other
class["gmod_camera"] = "Camera"
class["weapon_fists"] = "Fists"
class["manhack_welder"] = "Manhack Gun"
class["weapon_medkit"] = "Medkit"
class["weapon_physgun"] = "Physics Gun"
class["gmod_tool"] = "Tool Gun"

// FAS 2
class["fas2_ak12"] = "AK-12"
class["fas2_ak47"] = "AK-47"
class["fas2_ak74"] = "AK-74"
class["fas2_ammobox"] = "Ammobox"
class["fas2_an94"] = "AN-94"
class["fas2_dv2"] = "DV2"
class["fas2_famas"] = "Famas"
class["fas2_g36c"] = "G36C"
class["fas2_g3"] = "G3A3"
class["fas2_deagle"] = "Deagle"
class["fas2_galil"] = "Galil"
class["fas2_uzi"] = "Uzi"
class["fas2_ifak"] = "Infantry Medkit"
class["fas2_ks23"] = "KS-23"
class["fas2_mac11"] = "M11A1"
class["fas2_m14"] = "M14"
class["fas2_m1911"] = "M1911"
class["fas2_m21"] = "M21"
class["fas2_m24"] = "M24"
class["fas2_m3s90"] = "M3S90"
class["fas2_m4a1"] = "M4A1"
class["fas2_m67"] = "M67"
class["fas2_m79"] = "M79"
class["fas2_m82"] = "M82"
class["fas2_machete"] = "Machete"
class["fas2_mp5a5"] = "MP5A5"
class["fas2_mp5k"] = "MP5K"
class["fas2_mp5sd6"] = "MP5SD6"
class["fas2_ots33"] = "OTs-33 Pernach"
class["fas2_p226"] = "P226"
class["fas2_pp19"] = "PP-19"
class["fas2_ragingbull"] = "Raging Bull"
class["fas2_rem870"] = "Remington"
class["fas2_rpk"] = "RPK-47"
class["fas2_rk95"] = "Sako RK-95"
class["fas2_sg550"] = "SG 550"
class["fas2_sg552"] = "SG 552"
class["fas2_sks"] = "SKS"
class["fas2_sr25"] = "SR-25"
class["fas2_toz34"] = "TOZ-34"

// CSS:Realistic
class["weapon_real_cs_pumpshotgun"] = "Benelli M3"
class["weapon_real_cs_xm1014"] = "Benelli M4"
class["weapon_real_cs_m4a1"] = "M4A1"
class["weapon_real_cs_desert_eagle"] = "Deagle"
class["weapon_real_cs_elites"] = "Barettas"
class["weapon_real_cs_grenade"] = "Explosive Grenade"
class["weapon_real_cs_famas"] = "Famas"
class["weapon_real_cs_flash"] = "Flash Grenade"
class["weapon_real_cs_five-seven"] = "Five Seven"
class["weapon_real_cs_p90"] = "P90"
class["weapon_real_cs_galil"] = "Galil"
class["weapon_real_cs_glock18"] = "Glock-18"
class["weapon_real_cs_g3sg1"] = "G3SG1"
class["weapon_real_cs_mp5a5"] = "MP5A5"
class["weapon_real_cs_ump_45"] = "UMP-45"
class["weapon_real_cs_usp"] = "USP"
class["weapon_real_cs_mac10"] = "MAC-10"
class["weapon_real_cs_ak47"] = "AK47"
class["weapon_real_cs_knife"] = "Knife"
class["weapon_real_cs_m249"] = "M249 SAW"
class["weapon_real_cs_sg550"] = "SG 550 Sniper"
class["weapon_real_cs_sg552"] = "SG 552"
class["weapon_real_cs_p228"] = "P228"
class["weapon_real_cs_smoke"] = "Smoke Grenade"
class["weapon_real_cs_aug"] = "AUG A1"
class["weapon_real_cs_scout"] = "Scout Sniper"
class["weapon_real_cs_tmp"] = "TMP"
class["weapon_real_cs_awp"] = "AWP"

// M9K
class["m9k_winchester73"] = "Winchester 73"
class["m9k_acr"] = "ACR"
class["m9k_ak47"] = "AK-47"
class["m9k_ak74"] = "AK-74"
class["m9k_amd65"] = "AMD 65"
class["m9k_an94"] = "AN-94"
class["m9k_val"] = "AS VAL"
class["m9k_f2000"] = "F2000"
class["m9k_famas"] = "Famas"
class["m9k_fal"] = "FN FAL"
class["m9k_g36"] = "G36"
class["m9k_m416"] = "M416"
class["m9k_g3a3"] = "G3A3"
class["m9k_l85"] = "L85"
class["m9k_m14sp"] = "M14"
class["m9k_m16a4_acog"] = "M16A4"
class["m9k_m4a1"] = "M4A1"
class["m9k_scar"] = "SCAR"
class["m9k_vikhr"] = "Vikhr"
class["m9k_auga3"] = "AUG A3"
class["m9k_tar21"] = "TAR-21"
class["m9k_ares_shrike"] = "Ares Shrike"
class["m9k_fg42"] = "FG 42"
class["m9k_minigun"] = "Minigun"
class["m9k_m1918bar"] = "M1918 BAR"
class["m9k_m249lmg"] = "M249 LMG"
class["m9k_m60"] = "M60"
class["m9k_pkm"] = "PKM"
class["m9k_colt1911"] = "Colt 1911"
class["m9k_coltpython"] = "Colt Python"
class["m9k_deagle"] = "Deagle"
class["m9k_glock"] = "Glock-18"
class["m9k_hk45"] = "HK45C"
class["m9k_m29satan"] = "M29 Satan"
class["m9k_m92beretta"] = "M92 Beretta"
class["m9k_luger"] = "P08 Luger"
class["m9k_ragingbull"] = "Raging Bull"
class["m9k_scoped_taurus"] = "Raging Bull(S)"
class["m9k_remington1858"] = "Remington 1858"
class["m9k_model3russian"] = "M3 Russian"
class["m9k_model500"] = "M500"
class["m9k_model627"] = "M627"
class["m9k_sig_p229r"] = "P229R"
class["m9k_m3"] = "Benelli M3"
class["m9k_browningauto5"] = "Browning Auto"
class["m9k_dbarrel"] = "Double Barrel"
class["m9k_ithacam37"] = "Ithaca M37"
class["m9k_mossberg590"] = "Mossberg 590"
class["m9k_jackhammer"] = "Jackhammer"
class["m9k_remington870"] = "Remington 870"
class["m9k_spas12"] = "SPAS 12"
class["m9k_striker12"] = "Striker 12"
class["m9k_usas"] = "USAS"
class["m9k_1897winchester"] = "Winchester 1897"
class["m9k_1887winchester"] = "Winchester 87"
class["m9k_aw50"] = "AW 50"
class["m9k_barret_m82"] = "Barret M82"
class["m9k_m98b"] = "Barret M98B"
class["m9k_svu"] = "Dragunov SVU"
class["m9k_sl8"] = "SL8"
class["m9k_intervention"] = "Intervention"
class["m9k_m24"] = "M24"
class["m9k_psg1"] = "PSG-1"
class["m9k_remington7615p"] = "Remington 7615P"
class["m9k_dragunov"] = "SVD Dragunov"
class["m9k_svt40"] = "SVT 40"
class["m9k_contender"] = "Contender"
class["m9k_damascus"] = "Damascus"
class["m9k_davy_crockett"] = "Davy Crockett"
class["m9k_ex41"] = "EX41"
class["m9k_fists"] = "Fists"
class["m9k_m61_frag"] = "Frag"
class["m9k_harpoon"] = "Harpoon"
class["m9k_ied_detonator"] = "IED"
class["m9k_knife"] = "Knife"
class["m9k_m202"] = "M202"
class["m9k_m79gl"] = "M79 GL"
class["m9k_machete"] = "Machete"
class["m9k_matador"] = "Matador"
class["m9k_milkormgl"] = "Milkor Mk1"
class["m9k_nerve_gas"] = "Nerve Gas"
class["m9k_nitro"] = "Nitro Glycerine"
class["m9k_orbital_strike"] = "Orbital Strike"
class["m9k_proxy_mine"] = "Prox Mine"
class["m9k_rpg7"] = "RPG-7"
class["m9k_sticky_grenade"] = "Sticky Grenade"
class["m9k_suicide_bomb"] = "Timed C4"
class["m9k_honeybadger"] = "Honey Badger"
class["m9k_bizonp19"] = "PP19"
class["m9k_smgp90"] = "P90"
class["m9k_mp5"] = "MP5"
class["m9k_mp7"] = "MP7"
class["m9k_ump45"] = "UMP-45"
class["m9k_usc"] = "USC"
class["m9k_kac_pdw"] = "PDW"
class["m9k_vector"] = "Vector"
class["m9k_magpulpdr"] = "PDR"
class["m9k_mp40"] = "MP40"
class["m9k_mp5sd"] = "MP5SD"
class["m9k_mp9"] = "MP9"
class["m9k_sten"] = "Sten"
class["m9k_tec9"] = "TEC-9"
class["m9k_thompson"] = "Tommy"
class["m9k_uzi"] = "UZI"

// Custom
class["grapplinghook"] = "Grappling Hook"
class["keypad_cracker"] = "Keypad Cracker"
class["weapon_kidnap"] = "Kidnap"
class["pro_lockpick_update"] = "Pro Lockpick"
class["spiderman's_swep"] = "Spiderman"


// Global methods 
function ReplaceClassWithName(wepclass)
	return class[wepclass]
end
