
function GM:PlayerInitialSpawn(ply)
	if ply:IsBot() then
		if (team.NumPlayers(TEAM_VAMP) > team.NumPlayers(TEAM_SLAY)) then
			ply:SetTeam(TEAM_SLAY)
		else
			ply:SetTeam(TEAM_VAMP)
		end
		ply:Spawn()
	else
		ply:SetTeam(TEAM_SPECTATOR)
		self:ShowTeam(ply)
	end

	ply:Flashlight(false)
	ply:SetCanZoom(false)
	ply:ShouldDropWeapon(false)
	ply:SetNoCollideWithTeammates(false)
	ply:SetAvoidPlayers(true)
end

function GM:PlayerSpawn(ply, transition)
	ply:UnSpectate()
	ply:SetupHands()
	ply:ResetHull()

	local teamid = ply:Team()
	if teamid == TEAM_VAMP or teamid == TEAM_SLAY then
		local cls = (ply:IsBot() and math.random(4) or ply:GetInfoNum("vs_playerclass_" .. teamid, 1))
		player_manager.SetPlayerClass(ply, team.GetClass(teamid)[cls])
		player_manager.OnPlayerSpawn(ply)
		player_manager.RunClass(ply, "Spawn")
	end

	ply:SetNWFloat("last_prayer", -999)
	ply:SetNWBool("carrying_flag", false)

	ply:StopAllLuaAnimations()
end

function GM:PlayerDeathThink(ply)
	if IsRoundState(ROUND_WAITING) then
		ply:Spawn()
	end
end

local SpawnPointOverrides = {
	["cs_"] = {
		[TEAM_VAMP] = "info_player_terrorist",
		[TEAM_SLAY] = "info_player_counterterrorist"
	}
}

function GM:PlayerSelectTeamSpawn(TeamID, pl)
	local map_name = game.GetMap()
	local map_prefix = string.Left(map_name, 3)
	-- print(pl:Nick() .. " on team " .. TeamID)
	local SpawnPoints = (SpawnPointOverrides[map_prefix] and SpawnPointOverrides[map_prefix][TeamID]) and ents.FindByClass(SpawnPointOverrides[map_prefix][TeamID]) or team.GetSpawnPoints(TeamID)
	if not SpawnPoints or table.IsEmpty(SpawnPoints) then return end

	local ChosenSpawnPoint = nil

	for i = 0, 15 do
		local ChosenSpawnPoint = table.Random(SpawnPoints)
		if TeamID == TEAM_VAMP and (not OVERCAST_MAPS[map_name]) and IsInSunlight(ChosenSpawnPoint:GetPos()) then continue end
		if hook.Call("IsSpawnpointSuitable", GAMEMODE, pl, ChosenSpawnPoint, i == 6) then
			-- print(ChosenSpawnPoint:GetClass())
			return ChosenSpawnPoint
		end
	end

	return ChosenSpawnPoint
end
