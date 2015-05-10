//
/*

	Server main script
	
	Nautical & Anarchy
	
	5/8/2015
*/

if (CLIENT) then return end

AddCSLuaFile("cl_main.lua");

// Include our scripts

local scripts,directories = file.Find("autorun/scripts/*","LUA");

for k,v in pairs(scripts) do

	print( "Including script: " .. v );
	include("scripts/" .. v);
end

// Create Inventory

local function CreateFirstInv(ply)
	if not file.Exists("inventory_data/" .. ply:SteamID64() .. ".txt", "DATA") then
		FH:WriteFile(ply:SteamID64() .. ".txt", NewInventory())
	end
	
end
hook.Add("PlayerSpawn", "CreateFirstInv", CreateFirstInv)
