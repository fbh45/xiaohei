Q = {	Range = 800,	Radius = 200,	Delay = 0.25,	Speed = 1150}
W = {	Range = 550	}
E = {	Range = 925,	Delay = 1,	Radius = 300,	Speed = 999999}

function LoadScript()
	Menu = MenuElement({type = MENU, id = myHero.networkID, name = myHero.charName})
	Menu:MenuElement({id = "Skills", name = "技能", type = MENU})
	
	Menu.Skills:MenuElement({id = "Q", name = "[Q]流星坠落", type = MENU})
	Menu.Skills.Q:MenuElement({id = "AccuracyCombo", name = "走砍精度", value = 2, min = 1, max = 6, step = 1 })
	Menu.Skills.Q:MenuElement({id = "AccuracyAuto", name = "自动精度", value = 3, min = 1, max = 6, step = 1 })
	Menu.Skills.Q:MenuElement({id = "Mana", name = "法力限制", value = 20, min = 1, max = 100, step = 5 })
	
	Menu.Skills:MenuElement({id = "W", name = "[W]星之灌注", type = MENU})
	Menu.Skills.W:MenuElement({id = "Targets", name = "目标设置", type = MENU})
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i)
		if hero and hero.isAlly and myHero ~= hero then
			Menu.Skills.W.Targets:MenuElement({id = hero.networkID, name = hero.charName, value = 50, min = 1, max = 100, step = 5 })		
		end
	end	
	Menu.Skills.W:MenuElement({id = "Health", tooltip ="How high must our health be to heal", name = "W最低健康", value = 35, min = 1, max = 100, step = 5 })
	Menu.Skills.W:MenuElement({id = "Mana", tooltip ="How high must our mana be to heal", name = "W最小法力值", value = 20, min = 1, max = 100, step = 5 })
		
	Menu.Skills:MenuElement({id = "E", name = "[E]星体结界", type = MENU})
	Menu.Skills.E:MenuElement({id = "Auto", name = "自动固定施放", value = true })
	Menu.Skills.E:MenuElement({id = "Count", name = "施放敌人#", value = 2, min = 1, max = 5, step = 1 })
	Menu.Skills.E:MenuElement({id = "Mana", name = "自动施放法力", value = 15, min = 1, max = 100, step = 5 })
	
	Menu.Skills:MenuElement({id = "R", name = "[R]祈愿", type = MENU})
	Menu.Skills.R:MenuElement({id = "Targets", name = "目标设置", type = MENU})
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i)
		if hero and hero.isAlly and myHero ~= hero then
			Menu.Skills.R.Targets:MenuElement({id = hero.networkID, name = hero.charName, value = 50, min = 1, max = 100, step = 5 })		
		end
	end
	Menu.Skills.R:MenuElement({id = "Count", name = "需要受伤人数", value = 2, min = 1, max = 5, step = 1 })
	
	
	
	
	LocalDamageManager:OnIncomingCC(function(target, damage, ccType, canDodge) OnCC(target, damage, ccType, canDodge) end)	
	Callback.Add("Tick", function() Tick() end)	
end



local NextTick = LocalGameTimer()
function Tick()
	local currentTime = LocalGameTimer()
	if NextTick > currentTime then return end
	if BlockSpells() then return end
	if myHero.activeSpell and myHero.activeSpell.valid and not myHero.activeSpell.spellWasCast then return end
	
	local saveCount = 0
	if Ready(_R) then
		for i = 1, LocalGameHeroCount() do
			local hero = LocalGameHero(i)
			if CanTargetAlly(hero) and Menu.Skills.R.Targets[hero.networkID] then
				local incomingDamage = LocalDamageManager:RecordedIncomingDamage(hero)
				local remainingLifePct = (hero.health - incomingDamage) / hero.maxHealth * 100
				if Menu.Skills.R.Targets[hero.networkID]:Value() >= remainingLifePct then
					saveCount = saveCount + 1
				end
			end
		end
	end
	if saveCount >= Menu.Skills.R.Count:Value() then
		CastSpell(HK_R)
		NextTick = LocalGameTimer() + .25		
		return
	end
	
	--Handle healing allies
	if Ready(_W) and CurrentPctLife(myHero) >= Menu.Skills.W.Health:Value() and CurrentPctMana(myHero) >= Menu.Skills.W.Mana:Value() then
		--Check all targets in range if they need to be healed
		for i = 1, LocalGameHeroCount() do
			local hero = LocalGameHero(i)
			if CanTargetAlly(hero) and LocalGeometry:IsInRange(myHero.pos, hero.pos, W.Range) and not hero.isMe then
				local incomingDamage = LocalDamageManager:RecordedIncomingDamage(hero)
				local remainingLifePct = (hero.health - incomingDamage) / hero.maxHealth * 100
				if Menu.Skills.W.Targets[hero.networkID]:Value() >= remainingLifePct then
					CastSpell(HK_W, hero)
					NextTick = LocalGameTimer() + .25
					return
				end
			end
		end
	end
	
	local target = GetTarget(E.Range)
	if target and Ready(_E) and CurrentPctMana(myHero) >= Menu.Skills.E.Mana:Value() then
		local castPosition, accuracy = LocalGeometry:GetCastPosition(myHero, target, E.Range, E.Delay, E.Speed, E.Radius, E.Collision, E.IsLine)
		local targetCount = EnemyCount(castPosition,E.Radius, E.Delay)
		if castPosition and targetCount >= Menu.Skills.E.Count:Value() or Menu.Skills.E.Auto:Value() and accuracy >= 4 then
			NextTick = LocalGameTimer() + .25
			CastSpell(HK_E, castPosition)
			return
		end
	end
	
	
	local target = GetTarget(Q.Range)	
	if target and Ready(_Q) and CurrentPctMana(myHero) >= Menu.Skills.Q.Mana:Value() then
		local accuracyRequired = ComboActive() and Menu.Skills.Q.AccuracyCombo:Value() or Menu.Skills.Q.AccuracyAuto:Value() 
		local castPosition, accuracy = LocalGeometry:GetCastPosition(myHero, target, Q.Range, Q.Delay, Q.Speed, Q.Radius, Q.Collision, Q.IsLine)
		if castPosition and accuracy >= accuracyRequired and LocalGeometry:IsInRange(myHero.pos, castPosition, Q.Range) then
			NextTick = LocalGameTimer() + .25
			CastSpell(HK_Q, castPosition)
			return
		end
	end
		
	
	NextTick = LocalGameTimer() + .05
end


function OnCC(target, damage, ccType, canDodge)
	if target.isEnemy and CanTarget(target) and LocalDamageManager.IMMOBILE_TYPES[ccType] then	
		if Ready(_E) and CurrentPctMana(myHero) >= Menu.Skills.E.Mana:Value() and Menu.Skills.E.Auto:Value() and LocalGeometry:IsInRange(myHero.pos, target.pos, E.Range) then
			NextTick = LocalGameTimer() + .25
			CastSpell(HK_E, target.pos)
			return
		end
		if Ready(_Q) and CurrentPctMana(myHero) >= Menu.Skills.Q.Mana:Value() and Menu.Skills.Q.AccuracyAuto:Value() >= 4 and LocalGeometry:IsInRange(myHero.pos, target.pos, Q.Range) then
			NextTick = LocalGameTimer() + .25
			CastSpell(HK_Q, target.pos)
			return
		end
	end
end