local preview = {}

preview.hide_background = true

function preview:init(mod, button, menu)
    --button:setColor(1, 1, 1)
    local hexToRGB = (ColorUtils and ColorUtils.hexToRGB or Utils.hexToRgb)
    self.colors = {
        hexToRGB("#3f48cc"),
        hexToRGB("#fff200"),
        hexToRGB("#ffaec9")
    }
    self.color_timer = 0
    self.color_index = love.math.random(1, #self.colors)
    self.button = button
    self.button:setFavoritedColor(unpack(self.colors[self.color_index]))

    self.deals = {
        "COME LOOK AT SPAMTON'S ASS! (GONE WRONG!!!) (+18!!!!)",
        "SPAMTON ASS!!! SPAMTON ASS!!! YEEEESS!!!",
        "SPAMTON YES!!!",
        "BEST DEAL IN CYBER CITY!!!",
        "YEEESS!!!",
        "YE--",
        "KILL YOUR TV",
        "There's no audience.",
        "Obey Spamton",
        "I am defined by Spamton's ass",
        "Go listen to the Spamton anthem now"
    }

    self.menu = menu or MainMenu

    if self.menu.spamton_ass then return end

    local base_path = mod.path.."/preview"

    self.menu.spamton_ass = love.graphics.newVideo(base_path.."/spamton_ASS.ogv")
    self.menu.spamton_ass:setFilter("linear", "linear")
    self.menu.spamton_ass:play()
    self.menu.spamton_ass:getSource():setVolume(self.fade)
end

function preview:update()
    if self.fade == 1 and self.button then
        self.color_timer = self.color_timer + DT
        if self.color_timer > 1 then
            self.color_timer = self.color_timer - 1
            self.color_index = self.color_index + 1
            if self.color_index > #self.colors then
                self.color_index = 1
            end
            self.button:setFavoritedColor(unpack(self.colors[self.color_index]))
            self.button.subtitle = (TableUtils or Utils).pick(self.deals)
        end
    end

    if self.menu.spamton_ass == nil then return end

    -- Destroy the video when Kristal starts loading something
    if Kristal.Overlay.loading then
        self.menu.spamton_ass:release()
        self.menu.spamton_ass = nil
        return
    end

    self.menu.spamton_ass:getSource():setVolume(self.fade)
    if self.fade <= 0 and self.menu.spamton_ass:isPlaying() then
        self.menu.spamton_ass:pause()
    elseif self.fade > 0 and not self.menu.spamton_ass:isPlaying() then
        self.menu.spamton_ass:play()
    end
end

function preview:draw()
    if self.menu.spamton_ass == nil then return end
    if self.fade <= 0 then return end

    love.graphics.setColor(1, 1, 1, self.fade)
    local vid_w, vid_h = self.menu.spamton_ass:getDimensions()
    love.graphics.draw(self.menu.spamton_ass, 0, 0, 0, SCREEN_WIDTH/vid_w, SCREEN_HEIGHT/vid_h)
end

return preview
