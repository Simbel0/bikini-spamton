local Warning, super = Class(Object)

function Warning:init()
	super:init(self)

	self.box = UIBox(0, 0, 60, 60)
	self:addChild(self.box)

	self.dialogue = Text("!WARNING!\n\nThe gamepad is not taken into account for you-know-what\nSorry :p", 5, 5, 100, 100)
	self.box:addChild(self.box)
end

return Warning