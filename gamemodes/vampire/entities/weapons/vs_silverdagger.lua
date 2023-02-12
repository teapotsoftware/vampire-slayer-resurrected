AddCSLuaFile()

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Silver Dagger"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "knife"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.IconLetter = "j"

SWEP.Primary.Enabled = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.SoundShoot = Sound("Weapon_Knife.Slash")
SWEP.Primary.SoundHitWorld = Sound("Weapon_Knife.HitWall")
SWEP.Primary.SoundHitPlayer = Sound("Weapon_Knife.Hit")
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 20
SWEP.Primary.Range = 60
SWEP.Primary.HullSize = 4
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.4
SWEP.Primary.DamageType = DMG_CLUB
SWEP.Primary.Animation = "midslash1"

SWEP.Secondary.Enabled = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.SoundShoot = Sound("Weapon_Knife.Slash")
SWEP.Secondary.SoundHitWorld = Sound("Weapon_Knife.HitWall")
SWEP.Secondary.SoundHitPlayer = Sound("Weapon_Knife.Stab")
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 45
SWEP.Secondary.Range = 40
SWEP.Secondary.HullSize = 12
SWEP.Secondary.Cone = 0
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.DamageType = DMG_CLUB
SWEP.Secondary.Animation = "stab"

SWEP.CrosshairSize = 0

function SWEP:DoImpactEffect(tr, nDamageType)
	if tr.HitSky then return end
	util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	return true
end

if CLIENT then
	killicon.AddFont("vs_silverdagger", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
