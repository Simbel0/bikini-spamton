return function(cutscene, script, chara)
    local spamton = cutscene:spawnNPC("spamtong", 640, 233)
    local kris = cutscene:getCharacter("kris")
    local pitch_timer
    if not Game:getFlag("quick", false) then
        local dumpster = cutscene:getEvent("dumpster")

        Assets.playSound("locker")
        dumpster:setSprite("events/dumpster_nakami")
        local bg_dumpster = Sprite("events/dumpster_open", dumpster.x+1, dumpster.y-(dumpster.sprite.height*2)-5)
        bg_dumpster.layer = 0.45
        bg_dumpster:setScale(2)
        Game.world:addChild(bg_dumpster)
        dumpster.sprite.shake_x = 4
        bg_dumpster.shake_x = 4
        dumpster.y = dumpster.y - dumpster.sprite.height-9
        cutscene:wait(1)
        cutscene:detachCamera()
        spamton.layer = 0.5
        Game.world:addChild(spamton)
        spamton.sprite.flip_x = true
        Game.world.timer:tween(2, spamton, {y=175})
        cutscene:wait(2)
        Game.world.music:play("spamton_meeting_intro")

        cutscene:text("* HOLY     !! THIS IS PERFECT!!!", nil, spamton)
        spamton:setSprite("laugh_left")
        cutscene:text("* I C4N NOW BE [[Number 1 Tumblr Sexyman2022]]!!", nil, spamton)
        spamton:setSprite("idle")
        cutscene:text("* ME SPAM", nil, spamton, {auto=true})
        spamton:setSprite("laugh_left")
        cutscene:text("* SPAMTON G. SPAMTON!!", nil, spamton)

        spamton:setAnimation("laugh_left")
        local laugh = Assets.playSound("spamton_laugh_noise")
        laugh:setLooping(true)
        cutscene:wait(2)
        laugh:stop()
        spamton:setSprite("idle")

        Game.world.music:fade(0, 1, function()
            Game.world.music:stop()
        end)
        cutscene:wait(0.75)
        spamton.sprite.flip_x = false
        cutscene:wait(0.1)
        spamton.alert_icon = Sprite("effects/alert", spamton.sprite.width/2)
        spamton.alert_icon:setOrigin(0.5, 1)
        spamton.alert_icon.layer = 100
        spamton:addChild(spamton.alert_icon)
        Game.world.timer:after(0.8, function()
            spamton.alert_icon:remove()
        end)

        cutscene:wait(1)

        cutscene:text("* WELL! IF I AIn\"T [%!$@] RIGHT NOW IT IS A..", nil, spamton)
        Game.world.timer:after(0.4, function()
            cutscene:walkTo(kris, 390, 280, 0.25, "right", true)
        end)
        cutscene:wait(cutscene:jumpTo(spamton, 520, 280, 15, 1, "jump", "landed"))
        cutscene:wait(0.5)
        Game.world.music:play("spamton_meeting", 1, 1)
        spamton_slide = true
        spamton_slide_values = {5, 6}
        spamton_inten_x = 520
        pitch_timer = Game.world.timer:every(0.2, function()
            if Game.world.music and Game.world.music:isPlaying() then
                Game.world.music.pitch = Utils.random(0.9, 1.1)
            else
                return false
            end
        end)

        cutscene:during(function()
            if not (spamton.sprite.shake_x~=0 or spamton.sprite.shake_y~=0) then
                if spamton_slide then
                    spamton.x = spamton_inten_x+math.cos(Kristal.getTime()*spamton_slide_values[1])*spamton_slide_values[2]
                else
                    if spamton_inten_x and spamton.x~=spamton_inten_x then
                        spamton.x = spamton_inten_x
                    end
                end
            end
        end)

        spamton:setAnimation("laugh_left")
        cutscene:text("* LIGHT nER! HEY-HE Y HEY!!!", nil, spamton)
        spamton_slide = false
        spamton:setSprite("idle")
        cutscene:wait(0.2)
        cutscene:text("* LOOKS LIKE YOU'RE [All Alone On A Late Night?]", nil, spamton)
        spamton_slide = true
        spamton_slide_values = {5, 6}
        spamton:setSprite("hands")
        cutscene:text("* ALL YOUR FRIENDS, [Abandoned you for the slime]] YOU ARE?", nil, spamton)
        spamton_slide_values = {10, 10}
        spamton:setSprite("hands_look_down")
        cutscene:text("* SALES, GONE DOWN THE [[Drain]] [[Drain]]??", nil, spamton)
        spamton_slide_values = {100, 2}
        spamton:setSprite("hands_look_down_dark")
        cutscene:text("* LIVING IN A GODDAMN GARBAGE CAN???", nil, spamton)
        spamton_slide = false

        spamton:setAnimation({"laugh_left", 1/12, true})
        laugh:play()
        cutscene:wait(1)
        laugh:stop()
        spamton.sprite:pause()
        cutscene:wait(0.5)
        spamton:setSprite("up_look_down")
        cutscene:wait(cutscene:slideTo(spamton, 560, 270, 0.1))
        cutscene:walkTo(kris, 370, 280, 0.25, "right", true)
        Assets.playSound("locker")
        spamton:setSprite("up_punch")
        dumpster.graphics.spin = math.rad(35)
        bg_dumpster.graphics.spin = math.rad(35)
        Game.world.camera:shake()
        Game.world.timer:tween(0.5, dumpster, {x=SCREEN_WIDTH, y=0}, nil, function()
            dumpster:explode()
        end)
        Game.world.timer:tween(0.5, bg_dumpster, {x=SCREEN_WIDTH, y=0}, nil, function()
            bg_dumpster:remove()
        end)
        cutscene:wait(2)
        cutscene:text("* ...fuck", nil, spamton, {auto=true})
        spamton_inten_x = 560
        spamton_slide = true
        spamton_slide_values = {5, 6}
        spamton:setSprite("idle")
        cutscene:text("* WELL HAVE I GOT A [[Specil Deal]] FOR LONELY [[Hearts]] LIKE YOU!!", nil, spamton)

        spamton_slide = false
        spamton_inten_x = nil
        spamton.sprite.flip_x = true
        spamton:setSprite("hands_look_down")
        cutscene:wait(cutscene:slideTo(spamton, 640, 280, 0.5))

        cutscene:setSpeaker(spamton)

        cutscene:text("* YOU SEE KID, I HAD AN [[Epiphany]] RECENTLY")
        spamton:shake()
        spamton:setSprite("grab")
        spamton.sprite.flip_x = false
        cutscene:text("* TIMES HAVE CHANGED AND ITS HARDER TO MOVE THEIR [[Silly Strings]]")
        cutscene:slideTo(spamton, 600, 280, 0.5)
        cutscene:text("* BUT I HAVE FOUND THE [[Satisfied Or]][[Satisfied]] SOLUTION!!!")
        spamton:setSprite("hands")
        spamton_inten_x = 600
        spamton_slide = true
        cutscene:text("* [[Checked the Internet lately?]]")
        cutscene:text("* PEOPLE ONLY WANTS ONE [[Deal]] NOWADAYS")
        spamton_slide = false
        spamton_inten_x = nil
        cutscene:slideTo(spamton, 560, 280, 0.5)
        spamton:setSprite("hands_look_down_dark")
        cutscene:text("* THEY WANT TRUE")
        spamton:setSprite("laugh_large_1")
        cutscene:text("* [[BIG SHOT!!!]]")
        spamton:setSprite("laugh_large_2")
        cutscene:text("* [[BIG SHOT!!!!!]]")
        spamton:setSprite("laugh_large_3")
        cutscene:text("* [[BIG SHOT!!!!!]]")
        spamton:setSprite("arms_up")
        cutscene:text("* THAT'S RIGHT!! THEY WANT [[BIG SHOTS]]!! [[Of Any Type And Genre At Half-Prize]]")
        cutscene:wait(cutscene:slideTo(spamton, 530, 280, 0.5))
        cutscene:text("* THEY'D GIVE YOU ANYTHING IF YOU HAVE [[XXL]] [[Sitting Cheeks]]")
        cutscene:wait(cutscene:slideTo(spamton, 490, 280, 0.5))
        cutscene:text("* IT'S AN INCREDIBLE OPPORTUNITY FOR PEOPLE LIKE US")
        cutscene:wait(cutscene:slideTo(spamton, 460, 280, 0.5))
        cutscene:text("* PEOPLE LIKE US.")
        cutscene:wait(cutscene:slideTo(spamton, 440, 280, 0.5))
        spamton:setSprite("idle")
        cutscene:text("* WHO LACKS.")
        cutscene:wait(cutscene:slideTo(spamton, 420, 280, 1))
        cutscene:wait(0.5)

        spamton:setSprite("dark")
        cutscene:text("* [[Hyperlink Blocked]]")

        laugh:setLooping(false)
        laugh:play()
        spamton:setAnimation("laugh_glitch")
        cutscene:wait(cutscene:slideTo(spamton, 640, 280, 0.7))
        cutscene:wait(function()
            return not laugh:isPlaying()
        end)

        cutscene:text("* INCREDIBLE, ISN'T IT??\n[[A One Time Ticket To]] GLORY!!!")
        spamton:setAnimation("laugh_left")
        spamton_inten_x = spamton.x
        spamton_slide = true
        cutscene:text("* THAT IS WHY I HAVE [[Finds a lovely bikini and puts it on! It's quite revealing!]]")
        spamton_slide = false
        spamton:setSprite("arms_up")
        cutscene:text("* AND LOOK AT ME NOW, I AM [[Fanservice Certified]]!!!")
        spamton:setAnimation("laugh_glitch")
        spamton_slide = true
        cutscene:text("* I DON'T EVEN AIM AT [[BIG]] ANYMORE!!! ALL [[SHOTS]] ARE IN MY GRISP!!")

        spamton_inten_x = nil
        spamton_slide = false
        spamton:setSprite("grab")
        cutscene:walkTo(kris, 350, 280, 0.25, "right", true)
        cutscene:wait(cutscene:slideTo(spamton, 560, 280, 0.5))
        cutscene:text("* AND IF WE COMBINE THAT WITH YOUR [[HeartShapeObject]]")
        spamton_inten_x = spamton.x
        spamton_slide = true
        cutscene:text("* WE WILL SEE THE [[Light]] IN A MATTER OF [[Fast Delivery]]")

        spamton_inten_x = nil
        spamton_slide = false

        cutscene:walkTo(kris, 320, 280, 0.25, "right", true)
        cutscene:wait(cutscene:slideTo(spamton, 450, 280, 0.5))
        cutscene:text("* NOT CONVINCED?? WELL HERE\'s ONE LAST ARGUMENT YOU CAN'T REFUTE")
        cutscene:wait(0.5)
        spamton:setSprite("dark")
        cutscene:text("* Both you and me are cursed by them since a long time ago...")

        cutscene:slideTo(spamton, 600, 280, 0.5)
        spamton:setAnimation({"laugh_left", 1/12, true})
        laugh:play()
        cutscene:wait(function()
            return not laugh:isPlaying()
        end)
        cutscene:wait(0.5)
        --spamton = spamton:convertToEnemy()
        Game:setFlag("quick", true)
        Game:saveQuick("spawn")
    else
        local dumpster = cutscene:getEvent("dumpster")

        Assets.playSound("locker")
        dumpster:setSprite("events/dumpster_nakami")
        local bg_dumpster = Sprite("events/dumpster_open", dumpster.x+1, dumpster.y-(dumpster.sprite.height*2)-5)
        bg_dumpster.layer = 0.45
        bg_dumpster:setScale(2)
        Game.world:addChild(bg_dumpster)
        dumpster.sprite.shake_x = 4
        bg_dumpster.shake_x = 4
        dumpster.y = dumpster.y - dumpster.sprite.height-9
        cutscene:wait(0.5)
        cutscene:detachCamera()
        spamton.layer = 0.5
        Game.world:addChild(spamton)
        spamton.sprite.flip_x = true
        Game.world.timer:tween(1, spamton, {y=175})
        cutscene:wait(1)
        spamton.sprite.flip_x = false
        cutscene:wait(0.1)
        spamton.alert_icon = Sprite("effects/alert", spamton.sprite.width/2)
        spamton.alert_icon:setOrigin(0.5, 1)
        spamton.alert_icon.layer = 100
        spamton:addChild(spamton.alert_icon)
        Game.world.timer:after(0.8, function()
            spamton.alert_icon:remove()
        end)
        cutscene:wait(0.8)
        Game.world.timer:after(0.4, function()
            cutscene:walkTo(kris, 390, 280, 0.25, "right", true)
        end)
        cutscene:wait(cutscene:jumpTo(spamton, 520, 280, 15, 1, "jump", "landed"))
        cutscene:wait(0.5)
        dumpster:explode()
        bg_dumpster:remove()
        Game.world.music:play("spamton_meeting", 1, 1)
        Game.world.music:pause()
        spamton_slide = false
        spamton_slide_values = {5, 6}
        spamton_inten_x = 520
        pitch_timer = Game.world.timer:every(0.2, function()
            if Game.world.music and Game.world.music:isPlaying() then
                Game.world.music.pitch = Utils.random(0.9, 1.1)
            end
        end)

        cutscene:during(function()
            if not (spamton.sprite.shake_x~=0 or spamton.sprite.shake_y~=0) then
                if spamton_slide then
                    spamton.x = spamton_inten_x+math.cos(Kristal.getTime()*spamton_slide_values[1])*spamton_slide_values[2]
                else
                    if spamton_inten_x and spamton.x~=spamton_inten_x then
                        spamton.x = spamton_inten_x
                    end
                end
            end
        end)

        spamton:setAnimation({"laugh_left", 1/12, true})
        local laugh = Assets.playSound("spamton_laugh_noise")
        cutscene:wait(function()
            return not laugh:isPlaying()
        end)
        cutscene:wait(0.5)
        --spamton = spamton:convertToEnemy()
    end
    cutscene:startEncounter("spamton", true, spamton)
    --spamton = spamton:convertToNPC()
    Game.world.music:resume()
    cutscene:setSpeaker("spamtong")
    if Game:getFlag("defeat", "deal")=="deal" then
        spamton_inten_x = spamton.x
        spamton_slide = true
        spamton_slide_values = {5, 20}
        spamton:setSprite("idle")
        cutscene:text("* SEEMS LIKE I CAN'T DO MUCH IN THAT ATTIRE...")
        spamton:setSprite("arms_up")
        cutscene:text("* BUT THAT'S OKAY!! I HAVE A MUCH BETTER [One Way Ticket] IN MIND!!!")
        spamton:setSprite("idle")
        cutscene:text("* I'LL GIVE YOU THE DETAILS AT MY [[Home-made Storefront Site]]")
        cutscene:text("* IN THE [[Trash Area Closed For Repairs.]]")
        spamton:setSprite("dark")
        spamton_slide = false
        cutscene:text("* COME[wait:5] ALONE...")
        spamton_slide = true
        spamton_slide_values = {7, 20}
        spamton:setAnimation("laugh_left")
        cutscene:text("* AND DON'T FORGET..")
        spamton:setSprite("idle")
        cutscene:text("* TO [Like And Subscribe] FOR MORE [[Hyperlink Blocked.]]")
        spamton_slide = false
        spamton_inten_x = nil
        local x=spamton.x+290
        spamton:setAnimation("laugh_glitch")
        Game.world.timer:tween(1, spamton, {x = x})
        local wait, text = cutscene:text("* HAEAHAEAHAEAHAEAH!!")
        Game.world.music:fade(0, 1)
        cutscene:wait(1.5)
        spamton:setSprite("idle")
        Game.world.timer:tween(1, spamton, {x = 750})
        cutscene:wait(1.3)
        cutscene:text("* BUT I'LL KEEP THE [[Summer Outfit]]")
        Game.world.timer:tween(0.5, spamton, {x = x}, nil, function()
            spamton.sprite.alpha = 0
            spamton:remove()
        end)
        cutscene:wait(1)
        cutscene:wait(cutscene:panTo(kris))
        cutscene:attachCamera()
        cutscene:look(kris, "down")
    else
        Game.world.music:stop()
        spamton:setAnimation("laugh_left")
        spamton_inten_x = spamton.x
        spamton_slide = true
        spamton_slide_values = {10, 10}
        cutscene:wait(1)
        cutscene:text("* HEY! WHAT ABOUT THE SAYING [Make Love, Not War]!")
        cutscene:text("* I'D PREFER [Kromer] BUT EVEN THEN, YOU PREFER [[Beating People Up]]!!")
        cutscene:text("* HOW CAN A [HonestMan] LIKE ME SUPPOSED TO [Rip People Off]")
        spamton:shake()
        Assets.playSound("damage")
        spamton_slide_values = {13, 10}
        cutscene:wait(1)
        cutscene:text("* WHEN SOME KIDS WANDERS AROUND, THROWING [Sand] ON OUR FACES")
        spamton:shake()
        Assets.playSound("damage")
        spamton_slide_values = {16, 10}
        cutscene:wait(1)
        cutscene:text("* YANKING THEIR [Noses], [Stomping] ON THEIR TOES")
        spamton:shake()
        Assets.playSound("damage")
        spamton_slide_values = {18, 10}
        cutscene:wait(1)
        cutscene:text("* WHAT'S THE NEXT [[Contract]]?? YOU'RE GONNA STEAL MY [[Glamorizing Oufit]]??")
        spamton:shake()
        Assets.playSound("damage")
        spamton_slide_values = {24, 10}
        cutscene:wait(1)
        cutscene:text("* FAT CHANCE, KID!!")
        spamton_slide = false
        spamton_inten_x = nil
        Assets.playSound("item")
        spamton:setSprite("grab")
        cutscene:text("* YOU SHOULD HAVE BUY MY [Commemorative Ring] INSTEAD!!")
        spamton:setSprite("hands")
        cutscene:text("* YOU WOULD OWN SOMETHING [Useful Anywhere] AT LEAST!")
        cutscene:text("* TOO BAD! SEE YOU KID!")
        spamton.sprite.flip_x = true
        Game.world.timer:tween(1, spamton, {x = spamton.x+200}, nil, function()
            spamton.sprite.alpha = 0
            spamton:remove()
        end)
        cutscene:wait(cutscene:panTo(kris))
        cutscene:attachCamera()
        cutscene:look(kris, "down")
    end
    Game.world.timer:cancel(pitch_timer)
    script:remove()

    --cutscene:text("* I SEE YOU HAVE [First Arrived First Served]")
    --cutscene:text("* HOW [%!@!] ARE YOU TO BE ABLE TO SEE MY [Beach Episode Outfit] in preview!")
    --cutscene:text("* KID LOOK AT ME, I AM [[Fanservice Certified]]")
    --cutscene:text("* EVEN MY [Sitting Cheeks] ARE [XXL]!!!")
end