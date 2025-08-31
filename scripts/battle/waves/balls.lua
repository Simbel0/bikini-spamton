local balls, super = Class(Wave)

function balls:init()
    super.init(self)
    self.hard = math.random()<0.5
    self.time = 15
    self:setArenaOffset(-60, 0)
end

function balls:onStart()
    local spamton = Game.battle.enemies[1]
    spamton:setAnimation("grow")
    self.timer:script(function(wait)
        while spamton.sprite.playing do
            print(spamton.sprite.playing)
            wait(0.1)
        end
        wait(0.5)
        spamton.sprite.alpha = 0
        self.big_spamton = {}
        self.big_spamton["bottom"] = Sprite("npcs/spamtong/laugh_bottom", 513, 55)
        self.big_spamton["bottom"].layer = BATTLE_LAYERS["bullets"]
        self.big_spamton["bottom"]:setScale(2)
        Game.battle:addChild(self.big_spamton["bottom"])
        self.big_spamton["middle"] = Sprite("npcs/spamtong/laugh_middle")
        self.big_spamton["middle"].layer = BATTLE_LAYERS["above_bullets"]
        --middle:setScale(2)
        self.big_spamton["bottom"]:addChild(self.big_spamton["middle"])
        self.big_spamton["top"] = Sprite("npcs/spamtong/laugh_top")
        self.big_spamton["top"].layer = BATTLE_LAYERS["above_bullets"]
        --top:setScale(2)
        self.big_spamton["bottom"]:addChild(self.big_spamton["top"])
        self.timer:every(1/2, function()
            -- Our X position is offscreen, to the right
            local x, y = self.big_spamton["middle"]:getScreenPos()
            print(x, y, x+self.big_spamton["middle"].width/2, y+self.big_spamton["middle"].height/2)

            -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            local bullet = self:spawnBullet("ball", x+self.big_spamton["middle"].width, y+self.big_spamton["middle"].height+20, math.rad(180), 8)
            bullet:setScale(0.5)
            self.timer:tween(0.25, bullet, {scale_x=2, scale_y=2})
            bullet.graphics.spin = math.rad(Utils.random(5, 25))

            -- Dont remove the bullet offscreen, because we spawn it offscreen
            bullet.remove_offscreen = false
        end)
    end)
end

function balls:update()
    -- Code here gets called every frame

    if self.big_spamton and self.big_spamton["top"] then
        self.big_spamton["top"].y = 0+math.sin(Kristal.getTime()*13)*8
    end
    if self.hard and self.big_spamton and self.big_spamton["bottom"] then
        self.big_spamton["bottom"].y = 55+math.sin(Kristal.getTime()*5)*40
    end

    super.update(self)
end

function balls:onEnd()
    self.big_spamton["bottom"]:remove()
    local spamton = Game.battle.enemies[1]
    spamton.sprite.alpha = 1
    spamton:setAnimation({"grow", 1/12, false, frames={5,4,3,2,1}}, function()
        -- Lazy way to fix a bug where the grow animation mess up the dialogue box position. Gotta report it later
        spamton.x = spamton.x - 1
        spamton.x = spamton.x + 1
        spamton:setSprite("idle")
    end)
end

return balls