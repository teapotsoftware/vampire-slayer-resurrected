AddCSLuaFile()

SWEP.Base = "vs_base_shotgun"

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_doublebarrl.mdl"
SWEP.WorldModel = "models/weapons/w_double_barrel_shotgun.mdl"
SWEP.Primary.SoundShoot = Sound("Double_Barrel.Single")
SWEP.ReloadDuration = 0.5

--[[
local USE_M9K_MODELS = util.IsValidModel(SWEP.ViewModel)
if not USE_M9K_MODELS then
	SWEP.Base = "vs_base_sck"
	SWEP.Primary.SoundShoot = Sound("Weapon_Shotgun.Single")

	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false
	SWEP.UseHands = true
	SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
	SWEP.WorldModel = "models/weapons/w_pistol.mdl"
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = false

	SWEP.ViewModelBoneMods = {
		["v_weapon.p90_Parent"] = { scale = Vector(0.001, 0.001, 0.001), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(2.5, 0, 1), angle = Angle(0, 0, 0) }
	}

	SWEP.DefaultPos = Vector(0.879, 0, 2.16)
	SWEP.DefaultAngle = Angle(-1.9, 7.199, 0)

	local metalMat = "models/props_c17/FurnitureMetal001a"
	local metalColor = Color(170, 170, 210, 255)

	SWEP.VElements = {
		["barrel2"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_L_Finger3", rel = "base", pos = Vector(-0.817, -1.02, -1.637), angle = Angle(-90, 0, 0), size = Vector(0.045, 0.045, 0.135), color = metalColor, surpresslightning = false, material = metalMat, skin = 0, bodygroup = {} },
		["barrel1"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_L_Finger3", rel = "base", pos = Vector(-0.817, 1.019, -1.637), angle = Angle(-90, 0, 0), size = Vector(0.045, 0.045, 0.135), color = metalColor, surpresslightning = false, material = metalMat, skin = 0, bodygroup = {} },
		["cap2"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel2", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.02), color = metalColor, surpresslightning = false, material = metalMat, skin = 0, bodygroup = {} },
		["cap1"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel1", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.02), color = metalColor, surpresslightning = false, material = metalMat, skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.349, 1.774, -1.117), angle = Angle(0, 0, 0), size = Vector(0.109, 0.035, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/wood", skin = 0, bodygroup = {} },
		["shell1+"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.p90_Clip", rel = "", pos = Vector(0.596, 0.238, -8.577), angle = Angle(-81.07, -1.17, 38.57), size = Vector(1.093, 1.093, 1.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-2.881, 0, 0.518), angle = Angle(-17.319, 0, 0), size = Vector(0.109, 0.035, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/wood", skin = 0, bodygroup = {} },
		["shell1"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.p90_Clip", rel = "", pos = Vector(-1.405, 0.156, -8.895), angle = Angle(-81.07, -1.17, 38.57), size = Vector(1.093, 1.093, 1.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["barrel1+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.817, -1.02, -1.637), angle = Angle(-90, 0, 0), size = Vector(0.045, 0.045, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalfloor_2-3", skin = 0, bodygroup = {} },
		["barrel1"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.817, 1.019, -1.637), angle = Angle(-90, 0, 0), size = Vector(0.045, 0.045, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalfloor_2-3", skin = 0, bodygroup = {} },
		["cap1+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel1+", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalfloor_2-3", skin = 0, bodygroup = {} },
		["cap1"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel1", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalfloor_2-3", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.559, 1.853, -2.845), angle = Angle(0, 0, 0), size = Vector(0.109, 0.035, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/wood", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-2.881, 0, 0.518), angle = Angle(-17.319, 0, 0), size = Vector(0.109, 0.035, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/wood", skin = 0, bodygroup = {} }
	}

	local capReloadPos = Vector(-0.9, 0, -1)

	function SWEP:ExtraThink()
		local act = self:GetActivity()
		local ft = FrameTime() * 18
		if act == ACT_VM_RELOAD then
			self.VElements["cap1"].pos = LerpVector(ft, self.VElements["cap1"].pos, capReloadPos)
			self.VElements["cap2"].pos = LerpVector(ft, self.VElements["cap2"].pos, capReloadPos)
			self.VElements["cap1"].angle.p = Lerp(ft, self.VElements["cap1"].angle.p, -90)
			self.VElements["cap2"].angle.p = Lerp(ft, self.VElements["cap2"].angle.p, -90)
		else
			self.VElements["cap1"].pos = LerpVector(ft, self.VElements["cap1"].pos, vector_origin)
			self.VElements["cap2"].pos = LerpVector(ft, self.VElements["cap2"].pos, vector_origin)
			self.VElements["cap1"].angle.p = Lerp(ft, self.VElements["cap1"].angle.p, 0)
			self.VElements["cap2"].angle.p = Lerp(ft, self.VElements["cap2"].angle.p, 0)
		end
	end

	SWEP.ReloadDuration = 2
end
]]


SWEP.PrintName = "Double Barrel"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.CSMuzzleFlashes = true
SWEP.IconLetter = "J"

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Recoil = 7
SWEP.Primary.Damage = 18
SWEP.Primary.NumShots = 12
SWEP.Primary.Cone = 0.12
SWEP.Primary.Delay = 0.1

SWEP.CrosshairSize = 42

if CLIENT then
	killicon.AddFont("vs_dbarrel", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
