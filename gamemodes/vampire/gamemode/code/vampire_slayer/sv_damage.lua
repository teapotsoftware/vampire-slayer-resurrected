
util.AddNetworkString("SyncRagdollColor")

-- This is used for both vampires and slayers
function CreatePlayerRagdoll(ply)
	local rag = ents.Create("prop_ragdoll")
	rag:SetModel(ply:GetModel())
	rag:SetPos(ply:GetPos())
	-- rag.GetPlayerColor = function() return ply:GetPlayerColor() end
	rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	rag:Spawn()

	timer.Simple(0, function()
		if not IsValid(ply) or not IsValid(rag) then return end
		net.Start("SyncRagdollColor")
		net.WriteEntity(rag)
		net.WriteVector(ply:GetPlayerColor())
		net.Broadcast()
	end)

	-- Position the bones
	local num = rag:GetPhysicsObjectCount() - 1
	for i = 0, num do
		local bone = rag:GetPhysicsObjectNum(i)
		if IsValid(bone) then
			local bp, ba = ply:GetBonePosition(rag:TranslatePhysBoneToBone(i))
			if bp and ba then
				bone:SetPos(bp)
				bone:SetAngles(ba)
				bone:SetVelocity(VectorRand(-500, 500))
			end
		end
	end

	return rag
end

local function PlayerIsStuck(ply, pos)
    local pos = ply:GetPos()
	local M = ply:OBBMaxs()
	local m = ply:OBBMins()
	local s = ply:GetModelScale()
    local tr = util.TraceHull({    
        start = pos,
        endpos = pos,
        maxs = Vector(M.x / s, M.y / s, M.z / s) ,
        mins = Vector(m.x / s, m.y / s, m.z / s),
        collisiongroup = COLLISION_GROUP_PLAYER,
        mask = MASK_PLAYERSOLID
    })

    return tr.Hit
end

function VampireKnockdown(ply, bKnockedDown)
	if bKnockedDown then
		ply:SetHealth(CONVARS.knockdown_health:GetInt())
		ply:SetNoDraw(true)
		ply:Freeze(true)
		ply:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

		local rag = CreatePlayerRagdoll(ply)
		rag.VampireOwner = ply
		ply:SetViewEntity(rag)

		ply.KnockedVampire = {
			knock_time = CurTime(),
			knocked_ragdoll = rag,
			previous_view_ent = ply:GetViewEntity(),
			previous_pos = ply:GetPos()
		}
	else
		ply:SetViewEntity(null) -- For some reason previous_view_ent doesn't work
		ply:SetNoDraw(false)
		ply:Freeze(false)
		ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		if IsValid(ply.KnockedVampire.knocked_ragdoll) then
			ply:SetPos(ply.KnockedVampire.knocked_ragdoll:GetPos())
			ply.KnockedVampire.knocked_ragdoll:Remove()
		else
			print("PREVIOUS RAGDOLL INVALID!")
		end
		if PlayerIsStuck(ply) then
			ply:SetPos(ply.KnockedVampire.previous_pos)
		end
		ply.KnockedVampire = nil
	end
end

local skull_model = Model("models/Gibs/HGIBS.mdl")

function GibExplosion(pos, gibcount, radius)
	gibcount = gibcount or 6
	radius = radius or 12

	for i = 1, gibcount do
		local x = math.cos(math.rad((i / gibcount) * 360)) * radius
		local y = math.sin(math.rad((i / gibcount) * 360)) * radius
		local gib = ents.Create("vs_gib")
		gib:SetPos(pos + Vector(x, y))
		gib:SetAngles(AngleRand())
		gib:Spawn()
		local phys = gib:GetPhysicsObject()

		if IsValid(phys) then
			local vel = VectorRand(-120, 120)
			vel.z = math.random(100, 200)
			phys:SetVelocity(vel)
		end

		if i == 1 then
			gib:SetModel(skull_model)
			gib:SetColor(color_white)
		end
	end

	sound.Play("vampire_slayer/gib_0" .. math.random(3) .. ".wav", pos)
end

function GM:EntityTakeDamage(target, dmg)
	-- If a knocked vampire's ragdoll takes stake damage, pass the damage to the owner
	if CONVARS.knockdown_ragdoll:GetBool() and target:GetClass() == "prop_ragdoll" and IsValid(target.VampireOwner) and dmg:IsDamageType(DMG_CLUB) then
		dmg:ScaleDamage(100)
		target.VampireOwner:TakeDamageInfo(dmg)

		return true
	end

	if IsValid(target) and target:IsPlayer() and target:Alive() then
		if target.KnockedVampire and not dmg:IsDamageType(DMG_CLUB) then
			return true
		end

		local attacker = dmg:GetAttacker()

		if IsValid(attacker) and attacker:IsPlayer() then
			if (IsRoundState(ROUND_INPROGRESS) or IsRoundState(ROUND_PREPARING)) and target:Team() == attacker:Team() and target ~= attacker then
				if dmg:IsDamageType(DMG_BLAST) then
					dmg:SetDamage(0)
				else
					dmg:ScaleDamage(0.2)
					attacker:TakeDamageInfo(dmg)
				end
			end

			if target == attacker and dmg:IsDamageType(DMG_BLAST) then
				dmg:ScaleDamage(0.5)
			end

			-- The power of Christ protects you!
			if target:Team() == TEAM_SLAY and attacker:Team() == TEAM_VAMP and target:IsPraying() then
				dmg:ScaleDamage(0)
			end

			-- Pool cue secondary attack
			if dmg:IsDamageType(DMG_NEVERGIB) and target:Team() == TEAM_VAMP then
				target:SetVelocity((target:GetPos() - attacker:GetPos()):GetNormalized() * 400 + Vector(0, 0, 300))
			end
		end

		-- Knock vampires down unless you're using a stake
		if target:Team() == TEAM_VAMP and dmg:GetDamage() >= target:Health() and not (dmg:IsDamageType(DMG_CLUB) or dmg:IsDamageType(DMG_BURN)) then
			if CONVARS.knockdown_ragdoll:GetBool() then
				VampireKnockdown(target, true)
				return true
			else
				dmg:SetDamage(target:Health() - 1)
			end
		end

		target:ViewPunch(Angle(dmg:GetDamage() * 0.3, dmg:GetDamage() * math.Rand(-0.2, 0.2), 0))
	end
end

-- Headshots do 25% more damage, but leg shots do 25% less
function GM:ScalePlayerDamage(ply, hit, dmg)
	if hit == HITGROUP_HEAD then
		dmg:ScaleDamage(1.25)
	elseif hit == HITGROUP_LEFTLEG or hit == HITGROUP_RIGHTLEG then
		dmg:ScaleDamage(0.75)
	end
end

function GM:PlayerPostThink(ply)
	if CONVARS.ctc_enabled:GetBool() and not ply:Alive() and CurTime() >= (ply:GetNWFloat("last_death", 0) + CONVARS.ctc_respawn_time:GetFloat()) then
		ply:Spawn()
	end

	if ply:Team() == TEAM_VAMP and ply:Alive() then
		if CONVARS.knockdown_ragdoll:GetBool() then
			if ply.KnockedVampire and CurTime() - ply.KnockedVampire.knock_time > CONVARS.knockdown_time:GetFloat() then
				VampireKnockdown(ply, false)
			end
		else
			if ply:Health() == 1 and not ply.KnockedVampire then
				ply.KnockedVampire = CurTime()
				ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 10))
				ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 10))
				ply:SetLuaAnimation("fallover")
			elseif ply.KnockedVampire and CurTime() - ply.KnockedVampire > CONVARS.knockdown_time:GetFloat() then
				ply.KnockedVampire = nil
				ply:SetHealth(CONVARS.knockdown_health:GetInt())
				ply:ResetHull()
				ply:StopLuaAnimation("fallover")
			end
		end

		if not ply.LastSunlightBurn then ply.LastSunlightBurn = 0 end
		if CurTime() - ply.LastSunlightBurn >= 0.5 then
			if IsInSunlight(ply:EyePos()) then
				local isNina = player_manager.GetPlayerClass(ply) == "player_nina"
				if OVERCAST_MAPS[game.GetMap()] then
					if isNina then
						ply:SetHealth(math.Clamp(ply:Health() + 2, 0, ply:GetMaxHealth()))
					end
				else
					if not isNina then
						local dmg_sunlight = DamageInfo()
						dmg_sunlight:SetDamage(2)
						dmg_sunlight:SetDamageType(DMG_BURN)
						dmg_sunlight:SetAttacker(ply)
						dmg_sunlight:SetInflictor(ply)
						ply:TakeDamageInfo(dmg_sunlight)
					end
				end
			end
			ply.LastSunlightBurn = CurTime()
		end		
	end

	ply:SetRenderMode((ply:Alive() and ply:Team() == TEAM_VAMP and player_manager.GetPlayerClass(ply) == "player_edgar" and ply:Crouching() and ply:OnGround()) and RENDERMODE_TRANSALPHA or RENDERMODE_NORMAL)
end

local function GetSpecTargets(current_target)
	local index = 1
	local plys = {}
	for _, ply in ipairs(player.GetAll()) do
		if ply:Alive() and (ply:Team() == TEAM_SLAY or ply:Team() == TEAM_VAMP) then
			table.insert(plys, ply)
			if ply == current_target then
				index = #plys
			end
		end
	end
	return plys, index
end

local RagNumber = 0

function GM:DoPlayerDeath(ply, atk, dmg)
	if ply:Team() == TEAM_VAMP then
		if ply.KnockedVampire then
			if CONVARS.knockdown_ragdoll:GetBool() then
				VampireKnockdown(ply, false)
			else
				ply.KnockedVampire = nil
			end
		end

		GibExplosion(ply:GetPos() + Vector(0, 0, 30))
	end

	if ply:Team() == TEAM_SLAY then
		local rag = CreatePlayerRagdoll(ply)
		rag.CorpseBlood = CONVARS.corpse_health:GetInt()

		-- Keep track of ragdolls
		rag.RagNumber = RagNumber
		RagNumber = RagNumber + 1
		local rag_amt = 0
		for k, v in ents.FindByClass("prop_ragdoll") do
			if v.RagNumber then
				rag_amt = rag_amt + 1
			end
		end

		-- Delete corpse(s) if there are too many
		if rag_amt > CONVARS.max_corpses:GetInt() then
			for i = 0, rag_amt - CONVARS.max_corpses:GetInt() do
				local oldest_rag = NULL
				local lowest_num = math.max
				for k, v in ents.FindByClass("prop_ragdoll") do
					if oldest_rag == NULL or v.RagNumber < oldest_rag.RagNumber then
						oldest_rag = v
					end
				end
				oldest_rag:Remove()
			end
		end
	end

	ply:AddDeaths(1)

	if atk:IsValid() and atk:IsPlayer() then
		if atk == ply then
			atk:AddFrags(-1)
		else
			atk:AddFrags(1)
		end
	end

	ply:Spectate(OBS_MODE_DEATHCAM)
	ply:SpectateEntity(atk)

	timer.Simple(4, function()
		if not IsValid(ply) or ply:Alive() then return end
		ply:Spectate(OBS_MODE_CHASE)
		if IsValid(atk) and atk:IsPlayer() and atk:Alive() then
			ply:SpectateEntity(atk)
		else
			ply:SpectateEntity(GetSpecTargets(NULL)[1])
		end
	end)
end

function GM:PostPlayerDeath(ply)
	ply:SetNWFloat("last_death", CurTime())

	if ply:IsCarryingFlag() then
		ply:SetNWBool("carrying_flag", false)
		local flagTeam = OTHER_TEAM[ply:Team()]
		local flag = ents.Create("vs_flag")
		flag:SetPos(ply:GetPos() + Vector(0, 0, 32))
		flag:SetIsDropped(true)
		flag:SetDropTime(CurTime())
		flag:SetTeam(flagTeam)
		flag:SetStartPos(FLAG_LOCATIONS[game.GetMap()][flagTeam] - Vector(0, 0, 20))
		flag:Spawn()
		net.Start("VSR_SendGameUpdate")
		net.WriteUInt(2 + flagTeam, 8)
		net.Broadcast()
	end

	if CONVARS.ammo_drops:GetBool() and ply:Team() == TEAM_SLAY then
		local ammo = ents.Create("vs_ammo")
		ammo:SetPos(ply:GetPos() + Vector(0, 0, 12))
		ammo:Spawn()
	end
end

hook.Add("PlayerButtonDown", "VampireSlayer.CycleSpectateTarget", function(ply, btn)
	if ply:Alive() or ply:GetObserverMode() == OBS_MODE_DEATHCAM then return end

	local t = ply:GetObserverTarget()
	if btn == MOUSE_LEFT then
		local plys, index = GetSpecTargets(t)
		local new_index = index - 1
		if new_index <= 0 then
			new_index = #plys
		end
		ply:SpectateEntity(plys[new_index])
	elseif btn == MOUSE_RIGHT then
		local plys, index = GetSpecTargets(t)
		local new_index = index + 1
		if new_index > #plys then
			new_index = 1
		end
		ply:SpectateEntity(plys[new_index])
	elseif btn == KEY_SPACE then
		if ply:GetObserverMode() == OBS_MODE_IN_EYE then
			ply:Spectate(OBS_MODE_CHASE)
		else
			ply:Spectate(OBS_MODE_IN_EYE)
		end
	elseif btn == KEY_E and (not CONVARS.ctc_enabled:GetBool()) then
		if IsValid(t) and t:IsPlayer() and t:IsBot() and t:Team() == ply:Team() then
			ply:Spawn()
			ply:SetHealth(t:Health())
			ply:SetPos(t:GetPos())
			ply:SetEyeAngles(t:EyeAngles())
			player_manager.SetPlayerClass(ply, player_manager.GetPlayerClass(t))
			player_manager.OnPlayerSpawn(ply)
			player_manager.RunClass(ply, "Spawn")
			t:KillSilent()
		end
	end
end)

local slurp_sound = Sound("NPC_Barnacle.FinalBite")

-- Vampires can slurp blood from corpses to regain health
function GM:PlayerUse(ply, ent)
	if ply:Team() == TEAM_VAMP and ply:Health() < ply:GetMaxHealth() and ent.CorpseBlood and ent.CorpseBlood > 0 then
		if not ply.LastCorpseSlurp then ply.LastCorpseSlurp = 0 end
		if not ply.LastCorpseSlurpSound then ply.LastCorpseSlurpSound = 0 end

		if CurTime() - ply.LastCorpseSlurp >= CONVARS.slurp_cooldown:GetFloat() then
			ply.LastCorpseSlurp = CurTime()
			local slurp_health = math.min(ply:GetMaxHealth() - ply:Health(), ent.CorpseBlood, CONVARS.slurp_amount:GetInt())
			ent.CorpseBlood = ent.CorpseBlood - slurp_health
			ply:SetHealth(ply:Health() + slurp_health)

			if CurTime() - ply.LastCorpseSlurpSound > 0.7 then
				ply.LastCorpseSlurpSound = CurTime()
				ply:EmitSound(slurp_sound)
			end

			-- Deflate bodies as you slurp them
			local scale = Vector(1, 1, 1) * (0.3 + (ent.CorpseBlood / CONVARS.corpse_health:GetInt()) * 0.7)
			for i = 0, ent:GetBoneCount() do
				ent:ManipulateBoneScale(i, scale)
			end
		end
	end
end

function GM:GetFallDamage(ply, fallspeed)
	if ply:Team() == TEAM_VAMP then
		return 0
	else
		return (fallspeed - 526.5) * 0.25
	end
end

function GM:PlayerDeathSound()
	-- get rid of beep beep beeeeeeep
	return true
end

function GM:OnDamagedByExplosion()
	-- get rid of tinnitus
	return true
end
