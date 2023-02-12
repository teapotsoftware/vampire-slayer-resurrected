AddCSLuaFile()

SWEP.Base = "vs_base_grenade"

SWEP.PrintName = "Frag Grenade"
SWEP.Category = "Vampire Slayer"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "O"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "grenade"

SWEP.WorldModel = Model( "models/weapons/w_eq_fraggrenade.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_eq_fraggrenade.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.Primary.Ammo = "grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 5

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.GrenadeEntity = "vs_hegrenade"

if CLIENT then
	killicon.AddFont( "vs_hegrenade", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end