-- converts a float into a binary list -- 

local reBinarizer = pd.Class:new():register("rebinarizer")

function reBinarizer:initialize(name, atoms)
	self.inlets = 1
	self.outlets = 1
	self.output = {}
	return true
end

function reBinarizer:in_1_float(f)
	local num = f
	local tab = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	local size = 16
	self.output = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	for i = size, 1, -1 do
		remainder = math.fmod(num,2)
		tab[i] = remainder
		num = (num - remainder)/2
	end 
	self.output = tab
	self:outlet(1, "list", self.output)
end

