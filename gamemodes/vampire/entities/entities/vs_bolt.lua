AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Crossbow Bolt"
ENT.Spawnable = false

local Damage = 99
local StuckSound = Sound("Wood_Panel.BulletImpact")

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/Gibs/wood_gib01d.mdl")
		self:SetModelScale(0.8)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInitSphere(0.1, "wood")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()

		local ang = self:GetAngles()
		ang.p = ang.p + 180
		self:SetAngles(ang)

		self.Stuck = false
	end

	function ENT:PhysicsCollide(data, phys)
		if not self.Stuck then
			self.Stuck = true

			self.StuckAng = self:GetAngles()
			self.StuckPos = data.HitPos

			-- Damage the entity we hit, if we hit one
			local ent = data.HitEntity
			if IsValid(ent) then
				self.StuckParent = ent

				local d = DamageInfo()
				d:SetDamage((ent:IsPlayer() and ent:Team() == self:GetOwner():Team()) and Damage * 0.1 or Damage)
				d:SetAttacker(self:GetOwner() or self)
				d:SetInflictor(self)
				d:SetDamageType(DMG_CLUB)
				d:SetDamagePosition(self:GetPos())
				ent:TakeDamageInfo(d)
			end

			-- Impact effects
			local e = EffectData()
			e:SetOrigin(data.HitPos)
			e:SetNormal(data.HitNormal * -1)
			e:SetSurfaceProp(data.TheirSurfaceProps)
			util.Effect("Impact", e)
			util.Effect("GlassImpact", e)
			util.Effect("MetalSpark", e)

			-- Get stuck next frame so we don't get a physics error in console
			timer.Simple(0, function()
				if not IsValid(self) then return end
				self:SetPos(self.StuckPos)
				self:SetAngles(self.StuckAng)
				if self.StuckParent ~= nil then
					self:SetParent(self.StuckParent)
				end
				self:SetMoveType(MOVETYPE_NONE)
				self:SetSolid(SOLID_NONE)
			end)

			self:EmitSound(StuckSound)
			self:SetMaterial("Debug/hsv") -- Become invisible until next frame
			SafeRemoveEntityDelayed(self, 20)
		end
	end
else -- CLIENT
	function ENT:Draw()
		self:DrawModel()
	end
end
