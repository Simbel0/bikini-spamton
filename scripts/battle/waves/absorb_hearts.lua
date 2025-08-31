local ab_heart, super = Class(Wave)

function ab_heart:init()
    super.init(self)
    self.time = 15
end

function ab_heart:onStart()
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

        self.sprites = {}
        self.timer:everyInstant(0.8, function()
            -- Our X position is offscreen, to the right
            local x, y = -20, Utils.random(Game.battle.arena.top-20, Game.battle.arena.bottom-20)
            print(x, y)

            local minispam = Sprite("npcs/spamtong/walk", x, y)
            minispam.will_jump = love.math.random()<0.5
            minispam.flip_x = true
            minispam.layer = BATTLE_LAYERS["below_bullets"]
            table.insert(self.sprites, minispam)
            Game.battle:addChild(minispam)
            minispam:play(0.1, true)
            local time = Utils.random(1, 2)
            -- People would probably kill me for that mess of timers lmao
            self.timer:tween(time, minispam, {x=Utils.random(80, Game.battle.arena.left-20)})
            self.timer:after(time+0.2, function()
                minispam:setSprite("npcs/spamtong/arms_up")
                self.timer:after(0.2, function()
                    local x, y = minispam.x+minispam.width/2, minispam.y-15
                    local bullet = self:spawnBullet("heart", x, y, love.math.random()<0.5)
                    if minispam.will_jump then
                        bullet.physics.direction = math.rad(270)
                        bullet.physics.speed = 4
                        bullet.physics.gravity = 0.2

                        minispam.physics.direction = math.rad(270)
                        minispam.physics.speed = 4
                        minispam.physics.gravity = 0.2
                    end
                    self.timer:after(0.45, function()
                        minispam:setSprite("npcs/spamtong/arms_up_laugh")
                        Assets.playSound("voice/snd_txtspam2")
                        if not minispam.will_jump then
                            minispam.physics.gravity = 0.2
                            bullet.physics.gravity = 0.2
                        end
                        
                        self.timer:tween(Utils.random(2, 3), bullet, {x=550, y=160}, "out-cubic", function()
                            bullet:remove()
                        end)
                    end)
                end)
            end)
        end)
    end)
end

function ab_heart:update()
    -- Code here gets called every frame

    if self.big_spamton and self.big_spamton["top"] then
        self.big_spamton["top"].y = 0+math.sin(Kristal.getTime()*13)*8
    end

    super.update(self)
end

function ab_heart:onEnd()
    if self.sprites then
        for i,v in ipairs(self.sprites) do
            v:remove()
        end
    end
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

return ab_heart