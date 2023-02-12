AddCSLuaFile()

SWEP.Base = "vs_base_sck"

SWEP.PrintName = "Stake + Crucifix"
SWEP.Category = "Vampire Slayers"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "duel"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	--["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },

	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -26.865, 0) },
	["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(19.415, -54.389, 0) },
	["ValveBiped.Bip01_R_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-12.421, -28.482, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-8.169, -31.723, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(32.133, -33.006, 13.873) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-6.407, 2.009, -1.255), angle = Angle(26.249, 24.85, -10.223) },
	["v_weapon.elite_right"] = { scale = Vector(0.001, 0.001, 0.001), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["v_weapon.elite_left"] = { scale = Vector(0.001, 0.001, 0.001), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-9.422, -46.663, 0) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.604, -8.525, 0) }
}

SWEP.DefaultPos = Vector(-0.401, 0, 0.4)

SWEP.VElements = {
	["cross"] = { type = "Model", model = "models/freeman/cross.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(2.723, 1.539, 2.994), angle = Angle(0, -91.217, 0), size = Vector(1.296, 1.296, 1.296), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["stake"] = { type = "Model", model = "models/weapons/arccw/stake_att/antivampire_stake.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.101, 0.189, 0.247), angle = Angle(91.477, 58.533, -1.785), size = Vector(1, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["cross"] = { type = "Model", model = "models/freeman/cross.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.822, 2.236, 3.565), angle = Angle(-17.223, 16.056, 0), size = Vector(1.539, 1.539, 1.539), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["stake"] = { type = "Model", model = "models/weapons/arccw/stake_att/antivampire_stake.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.768, 0.24, -0.879), angle = Angle(101.67, 58.514, -3.225), size = Vector(0.734, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Slot = 0
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true
SWEP.IconLetter = "K"

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

SWEP.CrosshairSize = -2
SWEP.ReloadDuration = 2.1
SWEP.DefaultPos = Vector(-0.36, 0, -0.48)

-- So the invulnerability works, even if you change this weapon's classname
SWEP.IsCrucifix = true

SWEP.SwingFrames = {
	{pos = Vector(-6.407, 2.009, -1.255), ang = Angle(26.249, 24.85, -10.223)},
	{pos = Vector(-8.495, -0.6, -2.997), ang = Angle(16.134, 9.498, 76.164)},
	{pos = Vector(-8.495, -0.6, -2.997), ang = Angle(-23.163, 12.529, 6.467)},
	{pos = Vector(-6.407, 2.009, -1.255), ang = Angle(26.249, 24.85, -10.223)},
	{pos = Vector(-6.407, 2.009, -1.255), ang = Angle(26.249, 24.85, -10.223)}
}

local function easeOutSine(x)
	return math.sin((x * math.pi) / 2)
end

function SWEP:ExtraThink()
	if SERVER then return end

	-- PRIMARY ATTACK ANIMATION
	local dt = math.min((CurTime() - self.LastPrimaryAttack) * 2.7, 1)

	local frames = #self.SwingFrames - 2
	local frame = math.floor(dt * frames)
	local frameDelta = (dt - (frame / frames)) * frames
	frame = math.Clamp(frame + 2, 2, frames + 2)

	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = LerpVector(easeOutSine(frameDelta), self.SwingFrames[frame - 1].pos, self.SwingFrames[frame].pos)
	self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = LerpAngle(easeOutSine(frameDelta), self.SwingFrames[frame - 1].ang, self.SwingFrames[frame].ang)

	-- SECONDARY ATTACK ANIMATION
	local dt2 = math.min((CurTime() - self.LastSecondaryAttack) * 0.25, 1)
	if dt2 < 0.1 then
		dt2 = dt2 * 10
	elseif dt2 <= 0.9 then
		dt2 = 1
	else
		dt2 = 1 - ((dt2 - 0.9) * 10)
	end
	self.ViewModelBoneMods["ValveBiped.Bip01_L_Hand"].angle = LerpAngle(dt2, Angle(-9.422, -46.663, 0), Angle(7.05, -62.675, 15.428))
	self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"].angle = LerpAngle(dt2, angle_zero, Angle(-19.416, 4.347, -3.98))
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = LerpAngle(dt2, angle_zero, Angle(19.853, -10.278, 23.551))
	self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].pos = LerpVector(dt2, vector_origin, Vector(-0.96, 1.804, 0))
	-- self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = LerpVector(dt2, vector_origin, Vector(3.322, -4.585, 2.269))
end

function SWEP:CanSecondaryAttack()
	return true
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end

	if SERVER then
		self.Owner:SetNWFloat("last_prayer", CurTime())
		-- self.Owner:EmitSound("vampire_slayer/latin_0" .. math.random(3) .. ".wav")
		self.Owner:EmitSound("vampire_slayer/vo/latin_prayer_01.wav")
		self.Owner:SetLuaAnimation("cross_prayer")
		-- self:SetNextPrimaryFire(CurTime() + 4 + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + 12)
	end

	self.LastSecondaryAttack = CurTime()
end
--[[
function SWEP:Holster()
	return CurTime() - self.LastSecondaryAttack >= 4 and self.BaseClass.Holster(self)
end
]]
function SWEP:Holster()
	if CurTime() - self.LastSecondaryAttack < 4 then
		self.Owner:StopLuaAnimation("cross_prayer")
	end
	return self.BaseClass.Holster(self)
end

if CLIENT then
	killicon.AddFont("vs_crucifix", "CSKillIcons", SWEP.IconLetter, KILLICON_COLOR)
	
	function SWEP:DrawHUD()
		if not IsValid(self.Owner) then return end

		local ct = CurTime()
		local last_prayer = self.Owner:GetNWFloat("last_prayer", -999)
		local frac
		if ct - last_prayer <= 4 then
			frac = 1 - ((ct - last_prayer) / 4)
		else
			frac = (ct - (last_prayer + 4)) / 8
		end
		frac = math.Clamp(frac, 0, 1)

		local w, h = ScrW(), ScrH()
		local cross_size = w * 0.02
		local poly = {
		
		}
		draw.NoTexture()
		if frac < 1 then
			surface.SetDrawColor(100 + 155 * frac, 0, 0)
		else
			local sub = 60 + (math.sin(ct * 4) + 1) * 30
			surface.SetDrawColor(255 - sub, 255, 255)
		end

		surface.DrawRect(w * 0.44, h * 0.78, w * 0.12 * frac, h * 0.04)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(w * 0.44, h * 0.78, w * 0.12, h * 0.04, 3)

		draw.SimpleText(LocalText("hud_faith"), "ExocetLightLarge", w * 0.5, h * 0.8, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end
