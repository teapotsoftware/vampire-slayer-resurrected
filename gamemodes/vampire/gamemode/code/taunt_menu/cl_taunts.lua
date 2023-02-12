
hook.Add("Think", "RadialTauntMenu", function()
	local shouldopen = input.IsKeyDown(KEY_Q) and LocalPlayer():Alive()
	if radialopen and not shouldopen then
		radialjustclosed = true
	else
		radialopen = shouldopen
		gui.EnableScreenClicker(shouldopen)
	end
end)

local function DrawHex(x, y, w, h)
	local hex = {
		{x = x, y = y + (h * 0.25)},
		{x = x + (w / 2), y = y},
		{x = x + w, y = y + (h * 0.25)},
		{x = x + w, y = y + (h * 0.75)},
		{x = x + (w / 2), y = y + h},
		{x = x, y = y + (h * 0.75)},
	}
	draw.NoTexture()
	surface.DrawPoly(hex)
end

local function CenteredSquare(x, y, size, highlighted, text)
	if highlighted then
		if LocalPlayer():Team() == TEAM_VAMP then
			surface.SetDrawColor(255, 100, 100, 200)
		else
			surface.SetDrawColor(100, 255, 100, 200)
		end
	else
		surface.SetDrawColor(50, 50, 50, 200)
	end
	local halfsize = size / 2
	DrawHex(x - halfsize, y - halfsize, size, size)
	if text then
		draw.SimpleText(text, "ExocetLightSmall", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

local lastradialtaunt = -10

hook.Add("HUDPaint", "VampireSlayer_RadialMenu", function()
	if radialopen then
		local centerx = ScrW() / 2
		local centery = ScrH() / 2 -- 100 years xd
		local distfromcenter = ScrH() / 8
		local size = distfromcenter * 1.2
		local x, y = input.GetCursorPos()
		x = x - centerx
		y = y - centery
		local canselect = math.abs(x) + math.abs(y) > size / 4 -- distance from center
		local xneg = x < 0
		local yneg = y < 0
		local xbigger = math.abs(x) > math.abs(y)
		CenteredSquare(centerx - distfromcenter, centery, size, canselect and xneg and xbigger, "Taunt")
		CenteredSquare(centerx + distfromcenter, centery, size, canselect and not xneg and xbigger, "Scream")
		CenteredSquare(centerx, centery + distfromcenter, size, canselect and not yneg and not xbigger, "Danger")
		CenteredSquare(centerx, centery - distfromcenter, size, canselect and yneg and not xbigger, "Laugh")
		if radialjustclosed and canselect and CurTime() - 0.5 > lastradialtaunt then
			lastradialtaunt = CurTime()
			if xbigger then
				if xneg then
					RunConsoleCommand("radialtaunt", "joke")
				else
					RunConsoleCommand("radialtaunt", "scream")
				end
			else
				if yneg then
					RunConsoleCommand("radialtaunt", "laugh")
				else
					RunConsoleCommand("radialtaunt", "danger")
				end
			end
		end
		if radialjustclosed then
			radialjustclosed = false
			radialopen = false
			gui.EnableScreenClicker(false)
		end
	end
end)
