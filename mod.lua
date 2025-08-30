function Mod:init()
    print("Loaded "..self.info.name.."!")
end

function Mod:postInit(newfile)
    Game.money = love.math.random(15, 1997)
end

function Mod:load()
    if Kristal.Config["borders"] then
        Game:setBorder("city")
    end
end

function Mod:onShadowCrystal(item, light)
    if light then return end

    if not item:getFlag("used_none", false) then
        item:setFlag("used_none", true)
        Game.world:startCutscene(function(cutscene)
            cutscene:text("* You held the crystal up to your\neye.")
            cutscene:text("* For some strange reason,[wait:5] for\njust a brief moment...")
            if love.math.random()<0.5 then
                cutscene:text("* You thought you saw the computer lab.")
            else
                cutscene:text("* You thought you saw a discussion on a social media.")
            end
            cutscene:text("* ...but,[wait:5] it must've just been\nyour imagination.")
        end)
        return true
    end
end