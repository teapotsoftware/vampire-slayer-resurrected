
-- Where the player animations are handled.
-- Copied from the base gamemode and then modified to fit our needs.

function GM:CalcMainActivity(ply, velocity)
	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = -1
	self:HandlePlayerLanding(ply, velocity, ply.m_bWasOnGround)

	if not (self:HandlePlayerNoClipping(ply, velocity) or self:HandlePlayerDriving(ply) or self:HandlePlayerVaulting(ply, velocity) or self:HandlePlayerJumping(ply, velocity) or self:HandlePlayerSwimming(ply, velocity) or self:HandlePlayerDucking(ply, velocity)) then
		local len2d = velocity:Length2DSqr()

		if len2d > 40000 then
			if ply:Team() == TEAM_VAMP then
				-- Vampires sprint, swinging their arms
				-- This doesn't work with weapons, but that's fine for vampires
				ply.CalcIdeal = ACT_HL2MP_RUN_FAST
			else
				-- Hunters run normally, carrying their guns
				ply.CalcIdeal = ACT_MP_RUN
			end
		elseif len2d > 0.25 then
			ply.CalcIdeal = ACT_MP_WALK
		end
	end

	ply.m_bWasOnGround = ply:IsOnGround()
	ply.m_bWasNoclipping = (ply:GetMoveType() == MOVETYPE_NOCLIP and not ply:InVehicle())

	return ply.CalcIdeal, ply.CalcSeqOverride
end

function GM:HandlePlayerVaulting(ply, vel)
	if ply:IsOnGround() or ply:Team() ~= TEAM_VAMP or vel:LengthSqr() < 100000 then return end

	-- Vampire leaping animation
	-- This is the fast zombie running animation, which makes them look like animals
	-- If this is too extreme, we could also try ACT_ZOMBIE_LEAP_START or ACT_ZOMBIE_LEAPING
	ply.CalcIdeal = ACT_HL2MP_RUN_ZOMBIE_FAST
	return true
end

function GM:PlayerFootstep(ply, pos, foot, sound, volume, rf)
	-- ply:EmitSound("NPC_Strider.Footstep")
	return ply:IsSprinting()
end
