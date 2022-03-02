local adlibsavestate = pd.Class:new():register("adlibsavestate")

function adlibsavestate:initialize(name, atoms)
	self.inlets = 1
	self.outlets = 1
	self.args = {}
	self.receives = {}
	self.values = {}
	self.types = {}
	for index, val in ipairs(atoms) do 
		self.args[index] = val
		self.values[index] = 0
	end
	return true
end

function adlibsavestate:postinitialize()
	for index, val in ipairs(self.args) do
		self.receives[index] = pd.Receive:new():register(self, val .. "snd", val .. "snd")
		self[val .. "snd"] = function (self, sel, atoms)
			--self:outlet(1, sel, atoms)--
			self.types[index] = type(atoms[1])
			self.values[index] = atoms[1]
			self:outlet(1, "list", self.values)
		end
	end
end

function adlibsavestate:in_1_symbol(sym)
	if sym == "dumpvalues" then
		dumptable(self.values)
		dumptable(self.types)
	end
end

function adlibsavestate:in_1_list(list)
	for index, value in ipairs(list) do
		self.types[index] = type(value)
		self.values[index] = value
	end
	--send values out to canvasargs--
	--self:outlet(1, "list", self.values)--
	--update controls with loaded values --
	for index, value in ipairs(self.args) do
		local receive = value .. "rcv"
		local selector = typeConvert(self.types[index])
		local val = self.values[index]
		pd.send(receive, selector, {val})
	end
end

function typeConvert(typeString)
	local output = ""
	if typeString == "string" then output = "symbol"
	elseif typeString == "number" then output = "float"
	end
	return output
end

function dumptable(table)
	for index, val in ipairs(table) do
		if type(val) == "table" then
			dumptable(val)
		else
			pd.post(val)
		end
	end
end

function adlibsavestate:finalize()
  for _,r in ipairs(self.receives) do r:destruct() end
end
