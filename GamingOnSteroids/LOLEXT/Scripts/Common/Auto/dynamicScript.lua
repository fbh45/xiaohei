local LocalGameTimer				= Game.Timer;
local LocalGameHeroCount 			= Game.HeroCount;
local LocalGameHero 				= Game.Hero;
local LocalGameMinionCount 			= Game.MinionCount;
local LocalGameMinion 				= Game.Minion;
local LocalGameTurretCount 			= Game.TurretCount;
local LocalGameTurret 				= Game.Turret;
local LocalGameWardCount 			= Game.WardCount;
local LocalGameWard 				= Game.Ward;
local LocalGameObjectCount 			= Game.ObjectCount;
local LocalGameObject				= Game.Object;
local LocalGameMissileCount 		= Game.MissileCount;
local LocalGameMissile				= Game.Missile;
local LocalGameParticleCount 		= Game.ParticleCount;
local LocalGameParticle				= Game.Particle;
local CastSpell 					= _G.Control.CastSpell
local LocalGameIsChatOpen			= Game.IsChatOpen;
local LocalGameLatency				= Game.Latency;
local LocalStringSub				= string.sub;
local LocalStringLen				= string.len;
local LocalStringFind				= string.find;
local LocalTableSort				= table.sort;
local LocalPairs					= pairs;
local LocalMathAbs					= math.abs;
local LocalMathMin					= math.min;
local LocalMathMax					= math.max;
local LocalTargetSelector			= nil;
local LocalOrbwalker				= nil;
local LocalHealthPrediction			= nil;

function StringEndsWith(str, word)
	return LocalStringSub(str, - LocalStringLen(word)) == word;
end
function Ready(spellSlot)
	return Game.CanUseSpell(spellSlot) == 0
end
	
function CurrentPctLife(entity)
	local pctLife =  entity.health/entity.maxHealth  * 100
	return pctLife
end

function CurrentPctMana(entity)
	local pctMana =  entity.mana/entity.maxMana * 100
	return pctMana
end

function CanTarget(target)
	return target and target.pos and target.isEnemy and target.alive and target.health > 0 and target.visible and target.isTargetable
end

function CanTargetAlly(target)
	return target and target.pos and target.isAlly and target.alive and target.health > 0 and target.visible and target.isTargetable
end

function GetTarget(range, isAD)
	if isAD then		
		return LocalTargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_PHYSICAL);
	else
		return LocalTargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_MAGICAL);
	end
end

function BlockSpells()
	if LocalGameIsChatOpen() then return true end
	if LocalBuffManager:HasBuff(myHero, "recall") then return true end
	if not Game.IsOnTop() then return true end
end

function FarmActive()
	return LocalOrbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] or LocalOrbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR] or LocalOrbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]
end

function ComboActive()
	return LocalOrbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO]
end

function HarassActive()
	return LocalOrbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS]
end


function EnableOrb(bool)
	LocalOrbwalker:SetMovement(bool)
	LocalOrbwalker:SetAttack(bool)
end

function EnableOrbAttacks(bool)   
	LocalOrbwalker:SetAttack(bool)
end


local vectorCast = {}
local mouseReturnPos = mousePos
local mouseCurrentPos = mousePos
local nextVectorCast = 0
function CastVectorSpell(key, pos1, pos2)
	if nextVectorCast > LocalGameTimer() then return end
	nextVectorCast = LocalGameTimer() + 1.5
	EnableOrb(false)
	vectorCast[#vectorCast + 1] = function () 
		mouseReturnPos = mousePos
		mouseCurrentPos = pos1
		Control.SetCursorPos(pos1)
	end
	vectorCast[#vectorCast + 1] = function () 
		Control.KeyDown(key)
	end
	vectorCast[#vectorCast + 1] = function () 
		local deltaMousePos =  mousePos-mouseCurrentPos
		mouseReturnPos = mouseReturnPos + deltaMousePos
		Control.SetCursorPos(pos2)
		mouseCurrentPos = pos2
	end
	vectorCast[#vectorCast + 1] = function ()
		Control.KeyUp(key)
	end
	vectorCast[#vectorCast + 1] = function ()	
		local deltaMousePos =  mousePos -mouseCurrentPos
		mouseReturnPos = mouseReturnPos + deltaMousePos
		Control.SetCursorPos(mouseReturnPos)
	end
	vectorCast[#vectorCast + 1] = function () 
		EnableOrb(true)
	end		
end

function CastSpell(key, pos, isLine)
	if not pos then Control.CastSpell(key) return end
	
	if type(pos) == "userdata" and pos.pos then
		pos = pos.pos
	end
	
	if not pos:ToScreen().onScreen and isLine then			
		pos = myHero.pos + (pos - myHero.pos):Normalized() * 500
	end
	
	if not pos:ToScreen().onScreen then
		return
	end
		
	EnableOrb(false)
	Control.CastSpell(key, pos)
	DelayAction(function() EnableOrb(true)	end, .1)	
	return true
end

function EnemyCount(origin, range, delay)
	local count = 0
	for i  = 1,LocalGameHeroCount(i) do
		local enemy = LocalGameHero(i)
		local enemyPos = enemy.pos
		if delay then
			enemyPos= LocalGeometry:PredictUnitPosition(enemy, delay)
		end
		if enemy and CanTarget(enemy) and LocalGeometry:IsInRange(origin, enemyPos, range) then
			count = count + 1
		end			
	end
	return count
end

function OdysseyEnemyCount(origin, range, delay)
	local count = 0
	for i  = 1,LocalGameHeroCount(i) do
		local enemy = LocalGameHero(i)
		local enemyPos = enemy.pos
		if delay then
			enemyPos= LocalGeometry:PredictUnitPosition(enemy, delay)
		end
		if enemy and CanTarget(enemy) and LocalGeometry:IsInRange(origin, enemyPos, range) then
			count = count + 1
		end			
	end
	for i  = 1,LocalGameMinionCount(i) do
		local enemy = LocalGameMinion(i)
		local enemyPos = enemy.pos
		if delay then
			enemyPos= LocalGeometry:PredictUnitPosition(enemy, delay)
		end
		if enemy and CanTarget(enemy) and LocalGeometry:IsInRange(origin, enemyPos, range) then
			count = count + 1
		end
	end
	return count
end


function NearestAlly(origin, range)
	local ally = nil
	local distance = range
	for i = 1,LocalGameHeroCount()  do
		local hero = LocalGameHero(i)
		if hero and hero ~= myHero and CanTargetAlly(hero) then
			local d =  LocalGeometry:GetDistance(origin, hero.pos)
			if d < range and d < distance then
				distance = d
				ally = hero
			end
		end
	end
	if distance < range then
		return ally, distance
	end
end

function NearestEnemy(origin, range)
	local enemy = nil
	local distance = range
	for i = 1,LocalGameHeroCount()  do
		local hero = LocalGameHero(i)
		if hero and CanTarget(hero) then
			local d =  LocalGeometry:GetDistance(origin, hero.pos)
			if d < range  and d < distance  then
				distance = d
				enemy = hero
			end
		end
	end
	if distance < range then
		return enemy, distance
	end
end

if FileExist(COMMON_PATH .. "Auto/Alpha.lua") then
	require 'Auto/Alpha'
else
	print("ERROR: Auto/Alpha.lua is not present in your Scripts/Common folder. Please re open loader.")
end

if not _G.SDK or not _G.SDK.TargetSelector then
	print("IC Orbwalker MUST be active in order to use this script.")
	return
end

local remaining = 30 - Game.Timer()
print(myHero.charName .. " will load shortly")
DelayAction(function()
	LocalTargetSelector = _G.SDK.TargetSelector
	LocalHealthPrediction = _G.SDK.HealthPrediction
	LocalOrbwalker = _G.SDK.Orbwalker
	
	LocalGeometry = _G.Alpha.Geometry
	LocalBuffManager = _G.Alpha.BuffManager
	LocalObjectManager = _G.Alpha.ObjectManager
	LocalDamageManager = _G.Alpha.DamageManager
	LoadScript()
end, remaining)
Q = {	Range = 650,	Delay = .25,	Speed = 1800	}
E = {	Range = 1000,	Delay = .5,	Speed = 999999,	Radius = 400	}

function LoadScript()
	Menu = MenuElement({type = MENU, id = myHero.networkID, name = myHero.charName})
	Menu:MenuElement({id = "Skills", name = "Skills", type = MENU})
	
	Menu.Skills:MenuElement({id = "Q", name = "[Q] Double Up", type = MENU})
	Menu.Skills.Q:MenuElement({id = "Auto", name = "Auto Minion Bounce", value = true})
	Menu.Skills.Q:MenuElement({id = "Crit", name = "Require Minion Crit", value = true})
	Menu.Skills.Q:MenuElement({id = "Hero", name = "Auto 2X Hero Bounce", value = true})
	Menu.Skills.Q:MenuElement({id = "Killsteal", name = "Killsteal", value = true})
	Menu.Skills.Q:MenuElement({id = "Mana", name = "Mana Limit", value = 15, min = 5, max = 100, step = 5 })
	
	Menu.Skills:MenuElement({id = "W", name = "[W] Strut", type = MENU})
	Menu.Skills.W:MenuElement({id = "Auto", name = "Use in Combo", value = false})
	Menu.Skills.W:MenuElement({id = "Mana", name = "Mana Limit", value = 25, min = 5, max = 100, step = 5 })
	
	Menu.Skills:MenuElement({id = "E", name = "[E] Make it Rain", type = MENU})
	Menu.Skills.E:MenuElement({id = "Auto", name = "Cast on Immobile Targets", value = true})
	Menu.Skills.E:MenuElement({id = "Combo", name = "Cast in Combo", value = true})
	Menu.Skills.E:MenuElement({id = "Count", name = "Combo Target Count", value = 2, min = 1, max = 6, step = 1})
	Menu.Skills.E:MenuElement({id = "Mana", name = "Mana Limit", value = 20, min = 5, max = 100, step = 5 })
	
	
	
	LocalDamageManager:OnIncomingCC(function(target, damage, ccType, canDodge) OnCC(target, damage, ccType, canDodge) end)
	LocalObjectManager:OnSpellCast(function(spell) OnSpellCast(spell) end)
	LocalObjectManager:OnParticleCreate(function(particleInfo) OnParticleCreate(particleInfo) end)
	
	Callback.Add("Tick", function() Tick() end)	
end


function OnSpellCast(spell)
	--If we're about to be hit by a spell, are in combo and have auto W turned on... use it so we can try to dodge easier
	if spell.isEnemy and Ready(_W) and Menu.Skills.W.Auto:Value() and ComboActive() and CurrentPctMana(myHero) >= Menu.Skills.W.Mana:Value() then
		local hitDetails = LocalDamageManager:GetSpellHitDetails(spell,myHero)
		if hitDetails.Hit then
			if hitDetails.HitTime  > .25 then	
				CastSpell(HK_W)
			end
		end
	end
end

local NextTick = LocalGameTimer()
local PassiveTarget = nil
function Tick()
	local currentTime = LocalGameTimer()
	if NextTick > currentTime then return end
	if myHero.activeSpell and myHero.activeSpell.valid and not myHero.activeSpell.spellWasCast then return end
	
	if BlockSpells() then return end
	local myMana = CurrentPctMana(myHero)
	
	
	if Ready(_E) and myMana >= Menu.Skills.E.Mana:Value() then
	
		local target = GetTarget(E.Range, true)
		if target and CanTarget(target) then
			local accuracyRequired = ComboActive() and Menu.Skills.E.Combo:Value() and 2 or Menu.Skills.E.Auto:Value() and 4 or 6
			local aimPosition, hitChance = LocalGeometry:GetCastPosition(myHero, target, E.Range, E.Delay,E.Speed, E.Radius, E.Collision, E.IsLine)
			if aimPosition and hitChance >= accuracyRequired then
				--We have the cast position. Now lets see if its an immobile target or not
				if hitChance > 3 or EnemyCount(aimPosition, E.Radius, E.Delay) >= Menu.Skills.E.Count:Value() then
					CastSpell(HK_E, aimPosition)
					NextTick = LocalGameTimer() + .25
					return
				end
			end
		end
	end
	
	--All the traditional Q logic
	if Ready(_Q) and myMana >= Menu.Skills.Q.Mana:Value() then
		local target = GetTarget(Q.Range, true)
		if target and CanTarget(target) then
			if ComboActive() or (Menu.Skills.Q.Killsteal:Value() and GetQDamage(target) >= target.health) then
				CastSpell(HK_Q, target)
				NextTick = LocalGameTimer() + .25
				return				
			end
			
			local bounceTarget = GetQBounceTarget(target)
			if CanTarget(bounceTarget) and LocalStringFind(bounceTarget.type, "Hero") then
				--Check for killsteal
				
				if Menu.Skills.Q.Killsteal:Value() and GetQDamage(bounceTarget) >= bounceTarget.health then
					CastSpell(HK_Q, target)
					NextTick = LocalGameTimer() + .25
					return				
				end
				
				--Check for 2x hero bounce cast
				if Menu.Skills.Q.Hero:Value() then
					CastSpell(HK_Q, target)
					NextTick = LocalGameTimer() + .25
					return				
				end				
			end			
		end
		
		--Minion bounce: only calculate if there are enemies we could bounce to
		if Menu.Skills.Q.Auto:Value() and NearestEnemy(myHero.pos, 1300) ~= nil then
			for i = 1, LocalGameMinionCount() do
				local minion = LocalGameMinion(i)
				if CanTarget(minion) and LocalGeometry:IsInRange(myHero.pos, minion.pos, Q.Range) then				
					local minionHp = _G.SDK.HealthPrediction:GetPrediction(minion, Q.Delay)
					if minionHp > 0 and (not Menu.Skills.Q.Crit:Value() or GetQDamage(minion) > minionHp) then
						local bounceTarget = GetQBounceTarget(minion)
						if CanTarget(bounceTarget) and LocalStringFind(bounceTarget.type, "Hero") then
							CastSpell(HK_Q, minion)
							NextTick = LocalGameTimer() + .25
							return	
						end
					end
				end
			end
		end
	end
	
	
	if ComboActive() and Menu.Skills.W.Auto:Value() and myMana >= Menu.Skills.E.Mana:Value() then
		Control.CastSpell(HK_W)
	end
	
	
	NextTick = LocalGameTimer() + .05
end

function OnParticleCreate(particleInfo)
	if LocalStringFind(particleInfo.name, "_P_Mark") then
		PassiveTarget = LocalObjectManager:GetPlayerByPosition(particleInfo.pos)	
	end
end

local _passiveDamagePctByLevel = { .50, .50, .60, .60, .60, .60, .60, .70, .70, .80, .80,.90, .90, 1,1,1,1,1 }
function GetQDamage(target)
	local qDamage= myHero:GetSpellData(_Q).level * 20  + myHero.ap * 0.35+ myHero.totalDamage	
	--Boost if they dont have love tap on them
	if target ~= PassiveTarget and myHero.levelData then
		local bonusDamage = myHero.totalDamage * _passiveDamagePctByLevel[myHero.levelData.lvl]
		--Passive damage is half to minion
		if not LocalStringFind(target.type, "Hero") then
			bonusDamage = bonusDamage / 2
		end		
		qDamage = qDamage + bonusDamage
	end
	local qDamage = LocalDamageManager:CalculatePhysicalDamage(myHero, target, qDamage)
	return qDamage
end

function GetQBounceTarget(target)
	if not target then return end
	local bounceTargetDelay = LocalGeometry:InterceptTime(myHero, target, Q.Delay, Q.Speed)
	local targetOrigin = LocalGeometry:PredictUnitPosition(target, bounceTargetDelay)
	if not LocalGeometry:IsInRange(myHero.pos, targetOrigin, Q.Range) then return end	
	local topVector = targetOrigin +(targetOrigin - myHero.pos):Perpendicular():Normalized()* 500
	local bottomVector = targetOrigin +(targetOrigin - myHero.pos):Perpendicular2():Normalized()* 500
	
	
	local targets = {}
	for i = 1, LocalGameMinionCount() do
		local hero = LocalGameMinion(i)
		if CanTarget(hero) and hero.networkID ~= target.networkID then
			local heroOrigin = LocalGeometry:PredictUnitPosition(hero, bounceTargetDelay)
			if LocalGeometry:IsInRange(targetOrigin, heroOrigin, 500 + hero.boundingRadius) and
				not LocalGeometry:IsInRange(topVector, heroOrigin, 450 - hero.boundingRadius) and
				not LocalGeometry:IsInRange(bottomVector, heroOrigin, 450 - hero.boundingRadius) and
				LocalGeometry:GetDistanceSqr(myHero.pos, heroOrigin) > LocalGeometry:GetDistanceSqr(myHero.pos, targetOrigin) then					
				targets[#targets + 1] = {t = hero, d = LocalGeometry:GetDistance(targetOrigin, heroOrigin)}
			end				
		end		
	end
	
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i)
		if CanTarget(hero) and hero.networkID ~= target.networkID then
			local heroOrigin = LocalGeometry:PredictUnitPosition(hero, bounceTargetDelay )
			if LocalGeometry:IsInRange(targetOrigin, heroOrigin, 500 + hero.boundingRadius) and
				not LocalGeometry:IsInRange(topVector, heroOrigin, 450 - hero.boundingRadius) and
				not LocalGeometry:IsInRange(bottomVector, heroOrigin, 450 - hero.boundingRadius) and
				LocalGeometry:GetDistanceSqr(myHero.pos, heroOrigin) > LocalGeometry:GetDistanceSqr(myHero.pos, targetOrigin) then					
				targets[#targets + 1] = {t = hero, d = LocalGeometry:GetDistance(targetOrigin, heroOrigin)}
			end				
		end
	end
	
	if #targets > 0 then
		LocalTableSort(targets, function (a,b) return a.d < b.d end)
		return targets[1].t
	end
	
end

function OnCC(target, damage, ccType, canDodge)
	if target.isEnemy and CanTarget(target) and LocalDamageManager.IMMOBILE_TYPES[ccType] then
		if Ready(_E) and CurrentPctMana(myHero) >= Menu.Skills.E.Mana:Value() and (Menu.Skills.E.Auto:Value() or Menu.Skills.E.Combo:Value() and ComboActive()) and LocalGeometry:IsInRange(myHero.pos, target.pos, E.Range) then
			NextTick = LocalGameTimer() + .25
			CastSpell(HK_E, target.pos)
			return
		end
	end
end