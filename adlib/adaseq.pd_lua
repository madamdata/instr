local adaseq = pd.Class:new():register("adaseq")

function adaseq:initialize(name,atoms)
	self.inlets=1
	self.outlets=1
	self.clocks={}
	return true
end

function adaseq:postinitialize()
end

function adaseq:finalize()
	for i=1, (#self.clocks) do
		self.clocks[i]:destruct()
	end
end

function adaseq:in_1_list(l)
	for i=1, (#l) do
		table.insert(self.clocks, pd.Clock:new():register(self, "trigger"))
		self.clocks[i].delay(l[i])
		pd.post(i)
	end
end

function adaseq:trigger()
	self:outlet(1, "bang", {})
end

