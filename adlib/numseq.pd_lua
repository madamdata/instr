local numseq = pd.Class:new():register("numseq")

function numseq:initialize(name, atoms)
	self.inlets=1
	self.outlets=1
	self.count=1
	return true
end

function numseq:in_1_list(l)
	self.sequence = l
	self.seqLength = #l
	if self.count > self.seqLength then
		self.count = self.count % self.seqLength
	end
end

function numseq:in_1_bang()
	local output = self.sequence[self.count]
	self.count = (self.count + 1) % self.seqLength
	self:outlet(1, "float", {output})
end
