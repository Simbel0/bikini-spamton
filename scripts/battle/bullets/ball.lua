local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/ball"..love.math.random(1,3))

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.direction = math.rad(Utils.random(190, 225))
    self.physics.speed = Utils.random(7, 9)
    self.physics.gravity = 0.2
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return SmallBullet