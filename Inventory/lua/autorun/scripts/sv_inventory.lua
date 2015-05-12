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
		
			if (table.Count(self.contents[r][c]) == 0 ) then // if the slot is empty..
		
				self.contents[r][c] = data;
			end
		end
	end
end

function inv:RemoveObject(row,column)

	self.contents[row][column] = {};
end

function inv:InteractObject(row,column,interactFunc)

	if (table.Count(self.contents[row][column]) > 0) then // if the slot isn't empty
	
		interactFunc(self.contents[row][column]) // call interactFunc and pass the data from the selected slot
	end
end

function inv:MoveObject(row,column,newRow,newColumn)
	
	local buffer = self.contents[newRow][newColumn];
	
	self.contents[newRow][newColumn] = self.contents[row][column];
	self.contents[row][column] = buffer;
end

function inv:Init()

	for r = 1,self.rows do
		for c = 1,self.columns do
		
			self.contents[r] = {};
			self.contents[r][c] = {};
		end
	end
end

// Global method(s)

function NewInventory()
	
	inv:Init()
	return inv;
end