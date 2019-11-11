if myHero.charName ~= "Talon" then return end
local Camille = myHero
--local leftside = MapPosition:inLeftBase(myHero.pos)
local castSpell = {state = 0, tick = GetTickCount(), casting = GetTickCount() - 1000, mouse = mousePos}
local SagaHeroCount = Game.HeroCount()
local SagaTimer = Game.Timer
local Latency = Game.Latency
local ping = Latency() * .001
local atan2 = math.atan2
local MathPI = math.pi
local W = {}
local _movementHistory = {}
local clock = os.clock
local sHero = Game.Hero
local TEAM_ALLY = Camille.team
local TEAM_ENEMY = 300 - TEAM_ALLY
local myCounter = 1
local SagaMCount = Game.MinionCount
local SagasBitch = Game.Minion
local LocalGameTurretCount 	= Game.TurretCount;
local LocalGameTurret = Game.Turret;
local ItsReadyDumbAss = Game.CanUseSpell
local CastItDumbFuk = Control.CastSpell
local _EnemyHeroes
local TotalHeroes
local _AllyHero
local TotalAHeroes
local LocalCallbackAdd = Callback.Add
local visionTick = 0
local _OnVision = {}
local abs = math.abs 
local deg = math.deg 
local acos = math.acos 
local ignitecast
local igniteslot
local HKITEM = { [ITEM_1] = 49, [ITEM_2] = 50, [ITEM_3] = 51, [ITEM_4] = 53, [ITEM_5] = 54, [ITEM_6] = 55, [ITEM_7] = 52
	}


    local SmiteTable = {
        SRU_Baron = "SmiteBaron",
        SRU_RiftHerald = "SmiteHerald",
        SRU_Dragon_Water = "SmiteDragonWater",
        SRU_Dragon_Fire = "SmiteDragonFire",
        SRU_Dragon_Earth = "SmiteDragonEarth",
        SRU_Dragon_Air = "SmiteDragonAir",
        SRU_Dragon_Elder = "SmiteDragonElder",
        SRU_Blue = "SmiteBlue",
        SRU_Red = "SmiteRed",
        SRU_Gromp = "SmiteGromp",
        SRU_Murkwolf = "SmiteWolves",
        SRU_Razorbeak = "SmiteRazorbeaks",
        SRU_Krug = "SmiteKrugs",
        Sru_Crab = "SmiteCrab",
    }

require "MapPosition"


local isEvading = ExtLibEvade and ExtLibEvade.Evading
	local validTarget,
		GetDistanceSqr,
        GetDistance,
        GetImmobileTime,
        GetTargetMS,
        GetTarget,
        GetPathNodes,
        PredictUnitPosition,
        UnitMovementBounds,
        GetRecallingData,
        PredictReactionTime,
        GetSpellInterceptTime,
        CanTarget,
        Angle,
        UpdateMovementHistory,
        GetHitchance,
        GetOrbMode,
        SagaOrb,
        Sagacombo,
        Sagaharass,
        SagalastHit,
        SagalaneClear,
        SagaSDK,
        SagaSDKCombo,
        SagaSDKHarass,
        SagaSDKJungleClear,
        SagaSDKLaneClear,
        SagaSDKLastHit,
        SagaSDKSelector,
        SagaGOScombo,
        SagaGOSharass,
        SagaGOSlastHit,
        SagaGOSlaneClear,
        SagaSDKModes,
        minionCollision,
        VectorPointProjectionOnLineSegment,
        SagaSDKMagicDamage,
        SagaSDKPhysicalDamage,
        UpdateRange,
        GetQstacks,
        Combo,
        Saga,
        Saga_Menu

        SpellData = {
            ["Aatrox"] = {
                ["aatroxeconemissile"] = {name = "��ĥ֮��",radius =  35}
            },
            ["Ahri"] = {
                ["ahriorbmissile"] = { name = "��ƭ֮��", radius =  100 },
                ["ahrifoxfiremissiletwo"] = {name = "�����", Width =  50},
                ["ahriseducemissile"] = {name = "����", radius =  60},
                ["ahritumblemissile"] = { name  = "SpiritRush", radius =  600}
            },
            ["Akali"] = {
                ["akalimota"] = {name = "�������ı�־", radius =  600}
            },
            ["Amumu"] = {
                ["sadmummybandagetoss"] = { name = "Ͷ������", Width =  50}
            },
            ["Anivia"] = {
                ["flashfrostspell"] = { name = "����˪", radius =  110},
                ["frostbite"] = { name = "����", radius =  650}
            },
            ["Annie"] = {
                ["disintegrate"] = { name = "�߽�", radius =  710}
            },
            ["Ashe"] = {
                ["volleyattack"] = {name = "����", Width =  50},
                ["enchantedcrystalarrow"] = { name = "ħ����", Radius =  130}
            },
            ["AurelionSol"] = {
                ["aurelionsolqmissile"] = { name = "��֩��", radius =  50}
            },
            ["Bard"] = {
                ["bardqmissile"] = { name = "��������", Width =  50}
            },
            ["Blitzcrank"] = {
                ["rocketgrabmissile"] = { name = "���ץ��", radius =  70}
            },
            ["Brand"] = {
                ["brandqmissile"] = { name = "Sear", Width =  50},
                ["brandr"] = { name = "��ɽ��м", radius =  600}
            },
            ["Braum"] = {
                ["braumqmissile"] = { name = "�����ҧ", radius =  60},
                ["braumrmissile"] = { name = "�����ѷ�", radius =  115}
            },
            ["Caitlyn"] = {
                ["caitlynpiltoverpeacemaker"] = { name = "Ƥ���з������", radius =  90},
                ["caitlynaceintheholemissile"] = { name = "�������", radius =  50}
            },
            ["Cassiopeia"] = {
                ["cassiopeiatwinfang"] = {name = "������", radius =  0}
            },
            ["Corki"] = {
                ["phosphorusbombmissile"] = { name = "�׵�", radius =  250},
                ["missilebarragemissile"] = { name = "�������Ӱ�", Width =  40},
                ["missilebarragemissile2"] = { name = "���͵���������", Width =  40}
            },
            ["Diana"] = {
                ["dianaarcthrow"] = { name = "���°չ�", radius =  50}
            },
            ["DrMundo"] = {
                ["infectedcleavermissile"] = { name = "�ܸ�Ⱦ�����⵶", Width =  50}
            },
            ["Draven"] = {
                ["dravenr"] = { name = "��ת����", radius =  160}
            },
            ["Ekko"] = {
                ["ekkoqmis"] = { name = "ʱ���", radius =  50}
            },
            ["Elise"] = {
                ["elisehumanq"] = { name = "�񾭶���", radius =  50},
                ["elisehumane"] = { name = "Cocoon", radius =  55}
            },
            ["Ezreal"] = {
                ["ezrealmysticshotmissile"] = { name = "���ؾ�ͷ", radius =  60},
                ["ezrealessencefluxmissile"] = {name = "��ͨ��", radius =  80},
                ["ezrealarcaneshiftmissile"] = { name = "������λ", radius =  275},
                ["ezrealtrueshotbarrage"] = { name = "ǿ����������", radius =  160}
            },
            ["FiddleSticks"] = {
                ["fiddlesticksdarkwindmissile"] = { name = "����", radius =  50}
            },
            ["Gangplank"] = {
                ["parley"] = { name = "̸��", radius =  50}
            },
            ["Gnar"] = {
                ["gnarqmissile"] = { name = "������Ͷ��", Width =  50},
                ["gnarbigqmissile"] = { name = "��ʯ", Width =  50}
            },
            ["Gragas"] = {
                ["gragasqmissile"] = { name = "��Ͱ", Width =  50},
                ["gragasrboom"] = { name = "��ըͰ", Width =  50}
            },
            ["Graves"] = {
                ["gravesqlinemis"] = { name = "�ߵľ�ͷ", radius =  60},
                ["graveschargeshotshot"] = { name = "������", radius =  100}
            },
            ["Illaoi"] = {
                ["illaoiemis"] = { name = "�������", radius =  50}
            },
            ["Irelia"] = {
                ["IreliaTranscendentBlades"] = { name = "���鵶Ƭ", radius =  120}
            },
            ["Janna"] = {
                ["howlinggalespell"] = { name = "��Х���", Width =  120},
                ["sowthewind"] = {name = "�ͷ�", radius =  50}
            },
            ["Jayce"] = {
                ["jayceshockblastmis"] = { name = "�����", radius =  70},
                ["jayceshockblastwallmis"] = { name = "��ǿ�����", radius =  70}
            },
            ["Camille"] = {
                ["Camillewmissile"] = {name = "Zap!", radius =  50},
                ["Camiller"] = { name = "�����������������", Width =  50}
            },
            ["Jhin"] = {
                ["jhinwmissile"] = {name = "�����ķ���", radius =  40},
                ["jhinrshotmis"] = { name = "лĻ", radius =  80}
            },
            ["Kalista"] = {
                ["kalistamysticshotmis"] = { name = "����", radius =  40}
            },
            ["Karma"] = {
                ["karmaqmissile"] = { name = "�ڲ���", radius =  60},
                ["karmaqmissilemantra"] = { name = "����:���ڻ���", Width =  50}
            },
            ["Kassadin"] = {
                ["nulllance"] = { name = "����", radius =  50}
            },
            ["Katarina"] = {
                ["katarinaqmis"] = { name = "����ҶƬ", Width =  50}
            },
            ["Kayle"] = {
                ["judicatorreckoning"] = { name = "����", Width =  50}
            },
            ["Kennen"] = {
                ["kennenshurikenhurlmissile1"] = { name = "������������", radius =  50}
            },
            ["Khazix"] = {
                ["khazixwmissile"] = {name = "��϶��", Width =  50}
            },
            ["Kogmaw"] = {
                ["kogmawq"] = { name = "��ʴ��̵Һ", radius =  70},
                ["kogmawvoidoozemissile"] = { name = "��϶��ˮ", Width =  50},
            },
            ["Leblanc"] = {
                ["leblancchaosorbm"] = { name = "������", radius =  50},
                ["leblancsoulshackle"] = { name = "����", Width =  50},
                ["leblancsoulshacklem"] = { name = "������¡", Width =  50}
            },
            ["LeeSin"] = {
                ["blindmonkqone"] = { name = "����", Width =  65}
            },
            ["Leona"] = {
                ["LeonaZenithBladeMissile"] = { name = "�춥ҶƬ", Width =  50}
            },
            ["Lissandra"] = {
                ["lissandraqmissile"] = { name = "������Ƭ", Width =  50},
                ["lissandraemissile"] = { name = "����·��", Width =  50}
            },
            ["Lucian"] = {
                ["lucianwmissile"] = {slot = 1, danger = 1, name = "���ȵĻ���", radius =  55},
                ["lucianrmissileoffhand"] = { name = "�޳�", radius =  110}
            },
            ["Lulu"] = {
                ["luluqmissile"] = { name = "����ǹ", Width =  50}
            },
            ["Lux"] = {
                ["luxlightbindingmis"] = { name = "", Width =  50} 
            },
            ["Malphite"] = {
                ["seismicshard"] = { name = "������Ƭ", radius =  50}
            },
            ["MissFortune"] = {
                ["missfortunericochetshot"] = { name = "�ӱ�", radius =  250}
            },
            ["Morgana"] = {
                ["darkbindingmissile"] = { name = "�����", radius =  80}
            },
            ["Nami"] = {
                ["namiwmissileenemy"] = {name = "����", radius =  50}
            },
            ["Nunu"] = {
                ["iceblast"] = { name = "����", radius =  50}
            },
            ["Nautilus"] = {
                ["nautilusanchordragmissile"] = { name = "", Width =  90}
            },
            ["Nidalee"] = {
                ["JavelinToss"] = { name = "����ǹ", radius =  40}
            },
            ["Nocturne"] = {
                ["nocturneduskbringer"] = { name = "�谵������", radius =  60}
            },
            ["Pantheon"] = {
                ["pantheonq"] = { name = "��ì���", radius =  50}
            },
            ["RekSai"] = {
                ["reksaiqburrowedmis"] = { name = "������Ѱ��", radius =  60}
            },
            ["Rengar"] = {
                ["rengarefinal"] = { name = "�����չ�", Width =  50}
            },
            ["Riven"] = {
                ["rivenlightsabermissile"] = { name = "��б��", radius =  125}
            },
            ["Rumble"] = {
                ["rumblegrenade"] = {name = "�����", Width =  50}
            },
            ["Ryze"] = {
                ["ryzeq"] = { name = "����", radius =  50},
                ["ryzee"] = {name = "����ͨ��", radius =  50}
            },
            ["Sejuani"] = {
                ["sejuaniglacialprison"] = { name = "��������", Width =  50}
            },
            ["Sivir"] = {
                ["sivirqmissile"] = { name = "�����ڵ�Ƭ", radius =  90}
            },
            ["Skarner"] = {
                ["skarnerfracturemissile"] = { name = "����", Width =  50}
            },
            ["Shaco"] = {
                ["twoshivpoison"] = { name = "˫м��ҩ", Width =  50}
            },
            ["Sona"] = {
                ["sonaqmissile"] = { name = "Ӣ���޸�", radius =  50},
                ["sonar"] = { name = "��������", radius =  140}
            },
            ["Swain"] = {
                ["swaintorment"] = { name = "ʹ��", radius =  50}
            },
            ["Syndra"] = {
                ["syndrarspell"] = { name = "�ͷŵ�����", radius =  50}
            },
            ["Teemo"] = {
                ["blindingdart"] = { name = "��ä��", radius =  50}
            },
            ["Tristana"] = {
                ["detonatingshot"] = { name = "��ըװҩ", radius =  50}
            },
            ["TahmKench"] = {
                ["tahmkenchqmissile"] = { name = "���", radius =  70}
            },
            ["Taliyah"] = {
                ["taliyahqmis"] = { name = "���ƽػ�", radius =  100}
            },
            ["Talon"] = {
                ["talonrakemissileone"] = {name = "Rake", Width =  50}
            },
            ["TwistedFate"] = {
                ["bluecardpreattack"] = {name = "��ɫ��Ƭ", radius =  50},
                ["goldcardpreattack"] = {name = "��", radius =  50},
                ["redcardpreattack"] = {name = "����", radius =  50}
            },
            ["Urgot"] = {
                --
            },
            ["Varus"] = {
                ["varusqmissile"] = { name = "���ļ�", radius =  70},
                ["varusrmissile"] = { name = "������", Width =  50}
            },
            ["Vayne"] = {
                ["vaynecondemnmissile"] = { name = "Ǵ��", Width =  50}
            },
            ["Veigar"] = {
                ["veigarbalefulstrikemis"] = { name = "����չ�", radius =  70},
                ["veigarr"] = { name = "ԭʼ����", Width =  50}
            },
            ["Velkoz"] = {
                ["velkozqmissile"] = { name = "���������ѱ�", Width =  50},
                ["velkozqmissilesplit"] = { name = "���������ѱ����", radius =  50}
             },
            ["Viktor"] = {
                ["viktorpowertransfer"] = { name = "��������", radius =  50},
                ["viktordeathraymissile"] = { name = "����", radius =  80}
            },
            ["Vladimir"] = {
                ["vladimirtidesofbloodnuke"] = { name = "Ѫ��", radius =  50}
            },
            ["Camille"] = {
                ["Camilleq3wmis"] = { name = "�ۼ��籩", radius =  50}
            },
            ["Zed"] = {
                ["zedqmissile"] = { name = "�굶�����", radius =  50}
            },
            ["Zyra"] = {
                ["zyrae"] = { name = "ץס��", Width =  50}
            }
        }
        
        local walllist = {}


    local sqrt = math.sqrt
    local DamageReductionTable = {
        ['Braum'] = {
            buff = 'BraumShieldRaise',
            amount = function(target)
                return 1 - ({0.3, 0.325, 0.35, 0.375, 0.4})[target:GetSpellData(_E).level]
            end
        },
        ['Urgot'] = {
            buff = 'urgotswapdef',
            amount = function(target)
                return 1 - ({0.3, 0.4, 0.5})[target:GetSpellData(_R).level]
            end
        },
        ['Alistar'] = {
            buff = 'Ferocious Howl',
            amount = function(target)
                return ({0.5, 0.4, 0.3})[target:GetSpellData(_R).level]
            end
        },
        ['Amumu'] = {
            buff = 'Tantrum',
            amount = function(target)
                return ({2, 4, 6, 8, 10})[target:GetSpellData(_E).level]
            end,
            damageType = 1
        },
        ['Galio'] = {
            buff = 'GalioIdolOfDurand',
            amount = function(target)
                return 0.5
            end
        },
        ['Garen'] = {
            buff = 'GarenW',
            amount = function(target)
                return 0.7
            end
        },
        ['Gragas'] = {
            buff = 'GragasWSelf',
            amount = function(target)
                return ({0.1, 0.12, 0.14, 0.16, 0.18})[target:GetSpellData(_W).level]
            end
        },
        ['Annie'] = {
            buff = 'MoltenShield',
            amount = function(target)
                return 1 - ({0.16, 0.22, 0.28, 0.34, 0.4})[target:GetSpellData(_E).level]
            end
        },
        ['Malzahar'] = {
            buff = 'malzaharpassiveshield',
            amount = function(target)
                return 0.1
            end
        }
    }



GetDistanceSqr = function(p1, p2)
		p2 = p2 or Camille
		p1 = p1.pos or p1
		p2 = p2.pos or p2
		
	
		local dx, dz = p1.x - p2.x, p1.z - p2.z 
		return dx * dx + dz * dz
	end

GetEnemyHeroes = function()
        _EnemyHeroes = {}
        for i = 1, Game.HeroCount() do
            local unit = Game.Hero(i)
            if unit.team == TEAM_ENEMY  then
                _EnemyHeroes[myCounter] = unit
                myCounter = myCounter + 1
            end
        end
        myCounter = 1
        return #_EnemyHeroes
    end

    GetAllyHeroes = function()
        _AllyHero = {}
        for i = 1, Game.HeroCount() do
            local unit = Game.Hero(i)
            if unit.team == TEAM_ALLY  then
                _AllyHero[myCounter] = unit
                myCounter = myCounter + 1
            end
        end
        myCounter = 1
        return #_AllyHero
    end

	GetDistance = function(p1, p2)
		
		return sqrt(GetDistanceSqr(p1, p2))
    end

    IsFacing = function(unit)
	    local V = Vector((unit.pos - myHero.pos))
	    local D = Vector(unit.dir)
	    local Angle = 180 - deg(acos(V*D/(V:Len()*D:Len())))
	    if abs(Angle) < 80 then 
	        return true  
	    end
	    return false
	end




validTarget = function(unit)
        if unit and unit.isEnemy and unit.valid and unit.isTargetable and not unit.dead and not unit.isImmortal and not (GotBuff(unit, 'FioraW') == 1) and
        not (GotBuff(unit, 'XinZhaoRRangedImmunity') == 1 and unit.distance < 450) and unit.visible then
            return true
        else 
            return false
        end
    end

GetImmobileTime = function(unit)
    local duration = 0
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if
            buff.count > 0 and buff.duration > duration and
                (buff.type == 5 or buff.type == 8 or buff.type == 21 or buff.type == 22 or buff.type == 24 or buff.type == 11 or buff.type == 29 or buff.type == 30 or buff.type == 39)
         then
            duration = buff.duration
        end
    end
    return duration
end

GetTargetMS = function(target)
    local ms = target.pathing.isDashing and target.pathing.dashSpeed or target.ms
    return ms
end

GetTarget = function(range)

	if SagaOrb == 1 then
		if Camille.ap > Camille.totalDamage then
			return EOW:GetTarget(range, EOW.ap_dec, Camille.pos)
		else
			return EOW:GetTarget(range, EOW.ad_dec, Camille.pos)
		end
	elseif SagaOrb == 2 and SagaSDKSelector then
		if Camille.ap > Camille.totalDamage then
			return SagaSDKSelector:GetTarget(range, SagaSDKMagicDamage)
		else
			return SagaSDKSelector:GetTarget(range, SagaSDKPhysicalDamage)
        end
    elseif _G.GOS then
		if Camille.ap > Camille.totalDamage then
			return GOS:GetTarget(range, "AP")
		else
			return GOS:GetTarget(range, "AD")
        end
    elseif _G.__gsoSDK then
        local enemyHeroes_ADdmg = __gsoOB:GetEnemyHeroes(range, false, "attack")
        return __TS:GetTarget(enemyHeroes_ADdmg)
	end
end

GetImmobileTime = function(unit)
    local duration = 0
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if
            buff.count > 0 and buff.duration > duration and
                (buff.type == 5 or buff.type == 8 or buff.type == 21 or buff.type == 22 or buff.type == 24 or buff.type == 11 or buff.type == 29 or buff.type == 30 or buff.type == 39)
         then
            duration = buff.duration
        end
    end
    return duration
end

GetPathNodes = function(unit)
    local nodes = {}
    nodes[myCounter] = unit.pos
    if unit.pathing.hasMovePath then
        for i = unit.pathing.pathIndex, unit.pathing.pathCount do
            local path = unit:GetPath(i)
            myCounter = myCounter + 1
            nodes[myCounter] = path
        end
    end
    myCounter = 1
    return nodes, #nodes
end

VectorPointProjectionOnLineSegment = function(v1, v2, v)
	local cx, cy, ax, ay, bx, by = v.x, v.z, v1.x, v1.z, v2.x, v2.z
	local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) * (bx - ax) + (by - ay) * (by - ay))
	local pointLine = { x = ax + rL * (bx - ax), z = ay + rL * (by - ay) }
	local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
	local isOnSegment = rS == rL
	local pointSegment = isOnSegment and pointLine or {x = ax + rS * (bx - ax), z = ay + rS * (by - ay)}
	return pointSegment, pointLine, isOnSegment
end 

minionCollision = function(target, me, position)
    local targemyCounter = 0
    for i = SagaMCount(), 1, -1 do 
        local minion = SagasBitch(i)
        if minion.isTargetable and minion.team == TEAM_ENEMY and minion.dead == false then
            local linesegment, line, isOnSegment = VectorPointProjectionOnLineSegment(me, position, minion.pos)
            if linesegment and isOnSegment and (GetDistanceSqr(minion.pos, linesegment) <= (minion.boundingRadius + 100) * (minion.boundingRadius + 100)) then
                targemyCounter = targemyCounter + 1
            end
        end
    end
    return targemyCounter
end

local manaManager = function(unit)
    return (unit.mana / unit.maxMana) * 100
end

heroCollision = function(target, me, position)
    local targemyCounter = 0
    for i = TotalHeroes, 1, -1 do 
        local hero = _EnemyHeroes[i]
        if hero.isTargetable and hero.team == TEAM_ENEMY and hero.dead == false and not target then
            local linesegment, line, isOnSegment = VectorPointProjectionOnLineSegment(me, position, hero.pos)
            if linesegment and isOnSegment and (GetDistanceSqr(hero.pos, linesegment) <= (hero.boundingRadius + R.Width) * (hero.boundingRadius + R.Width)) then
                targemyCounter = targemyCounter + 1
            end
        end
    end
    return targemyCounter
end





PredictUnitPosition = function(unit, delay)
    local predictedPosition = unit.pos
    local timeRemaining = delay
    local pathNodes = GetPathNodes(unit)
    for i = 1, #pathNodes - 1 do
        local nodeDistance = sqrt(GetDistanceSqr(pathNodes[i], pathNodes[i + 1]))
        local targetMs = GetTargetMS(unit)
        local nodeTraversalTime = nodeDistance / targetMs
        if timeRemaining > nodeTraversalTime then
            --This node of the path will be completed before the delay has finished. Move on to the next node if one remains
            timeRemaining = timeRemaining - nodeTraversalTime
            predictedPosition = pathNodes[i + 1]
        else
            local directionVector = (pathNodes[i + 1] - pathNodes[i]):Normalized()
            predictedPosition = pathNodes[i] + directionVector * targetMs * timeRemaining
            break
        end
    end
    return predictedPosition
end

UnitMovementBounds = function(unit, delay, reactionTime)
    local startPosition = PredictUnitPosition(unit, delay)
    local radius = 0
    local deltaDelay = delay - reactionTime - GetImmobileTime(unit)
    if (deltaDelay > 0) then
        radius = GetTargetMS(unit) * deltaDelay
    end
    return startPosition, radius
end

GetRecallingData = function(unit)
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff and buff.name == 'recall' and buff.duration > 0 then
            return true, SagaTimer() - buff.startTime
        end
    end
    return false
end

OnVision = function(unit)
    _OnVision[unit.networkID] = _OnVision[unit.networkID] == nil and {state = unit.visible, tick = GetTickCount(), pos = unit.pos} or _OnVision[unit.networkID]
    if _OnVision[unit.networkID].state == true and not unit.visible then
        _OnVision[unit.networkID].state = false
        _OnVision[unit.networkID].tick = GetTickCount()
    end
    if _OnVision[unit.networkID].state == false and unit.visible then
        _OnVision[unit.networkID].state = true
        _OnVision[unit.networkID].tick = GetTickCount()
    end
    return _OnVision[unit.networkID]
end

OnVisionF = function()
    if GetTickCount() - visionTick > 100 then
        for i = 1, TotalHeroes do
            OnVision(_EnemyHeroes[i])
        end
        visionTick = GetTickCount()
    end
end

PredictReactionTime = function(unit, minimumReactionTime)
    local reactionTime = minimumReactionTime
    --If the target is auto attacking increase their reaction time by .15s - If using a skill use the remaining windup time
    if unit.activeSpell and unit.activeSpell.valid then
        local windupRemaining = unit.activeSpell.startTime + unit.activeSpell.windup - SagaTimer()
        if windupRemaining > 0 then
            reactionTime = windupRemaining
        end
    end
    --If the target is recalling and has been for over .25s then increase their reaction time by .25s
    local isRecalling, recallDuration = GetRecallingData(unit)
    if isRecalling and recallDuration > .25 then
        reactionTime = .25
    end
    return reactionTime
end

GetSpellInterceptTime = function(startPos, endPos, delay, speed)
    local interceptTime = Latency() / 2000 + delay + sqrt(GetDistanceSqr(startPos, endPos)) / speed
    return interceptTime
end

CanTarget = function(target)
    return target.team == TEAM_ENEMY and target.alive and target.visible and target.isTargetable
end

Angle = function(A, B)
    local deltaPos = A - B
    local angle = atan2(deltaPos.x, deltaPos.z) * 180 / MathPI
    if angle < 0 then
        angle = angle + 360
    end
    return angle
end

UpdateMovementHistory =
    function()
    for i = 1, TotalHeroes do
        local unit = sHero(i)
        if not _movementHistory[unit.charName] then
            _movementHistory[unit.charName] = {}
            _movementHistory[unit.charName]['EndPos'] = unit.pathing.endPos
            _movementHistory[unit.charName]['StartPos'] = unit.pathing.endPos
            _movementHistory[unit.charName]['PreviousAngle'] = 0
            _movementHistory[unit.charName]['ChangedAt'] = SagaTimer()
        end

        if
            _movementHistory[unit.charName]['EndPos'].x ~= unit.pathing.endPos.x or _movementHistory[unit.charName]['EndPos'].y ~= unit.pathing.endPos.y or
                _movementHistory[unit.charName]['EndPos'].z ~= unit.pathing.endPos.z
         then
            _movementHistory[unit.charName]['PreviousAngle'] =
                Angle(
                Vector(_movementHistory[unit.charName]['StartPos'].x, _movementHistory[unit.charName]['StartPos'].y, _movementHistory[unit.charName]['StartPos'].z),
                Vector(_movementHistory[unit.charName]['EndPos'].x, _movementHistory[unit.charName]['EndPos'].y, _movementHistory[unit.charName]['EndPos'].z)
            )
            _movementHistory[unit.charName]['EndPos'] = unit.pathing.endPos
            _movementHistory[unit.charName]['StartPos'] = unit.pos
            _movementHistory[unit.charName]['ChangedAt'] = SagaTimer()
        end
    end
end



function CheckMinionCollision(origin, endPos, delay, speed, radius, frequency)
    if not frequency then
		frequency = radius
    end
	local directionVector = (endPos - origin):Normalized()
    local checkCount = GetDistance(origin, endPos) / frequency
	for i = 1, checkCount do
		local checkPosition = origin + directionVector * i * frequency
        local checkDelay = delay + GetDistance(origin, checkPosition) / speed
		if IsMinionIntersection(checkPosition, radius, checkDelay, radius * 3) then
			return true
		end
	end
	return false
end
function IsMinionIntersection(location, radius, delay, maxDistance)
	if not maxDistance then
		maxDistance = 500
	end
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if minion and CanTarget(minion) and IsInRange(minion.pos, location, maxDistance) then
			local predictedPosition = PredictUnitPosition(minion, delay)
			if IsInRange(location, predictedPosition, radius + minion.boundingRadius) then
				return true
			end
		end
	end
	return false
end

function IsInRange(p1, p2, range)
	if not p1 or not p2 then
		local dInfo = debug.getinfo(1)
		print("Undefined IsInRange target. Please report. Method: " .. dInfo.name .. "  Line: " .. dInfo.linedefined)
		return false
	end
	return (p1.x - p2.x) *  (p1.x - p2.x) + ((p1.z or p1.y) - (p2.z or p2.y)) * ((p1.z or p1.y) - (p2.z or p2.y)) < range * range 
end

GetEnemiesinRangeCount = function(target,range)
	local inRadius =  {}
	
    for i = 1, TotalHeroes do
		local unit = _EnemyHeroes[i]
		if unit.pos ~= nil and validTarget(unit) then
			if  GetDistance(target.pos, unit.pos) <= range then
								
				inRadius[myCounter] = unit
                myCounter = myCounter + 1
            end
        end
	end
		myCounter = 1
    return #inRadius, inRadius
end


GetAlliesinRangeCount = function(target,range)
	local inRadius =  {}
	
    for i = 1, TotalAHeroes do
		local unit = _AllyHero[i]
		if unit.pos ~= nil and validTarget(unit) then
			if  GetDistance(target.pos, unit.pos) <= range then
								
				inRadius[myCounter] = unit
                myCounter = myCounter + 1
            end
        end
	end
		myCounter = 1
    return #inRadius, inRadius
end


GetMinionsinRangeCount = function(target,range)
	local inRadius =  {}
	
    for i = SagaMCount(), 1, -1 do 
        local minion = SagasBitch(i)
		if minion.pos ~= nil and minion.isTargetable and minion.team == TEAM_ENEMY and minion.dead == false then
			if  GetDistance(target.pos, minion.pos) <= range then	
				inRadius[myCounter] = minion
                myCounter = myCounter + 1
            end
        end
	end
		myCounter = 1
    return #inRadius, inRadius
end

LocalCallbackAdd("Load", function()
TotalHeroes = GetEnemyHeroes()
TotalAHeroes = GetAllyHeroes()
GetIgnite()
--leftside = MapPosition:inLeftBase(myHero.pos)
Saga_Menu()

if Game.Timer() > Saga.Rate.champion:Value() and #_EnemyHeroes == 0 then
    for i = 1, TotalHeroes do 
        local unit = _EnemyHeroes[i]
        if SpellData[unit.charName] then
            for x, v in pairs(SpellData[unit.charName]) do
                if v then
    Saga.Wset.UseW:MenuElement({id = x, name = "ʹ��W��"..v['name'], value = true})
                end
            end
        end
    end
end
if _G.EOWLoaded then
    SagaOrb = 1
elseif _G.SDK and _G.SDK.Orbwalker then
    SagaOrb = 2
elseif _G.GOS then
    SagaOrb = 3
--[[elseif __gsoSDK then
    SagaOrb = 4]]--
end

if  SagaOrb == 1 then
   local mode = EOW:Mode()

   Sagacombo = mode == 1
   Sagaharass = mode == 2
   SagalastHit = mode == 3
   SagalaneClear = mode == 4
   SagajungleClear = mode == 4

   Sagacanmove = EOW:CanMove()
   Sagacanattack = EOW:CanAttack()
elseif  SagaOrb == 2 then
    SagaSDK = SDK.Orbwalker
    SagaSDKCombo = SDK.ORBWALKER_MODE_COMBO
    SagaSDKHarass = SDK.ORBWALKER_MODE_HARASS
    SagaSDKJungleClear = SDK.ORBWALKER_MODE_JUNGLECLEAR
    SagaSDKJungleClear = SDK.ORBWALKER_MODE_JUNGLECLEAR
    SagaSDKLaneClear = SDK.ORBWALKER_MODE_LANECLEAR
    SagaSDKLastHit = SDK.ORBWALKER_MODE_LASTHIT
    SagaSDKFlee = SDK.ORBWALKER_MODE_FLEE
    SagaSDKSelector = SDK.TargetSelector
    SagaSDKMagicDamage = _G.SDK.DAMAGE_TYPE_MAGICAL
    SagaSDKPhysicalDamage = _G.SDK.DAMAGE_TYPE_PHYSICAL
elseif  SagaOrb == 3 then
   
end
end)







DisableMovement = function(bool)

   if SagaOrb == 2 then
       SagaSDK:SetMovement(not bool)
   elseif SagaOrb == 1 then
       EOW:SetMovements(not bool)
   elseif SagaOrb == 3 then
       GOS.BlockMovement = bool
   end
end

DisableAttacks = function(bool)

   if SagaOrb == 2 then
       SagaSDK:SetAttack(not bool)
   elseif SagaOrb == 1 then
       EOW:SetAttacks(not bool)
   elseif SagaOrb == 3 then
       GOS.BlockAttack = bool
   end
end


GetOrbMode = function()
   if SagaOrb == 1 then
       if Sagacombo == 1 then
           return 'Combo'
       elseif Sagaharass == 2 then
           return 'Harass'
       elseif SagalastHit == 3 then
           return 'Lasthit'
       elseif SagalaneClear == 4 then
           return 'Clear'
       end
   elseif SagaOrb == 2 then
       SagaSDKModes = SDK.Orbwalker.Modes
       if SagaSDKModes[SagaSDKCombo] then
           return 'Combo'
       elseif SagaSDKModes[SagaSDKHarass] then
           return 'Harass'
       elseif SagaSDKModes[SagaSDKLaneClear] or SagaSDKModes[SagaSDKJungleClear] then
           return 'Clear'
       elseif SagaSDKModes[SagaSDKLastHit] then
           return 'Lasthit'
       elseif SagaSDKModes[SagaSDKFlee] then
           return 'Flee'
       end
   elseif SagaOrb == 3 then
       return GOS:GetMode()
   elseif SagaOrb == 4 then
        return __gsoOrbwalker.GetMode()
   end
end



RotateAroundPoint = function(v1,v2, angle)
    local cos, sin = math.cos(angle), math.sin(angle)
    local x = ((v1.x - v2.x) * cos) - ((v1.z - v2.z) * sin) + v2.x
    local z = ((v1.z - v2.z) * cos) + ((v1.x - v2.x) * sin) + v2.z
    return Vector(x, v1.y, z or 0)
end



DisableMovement = function(bool)

	if SagaOrb == 2 then
		SagaSDK:SetMovement(not bool)
	elseif SagaOrb == 1 then
		EOW:SetMovements(not bool)
	elseif SagaOrb == 3 then
		GOS.BlockMovement = bool
	end
end

DisableAttacks = function(bool)

	if SagaOrb == 2 then
		SagaSDK:SetAttack(not bool)
	elseif SagaOrb == 1 then
		EOW:SetAttacks(not bool)
	elseif SagaOrb == 3 then
		GOS.BlockAttack = bool
	end
end


LocalCallbackAdd("Draw", function()
    
    if Saga.Drawings.Q.Enabled:Value() then 
        Draw.Circle(myHero.pos, 575, 0, Saga.Drawings.Q.Color:Value())
    end

    if Saga.Drawings.W.Enabled:Value() then 
        Draw.Circle(myHero.pos, 650, 0, Saga.Drawings.W.Color:Value())
    end


    if Saga.Drawings.R.Enabled:Value() then 
        Draw.Circle(myHero.pos, 500, 0, Saga.Drawings.R.Color:Value())
    end
    
    for i = 1, TotalHeroes do 
        local hero = _EnemyHeroes[i]
        if validTarget(hero) then
            if hero.health + hero.shieldAD < GetFullCombo(hero) then
                Draw.Text("KILL NOW", 30, hero.pos2D.x - 50, hero.pos2D.y + 50,Draw.Color(200, 255, 87, 51))				
            else
                Draw.Text("Harass Me", 30, hero.pos2D.x - 50, hero.pos2D.y + 50,Draw.Color(200, 255, 87, 51))
            end
        end
    end

end)

LocalCallbackAdd("Tick", function()

    
    if Game.Timer() > Saga.Rate.champion:Value() and #_EnemyHeroes == 0 then
        TotalHeroes = GetEnemyHeroes()
        TotalAHeroes = GetAllyHeroes()
    end
    if #_EnemyHeroes == 0 then return end

    OnVisionF()
    KillSteal()
    if GetOrbMode() == 'Combo' then
        Combo()
    end

    if GetOrbMode() == 'Harass' then
        Harass()
    end

    if GetOrbMode() == 'Clear'  then
        Clear()
    end


    end)

    Combo = function()
        target = GetTarget(1000)
        if target and validTarget(target)then
            SIGroup(target)

            if Saga.Combo.UseC:Value() then
                CastLaneCombo(target)
            end

            if Saga.Combo.UseL:Value() then
                RealTalonCombo(target)
                end

            if Saga.Combo.UseW:Value() then
                CastW(target)
            end
            if Saga.Combo.UseQ:Value() then
                CastQ(target)
            end
            if Saga.Combo.UseR:Value() then
                CastR(target)
            end
            if Game.CanUseSpell(3) == 0 and Game.CanUseSpell(1) == 0 and Game.CanUseSpell(0) == 0 and GetDistanceSqr(myHero, target) < 500 * 500 and 
            GetDamage(target, HK_R) + GetDamage(target,HK_Q) + GetDamage(target, HK_W) > target.health + target.shieldAD then
                CastW(target)
                CastQ(target)
                CastR(target)
            end

        end
    end

    CastLaneCombo = function(target)
        if GetDamage(target,HK_W) + GetDamage(target,HK_Q) < target.health then
            CastR2(target)
            CastW2(target)
            CastQ(target)
        end
    end

    RealTalonCombo = function(target)
        if GetDamage(target,HK_W) + GetDamage(target,HK_Q) < target.health then
            CastW(target)
            CastR3(target)
            CastQ(target)
        end
    end

    CastR2 = function(target)
        if Game.CanUseSpell(3) == 0 and GetDistanceSqr(myHero, target) < 800 * 800 then
            Control.CastSpell(HK_R)
        end
    end

    CastR3 = function(target)
        if Game.CanUseSpell(3) == 0 and GetDistance(myHero, target) < 575 and Game.CanUseSpell(1) ~= 0 then
            Control.CastSpell(HK_R)
        end
    end

    CastW = function(target) 
        local aim = GetPred(target, 2300, .25)
        if Game.CanUseSpell(1) == 0 and GetDistanceSqr(myHero, target) < 650 * 650 and myHero:GetSpellData(_R).name == "TalonR" then
            if GetDistance(myHero, aim) > 650 then
                aim = myHero.pos + (aim- myHero.pos):Normalized() * 650
            end
            CastSpell(HK_W, aim, 400)
        end
    end

    CastW2 = function(target) 
        local aim = GetPred(target, 2300, .25)
        if Game.CanUseSpell(1) == 0 and GetDistanceSqr(myHero, target) < 650 * 650 and myHero:GetSpellData(_R).name == "TalonR"then
            if GetDistance(myHero, aim) > 650 then
                aim = myHero.pos + (aim- myHero.pos):Normalized() * 650
            end
            CastSpell(HK_W, aim, 400)
        end
    end

    CastQ = function(target)
        if Game.CanUseSpell(0) == 0 and GetDistanceSqr(myHero, target) < 575 * 575 then
            CastSpell(HK_Q, target)
        end
    end
    

    CastR = function(target)
        if Game.CanUseSpell(3) == 0 and GetDistanceSqr(myHero, target) < 500 * 500 and GetDamage(target, HK_R) > target.health + target.shieldAD and myHero:GetSpellData(_R).name == "TalonR" then
            Control.CastSpell(HK_R)
        end
    end

    CastR3 = function(target)
        if Game.CanUseSpell(3) == 0 and GetDistanceSqr(myHero, target) < 500 * 500 and myHero:GetSpellData(_R).name == "TalonR" then
            Control.CastSpell(HK_R)
        end
    end

    Harass = function()
        target = GetTarget(1000)
    if target then
        if Saga.Harass.UseW:Value() then
            CastW(target)
        end
        if Saga.Harass.UseQ:Value() then
            CastQ(target)
        end
    end
    end

    Clear = function() 
        
        for i = 1, Game.MinionCount() do
            local minion = Game.Minion(i)
            if minion then
                if minion.team == 300 - myHero.team and minion.isTargetable and minion.visible and not minion.dead then
                    if Saga.Clear.UseQ:Value() then
                        CastQ(minion)
                    end
                    if Saga.Clear.UseW:Value() then
                        CastW(minion)
                    end
                end
                if minion.team == 300 and minion and minion.isTargetable and minion.visible and not minion.dead then
                    if Saga.Clear.UseQ:Value() then
                        CastQ(minion)
                    end
                    if Saga.Clear.UseW:Value() then
                        CastW(minion)
                    end
                end
            end
        end
    end

    KillSteal = function()
        target = GetTarget(1000)
        if target then
            if GetDamage(target, HK_Q) > target.health + target.shieldAD and Saga.KillSteal.UseQ:Value() then
                CastQ(target)
            end

            if GetDamage(target, HK_W) > target.health + target.shieldAD and Saga.KillSteal.UseW:Value() then
                CastW(target)
            end

            if Saga.KillSteal.UseQ:Value() and Saga.KillSteal.UseW:Value() and GetDamage(target, HK_Q) > target.health + target.shieldAD and GetDamage(target, HK_W) > target.health + target.shieldAD then
                CastW(target)
                CastQ(target)
            end

            if Saga.KillSteal.UseR:Value() and GetDamage(target, HK_R) > target.health + target.shieldAD then
                CastR(target)
            end
        end

    end
    
    GetFullCombo = function(target)
        local spells = {HK_Q,HK_W,HK_R}
        local damage = 0
        for i = 1, #spells do 
            local s = spells[i]
            damage = damage + GetDamage(target, s)
        end
        return damage
    end
    checkItems = function()
        local items = {}
        for slot = ITEM_1,ITEM_6 do
            local id = myHero:GetItemData(slot).itemID 
            if id > 0 then
                items[id] = slot
            end
        end
        return items
    end
    
    GetIgnite = function()
        if myHero:GetSpellData(SUMMONER_2).name:lower() == "summonerdot" then
            igniteslot = 5
            ignitecast = HK_SUMMONER_2
    
        elseif myHero:GetSpellData(SUMMONER_1).name:lower() == "summonerdot" then
            igniteslot = 4
            ignitecast = HK_SUMMONER_1
        else
            igniteslot = nil
            ignitecast = nil
        end
        
    end
    SIGroup = function(target)
        local items = checkItems()
        local bg = items[3144] or items[3153]
        if target then
            if bg and Saga.items.bg:Value() and myHero:GetSpellData(bg).currentCd == 0  and myHero.pos:DistanceTo(target.pos) < 550 then
                Control.CastSpell(HKITEM[bg], target.pos)
            end
            
            
            local tmt = items[3077] or items[3748] or items[3074]
            if tmt and Saga.items.tm:Value() and myHero:GetSpellData(tmt).currentCd == 0  and myHero.pos:DistanceTo(target.pos) < 400 and myHero.attackData.state == 2 then
                Control.CastSpell(HKITEM[tmt], target.pos)
            end
    
            local YG = items[3142]
            if YG and Saga.items.yg:Value() and myHero:GetSpellData(YG).currentCd == 0  and myHero.pos:DistanceTo(target.pos) < 1575 then
                Control.CastSpell(HKITEM[YG])
            end
            
            
            if ignitecast and igniteslot and Saga.items.ig:Value() then
                if target and Game.CanUseSpell(igniteslot) == 0 and GetDistanceSqr(myHero, target) < 450 * 450 and 25 >= (100 * target.health / target.maxHealth) then
                    Control.CastSpell(ignitecast, target)
                end
            end
    
        end
    
    end
    
    CastSpell = function(spell,pos,delay)
        
        local range = range or math.huge
        local delay = delay or 250
        local ticker = GetTickCount()
    
        if castSpell.state == 0 and ticker - castSpell.casting > delay + Latency() then
            castSpell.state = 1
            castSpell.mouse = mousePos
            castSpell.tick = ticker
        end
        if castSpell.state == 1 then
            if ticker - castSpell.tick < Latency() then
                Control.SetCursorPos(pos)
                Control.KeyDown(spell)
                Control.KeyUp(spell)
                castSpell.casting = ticker + delay
                DelayAction(function()
                    if castSpell.state == 1 then
                        Control.SetCursorPos(castSpell.mouse)
                        castSpell.state = 0
                    end
                end,Latency()/1000)
            end
            if ticker - castSpell.casting > Latency() then
                Control.SetCursorPos(castSpell.mouse)
                castSpell.state = 0
            end
        end
    end
    
    
    
    CastItBlindFuck = function(spell, pos, range, delay)
    
        local range = range or math.huge
        local delay = delay or 250
        local ticker = GetTickCount()
    
        if castSpell.state == 0 and GetDistance(myHero.pos, pos) < range and ticker - castSpell.casting > delay + Latency() then
            castSpell.state = 1
            castSpell.mouse = mousePos
            castSpell.tick = ticker
        end
        if castSpell.state == 1 then
            if ticker - castSpell.tick < Latency() then
                local castPosMM = pos:ToMM()
                Control.SetCursorPos(castPosMM.x,castPosMM.y)
                Control.KeyDown(spell)
                Control.KeyUp(spell)
                castSpell.casting = ticker + delay
                DelayAction(function()
                    if castSpell.state == 1 then
                        Control.SetCursorPos(castSpell.mouse)
                        castSpell.state = 0
                    end
                end,ping)
            end
            if ticker - castSpell.casting > Latency() then
                Control.SetCursorPos(castSpell.mouse)
                castSpell.state = 0
            end
        end
    end
    
    function GetDistance2D(p1,p2)
        return sqrt((p2.x - p1.x)*(p2.x - p1.x) + (p2.y - p1.y)*(p2.y - p1.y))
    end
    
    local _OnWaypoint = {}
    function OnWaypoint(unit)
        if _OnWaypoint[unit.networkID] == nil then _OnWaypoint[unit.networkID] = {pos = unit.posTo , speed = unit.ms, time = Game.Timer()} end
        if _OnWaypoint[unit.networkID].pos ~= unit.posTo then 
            -- print("OnWayPoint:"..unit.charName.." | "..math.floor(Game.Timer()))
            _OnWaypoint[unit.networkID] = {startPos = unit.pos, pos = unit.posTo , speed = unit.ms, time = Game.Timer()}
                DelayAction(function()
                    local time = (Game.Timer() - _OnWaypoint[unit.networkID].time)
                    local speed = GetDistance2D(_OnWaypoint[unit.networkID].startPos,unit.pos)/(Game.Timer() - _OnWaypoint[unit.networkID].time)
                    if speed > 1250 and time > 0 and unit.posTo == _OnWaypoint[unit.networkID].pos and GetDistance(unit.pos,_OnWaypoint[unit.networkID].pos) > 200 then
                        _OnWaypoint[unit.networkID].speed = GetDistance2D(_OnWaypoint[unit.networkID].startPos,unit.pos)/(Game.Timer() - _OnWaypoint[unit.networkID].time)
                        -- print("OnDash: "..unit.charName)
                    end
                end,0.05)
        end
        return _OnWaypoint[unit.networkID]
    end
    
    function IsImmobileTarget(unit)
        for i = 0, unit.buffCount do
            local buff = unit:GetBuff(i)
            if buff and (buff.type == 5 or buff.type == 11 or buff.type == 29 or buff.type == 24 or buff.name == "recall") and buff.count > 0 then
                return true
            end
        end
        return false	
    end
    
    function GetPred(unit,speed,delay, sourceA)
        local speed = speed or math.huge
        local delay = delay or 0.25
        local unitSpeed = unit.ms
        local source = myHero or sourceA
        if OnWaypoint(unit).speed > unitSpeed then unitSpeed = OnWaypoint(unit).speed end
        if OnVision(unit).state == false then
            local unitPos = unit.pos + Vector(unit.pos,unit.posTo):Normalized() * ((GetTickCount() - OnVision(unit).tick)/1000 * unitSpeed)
            local predPos = unitPos + Vector(unit.pos,unit.posTo):Normalized() * (unitSpeed * (delay + (GetDistance(source.pos,unitPos)/speed)))
            if GetDistance(unit.pos,predPos) > GetDistance(unit.pos,unit.posTo) then predPos = unit.posTo end
            return predPos
        else
            if unitSpeed > unit.ms then
                local predPos = unit.pos + Vector(OnWaypoint(unit).startPos,unit.posTo):Normalized() * (unitSpeed * (delay + (GetDistance(source.pos,unit.pos)/speed)))
                if GetDistance(unit.pos,predPos) > GetDistance(unit.pos,unit.posTo) then predPos = unit.posTo end
                return predPos
            elseif IsImmobileTarget(unit) then
                return unit.pos
            else
                return unit:GetPrediction(speed,delay)
            end
        end
    end
    
    GetTarget = function(range)
    
        if SagaOrb == 1 then
            if myHero.ap > myHero.totalDamage then
                return EOW:GetTarget(range, EOW.ap_dec, myHero.pos)
            else
                return EOW:GetTarget(range, EOW.ad_dec, myHero.pos)
            end
        elseif SagaOrb == 2 and SagaSDKSelector then
            if myHero.ap > myHero.totalDamage then
                return SagaSDKSelector:GetTarget(range, SagaSDKMagicDamage)
            else
                return SagaSDKSelector:GetTarget(range, SagaSDKPhysicalDamage)
            end
        elseif _G.GOS then
            if myHero.ap > myHero.totalDamage then
                return GOS:GetTarget(range, "AP")
            else
                return GOS:GetTarget(range, "AD")
            end
        elseif _G.gsoSDK then
            return _G.gsoSDK.TS:GetTarget()
        end
    end
    
    
    function CalcPhysicalDamage(source, target, amount)
        local ArmorPenPercent = source.armorPenPercent
        local ArmorPenFlat = (0.4 + target.levelData.lvl / 30) * source.armorPen
        local BonusArmorPen = source.bonusArmorPenPercent
      
        if source.type == Obj_AI_Minion then
          ArmorPenPercent = 1
          ArmorPenFlat = 0
          BonusArmorPen = 1
        elseif source.type == Obj_AI_Turret then
          ArmorPenFlat = 0
          BonusArmorPen = 1
          if source.charName:find("3") or source.charName:find("4") then
            ArmorPenPercent = 0.25
          else
            ArmorPenPercent = 0.7
          end
        end
      
        if source.type == Obj_AI_Turret then
          if target.type == Obj_AI_Minion then
            amount = amount * 1.25
            if string.ends(target.charName, "MinionSiege") then
              amount = amount * 0.7
            end
            return amount
          end
        end
      
        local armor = target.armor
        local bonusArmor = target.bonusArmor
        local value = 100 / (100 + (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat)
      
        if armor < 0 then
          value = 2 - 100 / (100 - armor)
        elseif (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat < 0 then
          value = 1
        end
        return math.max(0, math.floor(DamageReductionMod(source, target, PassivePercentMod(source, target, value) * amount, 1)))
      end
    
    CalcMagicalDamage = function(source, target, amount)
        local mr = target.magicResist
        local value = 100 / (100 + (mr * source.magicPenPercent) - source.magicPen)
      
        if mr < 0 then
          value = 2 - 100 / (100 - mr)
        elseif (mr * source.magicPenPercent) - source.magicPen < 0 then
          value = 1
        end
        return math.max(0, math.floor(DamageReductionMod(source, target, PassivePercentMod(source, target, value) * amount, 2)))
      end
    
      DamageReductionMod = function(source,target,amount,DamageType)
        if source.type == Obj_AI_Hero then
          if GotBuff(source, "Exhaust") > 0 then
            amount = amount * 0.6
          end
        end
        if target.type == Obj_AI_Hero then
          for i = 0, target.buffCount do
            if target:GetBuff(i).count > 0 then
              local buff = target:GetBuff(i)
              if buff.name == "MasteryWardenOfTheDawn" then
                amount = amount * (1 - (0.06 * buff.count))
              end
              if DamageReductionTable[target.charName] then
                if buff.name == DamageReductionTable[target.charName].buff and (not DamageReductionTable[target.charName].damagetype or DamageReductionTable[target.charName].damagetype == DamageType) then
                  amount = amount * DamageReductionTable[target.charName].amount(target)
                end
              end
              if target.charName == "Maokai" and source.type ~= Obj_AI_Turret then
                if buff.name == "MaokaiDrainDefense" then
                  amount = amount * 0.8
                end
              end
              if target.charName == "MasterYi" then
                if buff.name == "Meditate" then
                  amount = amount - amount * ({0.5, 0.55, 0.6, 0.65, 0.7})[target:GetSpellData(_W).level] / (source.type == Obj_AI_Turret and 2 or 1)
                end
              end
            end
          end
        if target.charName == "Kassadin" and DamageType == 2 then
            amount = amount * 0.85
          end
        end
        return amount
      end
    
      PassivePercentMod = function(source, target, amount, damageType)
        local SiegeMinionList = {"Red_Minion_MechCannon", "Blue_Minion_MechCannon"}
        local NormalMinionList = {"Red_Minion_Wizard", "Blue_Minion_Wizard", "Red_Minion_Basic", "Blue_Minion_Basic"}
        if source.type == Obj_AI_Turret then
          if table.contains(SiegeMinionList, target.charName) then
            amount = amount * 0.7
          elseif table.contains(NormalMinionList, target.charName) then
            amount = amount * 1.14285714285714
          end
        end
        if source.type == Obj_AI_Hero then 
          if target.type == Obj_AI_Hero then
            if (GetItemSlot(source, 3036) > 0 or GetItemSlot(source, 3034) > 0) and source.maxHealth < target.maxHealth and damageType == 1 then
              amount = amount * (1 + math.min(target.maxHealth - source.maxHealth, 500) / 50 * (GetItemSlot(source, 3036) > 0 and 0.015 or 0.01))
            end
          end
        end
        return amount
        end
        
    
    GetItemSlot = function(unit, id)
        for i = ITEM_1, ITEM_7 do
            if unit:GetItemData(i).itemID == id then
                return i
            end
        end
        return 0
    end
    
    IsEvading = function()
    if ExtLibEvade and ExtLibEvade.Evading then
        
        return true
    end
    end
    
    GetItemSlotCustom= function(unit, id)
        for i = ITEM_1, ITEM_7 do
            if unit:GetItemData(i).itemID == id then
                return i
            end
        end
        return 0
    end
    
    ---Took From Shulepin
    function DashEndPos(unit)
        return myHero.pos + (unit.pos - myHero.pos):Normalized() * 600
    end
    
    function CalcPhysicalDamage(source, target, amount)
        local ArmorPenPercent = source.armorPenPercent
        local ArmorPenFlat = (0.4 + target.levelData.lvl / 30) * source.armorPen
        local BonusArmorPen = source.bonusArmorPenPercent
      
        if source.type == Obj_AI_Minion then
          ArmorPenPercent = 1
          ArmorPenFlat = 0
          BonusArmorPen = 1
        elseif source.type == Obj_AI_Turret then
          ArmorPenFlat = 0
          BonusArmorPen = 1
          if source.charName:find("3") or source.charName:find("4") then
            ArmorPenPercent = 0.25
          else
            ArmorPenPercent = 0.7
          end
        end
      
        if source.type == Obj_AI_Turret then
          if target.type == Obj_AI_Minion then
            amount = amount * 1.25
            if string.ends(target.charName, "MinionSiege") then
              amount = amount * 0.7
            end
            return amount
          end
        end
      
        local armor = target.armor
        local bonusArmor = target.bonusArmor
        local value = 100 / (100 + (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat)
      
        if armor < 0 then
          value = 2 - 100 / (100 - armor)
        elseif (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat < 0 then
          value = 1
        end
        return math.max(0, math.floor(DamageReductionMod(source, target, PassivePercentMod(source, target, value) * amount, 1)))
      end
    
      function DamageReductionMod(source,target,amount,DamageType)
        if source.type == Obj_AI_Hero then
          if GotBuff(source, "Exhaust") > 0 then
            amount = amount * 0.6
          end
        end
        if target.type == Obj_AI_Hero then
          for i = 0, target.buffCount do
            if target:GetBuff(i).count > 0 then
              local buff = target:GetBuff(i)
              if buff.name == "MasteryWardenOfTheDawn" then
                amount = amount * (1 - (0.06 * buff.count))
              end
              if DamageReductionTable[target.charName] then
                if buff.name == DamageReductionTable[target.charName].buff and (not DamageReductionTable[target.charName].damagetype or DamageReductionTable[target.charName].damagetype == DamageType) then
                  amount = amount * DamageReductionTable[target.charName].amount(target)
                end
              end
              if target.charName == "Maokai" and source.type ~= Obj_AI_Turret then
                if buff.name == "MaokaiDrainDefense" then
                  amount = amount * 0.8
                end
              end
              if target.charName == "MasterYi" then
                if buff.name == "Meditate" then
                  amount = amount - amount * ({0.5, 0.55, 0.6, 0.65, 0.7})[target:GetSpellData(_W).level] / (source.type == Obj_AI_Turret and 2 or 1)
                end
              end
            end
          end
        if GetItemSlotCustom(target, 1054) > 0 then
            amount = amount - 8
          end
        if target.charName == "Kassadin" and DamageType == 2 then
            amount = amount * 0.85
          end
        end
        return amount
      end
    
      PassivePercentMod = function(source, target, amount, damageType)
        local SiegeMinionList = {"Red_Minion_MechCannon", "Blue_Minion_MechCannon"}
        local NormalMinionList = {"Red_Minion_Wizard", "Blue_Minion_Wizard", "Red_Minion_Basic", "Blue_Minion_Basic"}
        if source.type == Obj_AI_Turret then
          if table.contains(SiegeMinionList, target.charName) then
            amount = amount * 0.7
          elseif table.contains(NormalMinionList, target.charName) then
            amount = amount * 1.14285714285714
          end
        end
        if source.type == Obj_AI_Hero then 
          if target.type == Obj_AI_Hero then
            if (GetItemSlotCustom(source, 3036) > 0 or GetItemSlotCustom(source, 3034) > 0) and source.maxHealth < target.maxHealth and damageType == 1 then
              amount = amount * (1 + math.min(target.maxHealth - source.maxHealth, 500) / 50 * (GetItemSlotCustom(source, 3036) > 0 and 0.015 or 0.01))
            end
          end
        end
        return amount
        end
    
    
        function GetHeroByHandle(handle)
            for i = 1, TotalHeroes do
                local h = _EnemyHeroes[i]
                if h.handle == handle then
                    return h
                end
            end
        end
    
        ResetAutoAttack = function()
            _G.SDK.Orbwalker:__OnAutoAttackReset()
        end
    
    
        GetDamage= function(target, spell) 
        
        local basedamage = 0
      
        if Game.CanUseSpell(0) == 0 and spell == HK_Q then
            basedamage = CalcPhysicalDamage(myHero,target, (myHero:GetSpellData(_Q).level* 25 + 40) + (1.1 * myHero.bonusDamage))
        end
        
      
        if Game.CanUseSpell(1) == 0 and spell == HK_W then
            basedamage = CalcPhysicalDamage(myHero,target, (myHero:GetSpellData(_Q).level* 15 + 35) + (.4 * myHero.bonusDamage)) +
            CalcPhysicalDamage(myHero,target, (myHero:GetSpellData(_Q).level* 25 + 45) + (.6 * myHero.bonusDamage))
        end
      
        if Game.CanUseSpell(3) == 0 and spell == HK_R then
            basedamage = CalcPhysicalDamage(myHero,target, (myHero:GetSpellData(_R).level* 45 + 45) + (myHero.bonusDamage))
        end
      
        return basedamage
    end
    
    Saga_Menu = 
    function()
        Saga = MenuElement({type = MENU, id = "Talon", name = "saga��ħצ:�����ڵ�����", icon = AIOIcon})
        MenuElement({ id = "blank", type = SPACE ,name = "�汾BETA 1 . 2 . 3"})
        --Combo
        Saga:MenuElement({id = "Combo", name = "�߿�", type = MENU})
        Saga.Combo:MenuElement({id = "UseQ", name = "Q", value = true})
        Saga.Combo:MenuElement({id = "UseW", name = "W", value = true})
        Saga.Combo:MenuElement({id = "UseR", name = "R", value = true})
        Saga.Combo:MenuElement({id = "blank2", name = "ֻѡ������֮һ(���)",type = SPACE})
        Saga.Combo:MenuElement({id = "UseC", name = "����1", value = false})
        Saga.Combo:MenuElement({id = "UseL", name = "����2", value = true})

        Saga:MenuElement({id = "Harass", name = "ɧ��", type = MENU})
        Saga.Harass:MenuElement({id = "UseQ", name = "Q", value = true})
        Saga.Harass:MenuElement({id = "UseW", name = "W", value = true})
        
    
        
        Saga:MenuElement({id = "Clear", name = "����", type = MENU})
        Saga.Clear:MenuElement({id = "UseQ", name = "Q", value = true})
        Saga.Clear:MenuElement({id = "UseW", name = "W", value = true})
        
    
        
        Saga:MenuElement({id = "Rate", name = "������", type = MENU})
        Saga.Rate:MenuElement({id = "champion", name = "ֵ", value = 30, min = 1, max = 120, step = 1})
        
        Saga:MenuElement({id = "KillSteal", name = "նɱ", type = MENU})
        Saga.KillSteal:MenuElement({id = "UseQ", name = "Q", value = true})
        Saga.KillSteal:MenuElement({id = "UseW", name = "W", value = true})
        Saga.KillSteal:MenuElement({id = "UseR", name = "R", value = true})
            
        Saga:MenuElement({id = "items", name = "ʹ����Ʒ", type = MENU})
        Saga.items:MenuElement({id = "bg", name = "ʹ�� �ȶ��������䵶/�ư�����֮��", value = true})
        Saga.items:MenuElement({id = "tm", name = "��������/̰����ͷ��", value = true})
        Saga.items:MenuElement({id = "yg", name = "����֮��", value = true})
        Saga.items:MenuElement({id = "ig", name = "��ȼ", value = true})
    
        Saga:MenuElement({id = "Drawings", name = "ͼֽ", type = MENU})
        Saga.Drawings:MenuElement({id = "Q", name = "����Q��Χ", type = MENU})
        Saga.Drawings.Q:MenuElement({id = "Enabled", name = "����", value = true})       
        Saga.Drawings.Q:MenuElement({id = "Width", name = "���", value = 1, min = 1, max = 5, step = 1})
        Saga.Drawings.Q:MenuElement({id = "Color", name = "��ɫ", color = Draw.Color(200, 255, 255, 255)})
            --E
            Saga.Drawings:MenuElement({id = "W", name = "����W��Χ", type = MENU})
            Saga.Drawings.W:MenuElement({id = "Enabled", name = "����", value = true})       
            Saga.Drawings.W:MenuElement({id = "Width", name = "���", value = 1, min = 1, max = 5, step = 1})
            Saga.Drawings.W:MenuElement({id = "Color", name = "��ɫ", color = Draw.Color(200, 255, 255, 255)})
        
        
        Saga.Drawings:MenuElement({id = "R", name = "����R��Χ", type = MENU})
        Saga.Drawings.R:MenuElement({id = "Enabled", name = "����", value = true})       
        Saga.Drawings.R:MenuElement({id = "Width", name = "���", value = 1, min = 1, max = 5, step = 1})
        Saga.Drawings.R:MenuElement({id = "Color", name = "��ɫ", color = Draw.Color(200, 255, 255, 255)})	
    
    
    end
