local scalegenerator = pd.Class:new():register("scalegenerator")

function scalegenerator:initialize(name, atoms)
	self.inlets = 1
	self.outlets = 1
	self.pent = {3,2,2,3,2}
	self.pentreverse = {2,3,2,2,3}
	return true
end

function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

function TableReverse(table)
	local newtable = {}
	for i = #table, 1, -1 do
		newtable[#newtable+1] = table[i]
	end
	return newtable
end

function ZipTable(size,t2)
	local newtable = {}
	local readindex = 1
	for i = 0, size do
	if i<t2[readindex+1] then
		newtable[#newtable+1] = t2[readindex]
	else 
		readindex = readindex + 1
		newtable[#newtable+1] = t2[readindex]
	end
	end
	return newtable
end
	
	

function scalegenerator:in_1_list(list)
	-- takes an identifier eg "pent" and a key --
	local upwards = {}
	local downwards = {}
	self.scaletype = list[1]
	self.key = list[2]
	local pitch = self.key
	local index = 0

	while pitch<128 do
	upwards[#upwards+1] = pitch --store incremented pitch
	pitch = pitch + self.pent[(index%(#self.pent))+1] -- increment pitch
	index = index + 1 -- increment index
	end

	pitch = self.key --reset pitch and index
	index = 0

	while pitch>0 do -- same thing but downwards
	pitch = pitch - self.pentreverse[(index%#self.pent)+1]
	downwards[#downwards+1] = pitch
	index = index + 1
	end

	downwards = TableReverse(downwards)
	self.output = TableConcat(downwards,upwards)
	self.output = ZipTable(126,self.output)
	pd.post(table.getn(self.output))

	self:outlet(1, "list", self.output)
		
end
