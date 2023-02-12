AddCSLuaFile()

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Pool Cue"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -0.715, 23.882) },
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-15.426, -34.96, 0) },
	["v_weapon.Knife_Handle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-17.715, -7.791, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.15, -4.316, 0), angle = Angle(8.312, -5.848, -56.917) },
	["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(17.76, 9.451, 0) },
	["ValveBiped.Bip01_L_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-18.188, -33.26, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-2.487, 12.869, -17.765) },
	["ValveBiped.Bip01_L_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.165, -19.861, 0) },
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(27.711, -25.769, 3.424) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10.873, -2.531, 45.255) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5.163, -15.587, 0) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-6.371, -8.645, 0) },
	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-21.869, -23.873, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10.105, 17.927, -73.483) },
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["cue"] = { type = "Model", model = "models/brewstersmodels/thesimsbustinout/aristoscratch_pool_cue.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.559, 1.2, -39.738), angle = Angle(0, 0, 0), size = Vector(0.806, 0.806, 0.806), color = Color(255, 216, 128, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["cue"] = { type = "Model", model = "models/brewstersmodels/thesimsbustinout/aristoscratch_pool_cue.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.467, 5.618, -37.628), angle = Angle(1.784, 16.711, -7.762), size = Vector(0.806, 0.806, 0.806), color = Color(255, 216, 128, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.DefaultPos = Vector(5.76, 0, -6.72)
SWEP.DefaultAngle = Angle(7.699, -5.7, 31.7)

SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.IconLetter = "j"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.SoundShoot = Sound("Weapon_Crowbar.Single")
SWEP.Primary.SoundHitWorld = Sound("Wood_Plank.ImpactHard")
SWEP.Primary.SoundHitPlayer = Sound("Flesh.ImpactHard")
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 20
SWEP.Primary.Range = 110
SWEP.Primary.HullSize = 10
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.5
SWEP.Primary.DamageType = DMG_CLUB
SWEP.Primary.Animation = 0

SWEP.Secondary.Enabled = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.SoundShoot = Sound("Weapon_Crowbar.Single")
SWEP.Secondary.SoundHitWorld = Sound("Wood_Plank.ImpactHard")
SWEP.Secondary.SoundHitPlayer = Sound("Flesh.ImpactHard")
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 4
SWEP.Secondary.Range = 110
SWEP.Secondary.HullSize = 30
SWEP.Secondary.Cone = 0
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.DamageType = DMG_NEVERGIB
SWEP.Secondary.Animation = 0

SWEP.CrosshairSize = -2
SWEP.ReloadDuration = 2.1

SWEP.SwingFrames = {
	{
		{pos = vector_origin, ang = angle_zero},
		{pos = Vector(-1.354, 3.323, 2.982), ang = Angle(22.052, 0, 22.733)},
		{pos = Vector(10.738, -3.635, -8.632), ang = Angle(27.841, 0, 22.733)},
		{pos = vector_origin, ang = angle_zero},
		{pos = vector_origin, ang = angle_zero}
	},
	{
		{pos = vector_origin, ang = angle_zero},
		{pos = Vector(3.24, 0, -6.08), ang = Angle(-1.2, 40, -6)},
		{pos = Vector(3.24, 0, -6.08), ang = Angle(90, 30, 20)},
		{pos = vector_origin, ang = angle_zero},
		{pos = vector_origin, ang = angle_zero}
	}
}

local function easeOutSine(x)
	return math.sin((x * math.pi) / 2)
end

function SWEP:ExtraThink()
	local lastattacks = {self.LastPrimaryAttack, self.LastSecondaryAttack}
	local anim = (lastattacks[1] > lastattacks[2]) and 1 or 2
	local dt = math.min((CurTime() - lastattacks[anim]) * 2.5, 1)

	local frames = #self.SwingFrames[anim] - 2
	local frame = math.floor(dt * frames)
	local frameDelta = (dt - (frame / frames)) * frames
	frame = math.Clamp(frame + 2, 2, frames + 2)

	self.ViewModelBoneMods["ValveBiped.Bip01_Spine4"].pos = LerpVector(easeOutSine(frameDelta), self.SwingFrames[anim][frame - 1].pos, self.SwingFrames[anim][frame].pos)
	self.ViewModelBoneMods["ValveBiped.Bip01_Spine4"].angle = LerpAngle(easeOutSine(frameDelta), self.SwingFrames[anim][frame - 1].ang, self.SwingFrames[anim][frame].ang)
end

function SWEP:DoImpactEffect(tr, nDamageType)
	if tr.HitSky then return end
	util.Decal("Impact.Sand", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	return true
end

if CLIENT then
	killicon.AddFont("vs_poolcue", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
end
