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

// Variables

local allInvens = {} // all loaded inventories

// Create first inventory

local function CreateFirstInv(ply)

	local inventory = NewInventory();
	inventory:Init();

	FH:WriteFile(FH:PlayerToFileName(ply), inventory);
end
hook.Add("PlayerSpawn", "CreateFirstInv", CreateFirstInv)

// Load inventory

local function LoadInventory(ply)

	table.insert(allInvens,FH:ReadFile(FH:PlayerToFileName(ply)));
end

// On Initial Spawn

local function OnInitialSpawn(ply)

	if (FH:FileExists(FH:PlayerToFileName(ply))) then
		
		LoadInventory(ply);
		
	else
	
		CreateFirstInv(ply);
	end
end

hook.Add( "PlayerInitialSpawn","Inventory-OnInitialSpawn",OnInitialSpawn)
