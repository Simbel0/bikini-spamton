local Spamton, super = Class(EnemyBattler)

function Spamton:init()
    super.init(self)

    -- Enemy name
    self.name = "Spamton"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("spamtong")

    -- Enemy health
    self.max_health = 600
    self.health = 600
    -- Enemy attack (determines bullet damage)
    self.attack = 8
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    self.exit_on_defeat = false

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "balls",
        "absorb_hearts",
        "run_away"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "ENL4RGE Yourself",
        "IT'S THE [Beach Episode]",
        "PLEASE SEND ME LOTS OF [Die]",
        "FEEL MY [Big Red][$!@$]",
        "TRANSMIT KROMER",
        "Get Big and WIN [Sp1cy Pr1zes!]",
        "[Press F1 For] HELP",
        "HELP"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "He wants to do \"[color:yellow]Fanservice[color:reset].\"\nGo along but don't go [color:yellow]too far[color:reset]!"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Great ENEMY! SUSCRIBE NOW!",
        "* please FOLLOW MY ONLYPipis!",
        "* Spamton mutters \"1997.\"",
        "* Smells like KROMER.\n[wait:5]...And anime tropes.",
        "* CONGRULATIONS YOU ARE THE 100th VISITOR!!! CLICK HERE TO [+18]",
        "* Spamton flashes an award-losing smile.",
        "* Spamton has seen some stuff.",
        "* GARANTED THICC WITH 10 CCCCCCCCCC"
    }

    self.turns = 0

    -- Register act called "Smile"
    self:registerAct("Deal")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("HealDeal", "DEAL &\nHEAL 60", nil, 50)
    self.deal = 1
    self.seen_deal = {false}
    self.shake = false
end

function Spamton:update()
    if self.shake then
        self.sprite.shake_x = 1
        self.sprite.shake_y = 1
    else
        if self.sprite.shake_x~=0 then
            self.sprite.shake_x = 0
            self.sprite.shake_y = 0
        end
    end
    super.update(self)
end

function Spamton:onAct(battler, name)
    if name == "Deal" or name=="HealDeal" then
        if name == "HealDeal" then
            battler:heal(60)
        end
        local c = "* seggs"
        local deal = self.deal

        if deal == 1 then
            c = function(cutscene)
                if not self.seen_deal[1] then
                    self:setSprite("grab")
                    cutscene:battlerText(self, "HEY HEY HEY!\nHERE'S THE NEXT\n[Big Hit Sensation]\nAROUND TOWN!!")
                    self.shake = true
                    self:setAnimation("laugh_left")
                    cutscene:battlerText(self, "ONLY [[Full Moon]] ATTRACT\nTHE MASS AND THAT'S WHERE\nWE GOTTA HIT!")
                    self:setSprite("arms_up")
                    self.shake = false
                    cutscene:battlerText(self, "WHAT DO YOU SAY??\nWANNA KNOW MORE?")
                else
                    cutscene:battlerText(self, "KID!! IN BUISINESS YOU\nHAVE TO BE INTERESTED\nAT ALL TIMES!!")
                end
                cutscene:choicer({"NOT INTERESTED", "TELL ME MORE"})
                if cutscene.choice == 2 then
                    self:addMercy(20)
                    Assets.playSound("shine")
                    self.deal = 2
                    self.shake = true
                    self:setAnimation("laugh_right")
                    cutscene:battlerText(self, "THAT'S THE ATTITUDE, KID!! KEEP\nTHE GODD OLD STYLE OF [[1997]]\nWHILE KEEPING UP TO DATE WITH\n[[0 year old]]!!!")
                    self.shake = false
                    self:setSprite("idle")
                elseif cutscene.choice == 1 then
                    self.seen_deal[1] = true
                    Assets.playSound("error")
                    self:setSprite("grab")
                    cutscene:battlerText(self, "WRONG!! WRONG\nWRONG WRONG!!!")
                    self.shake = false
                    self:setSprite("idle")
                end
            end
        elseif deal == 2 then
            c = function(cutscene)
                if not self.seen_deal[deal] then
                    self:setSprite("hands")
                    cutscene:battlerText(self, "NOW WE GOTTA POSE\nLIKE SUPER [$!$!]!!!")
                    self.shake = true
                    self:setSprite("grab")
                    cutscene:battlerText(self, "[Subscribe Plan] COMES FAST\nWHEN SHOWING OFF YOUR [[Products]]")
                else
                    self.shake = true
                    self:setAnimation("laugh_left")
                    cutscene:battlerText(self, "HAV E ANY OTHER KROMER??")
                end
                cutscene:choicer({"POSE", "DON'T POSE"})
                if cutscene.choice == 1 then
                    Assets.playSound("error")
                    self.seen_deal[deal] = true
                    self.shake = true
                    self:setAnimation("laugh_left")
                    cutscene:battlerText(self, "HOLY [Cungadero] KID!!\nTHIS IS A BIG [Breach\nOf Contract]!!")
                    self:setAnimation("laugh_right")
                    cutscene:battlerText(self, "WE CAN'T RISK HAVING\nOURSELVES GETTING [Killed]")
                    self.shake = false
                    self:setSprite("hands")
                    cutscene:battlerText(self, "GOOD THING WE CAN GET\nYOU OFF WITH A\nLITTLE [Payement]")
                    Game.battle.money = Game.battle.money - 25
                    Assets.playSound("hypnosis")
                    cutscene:text("* (Spamton absorbs your KROMER to get you unbanned.)\n* (Wrong choice...?)")
                    self:setSprite("idle")
                elseif cutscene.choice == 2 then
                    self:addMercy(20)
                    self.deal = 3
                    Assets.playSound("shine")
                    self.shake = true
                    self:setSprite("arms_up")
                    cutscene:battlerText(self, "THAT'S RIGHT, WE\nCAN'T GO TOO FAR!!")
                    self:setAnimation("laugh_right")
                    cutscene:battlerText(self, "THIS IS A [Damn Crazy] PLACE,\nYOU CAN [Die] FOR ANY REASON!!!")
                    self.shake = false
                    self:setSprite("idle")
                    cutscene:battlerText(self, "BETTER TO KEEP IT\n[Low And Clean]!!!")
                end
            end
        elseif deal == 3 then
            c = function(cutscene)
                if not self.seen_deal[deal] then
                    cutscene:battlerText(self, "YOU KNOW, THIS [Public Underwear]\nISN\"t TOO BAD")
                    self:setSprite("grab")
                    self.shake = true
                    cutscene:battlerText(self, "YOU SHOULD TRY\nIT FOR YOURSELF!!")
                else
                    self:setSprite("arms_up")
                    self.shake = true
                    cutscene:battlerText(self, "PUT THE [Beach Outfit] ON!!")
                end
                cutscene:choicer({"ACCEPT", "REFUSE"})
                if cutscene.choice == 1 then
                    Assets.playSound("error")
                    self.seen_deal[deal] = true
                    self.shake = false
                    self:setSprite("grab")
                    cutscene:battlerText(self, "COME ON!! YOU SHOULD\nKNOW THE GIST BY NOW")
                    self:setAnimation("laugh_right")
                    cutscene:battlerText(self, "DIDN't YOU LISTEN TO\nYOUR LITTLE [Narrator]???")
                    self:setSprite("idle")
                elseif cutscene.choice == 2 then
                    self:addMercy(20)
                    self.deal = 4
                    Assets.playSound("shine")
                    self.shake = true
                    self:setAnimation("laugh_right")
                    cutscene:battlerText(self, "WHAT??? YOU DON'T HAVE\nWHAT IT TAKES TO BE\n[Fan Favorite]???")
                    self:setAnimation("laugh_left")
                    cutscene:battlerText(self, "AHAHAHAH!!! YOU'RE\n[Killing] ME!! AH AH\nHA HA!!")
                    self.shake = false
                    self:setSprite("idle")
                end
            end
        elseif deal == 4 then
            c = function(cutscene)
                if not self.seen_deal[deal] then
                    cutscene:battlerText(self, "COME TO THINK OF IT,\nI UNDERTAND YOUR\n[3rd Person POV]")
                    self:setSprite("grab")
                    cutscene:battlerText(self, "PLEASE ALLOW ME TO\nGET CLOSER TO\n[Help] YOU THEN!!")
                else
                    self:setSprite("dark")
                    cutscene:battlerText(self, "[Get some help.]")
                end
                cutscene:choicer({"NO HELP", "GET HELP"})
                if cutscene.choice == 2 then
                    Assets.playSound("error")
                    self.seen_deal[deal] = true
                    self:setSprite("arms_up")
                    cutscene:battlerText(self, "UH OH!! HEAR THAT\n[Slamming Noise]???\n[You've Got Mail]")
                    self:setAnimation("laugh_right")
                    cutscene:battlerText(self, "I ONLY WANTED TO HELP BUT\nSEEMS LIKE IT WAS\n[See Yourself In\nA Whole New Light]!!")
                    self.shake = false
                    Game.battle.money = Game.battle.money - 25
                    Assets.playSound("hypnosis")
                    cutscene:text("* (Spamton absorbs your KROMER to get you unbanned.)\n* (Wrong choice...?)")
                    self:setSprite("idle")
                elseif cutscene.choice == 1 then
                    self:addMercy(20)
                    Assets.playSound("shine")
                    self.deal = 5
                    self:setSprite("arms_up")
                    cutscene:battlerText(self, "AH???? ARE YOU SCARED\nOF MY [[Sitting Cheeks]]??")
                    self:setAnimation("laugh_left")
                    self.shake = true
                    cutscene:battlerText(self, "FINE FINE, WE'LL FIND\nANOTHER [Deal] BEFORE I\n[Die] THEN AH AH AH!!")
                    self.shake = false
                    self:setSprite("idle")
                end
            end
        elseif deal == 5 then
            c = function(cutscene)
                if not self.seen_deal[deal] then
                    cutscene:battlerText(self, "RULES ARE [$!$#] NOWADAYS\nAREN'T THEY")
                    cutscene:battlerText(self, "MAYBE JUST STAYING IN\nTHIS [Fine Piece Of Work] IS\nJUST ENOUGH??")
                else
                    self.shake = true
                    self:setSprite("grab")
                    cutscene:battlerText(self, "SO WHAT DO YOU THINK???")
                end
                cutscene:choicer({"AGREE", "DISAGREE"})
                if cutscene.choice == 2 then
                    Assets.playSound("error")
                    self.seen_deal[deal] = true
                    self:setSprite("grab")
                    cutscene:battlerText(self, "BUT WHAT CAN I DO THEN??")
                    self.shake = false
                    self:setSprite("idle")
                elseif cutscene.choice == 1 then
                    self:addMercy(19)
                    self.deal = 6
                    Assets.playSound("shine")
                    self.shake = false
                    self:setSprite("arms_up")
                    cutscene:battlerText(self, "YEAH THAt'S JUST ENOUGH\nTO GET [Ink Flows Into A\nDark Puddle]")
                    self.shake = true
                    self:setAnimation("laugh_left")
                    cutscene:battlerText(self, "YOU TRULY DID A BIGSHOT\nMOVE KID, YOU'VE SAVED\nMY [$!@!]")
                    self.shake = false
                    self:setSprite("idle")
                    cutscene:battlerText(self, "YOU MUST BE LIKE ME")
                    cutscene:battlerText(self, "[Desperate]")
                    self:setSprite("arms_up")
                    self.shake = true
                    cutscene:battlerText(self, "BUT I BELIEVE WE CAME\nTO A [End Conclusion]")
                    self:setAnimation("laugh_left")
                    cutscene:battlerText(self, "WE NOW KNOW WHAT\nWE WANT TO REACH OUR\n[Donation Goal]")
                    self:setSprite("idle")
                    self.shake = false
                    cutscene:battlerText(self, "[Hyperlink Blocked].")
                    self.shake = true
                    self:setSprite("grab")
                    cutscene:battlerText(self, "SO WILL YOU TAKE\nTHE FINAL DEAL??")
                    self.shake = false
                    self:setSprite("idle")
                    cutscene:battlerText(self, "REMEMBER,\nI CAN'T FORCE YOU\nTHIS IS UP TO YOU!!")
                    cutscene.choice = 0
                    while cutscene.choice~=2 do
                        cutscene:choicer({"NO DEAL", "YES DEAL"})
                        if cutscene.choice == 1 then
                            self.seen_deal[deal] = true
                            self.sprite.scale_x = self.sprite.scale_x + 0.025
                            self.x = 550 - (self.sprite.width/2)*self.sprite.scale_x
                            cutscene:battlerText(self, "WRONG")
                        end
                    end
                    self.sprite.scale_x = 1
                    self.x = 550
                    self:addMercy(100)
                    Assets.playSound("shine")
                    self:setSprite("arms_up")
                    Game.battle.music:stop()
                    cutscene:wait(2)
                    cutscene:battlerText(self, "THEN A DEAL'S A DEAL!!")
                    self:setSprite("grab")
                    cutscene:battlerText(self, "PLEASURE DOING BUISINESS\nWITH YOU KID!!!")
                    Game:setFlag("defeat", "deal")
                    cutscene:after(function() Game.battle:setState("VICTORY") end)
                end
            end
        end

        self:setSprite("idle")
        Game.battle:startActCutscene(c)
        return
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Spamton:getEncounterText()
    self.turns = self.turns +1
    if self.turns == 1 then
        return "* THERE'S NOTHING WRONG WITH HAVING A NICE [@$$] EVERY ONCE IN A WHILE"
    elseif self.turns == 2 then
        return "* There's nothing wrong.\nThere's NOTHING WRONG.\nTHERE'S NOTHING WRONG."
    end
    return super.getEncounterText(self)
end

function Spamton:getEnemyDialogue()
    dialogue = super.getEnemyDialogue(self)
    if dialogue == "FEEL MY [Big Red][$!@$]" then
        self.wave_override = "run_away"
    elseif dialogue == "PLEASE SEND ME LOTS OF [Die]" then
        self.wave_override = "absorb_hearts"
    elseif dialogue == "IT'S THE [Beach Episode]" then
        self.wave_override = "balls"
    elseif dialogue == "[Press F1 For] HELP" then
        table.remove(self.dialogue, 7)
    end
    return dialogue
end

function Spamton:onDefeat(damage, battler)
    Game:setFlag("defeat", "violence")
end

return Spamton