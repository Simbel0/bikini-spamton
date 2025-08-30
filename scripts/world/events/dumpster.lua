local dumpster, super = Class(Event, "dumpster")

function dumpster:init(data)
	super:init(self, data.x, data.y, 58, 43)

	self.sprite=Sprite("dumpster_closed", 0, 0, 58, 43, "events")
	self.sprite:setOrigin(0, 0.6)
    self.sprite:setScale(2)
	self:addChild(self.sprite)
end

return dumpster