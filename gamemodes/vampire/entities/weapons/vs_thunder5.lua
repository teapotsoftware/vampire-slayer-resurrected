AddCSLuaFile()

sound.Add({
	name = "Weapon_Thunder5.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = {
		"vampire_slayer/weapons/thunder5_01.wav",
		"vampire_slayer/weapons/thunder5_02.wav"
	}
})

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Thunder-5 Shotgun"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.UseHands = false
SWEP.ViewModel = Model("models/weapons/v_swmodel_627.mdl")
SWEP.WorldModel = Model("models/weapons/w_sw_model_627.mdl")

--[[
local USE_M9K_MODELS = util.IsValidModel(SWEP.ViewModel)
if not USE_M9K_MODELS then
	SWEP.ViewModelFOV = 57
	SWEP.ViewModelFlip = false
	SWEP.UseHands = true
	SWEP.ViewModel = Model("models/weapons/c_357.mdl")
	SWEP.WorldModel = Model("models/weapons/w_357.mdl")
	SWEP.ViewModelBoneMods = {
		["Bullet1"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
		["Bullet2"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
		["Bullet3"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
		["Bullet4"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
		["Bullet5"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
		["Bullet6"] = {scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)}
	}

	SWEP.VElements = {
		["shell++"] = { type = "Model", model = "models/weapons/Shotgun_shell.mdl", bone = "Bullet3", rel = "", pos = Vector(0.33, -0.02, 1.12), angle = Angle(90, 0, 0), size = Vector(0.414, 0.414, 0.414), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["shell+"] = { type = "Model", model = "models/weapons/Shotgun_shell.mdl", bone = "Bullet2", rel = "", pos = Vector(0.33, -0.02, 1.12), angle = Angle(90, 0, 0), size = Vector(0.414, 0.414, 0.414), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["shell++++"] = { type = "Model", model = "models/weapons/Shotgun_shell.mdl", bone = "Bullet5", rel = "", pos = Vector(0.33, -0.02, 1.12), angle = Angle(90, 0, 0), size = Vector(0.414, 0.414, 0.414), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["shell+++"] = { type = "Model", model = "models/weapons/Shotgun_shell.mdl", bone = "Bullet4", rel = "", pos = Vector(0.33, -0.02, 1.12), angle = Angle(90, 0, 0), size = Vector(0.414, 0.414, 0.414), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["shell"] = { type = "Model", model = "models/weapons/Shotgun_shell.mdl", bone = "Bullet1", rel = "", pos = Vector(0.33, -0.02, 1.12), angle = Angle(90, 0, 0), size = Vector(0.414, 0.414, 0.414), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["shell+++++"] = { type = "Model", model = "models/weapons/Shotgun_shell.mdl", bone = "Bullet6", rel = "", pos = Vector(0.33, -0.02, 1.12), angle = Angle(90, 0, 0), size = Vector(0.414, 0.414, 0.414), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.DefaultPos = Vector(-1.5, 0, -0.8)
end
]]

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.IconLetter = "f"

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 20
SWEP.Primary.SoundShoot = Sound("Weapon_Thunder5.Single")
SWEP.Primary.Recoil = 12
SWEP.Primary.NumShots = 10
SWEP.Primary.Damage = 18
SWEP.Primary.Cone = 0.13
SWEP.Primary.Delay = 1

SWEP.CrosshairSize = 49
SWEP.ReloadDuration = 2.5

if CLIENT then
	killicon.AddFont("vs_thunder5", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
