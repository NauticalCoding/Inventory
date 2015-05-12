//
/*

	File Handler
	
	Nautical & Anarchy
	
	5/8/2015
*/

// Create directory

local dirName = "inventory_data";

if (!file.IsDir(dirName,"DATA")) then

	file.CreateDir(dirName);
end

// Filehandler

FH = {}

function FH:FileExists(filename)

	return file.Exists(dirName .. "/" .. filename,"DATA");
end

function FH:ReadFile(filename)
	
	local source = file.Read(dirName .. "/" .. filename,"DATA");
	return util.JSONToTable(source);
end

function FH:WriteFile(filename,data)

	local source = util.TableToJSON(data);
	file.Write(dirName .. "/" .. filename,source);
	
	
end

function FH:PlayerToFileName(ply)

	return ply:SteamID64() .. ".txt";
end