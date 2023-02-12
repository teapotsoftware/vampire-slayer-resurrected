
-- Player classes for VS:R
-- This is where we define speed, jump height, playermodels, and weapons

-- VS BASE CLASS: All classes are derived from this
local PLAYER = {}
PLAYER.DisplayName = "Vampire Slayers Base"
PLAYER.PlayerModel = "models/player/gasmask.mdl"
PLAYER.WalkSpeed = 400
PLAYER.RunSpeed = 240
PLAYER.MaxHealth = 100
PLAYER.DuckSpeed = 0.4
PLAYER.UnDuckSpeed = 0.3
PLAYER.JumpPower = 200
PLAYER.PlayerColor = Vector(0, 1, 1)
PLAYER.WeaponList = {}

function PLAYER:Loadout()
    self.Player:StripWeapons()
    self.Player:RemoveAllAmmo()

    for _, v in ipairs(self.WeaponList) do
        self.Player:Give(v)
    end
end

function PLAYER:SetModel()
    util.PrecacheModel(self.PlayerModel)
    self.Player:SetModel(self.PlayerModel)
    self.Player:SetPlayerColor(self.PlayerColor)
end

function PLAYER:Spawn()
    self:SetModel()
    self:Loadout()
    self.Player:SetWalkSpeed(self.WalkSpeed)
    self.Player:SetRunSpeed(self.RunSpeed)
    self.Player:SetMaxHealth(self.MaxHealth)
    self.Player:SetHealth(self.MaxHealth)
    self.Player:SetJumpPower(self.JumpPower)
    -- self.Player:AllowFlashlight(self.CanUseFlashlight)
    self.Player:SetCrouchedWalkSpeed(.33)
end

player_manager.RegisterClass("player_vsbase", PLAYER, "player_default")

-- BASE VAMPIRE: Vampires are derived from this
local VAMPIRE = {}
VAMPIRE.DisplayName = "Base Vampire"
VAMPIRE.WalkSpeed = 350
VAMPIRE.RunSpeed = 180
VAMPIRE.JumpPower = 250
VAMPIRE.PlayerColor = TEAM_VAMP_COLOR:ToVector()
VAMPIRE.WeaponList = {"vs_claws"}
function VAMPIRE:GetHandsModel() return {model = "models/weapons/c_arms_refugee.mdl", skin = 2, body = "0000000"} end
player_manager.RegisterClass("player_vampire", VAMPIRE, "player_vsbase")

-- BASE SLAYER: Slayers are derived from this
local SLAYER = {}
SLAYER.DisplayName = "Base Slayer"
SLAYER.WalkSpeed = 250
SLAYER.RunSpeed = 120
SLAYER.JumpPower = 180
SLAYER.PlayerColor = TEAM_SLAY_COLOR:ToVector()
function SLAYER:GetHandsModel() return {model = "models/weapons/c_arms_cstrike.mdl", skin = 0, body = "0000000"} end
player_manager.RegisterClass("player_slayer", SLAYER, "player_vsbase")

-- VAMPIRES
player_manager.RegisterClass("player_louis", {DisplayName = "Louis", PlayerModel = "models/player/breen.mdl"}, "player_vampire")
player_manager.RegisterClass("player_edgar", {DisplayName = "Edgar", PlayerModel = "models/player/gman_high.mdl"}, "player_vampire")
player_manager.RegisterClass("player_nina", {DisplayName = "Nina", PlayerModel = "models/player/p2_chell.mdl"}, "player_vampire")
player_manager.RegisterClass("player_butler", {DisplayName = "Butler", PlayerModel = "models/player/kleiner.mdl"}, "player_vampire")

-- SLAYERS
player_manager.RegisterClass("player_fatherd", {DisplayName = "Father D", PlayerModel = "models/player/monk.mdl", WeaponList = {"vs_crucifix", "vs_dbarrel", "vs_shotgun"}}, "player_slayer")
player_manager.RegisterClass("player_molly", {DisplayName = "Molly", PlayerModel = "models/player/alyx.mdl", WeaponList = {"vs_stakepistol", "vs_smg", "vs_crossbow"}}, "player_slayer")
player_manager.RegisterClass("player_8ball", {DisplayName = "Eightball", PlayerModel = "models/player/leet.mdl", WeaponList = {"vs_poolcue", "vs_thunder5", "vs_winchester"}}, "player_slayer")
player_manager.RegisterClass("player_sarge", {DisplayName = "Bulldog", PlayerModel = "models/player/guerilla.mdl", WeaponList = {"vs_silverdagger", "vs_frag", "vs_m60"}}, "player_slayer")
