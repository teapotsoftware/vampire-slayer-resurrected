
if SERVER then
	util.AddNetworkString("togglevamplight")

	function GM:PlayerSwitchFlashlight(ply, doEnable)
		if doEnable and ply:Team() == TEAM_VAMP then
			net.Start("togglevamplight")
			net.Send(ply)
			return false
		elseif ply:Team() == TEAM_SLAY then
			return true
		else
			return false
		end
	end
else
	local vampLight = false

	net.Receive("togglevamplight", function()
		vampLight = !vampLight
	end)

	hook.Add("Think", "vamplightthink", function()
		local vampLightEnt = DynamicLight(LocalPlayer():EntIndex())

		if vampLight and vampLightEnt then
			vampLightEnt.pos = LocalPlayer():GetShootPos()
			vampLightEnt.r = 1
			vampLightEnt.g = 0
			vampLightEnt.b = 0
			vampLightEnt.minlight = 0.5
			vampLightEnt.brightness = 1
			vampLightEnt.Decay = 1000
			vampLightEnt.Size = 10000
			vampLightEnt.DieTime = CurTime() + 0.1
		end
	end)

	hook.Add("RenderScreenspaceEffects", "vampLight", function()
		if vampLight then
			DrawColorModify({
				["$pp_colour_addr"] = 0.003,
				["$pp_colour_addg"] = -0.003,
				["$pp_colour_addb"] = -0.003,
				["$pp_colour_brightness"] = 0,
				["$pp_colour_contrast"] = 6,
				["$pp_colour_colour"] = 0,
				["$pp_colour_mulr"] = 255,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			})
			DrawSharpen( 2, 1.2 )
		end
	end)
end
