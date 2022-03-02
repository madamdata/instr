local oeisreader = pd.Class:new():register("oeisreader")

function oeisreader:initialize(name, atoms)
	pd.post("Online Encyclopedia of Integer Sequences Sequencer by Madam Data")
	pd.post("Online Encyclopedia of Integer Sequences (OEIS) https://oeis.org")
	pd.post("OEIS information is released under the Creative Commons Attribution Non-Commercial 3.0 License")
	self.inlets=1
	self.outlets=2
	self.names = {}
	self.seqs= {}
	return true
end

function oeisreader:postinitialize()
	pd.post("postinitializing...")
	--local names = assert(io.open('./oeisnames', "r"))
	local names = assert(io.open('./oeisnames', "r"))
	--local names = assert(io.open('/home/ada/Documents/Pd/externals/oeis/oeisnames.txt ', "r"))
	local seqs = assert(io.open('./oeissequences', "r"))
	for name in names:lines() do
		table.insert(self.names, name)
	end
	for seq in seqs:lines() do
		table.insert(self.seqs, seq)
	end
end

function oeisreader:getLine(file, linenumber)
	local count = 1
	for line in file:lines() do
		if count == linenumber then
			return line
		end
		count = count + 1
	end
end

function oeisreader:splitString(string)
	local output = {}
	for item in string.gmatch(string, '%d+,') do
		local cookeditem = string.match(item, '%d+')
		cookeditem = tonumber(cookeditem)
		table.insert(output, cookeditem)
	end
	return output
end

function oeisreader:breakString(string, number)
	local output = {}
	local length = #string
	local numlines = math.ceil(length / number)
	local count = 1
	for i = 1, numlines do
		start = (i-1) * number
		local sub = string.sub(string, start, start+number-1)
		table.insert(output, sub)
	end
	return output
end


function oeisreader:in_1_float(f)
	local indexnumber = math.floor(f+4)
	--local name = self:getLine(names,indexnumber)
	local name = self.names[indexnumber]
	--local sequence = self:getLine(seqs, indexnumber)
	local sequence = self.seqs[indexnumber]
	name = string.sub(name, 1)
	name = string.gsub(name, " ", " ") --replace space with non breaking space
	--name = self:breakString(name, 22)
	sequence = string.sub(sequence, 9)
	local output = self:splitString(sequence)
	self:outlet(1, "list", output)
	--self:outlet(2, "list", name)
	self:outlet(2, "symbol", {name})
end


