AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Vampire Relic"
ENT.Spawnable = true

if SERVER then
	ENT.RelicHealth = 100

    function ENT:Initialize()
        self:SetModel("models/monastery/coffin.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysWake()
		self:SetAngles(self:GetAngles() + Angle(90, 0, 0))
		local length = 60
		local tr = util.QuickTrace(self:GetPos() + Vector(0, 0, length), Vector(0, 0, length * -2), self)
		self:SetPos(tr.HitPos + Vector(0, 0, 40))

		if CONVARS.ctc_enabled:GetBool() then
			self:Remove()
		end
    end

	local BreakSound = Sound("Wood_Box.Break")

    function ENT:OnTakeDamage(dmg)
		local atk = dmg:GetAttacker()
		if dmg:IsDamageType(DMG_CLUB) and IsValid(atk) and atk:IsPlayer() and atk:Team() == TEAM_SLAY then
			self.RelicHealth = self.RelicHealth - dmg:GetDamage()
			self:EmitSound(BreakSound)
			if self.RelicHealth <= 0 then
				self:Remove()
			end
		end
	end
else -- CLIENT
    function ENT:Draw()
        self:DrawModel()
    end
end
