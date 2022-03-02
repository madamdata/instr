-- converts a binary list into a single float -- 

local deBinarizer = pd.Class:new():register("debinarizer")

function deBinarizer:initialize(name, atoms)
	self.inlets = 1
	self.outlets = 1
	self.output = 0
	return true
end

function deBinarizer:in_1_list(list)
	local size = table.getn(list)
	self.output = 0
	for i = size, 1, -1 do
		local power = size-i
		self.output = self.output + (list[i] * math.pow(2,power))
	end
	self:outlet(1, "float", {self.output})
end

