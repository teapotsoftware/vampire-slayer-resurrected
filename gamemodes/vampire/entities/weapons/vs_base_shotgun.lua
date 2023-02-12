AddCSLuaFile()

SWEP.Base = "vs_base"

SWEP.PrintName = "Vampire Slayer Base Shotgun"
SWEP.Category = "Vampire Slayer"
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model( "models/weapons/w_shot_m3super90.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_shot_m3super90.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.Sound = Sound( "Weapon_M3.Single" )
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 12
SWEP.Primary.NumShots = 8
SWEP.Primary.Cone = 0.07
SWEP.Primary.Delay = 0.9

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 8

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

function SWEP:Reload()
	if not self:CanReload() then return end

	self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
	self.Owner:DoReloadEvent()
	self:QueueIdle()

	self:SetReloading( true )
	self:SetReloadTime( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
end

function SWEP:InsertShell()
	self:SetClip1( self:Clip1() + 1 )
	self.Owner:RemoveAmmo( 1, self:GetPrimaryAmmoType() )

	self:SendWeaponAnim( ACT_VM_RELOAD )
	self:QueueIdle()

	self:SetReloadTime( CurTime() + (self.ReloadDuration ~= nil and self.ReloadDuration or self.Owner:GetViewModel():SequenceDuration()) )
end

function SWEP:ReloadThink()
	if self:GetReloadTime() > CurTime() then return end

	if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) > 0
		and not self.Owner:KeyDown( IN_ATTACK ) then
		self:InsertShell()
	else
		self:FinishReload()
	end
end

function SWEP:FinishReload()
	self:SetReloading( false )

	self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
	self:SetReloadTime( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self:QueueIdle()

	if self.PumpSound then self:EmitSound( self.PumpSound ) end
end
