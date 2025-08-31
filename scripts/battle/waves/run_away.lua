local run_away, super = Class(Wave)

function run_away:init()
    super.init(self)
    self.time = -1
    self.path_selections = love.math.random(5,7)
end

function run_away:onStart()
    -- Every 0.33 seconds...
    self.timer:script(function(wait)
        local spamton = Game.battle.enemies[1]
        spamton:setLayer(BATTLE_LAYERS["bullets"])
        spamton.collider = Hitbox(spamton, spamton.x+10, spamton.y+10, spamton.width-10, spamton.height-10)
        spamton.sprite.flip_x = true
        wait(0.5)
        spamton.sprite.shake_x = 4
        spamton:setSprite("hurt")
        wait(0.3)
        spamton.sprite.flip_x = false
        spamton:setAnimation("walk")
        self.timer:tween(1.6, spamton, {x=-60})
        wait(0.5)
        self.timer:everyInstant(1/30, function()
            local bullet = self:spawnBullet("heart", (SCREEN_WIDTH+15)+Utils.random(6, 6*4), spamton.y+Utils.random(-30, 30))
            bullet.physics.direction = math.rad(180)
            bullet.physics.speed = Utils.random(19, 21)
        end, 40)
        wait(((1/30)*40)+0.3)
        self.pathes = {
            {-20, -20, SCREEN_WIDTH+20, SCREEN_HEIGHT+20},
            {Utils.random(Game.battle.arena.left, Game.battle.arena.right), 0, nil, SCREEN_HEIGHT+50},
            {-20, SCREEN_HEIGHT/4, SCREEN_WIDTH+20, SCREEN_HEIGHT/3},
            {-20, SCREEN_HEIGHT-75, SCREEN_WIDTH+20, 100},
            {-20, Game.battle.arena.top, SCREEN_WIDTH+20, Game.battle.arena.bottom},
            {-20, Game.battle.arena.bottom, SCREEN_WIDTH+20, Game.battle.arena.top}
        }
        self.finished_path = true
        self.timer:everyInstant(0.5, function()
            if self.finished_path then
                self.finished_path = false
                if self.path_selections>0 then
                    local path = Utils.pick(self.pathes)
                    spamton:setPosition(path[1], path[2])
                    spamton.sprite.alpha = 1
                    self.timer:tween(1.3, spamton, {x=path[3], y=path[4]}, nil, function() spamton.sprite.alpha = 0 end)
                    self.timer:after(0.5, function()
                        self.timer:everyInstant(1/30, function()
                            local bullet = self:spawnBullet("heart", path[1]+Utils.random(6, 6*4), path[2]+Utils.random(-30, 30))
                            bullet.tp = (bullet.getGrazeTension and bullet:getGrazeTension() or bullet.tp)/2
                            bullet.physics.direction = Utils.angle(bullet.x, bullet.y, path[3] or path[1], path[4])
                            bullet.physics.speed = Utils.random(19, 21)
                        end, 20)
                        self.timer:after(((1/30)*20)+0.5, function()
                            self.finished_path = true
                            self.path_selections = self.path_selections - 1
                        end)
                    end)
                else
                    spamton:setPosition(SCREEN_WIDTH+20, 216)
                    spamton.sprite.alpha = 1
                    self.timer:tween(1.5, spamton, {x=550, y=216}, nil, function()
                        spamton:setSprite("idle")
                        self.finished = true
                    end)
                end
            end
        end)
    end)
end

function run_away:update()
    -- Code here gets called every frame

    super.update(self)
end

return run_away