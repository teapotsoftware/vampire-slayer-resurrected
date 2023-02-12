AddCSLuaFile()

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Stake + Pistol"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "duel"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/f_dmgf_co1911.mdl"
SWEP.WorldModel = "models/weapons/s_dmgf_co1911.mdl"
SWEP.Secondary.SoundShoot = Sound("Dmgfok_co1911.Single")

SWEP.ViewModelBoneMods = {
	["Left_U_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(-2.625, -0.345, 3.088), angle = Angle(3.79, -1.9, 125.803) },
	["Left_L_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["stake"] = { type = "Model", model = "models/weapons/arccw/stake_att/antivampire_stake.mdl", bone = "Left_Hand", rel = "", pos = Vector(0.626, -0.598, 0.409), angle = Angle(-110.145, 59.889, -9.499), size = Vector(0.508, 0.508, 0.508), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["stake"] = { type = "Model", model = "models/weapons/arccw/stake_att/antivampire_stake.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.309, -2.122, 0.547), angle = Angle(-109.18, 3.584, 0.532), size = Vector(0.744, 0.744, 0.744), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.DefaultPos = Vector(-1.241, 0, 0.119)

--[[
local USE_M9K_MODELS = util.IsValidModel(SWEP.ViewModel)
if not USE_M9K_MODELS then
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false
	SWEP.UseHands = true
	SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
	SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
	SWEP.Secondary.SoundShoot = Sound("Weapon_Deagle.Single")
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true
	SWEP.ViewModelBoneMods = {
		["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(7.607, -6.676, 10.291), angle = Angle(-0.783, -35.231, 29.329) },
		-- ["v_weapon.USP_Silencer"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.446), angle = Angle(5.324, 3.319, 159.639) }
	}
	SWEP.DefaultPos = Vector(-2.481, 0, 0.839)
	SWEP.VElements = {
		["stake"] = { type = "Model", model = "models/Gibs/wood_gib01d.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.555, 2, -3.2), angle = Angle(100.841, -52.966, 121.161), size = Vector(0.361, 0.361, 0.361), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["stake"] = { type = "Model", model = "models/Gibs/wood_gib01d.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.895, 2.145, -3.599), angle = Angle(87.254, 68.555, -0.959), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.DefaultPos = Vector(-3, 0, -0.5)

	function SWEP:ExtraThink()
		local act = self:GetActivity()
		local ft = FrameTime() * 18
		if act == ACT_VM_RELOAD and false then
			self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = LerpVector(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos, vector_origin)
			self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = LerpAngle(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle, angle_zero)
			self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].pos = LerpVector(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].pos, vector_origin)
			self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].angle = LerpAngle(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].angle, angle_zero)
		else
			self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = LerpVector(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos, Vector(7.607, -6.676, 10.291))
			self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = LerpAngle(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle, Angle(-0.783, -35.231, 29.329))
			self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].pos = LerpVector(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].pos, self.ForeArmPos)
			self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].angle = LerpAngle(ft, self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].angle, self.ForeArmAngle)
		end

		local dt = math.min((CurTime() - self.LastPrimaryAttack) * 5, 1)
		self.ForeArmPos = LerpVector(dt, Vector(9.534, -1.676, -2.23), Vector(0, 0, 0.446))
		self.ForeArmAngle = LerpAngle(dt, Angle(-62.468, 43.166, 140.042), Angle(5.324, 3.319, 159.639))
	end
end
]]

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.IconLetter = "j"

SWEP.Primary.Enabled = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.SoundShoot = Sound("Weapon_Crowbar.Single")
SWEP.Primary.SoundHitWorld = Sound("Wood_Plank.ImpactHard")
SWEP.Primary.SoundHitPlayer = Sound("Flesh.ImpactHard")
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 20
SWEP.Primary.Range = 60
SWEP.Primary.HullSize = 4
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.4
SWEP.Primary.DamageType = DMG_CLUB
SWEP.Primary.Animation = 0

SWEP.Secondary.Enabled = true
SWEP.Secondary.Ammo = "pistol"
SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = 7
SWEP.Secondary.DefaultClip = 28
SWEP.Secondary.Recoil = 2.3
SWEP.Secondary.Damage = 30
SWEP.Secondary.Cone = 0.03
SWEP.Secondary.Delay = 0.2
SWEP.Secondary.Animation = ACT_VM_PRIMARYATTACK

SWEP.CrosshairSize = 0
SWEP.ReloadDuration = 1.5

SWEP.SwingFrames = {
	{pos = Vector(-2.625, -0.345, 3.088), ang = Angle(3.79, -1.9, 125.803)},
	{pos = Vector(4.909, -10.013, 0.745), ang = Angle(51.199, -19.042, 100.195)},
	{pos = Vector(4.909, -7.044, -1.543), ang = Angle(11.064, -9.563, 71.237)},
	{pos = Vector(-2.625, -0.345, 3.088), ang = Angle(3.79, -1.9, 125.803)},
	{pos = Vector(-2.625, -0.345, 3.088), ang = Angle(3.79, -1.9, 125.803)}
}

local function easeInOutElastic(x)
	local c5 = (2 * math.pi) / 4.5

	if x == 0 or x == 1 then
		return x
	end

	if x < 0.5 then
		return -(math.pow(2, 20 * x - 10) * math.sin((20 * x - 11.125) * c5)) / 2
	end

	return (math.pow(2, -20 * x + 10) * math.sin((20 * x - 11.125) * c5)) / 2 + 1
end

local function easeOutSine(x)
	return math.sin((x * math.pi) / 2)
end

function SWEP:ExtraThink()
	self.Secondary.Animation = self:Clip2() > 1 and ACT_VM_PRIMARYATTACK or "shoot_empty"

	local dt = math.min((CurTime() - self.LastPrimaryAttack) * 3.3, 1)

	local frames = #self.SwingFrames - 2
	local frame = math.floor(dt * frames)
	local frameDelta = (dt - (frame / frames)) * frames
	frame = math.Clamp(frame + 2, 2, frames + 2)

	self.ViewModelBoneMods["Left_U_Arm"].pos = LerpVector(easeOutSine(frameDelta), self.SwingFrames[frame - 1].pos, self.SwingFrames[frame].pos)
	self.ViewModelBoneMods["Left_U_Arm"].angle = LerpAngle(easeOutSine(frameDelta), self.SwingFrames[frame - 1].ang, self.SwingFrames[frame].ang)

	local dt2 = math.sin(math.min((CurTime() - self.LastSecondaryAttack) * 5, 1) * math.pi)
	self.ViewModelBoneMods["Left_L_Arm"].angle.p = Lerp(dt2, 0, 5)
	self.ViewModelBoneMods["Left_L_Arm"].angle.y = Lerp(dt2, 0, -5)
end

if CLIENT then
	killicon.AddFont("vs_stakepistol", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
