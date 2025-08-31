local spamton, super = Class(Encounter)

function spamton:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* That doesn't feel right at all.."

    -- Battle music ("battle" is rude buster)
    self.music = "spamton_battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self.spamton = self:addEnemy("spamton", 550, 216)
    Game:setFlag("defeat", nil)
    Game:setFlag("f1_angel", true)

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")

    --[[Utils.hook(Game.battle, "onStateChange", function(orig, old, new)
        orig(old, new)
        if new=="VICTORY" then
            win_text = ""
        end
    end)]]
end

function spamton:update()
    --print(Input.pressed("f1"))
    if (Input.pressed("f1") or Input.pressed("gamepad:rightstick")) and not (Game.battle.state:sub(1,9)=="DEFENDING" or Game.battle.state=="VICTORY") then
        print("KHZKAHKHK")
        if Game:getFlag("f1_angel", true) then
            print("hello")
            Game:setFlag("f1_angel", false)
            local kris = Game.battle.party[1]
            --print(kris.chara)
            Game.battle:addChild(spamAngel(kris.x-20, kris.y-110, kris))
        end
    end
end


function spamton:beforeStateChange(old, new)
    if new=="ENEMYDIALOGUE" and Game:getFlag("defeat")=="violence" then
        Game.battle:setState("VICTORY")
        return true
    end
    return false
end

return spamton