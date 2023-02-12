AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "vs_base_grenade"

ENT.Model = Model( "models/weapons/w_eq_fraggrenade_thrown.mdl" )
ENT.LifeTime = 2.2
ENT.BounceSound = Sound( "HEGrenade.Bounce" )

function ENT:Explode()
	util.BlastDamage( self, self:GetOwner(), self:GetPos(), 400, 200 )

	local ef = EffectData()
	ef:SetOrigin( self:GetPos() )
	util.Effect( "Explosion", ef, true, true )
end