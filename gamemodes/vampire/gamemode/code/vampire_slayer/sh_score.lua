
if SERVER then
	util.AddNetworkString("VS_SyncScore")

	function UpdateScore(ply)
		net.Start("VS_SyncScore")
		net.WriteUInt(SCORE[TEAM_VAMP], 8)
		net.WriteUInt(SCORE[TEAM_SLAY], 8)
		if ply == nil then
			net.Broadcast()
		else
			net.Send(ply)
		end
	end

	function AddScore(team, amt)
		if amt == nil then amt = 1 end
		SCORE[team] = SCORE[team] + amt
		UpdateScore()
		if SCORE[team] >= CONVARS.ctc_capture_limit:GetInt() then
			SetRoundState(ROUND_OVER)
			net.Start("RoundOver")
			net.WriteInt(team, 5)
			net.Broadcast()
		end
	end

	function ResetScores()
		SCORE = {0, 0}
		UpdateScore()
	end
else
	net.Receive("VS_SyncScore", function(len)
		SCORE[TEAM_VAMP] = net.ReadUInt(8)
		SCORE[TEAM_SLAY] = net.ReadUInt(8)
	end)
end


