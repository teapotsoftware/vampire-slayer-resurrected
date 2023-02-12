AddCSLuaFile()

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Stake Crossbow"
SWEP.Category = "Vampire Slayer"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "crossbow"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.bolt"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["stake"] = { type = "Model", model = "models/Gibs/wood_gib01d.mdl", bone = "ValveBiped.bolt", rel = "", pos = Vector(-0.233, -0.255, 10.296), angle = Angle(-90, 2.562, -169.482), size = Vector(0.894, 0.238, 0.742), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["stake"] = { type = "Model", model = "models/weapons/arccw/stake_att/antivampire_stake.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(21.048, -1.581, -4), angle = Angle(0, 9.913, -89.794), size = Vector(0.319, 0.639, 0.639), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.CSMuzzleFlashes = true

SWEP.IconLetter = "n"

SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 9
SWEP.Primary.SoundShoot = Sound("Weapon_Crossbow.Single")
SWEP.Primary.Recoil = 1
SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.4
SWEP.Primary.DamageType = DMG_CLUB

SWEP.CrosshairSize = -2
SWEP.ReloadDuration = 1.2

SWEP.DefaultPos = Vector(-2.161, 0, 0.119)

function SWEP:PrimaryAttack()
	if self:Clip1() == 0 then
		self:Reload()
		return
	end

	if not self:CanPrimaryAttack() or self:GetReloadTime() > CurTime() then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetReloadTime(CurTime() + self.Primary.Delay)

	self:SendWeaponAnim(self.Primary.Animation)
	self:QueueIdle()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:TakePrimaryAmmo(1)

	self:EmitSound(self.Primary.SoundShoot)

	if SERVER then
		local bolt = ents.Create("vs_bolt")

		if not IsValid(bolt) then return end

		bolt:SetOwner(self.Owner)
		bolt:SetPos(self.Owner:EyePos() + self.Owner:GetRight() * 5 + self.Owner:GetUp() * -4)
		bolt:SetAngles(self.Owner:EyeAngles())
		bolt:Spawn()

		local phys = bolt:GetPhysicsObject()
		if not IsValid(phys) then bolt:Remove() return end

		local velocity = self.Owner:GetAimVector()
		velocity = velocity * 10000
		phys:ApplyForceCenter(velocity)
		phys:SetAngleVelocity(Vector(math.Rand(-500, 500), 0, 0))
	end

	self.LastPrimaryAttack = CurTime()
end

function SWEP:AimingDownSights()
	return self.Owner:KeyDown(IN_ATTACK2) and not self:GetReloading()
end

function SWEP:CanSecondaryAttack() return false end
function SWEP:SecondaryAttack() end

SWEP.ZoomMultiplier = 1

function SWEP:TranslateFOV(fov)
	self.ZoomMultiplier = Lerp(FrameTime() * 2, self.ZoomMultiplier, self:AimingDownSights() and 0.4 or 1)
	return fov * self.ZoomMultiplier
end

function SWEP:AdjustMouseSensitivity()
	return self.ZoomMultiplier
end

if CLIENT then
	killicon.AddFont("vs_crossbow", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
	killicon.AddFont("vs_bolt", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
