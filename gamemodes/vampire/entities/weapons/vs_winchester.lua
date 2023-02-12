AddCSLuaFile()

SWEP.Base = "vs_base_shotgun"

sound.Add({
	name = "Weapon_Winchester.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = "vampire_slayer/weapons/winchester_01.wav"
})

sound.Add({
	name = "Weapon_Winchester.PoweredSingle",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = {95, 110},
	sound = "vampire_slayer/weapons/winchester_powered_02.wav"
})

SWEP.PrintName = "Winchester Rifle"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.ViewModelFOV = 66
SWEP.ViewModelFlip = true
SWEP.UseHands = false
SWEP.ViewModel = Model("models/weapons/v_winchester1873.mdl")
SWEP.WorldModel = Model("models/weapons/w_winchester_1873.mdl")
SWEP.Primary.SoundShoot = Sound("Weapon_73.Single")

--[[
local USE_M9K_MODELS = util.IsValidModel(SWEP.ViewModel)
if not USE_M9K_MODELS then
	SWEP.ViewModelFOV = 57
	SWEP.ViewModelFlip = false
	SWEP.UseHands = true
	SWEP.ViewModel = Model("models/weapons/cstrike/c_shot_xm1014.mdl")
	SWEP.WorldModel = Model("models/weapons/w_shot_xm1014.mdl")
	SWEP.Primary.SoundShoot = Sound("Weapon_Scout.Single")
	SWEP.DefaultPos = Vector(-3.2, 0, -0.8)
end
]]

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.IconLetter = "B"

SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 40
SWEP.Primary.Recoil = 2
SWEP.Primary.Damage = 41
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.035
SWEP.Primary.Delay = 0.6
SWEP.Primary.Animation = "shoot2"

SWEP.CrosshairSize = 13
SWEP.ReloadDuration = 0.4

SWEP.IronPos = Vector(4.367, 0, 2.634)
SWEP.IronAngle = Angle(-0.3, 0, 0)

function SWEP:AimingDownSights()
	return self.Owner:KeyDown(IN_ATTACK2) and not self:GetReloading()
end

function SWEP:CanSecondaryAttack() return false end
function SWEP:SecondaryAttack() end

function SWEP:CreateBullets(v)
	local bullet = self.BaseClass.CreateBullets(self, v)
	if self:AimingDownSights() then
		bullet.Spread = vector_origin
		self.Primary.Delay = 1.1
		self.Primary.Damage = 96
		self.Primary.SoundShoot = "Weapon_Winchester.PoweredSingle"
	else
		self.Primary.Delay = 0.8
		self.Primary.Damage = 48
		self.Primary.SoundShoot = "Weapon_Winchester.Single"
		-- self.Primary.Animation = "shoot1"
	end
	return bullet
end

SWEP.TargetCrosshairSize = 13

function SWEP:ExtraThink()
	if self:AimingDownSights() then
		self.BobScale = 0.01
		self.SwayScale = 0.02
		self.TargetCrosshairSize = -2
		self:SetHoldType("rpg")
	else
		self.BobScale = 1
		self.SwayScale = 1
		self.TargetCrosshairSize = 13
		self:SetHoldType("shotgun")
	end
	self.CrosshairSize = Lerp(FrameTime() * 20, self.CrosshairSize, self.TargetCrosshairSize)
end

function SWEP:DoDrawCrosshair(x, y)
	if self.VisibleCrosshair and (CONVARS.lower_ironsights:GetBool() or not self:AimingDownSights()) then
		local CrosshairSpread = self.CrosshairSize
		self:DrawCrosshairSegment(x - 13 - CrosshairSpread, y, 10, 3)
		self:DrawCrosshairSegment(x + 6 + CrosshairSpread, y, 10, 3)
		self:DrawCrosshairSegment(x, y - 13 - CrosshairSpread, 3, 10)
		self:DrawCrosshairSegment(x, y + 6 + CrosshairSpread, 3, 10)
	end

	return true
end

function SWEP:GetViewModelPosition(pos, ang)
	local ft = FrameTime() * 6
	if self:AimingDownSights() then
		local ironpos = CONVARS.lower_ironsights:GetBool() and (self.IronPos - Vector(0, 0, 1)) or self.IronPos
		self.ViewModelPos = LerpVector(ft, self.ViewModelPos, ironpos)
		self.ViewModelAngle = LerpAngle(ft, self.ViewModelAngle, self.IronAngle)
	else
		self.ViewModelPos = LerpVector(ft, self.ViewModelPos, self.DefaultPos + Vector(0, 0, math.sin(CurTime() * 2) * 0.14))
		self.ViewModelAngle = LerpAngle(ft, self.ViewModelAngle, self.DefaultAngle)
	end

	ang:RotateAroundAxis(ang:Right(), self.ViewModelAngle.p)
	ang:RotateAroundAxis(ang:Up(), self.ViewModelAngle.y)
	ang:RotateAroundAxis(ang:Forward(), self.ViewModelAngle.r)

	pos = pos + self.ViewModelPos.x * ang:Right()
	pos = pos + self.ViewModelPos.y * ang:Forward()
	pos = pos + self.ViewModelPos.z * ang:Up()

	return pos, ang
end

SWEP.ZoomMultiplier = 1

function SWEP:TranslateFOV(fov)
	self.ZoomMultiplier = Lerp(FrameTime() * 2, self.ZoomMultiplier, self:AimingDownSights() and 0.55 or 1)
	return fov * self.ZoomMultiplier
end

function SWEP:AdjustMouseSensitivity()
	return self.ZoomMultiplier
end

if CLIENT then
	killicon.AddFont("vs_winchester", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
