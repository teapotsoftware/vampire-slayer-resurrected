AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Gib"
ENT.Spawnable = true

-- ENT.Models = {"models/Gibs/HGIBS_rib.mdl", "models/Gibs/HGIBS_scapula.mdl", "models/Gibs/HGIBS_spine.mdl", "models/Gibs/HGIBS_rib.mdl", "models/Gibs/HGIBS_scapula.mdl", "models/Gibs/HGIBS_spine.mdl"}

local dark_red = Color(127, 0, 0)

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_junk/rock001a.mdl")
        self:SetColor(dark_red)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self:PhysWake()
    end

    function ENT:PhysicsCollide(data, phys)
        if data.Speed > 50 then
            util.Decal("Blood", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)

            if data.Speed > 100 then
                sound.Play("physics/flesh/flesh_squishy_impact_hard" .. math.random(4) .. ".wav", data.HitPos, 50, math.random(110, 120))
            end
        end
    end

--[[
    function ENT:Use(ply)
        if IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_VAMPIRE and ply:Health() < ply:GetMaxHealth() then
            ply:SetHealth(math.min(ply:Health() + 20, ply:GetMaxHealth()))
            ply:EmitSound("npc/barnacle/barnacle_gulp" .. math.random(2) .. ".wav")
            SafeRemoveEntity(self)
        end
    end
]]
else -- CLIENT
    function ENT:Draw()
        self:DrawModel()
    end
end