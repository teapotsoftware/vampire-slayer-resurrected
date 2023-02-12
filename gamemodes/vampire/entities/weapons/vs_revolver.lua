AddCSLuaFile()

SWEP.Base = "vs_base"

SWEP.PrintName = "Revolver"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 57
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = Model("models/weapons/c_357.mdl")
SWEP.WorldModel = Model("models/weapons/w_357.mdl")

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.IconLetter = "f"

SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 36
SWEP.Primary.SoundShoot = Sound("Weapon_357.Single")
SWEP.Primary.Recoil = 12
SWEP.Primary.Damage = 80
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = 0.8

SWEP.CrosshairSize = 0
SWEP.ReloadDuration = 2.5

if CLIENT then
	killicon.AddFont("vs_revolver", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
