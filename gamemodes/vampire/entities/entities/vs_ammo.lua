AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Ammo"
ENT.Spawnable = true

-- ENT.Models = {"models/Gibs/HGIBS_rib.mdl", "models/Gibs/HGIBS_scapula.mdl", "models/Gibs/HGIBS_spine.mdl", "models/Gibs/HGIBS_rib.mdl", "models/Gibs/HGIBS_scapula.mdl", "models/Gibs/HGIBS_spine.mdl"}

local dark_red = Color(127, 0, 0)

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/Items/BoxBuckshot.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:PhysWake()
    end

	local PickupSound = Sound("Player.PickupWeapon")
	local Ammo = {
		["player_fatherd"] = {
			["buckshot"] = 8,
		},
		["player_molly"] = {
			["pistol"] = 7,
			["smg1"] = 30,
			["357"] = 1
		},
		["player_8ball"] = {
			["buckshot"] = 5,
			["357"] = 10
		},
		["player_sarge"] = {
			["smg1"] = 40,
			["grenade"] = 1
		}
	}

    function ENT:StartTouch(ply)
		if IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_SLAY then
			local cls = player_manager.GetPlayerClass(ply)
			if Ammo[cls] then
				for k, v in pairs(Ammo[cls]) do
					ply:GiveAmmo(v, k, true)
				end
			end
			ply:EmitSound(PickupSound)
			self:Remove()
		end
	end
else -- CLIENT
    function ENT:Draw()
        self:DrawModel()
    end
end