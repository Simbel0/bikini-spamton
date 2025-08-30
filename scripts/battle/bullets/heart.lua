local heart, super = Class(Bullet)

function heart:init(x, y, dollar)
    -- Last argument = sprite path
    super:init(self, x, y, dollar and "bullets/dollar" or "bullets/heart")
end

function heart:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
end

return heart