
local cloak_color = Color(255, 255, 255, 10)
local cloak_color_moving = Color(255, 255, 255, 70)
local cloak_color_friendly = Color(255, 255, 255, 120)

local function ShouldCloak(ply)
	return ply:Team() == TEAM_VAMP and player_manager.GetPlayerClass(ply) == "player_edgar" and ply:Crouching() and ply:OnGround() and CurTime() - ply:GetNWFloat("last_attack", -999) > 0.5
end

hook.Add("PrePlayerDraw", "VSR_EdgarCloak", function(ply, flags)
	if ply:Alive() then
		if ShouldCloak(ply) then
			ply:SetColor(LocalPlayer():Team() == TEAM_VAMP and cloak_color_friendly or (ply:GetVelocity():LengthSqr() > 0 and cloak_color_moving or cloak_color))
		else
			ply:SetColor(color_white)
		end
	end
end)

hook.Add("PreDrawPlayerHands", "VSR_EdgarCloakVM", function(hands, vm, ply, wep)
	if ply:Alive() then
		return ShouldCloak(ply)
	end
end)

hook.Add("HUDPaint", "VSR_EdgarCloakHUD", function()
	local ply = LocalPlayer()
	if ply:Alive() and ShouldCloak(ply) then
		draw.SimpleText(LocalText("hud_cloak"), "ExocetLightLarge", ScrW() * 0.5, ScrH() * 0.6, Color(255 - (60 + (math.sin(CurTime() * 4) + 1) * 30), 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)

local color_red = Color(255, 0, 0)
local color_louis_esp = Color(164, 148, 10)

hook.Add("PreDrawHalos", "VSR_LouisESP", function()
	local ply = LocalPlayer()
	local carriers = {{}, {}}
	local slayers = {}

	local isCTC = CONVARS.ctc_enabled:GetBool()
	local isLouis = ply:Alive() and ply:Team() == TEAM_VAMP and player_manager.GetPlayerClass(ply) == "player_louis"

	for _, p in ipairs(player.GetAll()) do
		if isCTC and p:GetNWBool("carrying_flag", false) and p ~= ply then
			local t = p:Team()
			carriers[t][#carriers[t] + 1] = p
		elseif isLouis and p:Alive() and p:Team() == TEAM_SLAY and p:EyePos():DistToSqr(ply:EyePos()) <= 360000 then
			slayers[#slayers + 1] = p
		end
	end

	halo.Add(slayers, color_louis_esp, 2, 2, 1, true, true)
	for i = 1, 2 do
		halo.Add(carriers[i], TEAM_COLOR[i], 1, 1, 1, true, true)
	end
end)
