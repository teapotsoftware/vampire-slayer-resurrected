AddCSLuaFile()

SWEP.Base = "vs_base"

SWEP.PrintName = "Claws"
SWEP.Category = "Vampire Slayer"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "fist"

SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.IconLetter = "H"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.SoundShoot = Sound("NPC_Vortigaunt.Swing")
SWEP.Primary.SoundHitWorld = Sound("Flesh.ImpactHard")
SWEP.Primary.SoundHitPlayer = Sound("NPC_FastZombie.AttackHit")
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 50 -- 45
SWEP.Primary.Range = 80
SWEP.Primary.HullSize = 12
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.5 -- 0.3
SWEP.Primary.DamageType = DMG_SLASH

SWEP.VisibleCrosshair = false

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))
	return true
end

local right = true

function SWEP:ShootEffects(i, v)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(right and "fists_right" or "fists_left"))
	right = not right

	self:QueueIdle()
end

function SWEP:CanSecondaryAttack()
	return self.Owner:OnGround() and not IsDownedVampire(self)
end

function SWEP:SecondaryAttack()
	if CLIENT or not self:CanSecondaryAttack() then return end

	if self.Owner:IsCarryingFlag() then
		self.Owner:ChatPrint("You can't leap with the flag!")
	else
		self.Owner:SetVelocity(self.Owner:GetForward() * 200 + Vector(0, 0, 400))
		self.Owner:EmitSound(Sound("Zombie.Pain"))
	end

	self:SetNextSecondaryFire(CurTime() + 2)
end

function SWEP:DoImpactEffect(tr, nDamageType)
	if tr.HitSky then return end
	util.Decal("Impact.Sand", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	return true
end

if CLIENT then
	killicon.AddFont("vs_claws", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
