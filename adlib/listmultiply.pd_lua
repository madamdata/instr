-- obj to multiply all elements of a list -- 

local ListMultiply = pd.Class:new():register("listmultiply")

function ListMultiply:initialize(name, atoms)
	self.inlets = 2
	self.outlets = 1
	self.multiplier = atoms[1]
	self.newlist = {}
	return true
end

function ListMultiply:in_2(sel, atoms)
	if sel == "float" then 
		self.multiplier = atoms
	elseif sel == "list" then 
		self.multiplier = atoms[1]
	end
end

function ListMultiply:in_1(sel, atoms)
	self.newlist = {}
	local size = table.getn(atoms)
	for i=size, 1, -1 do
		table.insert(self.newlist, 1, atoms[i] * self.multiplier)
	end
	self:outlet(1, "list", self.newlist)
end
		
		
