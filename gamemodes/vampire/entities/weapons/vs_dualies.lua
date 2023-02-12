AddCSLuaFile()

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Dual Desert Eagles"
SWEP.Category = "Vampire Slayer"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "f"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "duel"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["v_weapon.elite_right"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["v_weapon.elite_left"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["gun_left"] = { type = "Model", model = "models/weapons/w_pist_deagle.mdl", bone = "v_weapon.elite_left", rel = "", pos = Vector(-0.232, 3.203, -0.225), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["bullet_left+"] = { type = "Model", model = "models/weapons/shell.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "mag_left+", pos = Vector(0, 0, -2.201), angle = Angle(0, 0, 0), size = Vector(0.735, 0.735, 0.735), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["mag_left+"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "v_weapon.magazine_right", rel = "", pos = Vector(0.006, -1.644, 0.56), angle = Angle(90, 90, 0), size = Vector(0.085, 0.12, 0.182), color = Color(45, 45, 45, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["gun_right"] = { type = "Model", model = "models/weapons/w_pist_deagle.mdl", bone = "v_weapon.elite_right", rel = "", pos = Vector(0.1, 3.552, 0.162), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["mag_left"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "v_weapon.magazine_left", rel = "", pos = Vector(-0.156, -1.803, 0), angle = Angle(90, 90, 0), size = Vector(0.085, 0.12, 0.182), color = Color(45, 45, 45, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["bullet_left"] = { type = "Model", model = "models/weapons/shell.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "mag_left", pos = Vector(0, 0, -2.201), angle = Angle(0, 0, 0), size = Vector(0.735, 0.735, 0.735), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["gun_left"] = { type = "Model", model = "models/weapons/w_pist_deagle.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.98, 1.116, -2.81), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["gun_right"] = { type = "Model", model = "models/weapons/w_pist_deagle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.072, 1.473, 2.703), angle = Angle(180, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 16
SWEP.Primary.DefaultClip = 176
SWEP.Primary.SoundShoot = Sound( "Weapon_Deagle.Single" )
SWEP.Primary.Recoil = 2
SWEP.Primary.Damage = 26
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.035
SWEP.Primary.Delay = 0.12
SWEP.Primary.Akimbo = true

SWEP.CrosshairSize = 4
SWEP.ReloadDuration = 2.7

if CLIENT then
	killicon.AddFont("vs_dualies", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
