local adabasedir = pd.Class:new():register("adabasedir")

function adabasedir:initialize(name, atoms)
	self.inlets=1
	self.outlets=2
	return true
end

function adabasedir:in_1_symbol(string)
	self.string = string
	self.results= {}
	self.results[1], self.results[2] = self.string.match([[/mnt/tmp/myfile.txt]], "(.-)([^\\/]-%.?([^%.\\/]*))$")
	self:outlet(1, "symbol", {self.results[1]})
	self:outlet(2, "symbol", {self.results[2]})
end

function adabasedir:in_1_list(ls)
	pd.post(ls[1])
	self.string = ls[1]
	self.results= {}
	self.results[1], self.results[2] = string.match(self.string, "(.-)([^\\/]-%.?([^%.\\/]*))$")
	self:outlet(1, "symbol", {self.results[1]});
	self:outlet(2, "symbol", {self.results[2]});
end
