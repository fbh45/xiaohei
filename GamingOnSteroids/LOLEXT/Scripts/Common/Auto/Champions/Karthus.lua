Q = {Range = 874, Radius = 100, Delay = .5, Speed = 999999}
W = {Range = 1000, Radius = 800, Delay = .25, Speed = 999999}
E = { Range = 500 }

function LoadScript()
	Menu = MenuElement({type = MENU, id = myHero.networkID, name = myHero.charName})
	Menu:MenuElement({id = "Skills", name = "技能", type = MENU})
	
	Menu.Skills:MenuElement({id = "Q", name = "[Q]荒芜", type = MENU})
	Menu.Skills.Q:MenuElement({id = "AccuracyAuto", name = "自动精度", value = 4, min = 1, max = 6, step = 1})
	Menu.Skills.Q:MenuElement({id = "AccuracyCombo", name = "走砍精度", value = 2, min = 1, max = 6, step = 1})
	Menu.Skills.Q:MenuElement({id = "Mana", name = "法力限制", value = 15, min = 5, max = 100, step = 5 })
	Menu.Skills.Q:MenuElement({id = "FarmMana", name = "清小兵法力上限", value = 15, min = 5, max = 100, step = 5 })
	
	Menu.Skills:MenuElement({id = "W", name = "[W]痛苦之墙", type = MENU})
	Menu.Skills.W:MenuElement({id = "Auto", name = "在固定自动施放", value = true})
	Menu.Skills.W:MenuElement({id = "Combo", name = "自动转换走砍", value = false})
	Menu.Skills.W:MenuElement({id = "Assist", name = "辅助键",value = false,  key = 0x71})	
	
	Menu.Skills:MenuElement({id = "E", name = "[E]亵渎", type = MENU})
	Menu.Skills.E:MenuElement({id = "Auto", name = "敌人在范围内时自动激活", value = true})
	Menu.Skills.E:MenuElement({id = "Mana", name = "法力限制", value = 15, min = 5, max = 100, step = 5 })
		
	
	Menu.Skills:MenuElement({id = "R", name = "[R]安魂曲", type = MENU})
	Menu.Skills.R:MenuElement({id = "Auto", name = "在被动状态下自动使用（如果会杀死）", value = true})
	Menu.Skills.R:MenuElement({id = "Draw", name = "绘制可杀数量", value = true})
	
	
	Menu.Skills:MenuElement({id = "Combo", name = "走砍键",value = false,  key = string.byte(" ") })	
	
	LocalDamageManager:OnIncomingCC(function(target, damage, ccType) OnCC(target, damage, ccType) end)
	Callback.Add("Tick", function() Tick() end)
end

local NextTick = LocalGameTimer()
local EActivatedAt = 0
function Tick()
	if LocalGameIsChatOpen() then return end
	local currentTime = LocalGameTimer()
	if NextTick > currentTime then return end	
	
	local eData = myHero:GetSpellData(_E)
	local target = NearestEnemy(myHero.pos, E.Range)
	if target and Menu.Skills.E.Auto:Value() then
		if eData.toggleState ==1 and CurrentPctMana(myHero) >= Menu.Skills.E.Mana:Value() then
			EActivatedAt = LocalGameTimer()
			Control.CastSpell(HK_E)
		elseif eData.toggleState == 2 and EActivatedAt > 0 and CurrentPctMana(myHero) < Menu.Skills.E.Mana:Value() then
			Control.CastSpell(HK_E)
			EActivatedAt = 0
		end
	--Don't deactivate E if we are the ones who turned it on!
	elseif eData.toggleState == 2 and LocalGameTimer() - EActivatedAt > .25 then
		EActivatedAt = 0
		Control.CastSpell(HK_E)
	end
	
	local target = GetTarget(Q.Range)
	if target and Ready(_Q) and (CurrentPctMana(myHero) > Menu.Skills.Q.Mana:Value() or Menu.Skills.Combo:Value()) then
		local accuracyRequired = Menu.Skills.Q.AccuracyAuto:Value()
		if Menu.Skills.Combo:Value() and Menu.Skills.Q.AccuracyCombo:Value() < accuracyRequired then
			accuracyRequired = Menu.Skills.Q.AccuracyCombo:Value()
		end
		local castPosition, accuracy = LocalGeometry:GetCastPosition(myHero, target, Q.Range, Q.Delay,Q.Speed, Q.Radius, Q.Collision, Q.IsLine)
		if castPosition and accuracy >= accuracyRequired and LocalGeometry:IsInRange(myHero.pos, castPosition, Q.Range) then
			NextTick = LocalGameTimer() + .25
			CastSpell(HK_Q, castPosition)
			return
		end
	end
	
	local target = GetTarget(W.Range)
	if target and Ready(_W) then
		--Get target to see if its already immobile		
		local castPosition, accuracy = LocalGeometry:GetCastPosition(myHero, target, Q.Range, Q.Delay,Q.Speed, Q.Radius, Q.Collision, Q.IsLine)
		if castPosition then
			if Menu.Skills.W.Assist:Value() or (accuracy > 3 and Menu.Skills.W.Auto:Value()) then
				NextTick = LocalGameTimer() + .25
				CastSpell(HK_W, castPosition)
				return
			end
		end
	end
	NextTick = LocalGameTimer() + .05
end

function OnCC(target, damage, ccType)
	if target.isEnemy and CanTarget(target) and CanTarget(target) and LocalDamageManager.IMMOBILE_TYPES[ccType] then		
		if Ready(_Q) and CurrentPctMana(myHero) >= Menu.Skills.Q.Mana:Value() and Menu.Skills.Q.Auto:Value() and LocalGeometry:IsInRange(myHero.pos, target.pos, Q.Range) then
			NextTick = LocalGameTimer() + .25
			CastSpell(HK_Q, target.pos,true)
			return
		end
	end
end