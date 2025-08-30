local SpamAngel, super = Class(Sprite)

function SpamAngel:init(x, y, chara)
	self.xstart = x --emulate xstart and ystart vars in gamemaker
	self.ystart = y --location of target

	super:init(self, "", x+200, y-150) --shifts over to beginning pos

	self.chara = chara --party member for heals

	--spawn point of cherub
	self.xspawn = self.x
	self.yspawn = self.y

	--little bit of random offset for some reason
	self.offset = Utils.random(2*math.pi)
	self.xoff = (-math.cos(8+self.offset))*20
	self.yoff = (-math.sin(8+self.offset))*20

	--initialization
	self:setOrigin(0, 0)
	self:setScale(2)

	--other vars
	self.timer = 0 --timer for animations
	self.healed = false --did the healing happen yet?
	self.created = false --was the angel created yet?

end


function SpamAngel:update(dt)

	if self.timer == 0 then
		local spark = Assets.playSound("sparkle_glock", 1, 1.1)
	end

	self.timer = self.timer + DTMULT --DTMULT for frames

	if self.timer >= 24 then
		if self.timer >= 63 then
			self:remove() --remove
			Game:setFlag("f1_doing", false)

		--healing happens here!
		elseif self.timer >= 48 and not self.healed then
			self.chara:heal(self.chara.chara.stats.health*0.5)
			self.healed = true

		--if cherub hasn't been created, it should be around 24 timer
		elseif not self.created then
			--create local angel
			local angel = Sprite("", self.x, self.y)

			--callback to remove after animation
			angel:setAnimation({"misc/cherub", 1/30, false, callback= function (self)
				self:remove()
			end})

			angel:setScale(2)
			Game.battle:addChild(angel) --adds to battle scene
			self.created = true --angel has been created
		end


	elseif self.timer >= 0 and self.timer <= 24 then

		--path to from spawn to target
		--lerps to travel across this path
		self.x = Utils.lerp(self.xspawn, (self.xstart + self.xoff), Utils.clamp(self.timer/25, 0, 1))
		self.y = Utils.lerp(self.yspawn, (self.ystart + self.yoff), Utils.clamp(self.timer/25, 0, 1))

		--since timer is not perfect ints, using rounding to estimate it
		local sparkle_created = false
		if Utils.round(self.timer % 2) == 0 and not sparkle_created then


			sparkle_created = true
			--variation of spawn location of sparkles
			local xx = self.x + (math.cos(((self.timer / 3) + self.offset)) * 20)
			local yy = self.y + (math.sin(((self.timer / 3) + self.offset)) * 20)

			local star = Sprite("", xx, yy)

			star:setAnimation({"effects/spare/star", 1/30})
			star:fadeOutAndRemove(0.1)
			star:setScale(2)
			star:setColor(0, 1, 0)
			Game.battle:addChild(star)

		elseif Utils.round(self.timer % 2) == 1 then
			sparkle_created = false
		end
	end


	super:update(self, dt)

end

return SpamAngel