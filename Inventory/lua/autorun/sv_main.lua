//
/*

	Server main script
	
	Nautical
	
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
