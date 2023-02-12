AddCSLuaFile()

SWEP.Base = "vs_base"

SWEP.PrintName = "M60 Machine Gun"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model("models/weapons/w_m60_machine_gun.mdl")
SWEP.ViewModel = Model("models/weapons/v_m60machinegun.mdl")
SWEP.ViewModelFOV = 70
SWEP.UseHands = false

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.IconLetter = "z"

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 200
SWEP.Primary.SoundShoot = Sound("Weapon_M_60.Single")
SWEP.Primary.Recoil = 1
SWEP.Primary.Damage = 24
SWEP.Primary.Cone = 0.035
SWEP.Primary.Delay = 0.1
SWEP.Primary.DamageType = DMG_BULLET

SWEP.CrosshairSize = 12
SWEP.ReloadDuration = 5
SWEP.DefaultPos = Vector(0, 0, 1.5)
SWEP.DefaultAngle = Angle(0, 0, 0)

if CLIENT then
	killicon.AddFont("vs_m60", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end