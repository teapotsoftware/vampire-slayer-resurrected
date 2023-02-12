AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/monastery/cross_wood.mdl")

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Team")
	self:NetworkVar("Bool", 0, "IsDropped")
	self:NetworkVar("Float", 0, "DropTime")
	self:NetworkVar("Vector", 0, "StartPos")
end

local TeamNames = {"Vampires", "Slayers"}

if SERVER then
	util.AddNetworkString("VSR_SendGameUpdate")

	function CaptureFlag(team)
		-- PrintMessage(HUD_PRINTTALK, TeamNames[team] .. " captured!")
		net.Start("VSR_SendGameUpdate")
		net.WriteUInt(6 + OTHER_TEAM[team], 8)
		net.Broadcast()
		AddScore(team)
		local pos = FLAG_LOCATIONS[game.GetMap()][OTHER_TEAM[team]] - Vector(0, 0, 20)
		local flag = ents.Create("vs_flag")
		flag:SetPos(pos)
		flag:SetStartPos(pos)
		flag:SetTeam(OTHER_TEAM[team])
		flag:Spawn()
	end

	local function ReturnFlag(ent)
		ent:SetIsDropped(false)
		ent:SetPos(ent:GetStartPos())
		-- PrintMessage(HUD_PRINTTALK, "Flag returned!")
		net.Start("VSR_SendGameUpdate")
		net.WriteUInt(4 + ent:GetTeam(), 8)
		net.Broadcast()
	end

	function ENT:Initialize()
		self:SetModel(self.Model)

		self:SetSolid(SOLID_BBOX)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionBounds(Vector(-16, -16, -16), Vector(16, 16, 16))

		if self:GetTeam() == TEAM_VAMP then
			self:SetAngles(self:GetAngles() + Angle(0, 0, 180))
		end
	end

	function ENT:StartTouch(ent)
		if IsValid(ent) and ent:IsPlayer() and ent:Alive() and not ent.KnockedVampire then
			if self:GetTeam() == ent:Team() then
				if self:GetIsDropped() then
					ReturnFlag(self)
				else
					if ent:GetNWBool("carrying_flag", false) then
						ent:SetNWBool("carrying_flag", false)
						CaptureFlag(ent:Team())
					end
				end
			else
				ent:SetNWBool("carrying_flag", true)
				-- PrintMessage(HUD_PRINTTALK, "Flag taken!")
				net.Start("VSR_SendGameUpdate")
				net.WriteUInt(ent:Team(), 8)
				net.Broadcast()
				self:Remove()
			end
		end
	end

	function ENT:Think()
		if self:GetIsDropped() and CurTime() - self:GetDropTime() >= CONVARS.ctc_return_time:GetFloat() then
			ReturnFlag(self)
		end
	end
else
	local spriteMat = Material("sprites/gmdm_pickups/light")
	function ENT:Draw()
		render.SetMaterial(spriteMat)
		render.DrawSprite(self:GetPos(), 150, 150, TEAM_COLOR[self:GetTeam()])
		self:DrawModel()
	end
end
