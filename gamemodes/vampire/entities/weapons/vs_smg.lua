AddCSLuaFile()

sound.Add({
	name = "Weapon_VSUzi.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {150, 160},
	sound = "weapons/m249/m249-1.wav"
})

SWEP.Base = "vs_base"

SWEP.PrintName = "SMG"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"

SWEP.WorldModel = Model("models/weapons/w_smg_mac10.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_smg_mac10.mdl")
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.IconLetter = "l"

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 150
SWEP.Primary.SoundShoot = Sound("Weapon_SMG1.Single")
SWEP.Primary.Recoil = 1.3
SWEP.Primary.Damage = 28
SWEP.Primary.Cone = 0.075
SWEP.Primary.Delay = 0.07
SWEP.Primary.DamageType = DMG_BULLET

SWEP.CrosshairSize = 15
SWEP.ReloadDuration = 2
SWEP.DefaultPos = Vector(-2.04, 0, -0.88)
SWEP.DefaultAngle = Angle(0.8, 3, -6.401)

if CLIENT then
	killicon.AddFont("vs_smg", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end