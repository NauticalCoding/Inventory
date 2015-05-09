//
/*

	Inventory object
	
	Nautical
	
	5/8/2015
*/

// Inventory obj

local inv = {
	
	rows = 5,
	columns = 10,
	contents = {},
}

function inv:AddObject(row,column)


end

function inv:RemoveObject(row,column)


end

function inv:InteractObject(row,column)


end

function inv:MoveObject(row,column,newRow,newColumn)

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