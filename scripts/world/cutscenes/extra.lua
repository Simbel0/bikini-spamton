return {
	gamePadWarning=function(cutscene)
		cutscene:text("* (INFO: The gamepad has not been made compatible for the f1 stuff.[wait:3] Sorry :p)")
		cutscene:text("* (- Simbel without a gamepad)")
	end,
	left_exit = function(cutscene, script, chara)
		cutscene:text("* (For some unexplainable reason,[wait:2] you feel like you shouldn't go back now.)")
		cutscene:wait(cutscene:walkTo(chara, chara.x, chara.y+50, 0.5))
	end,
	right_exit = function(cutscene, script, chara)
		cutscene:walkTo(chara, chara.x, -30, 3.5)
		Kristal.hideBorder(3.5)
		cutscene:wait(cutscene:fadeOut(4, {global=true}))
		cutscene:panTo(240, 420, 0)
		local hider = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		hider:setColor({0, 0, 0, 1})
		hider.layer = WORLD_LAYERS["top"]
		Game.world:addChild(hider)
		local bg = Sprite("shop_bg")
		bg:setScale(2)
		bg.layer = WORLD_LAYERS["top"]+10
		Game.world:addChild(bg)
		box = UIBox()
	    local left, top = box:getBorder()
	    box:setOrigin(0, 1)
	    box.x = left
	    box.y = SCREEN_HEIGHT - top + 1
	    box.width = SCREEN_WIDTH - (top * 2) + 1
	    box.height = 213 - 37 + 1
	    box:setLayer(WORLD_LAYERS["top"]+20)
		Game.world:addChild(box)
		local dialogue = DialogueText(nil, 30, 270, 600, 194)
		--dialogue.state["skipping"] = false
		dialogue:setLayer(WORLD_LAYERS["top"]+30)
		Game.world:addChild(dialogue)
		cutscene:wait(1)

		Game.world.music:play("spamton_neo_after", 1, 0.7)		
		if Kristal.Config["borders"] then
        	Game:setBorder("simple", 0)
        	Kristal.showBorder(2)
    	end
		cutscene:fadeIn(2, {global=true})
		cutscene:wait(1)

		dialogue:setText("[voice:none]* -- CREDITS --")
		cutscene:wait(2)
		dialogue:setText("[voice:none]* Made on Kristal by the Kristal Team[wait:3]\n* Deltarune by Toby Fox[wait:3]\n* Sprites by the Deltarune Team[wait:1]\n(Including the Spamton Ass one.)[wait:3]\n* Music by Toby Fox")
		cutscene:wait(6.5)
		dialogue:setText("[voice:none]* Coded by Simbel[wait:3]\n* Spamton Ass sprite rigged by Just Another Random User[wait:3]\n* Bikini Spamton sprites by Just Another Random User and Simbel")
		cutscene:wait(7)
		dialogue:setText("[voice:none]* The F1 Spamton Angel was remade on Kristal by spacerace")
		cutscene:wait(3)
		dialogue:setText("[voice:none]* This masterpiece of a shitpost was brought to you by:")
		cutscene:wait(2.5)
		dialogue:setText("[voice:none]* Octobox[wait:3]\n\n* Held the hunger game sim that led to Spamton putting on a bikini")
		cutscene:wait(3.6)
		dialogue:setText("[voice:none]* Just Another Random User[wait:3]\n\n* Drew Bikini Spamton in his full glory")
		cutscene:wait(3.4)
		dialogue:setText("[voice:none]* AcousticJamm[wait:3]\n\n* Said we should make a mod out of Bikini Spamton")
		cutscene:wait(3.4)
		dialogue:setText("[voice:none]* Simbel[wait:3]\n\n* Accepted to do the mod for some reason")
		cutscene:wait(3)
		dialogue:setText("[voice:none]* -- Honorable Mentions --[wait:3]\n* BrandonK7200 - Being at the event[wait:3]\n* vitellary - Being the sane person refusing to add Bikini Spamton as an emote")
		cutscene:wait(6)
		dialogue:setText("")
		cutscene:wait(1)
		local img = Sprite("origin by just another random user", 120, 270)
		img:setScale(0.75)
		img.layer = WORLD_LAYERS["top"]+30
		img.alpha = 0
		Game.world:addChild(img)
		Game.world.timer:tween(4, img, {alpha=1})
		cutscene:wait(7)
		Game.world.music:fade(0, 4)
		cutscene:wait(cutscene:fadeOut(4, {global=true}))
		cutscene:wait(2)
		Kristal.returnToMenu()
	end
}