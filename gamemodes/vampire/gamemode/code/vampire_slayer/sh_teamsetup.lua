
function GM:CreateTeams()
	team.SetUp(TEAM_VAMP, "Vampires", TEAM_VAMP_COLOR, true)
	team.SetSpawnPoint(TEAM_VAMP, {"info_player_counterterrorist"})
	team.SetClass(TEAM_VAMP, {"player_louis", "player_edgar", "player_nina", "player_butler"})

	team.SetUp(TEAM_SLAY, "Slayers", TEAM_SLAY_COLOR, true)
	team.SetSpawnPoint(TEAM_SLAY, {"info_player_terrorist"})
	team.SetClass(TEAM_SLAY, {"player_fatherd", "player_molly", "player_8ball", "player_sarge"})

	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end

if SERVER then
	util.AddNetworkString("VSR_OpenMenu")
	util.AddNetworkString("VSR_RequestRespawn")

	net.Receive("VSR_RequestRespawn", function(len, ply)
		local cls = net.ReadInt(5)

		local ctc = CONVARS.ctc_enabled:GetBool()
		if ctc and CurTime() - ply:GetNWFloat("last_death", -999) < CONVARS.ctc_respawn_time:GetFloat() then
			return
		end

		if (not ctc) and ((not ply:Alive()) or (IsRoundState(ROUND_INPROGRESS) and CurTime() - LastRoundStateChange() > 6)) then
			return
		end

		if IsRoundState(ROUND_OVER) then return end

		ply:Spawn()

		local teamid = ply:Team()
		if teamid == TEAM_VAMP or teamid == TEAM_SLAY then
			player_manager.SetPlayerClass(ply, team.GetClass(teamid)[cls])
		end

		player_manager.OnPlayerSpawn(ply)
		player_manager.RunClass(ply, "Spawn")
	end)

	function GM:ShowTeam(ply)
		net.Start("VSR_OpenMenu")
		net.WriteInt(1, 5)
		net.Send(ply)
	end

	local TimeBetweenSwitches = 2
	function GM:PlayerRequestTeam(ply, teamid)
		if not team.Joinable(teamid) then
			return
		end

		if ply.LastTeamSwitch and CurTime() - ply.LastTeamSwitch < TimeBetweenSwitches then
			ply:ChatPrint(Format(LocalText("change_team_wait"), (TimeBetweenSwitches - (CurTime() - ply.LastTeamSwitch)) + 1))
			return
		end

		GAMEMODE:PlayerJoinTeam(ply, teamid)
	end

	function GM:PlayerJoinTeam(ply, teamid)
		local oldteam = ply:Team()

		if ply:Alive() and teamid ~= oldteam then
			if oldteam == TEAM_SPECTATOR or oldteam == TEAM_UNASSIGNED then
				ply:KillSilent()
			else
				ply:Kill()
			end
		end

		if teamid == TEAM_VAMP or teamid == TEAM_SLAY then
			player_manager.SetPlayerClass(ply, team.GetClass(teamid)[ply:GetInfoNum("vs_playerclass_" .. teamid, 1)])
		end

		ply:SetTeam(teamid)
		ply.LastTeamSwitch = CurTime()

		GAMEMODE:OnPlayerChangedTeam(ply, oldteam, teamid)
	end

	function GM:ShowSpare1(ply)
		net.Start("VSR_OpenMenu")
		net.WriteInt(2, 5)
		net.Send(ply)
	end
else
	local hoveredClass = 0
	local classKeys = {
		{"louis", "edgar", "nina", "butler"},
		{"fatherd", "molly", "8ball", "sarge"}
	}

	local function GoldSrcButtonPaint(self, w, h)
		surface.SetDrawColor(159, 95, 47, 255)
		surface.DrawOutlinedRect(0, 0, w, h)

		if self:IsHovered() then
			surface.SetDrawColor(159, 95, 47, 20)
			surface.DrawRect(0, 0, w, h)
		end
	end

	local Menus = {}

	local function OpenMenu(i)
		GAMEMODE:HideTeam() -- delete current menu if open
		GAMEMODE.CurrentMenu = Menus[i]()
	end

	Menus[1] = function()
		local teamSelectionGui = vgui.Create("DPanel")
		teamSelectionGui:SetSize(ScrW(), ScrH())
		teamSelectionGui:Center()
		teamSelectionGui:MakePopup()

		teamSelectionGui.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 235)
			surface.DrawRect(0, 0, w, h)
		end

		local teamLabel = vgui.Create("DLabel", teamSelectionGui)
		teamLabel:SetColor(Color(159, 95, 47, 255))
		teamLabel:SetPos(ScrW() * 0.062, ScrH() * 0.077)
		teamLabel:SetFont("GothicLarge")
		teamLabel:SetText(LocalText("select_team"))
		teamLabel:SizeToContents()

		local slayButton = vgui.Create("DButton", teamSelectionGui)
		slayButton:SetPos(ScrW() * 0.065, ScrH() * 0.17)
		slayButton:SetSize(ScrH() * 0.35, ScrH() * 0.06)
		slayButton.Paint = GoldSrcButtonPaint
		slayButton:SetContentAlignment(4)
		slayButton:SetText("  1 " .. LocalText("team_slayer"))
		slayButton:SetFont("GothicRegular")
		slayButton:SetColor(Color(159, 95, 47))

		function slayButton:DoClick()
			if LocalPlayer():Team() ~= TEAM_SLAY then
				LocalPlayer():ConCommand("changeteam 2")
			end
			Menus[2](2)
			teamSelectionGui:Remove()
		end

		local vampButton = vgui.Create("DButton", teamSelectionGui)
		vampButton:SetPos(ScrW() * 0.065, ScrH() * 0.25)
		vampButton:SetSize(ScrH() * 0.35, ScrH() * 0.06)
		vampButton.Paint = GoldSrcButtonPaint
		vampButton:SetContentAlignment(4)
		vampButton:SetText("  2 " .. LocalText("team_vampire"))
		vampButton:SetFont("GothicRegular")
		vampButton:SetColor(Color(159, 95, 47))

		function vampButton:DoClick()
			if LocalPlayer():Team() ~= TEAM_VAMP then
				LocalPlayer():ConCommand("changeteam 1")
			end
			Menus[2](1)
			teamSelectionGui:Remove()
		end

		local autoButton = vgui.Create("DButton", teamSelectionGui)
		autoButton:SetPos(ScrW() * 0.065, ScrH() * 0.33)
		autoButton:SetSize(ScrH() * 0.35, ScrH() * 0.06)
		autoButton.Paint = GoldSrcButtonPaint
		autoButton:SetContentAlignment(4)
		autoButton:SetText("  5 " .. LocalText("auto_assign"))
		autoButton:SetFont("GothicRegular")
		autoButton:SetColor(Color(159, 95, 47))

		function autoButton:DoClick()
			local bestTeam = 1

			if team.NumPlayers(1) > team.NumPlayers(2) then
				bestTeam = 2
			end

			if LocalPlayer():Team() ~= bestTeam then
				LocalPlayer():ConCommand("changeteam " .. bestTeam)
			end
			Menus[2](bestTeam)
			teamSelectionGui:Remove()
		end

		function teamSelectionGui:OnKeyCodePressed(key)
			if key == KEY_1 then
				slayButton:DoClick()
			elseif key == KEY_2 then
				vampButton:DoClick()
			elseif key == KEY_5 then
				autoButton:DoClick()
			end
		end

		local textBox = vgui.Create("DPanel", teamSelectionGui)
		textBox:SetPos(ScrW() * 0.065 + ScrH() * 0.39, ScrH() * 0.17)
		textBox:SetSize(ScrW() * 0.63, ScrH() * 0.65)
		textBox.Paint = function(self, w, h)
			surface.SetDrawColor(159, 95, 47, 255)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local map = game.GetMap()

		local mapTitle = vgui.Create("DLabel", textBox)
		mapTitle:SetColor(Color(159, 95, 47, 255))
		mapTitle:SetPos(ScrH() * 0.06, ScrH() * 0.05)
		mapTitle:SetFont("GothicRegular")
		mapTitle:SetText(LangKeyExists("map_" .. map .. "_name") and LocalText("map_" .. map .. "_name") or string.upper(map))
		mapTitle:SizeToContents()

		local mapDesc = vgui.Create("DLabel", textBox)
		mapDesc:SetColor(Color(159, 95, 47, 255))
		mapDesc:SetPos(ScrH() * 0.06, ScrH() * 0.13)
		mapDesc:SetFont("GothicSmall")
		mapDesc:SetText((OVERCAST_MAPS[game.GetMap()] and (LocalText("overcast_notice") .. "\n\n") or "") .. (LangKeyExists("map_" .. map .. "_desc") and LocalText("map_" .. map .. "_desc") or LocalText("default_map_desc")))
		mapDesc:SizeToContents()

		return teamSelectionGui
	end
	Menus[2] = function(myTeam)
		if myTeam == nil then myTeam = LocalPlayer():Team() end
		if myTeam ~= TEAM_VAMP and myTeam ~= TEAM_SLAY then return nil end

		-- Reset hovered class every time we open the menu
		hoveredClass = 0

		local frame = vgui.Create("DPanel")
		frame:SetSize(ScrW(), ScrH())
		frame:Center()
		frame:MakePopup()

		local classLabel = vgui.Create("DLabel", frame)
		classLabel:SetColor(Color(159, 95, 47, 255))
		classLabel:SetPos(ScrW() * 0.062, ScrH() * 0.077)
		classLabel:SetFont("GothicLarge")
		classLabel:SetText(LocalText("select_class"))
		classLabel:SizeToContents()

		local classButtons = {}

		for i = 1, 4 do
			classButtons[i] = vgui.Create("DButton", frame)
			classButtons[i]:SetPos(ScrW() * 0.065, ScrH() * (0.09 + i * 0.08))
			classButtons[i]:SetSize(ScrH() * 0.35, ScrH() * 0.06)
			classButtons[i]:SetContentAlignment(4)
			classButtons[i]:SetText("  " .. i .. " " .. LocalText("class_" .. classKeys[myTeam][i]))
			classButtons[i]:SetFont("GothicRegular")
			classButtons[i]:SetColor(Color(159, 95, 47))

			classButtons[i].Paint = function(self, w, h)
				surface.SetDrawColor(159, 95, 47, 255)
				surface.DrawOutlinedRect(0, 0, w, h)

				if self:IsHovered() then
					surface.SetDrawColor(159, 95, 47, 20)
					surface.DrawRect(0, 0, w, h)

					hoveredClass = i
				end
			end

			classButtons[i].DoClick = function(self)
				LocalPlayer():ChatPrint(Format(LocalText("you_will_spawn_as"), LocalText("class_" .. classKeys[myTeam][i] .. "_name")))
				LocalPlayer():ConCommand("vs_playerclass_" .. myTeam .. " " .. i)
				net.Start("VSR_RequestRespawn")
				net.WriteInt(i, 5)
				net.SendToServer()
				frame:Remove()
			end
		end

		local autoButton = vgui.Create("DButton", frame)
		autoButton:SetPos(ScrW() * 0.065, ScrH() * 0.49)
		autoButton:SetSize(ScrH() * 0.35, ScrH() * 0.06)
		autoButton.Paint = GoldSrcButtonPaint
		autoButton:SetContentAlignment(4)
		autoButton:SetText("  5 " .. LocalText("class_random"))
		autoButton:SetFont("GothicRegular")
		autoButton:SetColor(Color(159, 95, 47))

		function autoButton:DoClick()
			classButtons[math.random(3)]:DoClick()
		end

		function frame:OnKeyCodePressed(key)
			if key == KEY_1 then
				classButtons[1]:DoClick()
			elseif key == KEY_2 then
				classButtons[2]:DoClick()
			elseif key == KEY_3 then
				classButtons[3]:DoClick()
			elseif key == KEY_5 then
				classButtons[math.random(3)]:DoClick()
			end
		end

		local textBox = vgui.Create("DPanel", frame)
		textBox:SetPos(ScrW() * 0.065 + ScrH() * 0.39, ScrH() * 0.17)
		textBox:SetSize(ScrW() * 0.63, ScrH() * 0.65)
		textBox.Paint = function(self, w, h)
			surface.SetDrawColor(159, 95, 47, 255)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local className = vgui.Create("DLabel", textBox)
		className:SetColor(Color(159, 95, 47, 255))
		className:SetPos(ScrH() * 0.06, ScrH() * 0.05)
		className:SetFont("GothicRegular")
		className:SetText("")

		local classDesc = vgui.Create("DLabel", textBox)
		classDesc:SetColor(Color(159, 95, 47, 255))
		classDesc:SetPos(ScrH() * 0.06, ScrH() * 0.13)
		classDesc:SetFont("GothicSmall")
		classDesc:SetText("")

		frame.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 235)
			surface.DrawRect(0, 0, w, h)

			if hoveredClass ~= 0 and classKeys[myTeam][hoveredClass] ~= nil then
				local key = classKeys[myTeam][hoveredClass]
				className:SetText(LocalText("class_" .. key .. "_name"))
				className:SizeToContents()
				classDesc:SetText(LocalText("class_" .. key .. "_bio"))
				classDesc:SizeToContents()
			end
		end

		return frame
	end

	net.Receive("VSR_OpenMenu", function(len)
		local i = net.ReadUInt(5)
		if not Menus[i] then return end
		OpenMenu(i)
	end)

	function GM:ShowTeam()
		if IsValid(self.CurrentMenu) then return end
	end

	function GM:HideTeam()
		if IsValid(self.CurrentMenu) then
			self.CurrentMenu:Remove()
		end
	end
end
