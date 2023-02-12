
local hide = {
	["CHudHealth"] = true,
	["CHudAmmo"] = true, 
	["CHudSecondaryAmmo"] = true
}

hook.Add("HUDShouldDraw", "ReplaceHUD", function(name)
	if hide[name] then return false end
end)

local winning_team = 0
local color_red = Color(255, 0, 0)

local RoundOverSounds = {
	"vampire_slayer/roundover_vampires.mp3",
	"vampire_slayer/roundover_slayers.mp3",
	"vampire_slayer/roundover_vampires.mp3"
}

net.Receive("RoundOver", function(len)
	winning_team = net.ReadInt(5)
	surface.PlaySound(RoundOverSounds[winning_team])
end)

local RoundOverText = {
	{key = "vampires_win", color = TEAM_VAMP_COLOR},
	{key = "slayers_win", color = TEAM_SLAY_COLOR},
	{key = "round_draw", color = Color(50, 50, 50)}
}

local GameUpdates = {
	{key = "ctc_slay_taken", color = TEAM_SLAY_COLOR, sound = "vampire_slayer/flag_pickup_vampire.wav"},
	{key = "ctc_vamp_taken", color = TEAM_VAMP_COLOR, sound = "vampire_slayer/flag_pickup_slayer.wav"},
	{key = "ctc_vamp_dropped", color = TEAM_VAMP_COLOR, sound = "vampire_slayer/flag_pickup_vampire.wav"},
	{key = "ctc_slay_dropped", color = TEAM_SLAY_COLOR, sound = "vampire_slayer/flag_pickup_slayer.wav"},
	{key = "ctc_vamp_returned", color = TEAM_VAMP_COLOR, sound = "vampire_slayer/flag_pickup_vampire.wav"},
	{key = "ctc_slay_returned", color = TEAM_SLAY_COLOR, sound = "vampire_slayer/flag_pickup_slayer.wav"},
	{key = "ctc_vamp_captured", color = TEAM_VAMP_COLOR, sound = "vampire_slayer/flag_pickup_slayer.wav"},
	{key = "ctc_slay_captured", color = TEAM_SLAY_COLOR, sound = "vampire_slayer/flag_pickup_vampire.wav"},
}

local LastGameUpdate = 0
local LastGameUpdateTime = -999

net.Receive("VSR_SendGameUpdate", function(len)
	LastGameUpdate = net.ReadUInt(8)
	LastGameUpdateTime = CurTime()
	surface.PlaySound(GameUpdates[LastGameUpdate].sound)
end)

function GM:HUDPaint()
	hook.Run("DrawDeathNotice", 0.85, 0.04)

	local w, h = ScrW(), ScrH()
	-- surface.SetTextPos(ScrW() / 2 - 37, ScrH() - 40)
	draw.SimpleText(GetRoundTimerString(), "ExocetLightLarge", w * 0.5, h * 0.99, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("-", "ExocetLightLarge", w * 0.5, h * 0.01, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	draw.SimpleText(SCORE[TEAM_VAMP], "ExocetLightLarge", w * 0.49, h * 0.01, TEAM_VAMP_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
	draw.SimpleText(SCORE[TEAM_SLAY], "ExocetLightLarge", w * 0.51, h * 0.01, TEAM_SLAY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	local ply = NULL
	local om = LocalPlayer():GetObserverMode()
	local alive = LocalPlayer():Alive()
	if alive and om == OBS_MODE_NONE then
		ply = LocalPlayer()
	elseif om == OBS_MODE_IN_EYE then
		ply = LocalPlayer():GetObserverTarget()
	end

	if ply ~= NULL then
		draw.SimpleText("t" .. ply:Health(), "ExocetLightHUD", w * 0.01, h * 0.99, color_red, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

		local wep = ply:GetActiveWeapon()
		if IsValid(wep) then
			if wep:GetPrimaryAmmoType() ~= -1 then
				draw.SimpleText((wep:Clip1() == -1) and ply:GetAmmoCount(wep:GetPrimaryAmmoType()) or (wep:Clip1() .. "|" .. ply:GetAmmoCount(wep:GetPrimaryAmmoType())), "ExocetLightHUD", w * 0.99, h * 0.99, color_red, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
			elseif wep:GetSecondaryAmmoType() ~= -1 then
				draw.SimpleText(wep:Clip2() .. "|" .. ply:GetAmmoCount(wep:GetSecondaryAmmoType()), "ExocetLightHUD", w * 0.99, h * 0.99, color_red, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
			end
		end
--[[
		surface.SetTextPos(20, h - 40)
		surface.DrawText("t" .. ply:Health())

		local wep = ply:GetActiveWeapon()
		if IsValid(wep) then
			if wep:GetPrimaryAmmoType() ~= -1 then
				local startLength = surface.GetTextSize(wep:Clip1())
				surface.SetTextPos(w - 80 - startLength, h - 40)
				surface.DrawText(wep:Clip1() .. "|" .. ply:GetAmmoCount(wep:GetPrimaryAmmoType()))
			elseif wep:GetSecondaryAmmoType() ~= -1 then
				local startLength = surface.GetTextSize(wep:Clip2())
				surface.SetTextPos(w - 80 - startLength, h - 40)
				surface.DrawText(wep:Clip2() .. "|" .. ply:GetAmmoCount(wep:GetSecondaryAmmoType()))
			end
		end
]]
	end

	if not alive then
		local ctc = CONVARS.ctc_enabled:GetBool()
		if ctc then
			local respawn_timer = math.max(math.ceil((LocalPlayer():GetNWFloat("last_death", 0) + CONVARS.ctc_respawn_time:GetFloat()) - CurTime()), 1)
			draw.SimpleText("Respawning in " .. respawn_timer .. "...", "ExocetLightLarge", w * 0.5, h * 0.25, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		local t = LocalPlayer():GetObserverTarget()
		if IsValid(t) and t:IsPlayer() then
			draw.SimpleText((om == OBS_MODE_DEATHCAM and "Killed by " or "Spectating ") .. t:Nick(), "ExocetLightLarge", w * 0.5, h * 0.2, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			if (not ctc) and om ~= OBS_MODE_DEATHCAM and t:Alive() and t:IsBot() and t:Team() == LocalPlayer():Team() then
				draw.SimpleText("Press E to take control", "ExocetLightLarge", w * 0.5, h * 0.25, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end

	if IsRoundState(ROUND_OVER) and RoundOverText[winning_team] then
		draw.SimpleText(LocalText(RoundOverText[winning_team].key), "ExocetLightLarge", w * 0.5, h * 0.4, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif CurTime() - LastGameUpdateTime < 4 then
		draw.SimpleText(LocalText(GameUpdates[LastGameUpdate].key), "ExocetLightLarge", w * 0.5, h * 0.3, GameUpdates[LastGameUpdate].color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end
