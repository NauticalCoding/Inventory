//
/*

	Server main script
	
	Nautical & Anarchy
	
	5/8/2015
*/

if (CLIENT) then return end

AddCSLuaFile("cl_main.lua");

// Networking
util.AddNetworkString("SendInv")
util.AddNetworkString("EquipWeapon")

local function PrintInfo()
	local col = net.ReadInt(32)
	local row = net.ReadInt(32)
	local ply = net.ReadEntity()
	local tbl = net.ReadTable()
	
	local inventory = NewInventory()
	inventory:Init(ply)
	
	inventory:InteractObject(row,col,function(tbl)
		local pos = LocalToWorld(Vector(35, 70, 35), Angle(0, 0, 0), ply:GetPos(), ply:GetAngles())
		local ent = ents.Create("spawned_weapon")
		ent:SetModel(tbl.model)
		ent:SetPos(ply:GetPos())
		ent:Spawn()
		ent:Activate()
		
		ent.dt["WeaponClass"] = tbl.class
		
	end)
	
	inventory:RemoveObject(row,col)

end
net.Receive("EquipWeapon", PrintInfo)

// Variables

local pickupWhitelist = {

	"spawned_weapon",
}

// Include our scripts

local scripts,directories = file.Find("autorun/scripts/*","LUA");

for k,v in pairs(scripts) do

	print( "Including script: " .. v );
	include("scripts/" .. v);
end

// Create first inventory

local function CreateFirstInv(ply)

	local inventory = NewInventory();
	inventory:Init(ply);

	FH:WriteFile(FH:PlayerToFileName(ply), inventory);
end

// On Initial Spawn

local function OnInitialSpawn(ply)

	if (!FH:FileExists(FH:PlayerToFileName(ply))) then
		
		//print("Creating first inventory for: " .. ply:Nick());
		CreateFirstInv(ply);
	end
end
hook.Add( "PlayerInitialSpawn","Inventory-OnInitialSpawn",OnInitialSpawn)

// Pickup object

local function PlyPickup(ply,key)
	
	if (ply:Health() <= 0) then return end
	if (key != IN_USE) then return end
	
	local ent = ply:GetEyeTrace().Entity
	
	if (!table.HasValue(pickupWhitelist,ent:GetClass())) then return end // bad class
	
	// debug
	print("Player: " .. ply:Nick() .. " picked up " .. ent:GetWeaponClass());
	
	// load inventory
	
	local inventory = NewInventory();
	inventory:Init(ply);
	
	// prepare data
	
	local data = {}
	data.class = ent:GetWeaponClass();
	data.model = ent:GetModel();
	
	// access inventory
	
	inventory:AddObject(data);
	
	// remove old ent
	ent:Remove()
end

hook.Add("KeyPress", "Inventory-PickUp", PlyPickup)

// Block normal pickup

local function CanPickupWeapon( ply,wep )
	
	if ( ply:GetPos():Distance( wep:GetPos() ) > 1 ) then return false end
end

hook.Add( "PlayerCanPickupWeapon","Inventory-DenyWeaponPickup",CanPickupWeapon )

// Open our clientside menu
local function InvMenu(ply)
	local inventory = FH:ReadFile(FH:PlayerToFileName(ply))


	umsg.Start("InvMenu", ply)
		net.Start("SendInv")
			net.WriteTable(inventory)
		net.Send(ply)
	umsg.End()
end
hook.Add("ShowHelp", "Inventory-ShowMenu", InvMenu)

