AddCSLuaFile()

SWEP.Base = "vs_base_shotgun"

SWEP.PrintName = "Pump Shotgun"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = Model("models/weapons/v_shot_mberg_590.mdl")
SWEP.WorldModel = Model("models/weapons/w_mossberg_590.mdl")
SWEP.Primary.SoundShoot = Sound("Mberg_590.Single")

--[[
local USE_M9K_MODELS = util.IsValidModel(SWEP.ViewModel)
if not USE_M9K_MODELS then
	SWEP.ViewModelFOV = 57
	SWEP.ViewModelFlip = false
	SWEP.UseHands = true
	SWEP.ViewModel = Model("models/weapons/cstrike/c_shot_m3super90.mdl")
	SWEP.WorldModel = Model("models/weapons/w_shot_m3super90.mdl")

	SWEP.Primary.SoundShoot = Sound("Weapon_M3.Single")
	SWEP.Primary.Animation = "shoot2" -- Don't slap your face with the gun
	SWEP.DefaultPos = Vector(-3, 0, -0.5)
end]]

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.CSMuzzleFlashes = true
SWEP.IconLetter = "k"

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 32
SWEP.Primary.Recoil = 4
SWEP.Primary.Damage = 18
SWEP.Primary.NumShots = 10
SWEP.Primary.Cone = 0.08
SWEP.Primary.Delay = 1.1

SWEP.CrosshairSize = 28
SWEP.ReloadDuration = 0.5

if CLIENT then
	killicon.AddFont("vs_shotgun", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
