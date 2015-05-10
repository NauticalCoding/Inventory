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

	return inv;
end