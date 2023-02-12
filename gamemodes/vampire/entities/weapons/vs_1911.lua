AddCSLuaFile()

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Pistol"
SWEP.Category = "Vampire Slayer"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/f_dmgf_co1911.mdl"
SWEP.WorldModel = "models/weapons/s_dmgf_co1911.mdl"

SWEP.DefaultPos = Vector(-1.241, 0, 0.119)

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.IconLetter = "y"

SWEP.Primary.Enabled = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 42
SWEP.Primary.Recoil = 2.3
SWEP.Primary.Damage = 30
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.2
SWEP.Primary.Animation = ACT_VM_PRIMARYATTACK
SWEP.Primary.SoundShoot = Sound("Dmgfok_co1911.Single")

SWEP.CrosshairSize = 0
SWEP.ReloadDuration = 1.5

if CLIENT then
	killicon.AddFont("vs_pistol", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
