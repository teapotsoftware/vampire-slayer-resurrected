
concommand.Add("vs_restartround", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	SetRoundState(ROUND_INPROGRESS, true)
end)

concommand.Add("vs_restartgame", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	if SERVER then
		ResetScores()
	end
	SetRoundState(ROUND_INPROGRESS, true)
end)

ROUND_WAITING = 1
ROUND_INPROGRESS = 2
ROUND_OVER = 3

local last_change = 0
local round_state = ROUND_WAITING

RoundStateData = {
	[ROUND_WAITING] = {},
	[ROUND_INPROGRESS] = {
		cvar_key = "round_time",
		next_state = ROUND_OVER,
		start = function()
			game.CleanUpMap()
			for _, v in ipairs(player.GetAll()) do
				v:Spawn()
			end
		end,
	},
	[ROUND_OVER] = {
		cvar_key = "post_round_time",
		next_state = ROUND_INPROGRESS
	},
}

local function RoundedCurTime()
	return math.ceil(CurTime())
end

function GetRoundState()
	return round_state
end

function LastRoundStateChange()
	return last_change
end

function IsRoundState(state)
	return round_state == state
end

function GetRoundTimerNumber()
	return (GetRoundLength() + last_change) - RoundedCurTime()
end

function GetRoundLength()
	local rs = GetRoundState()
	if rs == ROUND_INPROGRESS then
		return CONVARS.ctc_round_time:GetInt()
	end
	return CONVARS[RoundStateData[rs].cvar_key]:GetInt()
end

function GetRoundTimerString()
	if IsRoundState(ROUND_WAITING) then
		return LocalText("waiting_for_players")
	end

	if GetRoundTimerNumber() < 0 then
		return LocalText("overtime")
	end

	return string.ToMinutesSeconds(GetRoundTimerNumber())
end

function IsOvertime()
	return RoundedCurTime() - last_change >= GetRoundLength()
end

if SERVER then
	util.AddNetworkString("RoundOver")
	util.AddNetworkString("UpdateRoundState")

	function UpdateRoundState()
		net.Start("UpdateRoundState")
		net.WriteInt(round_state, 5)
		net.Broadcast()
	end

	function SetRoundState(state, forceupdate)
		if round_state == state and not forceupdate then return end
		last_change = RoundedCurTime()
		round_state = state
		UpdateRoundState()
		if RoundStateData[state].start then
			RoundStateData[state].start()
		end
	end

	function GM:PostCleanupMap()
		if CONVARS.ctc_enabled:GetBool() and FLAG_LOCATIONS[game.GetMap()] then
			ResetScores()
			local locs = FLAG_LOCATIONS[game.GetMap()]
			for i = 1, 2 do
				local pos = locs[i] - Vector(0, 0, 20)
				local flag = ents.Create("vs_flag")
				flag:SetPos(pos)
				flag:SetStartPos(pos)
				flag:SetTeam(i)
				flag:Spawn()
			end
		end
	end

	hook.Add("Think", "RoundStateThink", function()
		if player.GetCount() < 2 or team.NumPlayers(TEAM_SLAY) < 1 or team.NumPlayers(TEAM_VAMP) < 1 then
			SetRoundState(ROUND_WAITING)
			return
		elseif IsRoundState(ROUND_WAITING) then -- just got enough players
			SetRoundState(ROUND_INPROGRESS)
		end

		if IsOvertime() then
			if IsRoundState(ROUND_INPROGRESS) then
				if CONVARS.ctc_enabled:GetBool() then
					if SCORE[TEAM_VAMP] ~= SCORE[TEAM_SLAY] then
						net.Start("RoundOver")
						net.WriteInt(SCORE[TEAM_VAMP] > SCORE[TEAM_SLAY] and TEAM_VAMP or TEAM_SLAY, 5)
						net.Broadcast()
					else
						return
					end
				else
					-- PrintMessage(HUD_PRINTTALK, "Time's up, nobody wins!")
					net.Start("RoundOver")
					net.WriteInt(3, 5)
					net.Broadcast()
				end
			end
			
			SetRoundState(RoundStateData[GetRoundState()].next_state)
		end
	end)

	local function CheckForGameOver(ply)
		if CONVARS.ctc_enabled:GetBool() then
			-- TODO
		else
			local living_players = {0, 0}
			for _, v in pairs(player.GetAll()) do
				if v:Alive() and (v:Team() == TEAM_VAMP or v:Team() == TEAM_SLAY) then
					living_players[v:Team()] = living_players[v:Team()] + 1
				end
			end

			if IsRoundState(ROUND_INPROGRESS) and (living_players[TEAM_VAMP] == 0 or living_players[TEAM_SLAY] == 0) then
				SetRoundState(ROUND_OVER)
				local winning_team = living_players[TEAM_VAMP] == 0 and 2 or 1
				AddScore(winning_team, 1)
				net.Start("RoundOver")
				net.WriteInt(winning_team, 5)
				net.Broadcast()
			end
		end
	end

	hook.Add("PostPlayerDeath", "VSR_CheckDeath", CheckForGameOver)
	hook.Add("PlayerDisconnected", "VSR_CheckDisc", CheckForGameOver)
else
	net.Receive("UpdateRoundState", function(len)
		local state = net.ReadInt(5)
		last_change = RoundedCurTime() -- could get desynced, but who cares
		round_state = state
	end)
end
