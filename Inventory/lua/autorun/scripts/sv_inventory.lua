//
/*

	Inventory object
	
	Nautical & Anarchy
	
	5/8/2015
*/

// Inventory obj

local inv = {
	
	rows = 5,
	columns = 10,
	parent = nil,
	contents = {},
}

--[[
	Data that we need to store:
		- all items being stored are going to be in the primary class "spawned_weapon"... So we can just do a check for that before AddObject is called.
		- We will need to store 2 things:
			- item subclass (ex: weapon_ak47 or durgz_alchohol)
			- item model path (ex: model/weapon/weapon_ak47.mdl)
		- These will need to be stored in our JSON table when we save and load.	
]]--

function inv:AddObject(data)

	for r = 1,self.rows do
		for c = 1,self.columns do 
			
			if (table.Count(self.contents[r][c]) == 0) then // if the slot is empty..
		
				self.contents[r][c] = data;
			end
		end
	end
	
	FH:WriteFile(FH:PlayerToFileName(self.parent),self);
end

function inv:RemoveObject(row,column)

	self.contents[row][column] = {};
	FH:WriteFile(FH:PlayerToFileName(self.parent),self);
end

function inv:InteractObject(row,column,interactFunc)

	if (table.Count(self.contents[row][column]) > 0) then // if the slot isn't empty
	
		interactFunc(self.contents[row][column]); // call interactFunc and pass the data from the selected slot
		self:RemoveObject(row,column);
	end
end

function inv:MoveObject(row,column,newRow,newColumn)
	
	local buffer = self.contents[newRow][newColumn];
	
	self.contents[newRow][newColumn] = self.contents[row][column];
	self.contents[row][column] = buffer;
	FH:WriteFile(FH:PlayerToFileName(self.parent),self);
end

function inv:Init(ply)

	for r = 1,self.rows do
		for c = 1,self.columns do
			
			if (self.contents[r] == nil) then 
				self.contents[r] = {};
			end
			self.contents[r][c] = {};
		end
	end
	
	self.parent = ply;
	self.contents = FH:ReadFile(FH:PlayerToFileName(ply))
end

// Global method(s)

function NewInventory()

	return inv;
end