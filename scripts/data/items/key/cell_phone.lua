local item, super = Class("cell_phone", true)

function item:onWorldUse()
    Game.world:startCutscene(function(cutscene)
        Assets.playSound("phone", 0.7)
        cutscene:text("* (You tried to call on the Cell\nPhone.)", nil, nil, {advance = false})
        cutscene:wait(40/30)
        local was_playing = Game.world.music:isPlaying()
        if was_playing then
            Game.world.music:pause()
        end
        local legit_gaster_noises = Assets.playSound("smile")
        local code = 0
        cutscene:wait(function()
        	--I was supposed to be nice and add a code to skip the BIG SHOT AUTOS audio... But I can't make it good enough so fuck you and suffer for 1 minute and 9 seconds lmao
        	--[[print(Utils.dump(Input.key_pressed))
        	print(code, Input.pressed("s"), code==0, Input.pressed("s") and code==0)
        	if Input.pressed("s") and code==0 then
        		code=1
        	elseif Input.pressed("p") and code==1 then
        		code=2
        	elseif Input.pressed("a") and code==2 then
        		code=3
        	elseif Input.pressed("m") and code==3 then
        		code=4
        	elseif Input.pressed("t") and code==4 then
        		code=5
        	elseif Input.pressed("o") and code==5 then
        		code=6
        	elseif Input.pressed("n") and code==6 then
        		code=7
        	else
        		local valid = false
        		if #Input.key_pressed==0 then
        			valid = true
        		else
	        		for k,v in pairs(Input.key_pressed) do
	        			if Utils.containsValue({"s", "p", "a", "m", "t", "o", "n"}, k) then
	        				valid = true
	        				break
	        			end
	        		end
	        	end
        		print("valid ="..tostring(valid))
        		if not valid then
        			code=0
               	end
            end
        	if code==7 then
        		Assets.playSound("spare")
        		legit_gaster_noises:stop()
        		return true
        	end]]

        	if legit_gaster_noises:isPlaying() then
        		return false
        	end

        	return true
        end)
        if was_playing then
            Game.world.music:resume()
        end
        cutscene:text("* It's nothing but garbage noise.")
    end)
end

return item