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

local vipGroups = {"superadmin"}

function inv:AddObject(data)
	if not (table.HasValue(vipGroups, self.parent:GetUserGroup())) then 
		self.rows = 3 
	end
	
	local wasAdded = false
	
	for r = 1,self.rows do
		for c = 1,self.columns do 
			
			if (table.Count(self.contents[r][c]) == 0) then // if the slot is empty..
		
				self.contents[r][c] = data;
				
				wasAdded = true
				
			end
		end
	end
	
	//print(self.rows)
	
	if wasAdded then
		FH:WriteFile(FH:PlayerToFileName(self.parent),self);
	end

	return wasAdded
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

	if not (table.HasValue(vipGroups, self.parent:GetUserGroup())) then 
		if (row > 3 || newRow > 3) then return; end 
	end
	
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
	
	if (FH:FileExists(FH:PlayerToFileName(ply))) then // if they have a file
		self.contents = FH:ReadFile(FH:PlayerToFileName(self.parent)) // set obj contents to their file's contents...
	end
end

// Global method(s)

function NewInventory()

	return inv;
end