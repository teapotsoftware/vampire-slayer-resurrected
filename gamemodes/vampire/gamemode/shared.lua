
DeriveGamemode("base")

GM.Name = "Vampire Slayer"
GM.Author = "Tooty582 & teapot"
GM.TeamBased = true
GM.AllowAutoTeam = true

TEAM_VAMP = 1
TEAM_VAMP_COLOR = Color(150, 0, 0, 255)

TEAM_SLAY = 2
TEAM_SLAY_COLOR = Color(0, 105, 145, 255)

TEAM_COLOR = {TEAM_VAMP_COLOR, TEAM_SLAY_COLOR}
OTHER_TEAM = {TEAM_SLAY, TEAM_VAMP}

OVERCAST_MAPS = {
	["cs_havana"] = true,
	["cs_italy"] = true,
	["de_cbble"] = true,
	["de_nuke"] = true,
	["de_piranesi"] = true,
	["de_inferno"] = true,
	["de_chateau"] = true,
	["de_aztec"] = true,
}

FLAG_LOCATIONS = {
	["cs_office"] = {Vector(1684, 692, -96), Vector(-1150, -2132, -272)},
}

SCORE = {0, 0}

function IsInSunlight(pos)
	local tr = util.TraceLine({
		start = pos,
		endpos = pos + vector_up * 100000,
		mask = MASK_OPAQUE
	})
	return tr.HitSky
end
