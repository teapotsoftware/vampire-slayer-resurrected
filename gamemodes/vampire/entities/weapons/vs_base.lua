AddCSLuaFile()

SWEP.PrintName = "Vampire Slayer Weapons Base"
SWEP.Category = "Vampire Slayer"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"

SWEP.WorldModel = Model("models/weapons/w_pistol.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_pist_p228.mdl")
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.CSMuzzleFlashes = true
SWEP.IconLetter = "C"

SWEP.Primary.Enabled = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 12
SWEP.Primary.SoundShoot = Sound("Weapon_P228.Single")
SWEP.Primary.SoundMiss = nil
SWEP.Primary.SoundHitWorld = Sound("FX_RicochetSound.Ricochet")
SWEP.Primary.SoundHitPlayer = nil
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Damage = 5
SWEP.Primary.Range = 56756
SWEP.Primary.HullSize = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.NeedsAmmo = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.13
SWEP.Primary.DamageType = DMG_BULLET
SWEP.Primary.Animation = ACT_VM_PRIMARYATTACK

SWEP.Secondary.Enabled = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.SoundShoot = Sound("Weapon_P228.Single")
SWEP.Secondary.SoundMiss = nil
SWEP.Secondary.SoundHitWorld = Sound("FX_RicochetSound.Ricochet")
SWEP.Secondary.SoundHitPlayer = nil
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 50
SWEP.Secondary.Range = 56756
SWEP.Secondary.HullSize = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.NeedsAmmo = 1
SWEP.Secondary.Cone = 0.03
SWEP.Secondary.Delay = 0.13
SWEP.Secondary.DamageType = DMG_BULLET
SWEP.Secondary.Animation = ACT_VM_SECONDARYATTACK

SWEP.VisibleCrosshair = true
SWEP.CrosshairSize = 15
SWEP.ReloadDuration = -1

SWEP.DefaultPos = Vector(0, 0, 0)
SWEP.DefaultAngle = Angle(0, 0, 0)

SWEP.LastSecondaryAttack = 0
SWEP.LastPrimaryAttack = 0

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "Recoil")

	self:NetworkVar("Bool", 0, "Reloading")
	self:NetworkVar("Float", 1, "ReloadTime")

	self:NetworkVar("Float", 2, "NextIdle")
end

function SWEP:Initialize()
	self:SetReloading(false)
	self:SetReloadTime(0)

	self:SetRecoil(0)
	self:SetNextIdle(0)

	self.ViewModelPos = self.DefaultPos
	self.ViewModelAngle = self.DefaultAngle

	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:SendWeaponAnim(self.Silenced and ACT_VM_DRAW_SILENCED or ACT_VM_DRAW)
	return true
end

function SWEP:ShootEffects(i, v)
	--if self[v].DamageType == DMG_BULLET then
		self.Owner:SetAnimation(PLAYER_ATTACK1)
	--end

	if self[v].Akimbo then
		local oddshot = self["Clip" .. i](self) % 2 == 0
		if oddshot then
			self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		else
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		end
	else
		if isnumber(self[v].Animation) then
			self:SendWeaponAnim(self[v].Animation)
		else
			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence(vm:LookupSequence(self[v].Animation))
		end
	end
	self:QueueIdle()
end

function SWEP:CreateBullets(v)
	local bullet = {}
	bullet.Num = self[v].NumShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(self[v].Cone, self[v].Cone, 0)
	bullet.Distance = self[v].Range
	bullet.HullSize = self[v].HullSize
	if self[v].DamageType == DMG_BULLET then
		bullet.Tracer = 1
		bullet.TracerName = "Tracer"
	else
		bullet.Tracer = 9999
		bullet.TracerName = nil
	end
	bullet.Force = self[v].Damage * 0.1
	bullet.Damage = self[v].Damage
	bullet.AmmoType = self[v].Ammo
	bullet.Callback = function(atk, tr, dmg)
		dmg:SetDamageType(self[v].DamageType)

		if IsFirstTimePredicted() and (CLIENT or game.SinglePlayer()) then
			if tr.Hit then
				if not IsValid(tr.Entity) or not (tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then
					if self[v].SoundHitWorld then
						sound.Play(self[v].SoundHitWorld, tr.HitPos)
					end

					if self[v].DamageType == DMG_BULLET then
						local eff = EffectData()
						eff:SetOrigin(tr.HitPos)

						if CONVARS.bullet_sparks:GetBool() then
							eff:SetMagnitude(CONVARS.bullet_sparks:GetInt())
							eff:SetScale(1)
							eff:SetNormal(tr.HitNormal)
							eff:SetRadius(4)
							util.Effect("Sparks", eff)
						end

						if CONVARS.bullet_smoke:GetBool() then
							for i = 1, CONVARS.bullet_smoke:GetInt() do
								util.Effect("GlassImpact", eff)
							end
						end
					end
				else
					if self[v].SoundHitPlayer then
						sound.Play(self[v].SoundHitPlayer, tr.HitPos)
					end

					local eff = EffectData()
					eff:SetOrigin(tr.HitPos)
					util.Effect("BloodImpact", eff)
				end
			elseif self[v].SoundMiss then
				sound.Play(self[v].SoundMiss, tr.HitPos)
			end
		end
	end

	return bullet
end

for i, v in ipairs({"Primary", "Secondary"}) do
	SWEP["Can" .. v .. "Attack"] = function(self)
		if self.Owner:Team() == TEAM_VAMPIRE and self.Owner:Health() == 1 then
			return false
		end

		if self[v].ClipSize > 0 and self["Clip" .. i](self) <= (self[v].NeedsAmmo - 1) then
			self:EmitSound("Weapon_Pistol.Empty")
			self["SetNext" .. v .. "Fire"](self, CurTime() + 0.2)
			self:Reload()
			return false
		end

		return self[v].Enabled
	end

	SWEP[v .. "Attack"] = function(self)
		if (not self["Can" .. v .. "Attack"](self)) or self:GetReloadTime() > CurTime() then return end

		self.Owner:FireBullets(self:CreateBullets(v))
		self:ShootEffects(i, v)

		self["SetNext" .. v .. "Fire"](self, CurTime() + self[v].Delay)
		self:SetReloadTime(CurTime() + self[v].Delay)

		self["Take" .. v .. "Ammo"](self, 1)

		self:SetRecoil(math.Clamp(self:GetRecoil() + self[v].Recoil * 0.4, 0, 1))
		self.Owner:ViewPunch(Angle(self[v].Recoil * -0.3, util.SharedRandom("ViewPunch", -0.5, 0.5) * self[v].Recoil * 0.5, 0))

		if IsFirstTimePredicted() and (CLIENT or game.SinglePlayer()) then
			self.Owner:SetEyeAngles(self.Owner:EyeAngles() - Angle(self[v].Recoil, 0, 0))
		end

		if self[v].PitchOverride then
			self:EmitSound(self[v].SoundShoot, 80, self[v].PitchOverride)
		else
			self:EmitSound(self[v].SoundShoot)
		end

		if SERVER and self[v].Blowback and (self[v].BlowbackJumpingAllowed or self.Owner:OnGround()) then
			local forward = self.Owner:EyeAngles():Forward()
			local vec = forward * -self[v].Blowback
			if not self[v].BlowbackJumpingAllowed then
				vec.z = 0
			end
			self.Owner:SetVelocity(vec)
		end

		self["Last" .. v .. "Attack"] = CurTime()

		self.Owner:SetNWFloat("last_attack", CurTime())
	end
end

function SWEP:Holster()
	self:SetReloading(false)
	self:SetReloadTime(0)

	self:SetRecoil(0)
	self:SetNextIdle(0)

	return true
end

function SWEP:QueueIdle()
	self:SetNextIdle(CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.1)
end

function SWEP:ExtraThink() end

function SWEP:Think()
	self:SetRecoil(math.Clamp(self:GetRecoil() - FrameTime() * 1.4, 0, 1))

	if self:GetNextIdle() ~= 0 and CurTime() > self:GetNextIdle() then
		self:SetNextIdle(0)
		self:SendWeaponAnim(self:Clip1() > 0 and (self.Silenced and ACT_VM_IDLE_SILENCED or ACT_VM_IDLE) or ACT_VM_IDLE_EMPTY)
	end

	if self:GetReloading() then
		self:ReloadThink()
	end

	self:ExtraThink()
end

function SWEP:ReloadThink()
	if self:GetReloadTime() < CurTime() then
		self:SetReloading(false)

		local amount = math.min(self:GetMaxClip1() - self:Clip1(), self:Ammo1())
		self:SetClip1(self:Clip1() + amount)

		local amount2 = math.min(self:GetMaxClip2() - self:Clip2(), self:Ammo2())
		self:SetClip2(self:Clip2() + amount2)

		self.Owner:RemoveAmmo(amount, self:GetPrimaryAmmoType())
		self.Owner:RemoveAmmo(amount2, self:GetSecondaryAmmoType())
	end
end

function SWEP:CanReload()
	return ((self:Ammo1() > 0 and self:Clip1() < self.Primary.ClipSize) or (self:Ammo2() > 0 and self:Clip2() < self.Secondary.ClipSize)) and not self:GetReloading() and self:GetNextPrimaryFire() < CurTime()
end

function SWEP:Reload()
	if not self:CanReload() then return end

	self.Owner:DoReloadEvent()
	self:SendWeaponAnim(self.Silenced and ACT_VM_RELOAD_SILENCED or ACT_VM_RELOAD)
	self:QueueIdle()

	if self.ReloadSound then self:EmitSound(self.ReloadSound) end

	self:SetReloading(true)

	if self.ReloadDuration == -1 then
		self:SetReloadTime(CurTime() + self.Owner:GetViewModel():SequenceDuration())
	else
		self:SetReloadTime(CurTime() + self.ReloadDuration)
	end
end

if SERVER then return end ---------------------------------------- CLIENT ONLY ----------------------------------------

function SWEP:DrawCrosshairSegment(x, y, w, h)
	x = math.Round(x)
	y = math.Round(y)

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(x - 1, y - 1, w, h)

	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawRect(x, y, w - 2, h - 2)
end

function SWEP:DoDrawCrosshair(x, y)
	if self.VisibleCrosshair then
		local CrosshairSpread = self.CrosshairSize
		self:DrawCrosshairSegment(x - 13 - CrosshairSpread, y, 10, 3)
		self:DrawCrosshairSegment(x + 6 + CrosshairSpread, y, 10, 3)
		self:DrawCrosshairSegment(x, y - 13 - CrosshairSpread, 3, 10)
		self:DrawCrosshairSegment(x, y + 6 + CrosshairSpread, 3, 10)
	end

	return true
end

function SWEP:GetViewModelPosition(pos, ang)
	self.ViewModelPos = self.DefaultPos
	self.ViewModelAngle = self.DefaultAngle

	ang:RotateAroundAxis(ang:Right(), self.ViewModelAngle.p)
	ang:RotateAroundAxis(ang:Up(), self.ViewModelAngle.y)
	ang:RotateAroundAxis(ang:Forward(), self.ViewModelAngle.r)

	pos = pos + self.ViewModelPos.x * ang:Right()
	pos = pos + self.ViewModelPos.y * ang:Forward()
	pos = pos + self.ViewModelPos.z * ang:Up()

	return pos + Vector(0, 0, math.sin(CurTime() * 2) * 0.14), ang
end

SWEP.SelectColor = Color(255, 210, 0)
SWEP.EmptySelectColor = Color(255, 50, 0)

function SWEP:DrawWeaponSelection(x, y, w, h, a)
	local col = self:HasAmmo() and self.SelectColor or self.EmptySelectColor

	draw.SimpleText(self.IconLetter, "CSSelectIcons", x + w / 2, y + h * 0.65,
		Color(col.r, col.g, col.b, a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

KILLICON_COLOR = Color(255, 80, 0, 255)

surface.CreateFont("CSKillIcons", {
	size = ScreenScale(30),
	weight = 500,
	antialiasing = true,
	additive = true,
	font = "csd"
})

surface.CreateFont("CSSelectIcons", {
	size = ScreenScale(60),
	weight = 500,
	antialiasing = true,
	additive = true,
	font = "csd"
})
