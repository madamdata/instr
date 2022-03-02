-- class to dynamically create chains of filters in a subpatch --

local Hipper = pd.Class:new():register("hipper")

function Hipper:initialize(name, atoms)
	pd.post("hipper initialized madam data 2017")
	self.inlets=1
	self.outlets=1
	self.numhips=atoms[1]
	return true
end

function Hipper:in_1_float(f)
	self.inletnums = {}
	self.hipnums = {}
	self.outletnums = {}
	self.controlnums = {}
	self:outlet(1, "symbol", {"clear"})
	--self:outlet(1, "list", {"obj",10,250,"outlet~"})--
	--self:outlet(1, "list", {"obj",80,250,"outlet~"})--
	for i=1,f do
		local x = 10
		local y = i * 25 + 15
		if i==1 then 
			self:outlet(1, "list", {"obj",10,10,"inlet~"})
			table.insert(self.inletnums, (i-1))
		end
		self:outlet(1, "list", {"obj", x, y, "hip~"})
		table.insert(self.hipnums, i)
		if i==f then
			self:outlet(1, "list", {"obj",x,y+25, "outlet~"})
			table.insert(self.outletnums, i+1)
			self:outlet(1, "list", {"obj", x + 50, 10, "inlet"})
			table.insert(self.controlnums, i+2)
		end
		--self:outlet(1, "list", {"obj", x+70, y, "hip~"})--
	end

	-- connect hips --
	for i,num in ipairs(self.hipnums) do
		if i == 1 then 
			self:outlet(1, "list", {"connect", self.inletnums[1], 0, num, 0})
		end
		if i == table.getn(self.hipnums) then
			self:outlet(1, "list", {"connect", num, 0, self.outletnums[1], 0})
		else
			self:outlet(1, "list", {"connect", num, 0, self.hipnums[i+1], 0})
		end
	end

	-- connect controls --
	for i,num in ipairs(self.hipnums) do 
		self:outlet(1, "list", {"connect", self.controlnums[1], 0, num, 1})
	end

end
