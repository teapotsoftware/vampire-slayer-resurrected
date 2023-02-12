
local drawguns = {
	["vs_winchester"] = {
		model = "models/weapons/w_winchester_1873.mdl",
		bone = "ValveBiped.Bip01_Spine4",
		pos = Vector(2.226, 3.157, -6.514),
		ang =  Angle(13.008, 165.542, -4.513)
	},
	["vs_thunder5"] = {
		model = "models/weapons/w_sw_model_627.mdl",
		bone = "ValveBiped.Bip01_R_Thigh",
		pos = Vector(-3.037, -3.658, -6.278),
		ang =  Angle(80.83, 78.259, 14.744)
	},
	["vs_poolcue"] = {
		model = "models/brewstersmodels/thesimsbustinout/aristoscratch_pool_cue.mdl",
		bone = "ValveBiped.Bip01_Spine4",
		pos = Vector(11.373, 7.991, 9.59),
		ang =  Angle(116.18, -12.79, 0)
	},
	["vs_shotgun"] = {
		model = "models/weapons/w_mossberg_590.mdl",
		bone = "ValveBiped.Bip01_Spine4",
		pos = Vector(3.828, 6.62, -5.012),
		ang =  Angle(135.106, -15.45, 6.959)
	},
	["vs_dbarrel"] = {
		model = "models/weapons/w_double_barrel_shotgun.mdl",
		bone = "ValveBiped.Bip01_Spine4",
		pos = Vector(5.499, 9.085, 6.605),
		ang =  Angle(-148.23, -7.876, -89.335)
	},
	["vs_crucifix"] = {
		model = "models/freeman/cross.mdl",
		bone = "ValveBiped.Bip01_Spine4",
		pos = Vector(-2.794, -9.391, -0.315),
		ang =  Angle(-180, -115.071, -90.134)
	},
	["vs_crossbow"] = {
		model = "models/weapons/w_crossbow.mdl",
		bone = "ValveBiped.Bip01_Spine2",
		pos = Vector(11.543, 1.782, -2.291),
		ang =  Angle(150.158, 1.802, 95.675)
	},
	["vs_smg"] = {
		model = "models/weapons/w_smg_mac10.mdl",
		bone = "ValveBiped.Bip01_L_Thigh",
		pos = Vector(5.742, 7.728, -2.507),
		ang =  Angle(10.312, 1.366, -46.582)
	},
	["vs_stakepistol"] = {
		model = "models/weapons/s_dmgf_co1911.mdl",
		bone = "ValveBiped.Bip01_Pelvis",
		pos = Vector(0.093, -3.464, -4.495),
		ang = Angle(104.757, -127.459, -33.66)
	},
	["vs_m60"] = {
		model = "models/weapons/w_m60_machine_gun.mdl",
		bone = "ValveBiped.Bip01_Spine4",
		pos = Vector(0.722, 3.775, -6.664),
		ang = Angle(163.932, -18.659, -180)
	},
	["vs_silverdagger"] = {
		model = "models/weapons/w_knife_t.mdl",
		bone = "ValveBiped.Bip01_L_Thigh",
		pos = Vector(0, 0.497, 3.681),
		ang = Angle(2.18, 86.449, 77.265)
	},
}

local grenades = {
	[1] = {
		bone = "ValveBiped.Bip01_Spine",
		pos = Vector(-3.727, -2.968, -9.178),
		ang = Angle(-8.638, 108.541, 83.796)
	},
	[2] = {
		bone = "ValveBiped.Bip01_Spine",
		pos = Vector(-3.498, -7.777, -7.204),
		ang = Angle(61.472, 108.541, 83.796)
	},
	[3] = {
		bone = "ValveBiped.Bip01_Spine",
		pos = Vector(-2.299, -9.964, -3.283),
		ang = Angle(61.472, 108.541, 83.796)
	},
	[4] = {
		bone = "ValveBiped.Bip01_Spine",
		pos = Vector(-2.227, -10.45, 4.238),
		ang = Angle(106.46, 119.763, 60.345)
	},
	[5] = {
		bone = "ValveBiped.Bip01_Spine",
		pos = Vector(-3.347, -7.547, 7.577),
		ang = Angle(106.46, 119.763, 60.345)
	}
}

hook.Add("PostPlayerDraw", "VampireSlayer.DrawHolsteredWeapons", function(ply)
	if not CONVARS.draw_holstered:GetBool() or not ply:Alive() or not ply:Team() == TEAM_SLAY then return end

	local wep = ply:GetActiveWeapon()

	for k, v in pairs(drawguns) do
		if IsValid(wep) and wep:IsWeapon() and wep:GetClass() == k then continue end
		if not ply:HasWeapon(k) then continue end

		local bone = ply:LookupBone(v.bone)
		if not bone then continue end

		local pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
		local m = ply:GetBoneMatrix(bone)

		if m then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z

		ang:RotateAroundAxis(ang:Up(), v.ang.y)
		ang:RotateAroundAxis(ang:Right(), v.ang.p)
		ang:RotateAroundAxis(ang:Forward(), v.ang.r)

		local model = {model = v.model, pos = pos, angle = ang}

		render.Model(model)
	end

	local frags = math.min(ply:GetAmmoCount("grenade"), #grenades)
	if frags > 0 and IsValid(wep) and wep:IsWeapon() and wep:GetClass() == "vs_frag" then
		frags = frags - 1
	end

	if frags <= 0 then return end

	local bone = ply:LookupBone(grenades[1].bone)
	if not bone then return end

	for i = 1, frags do
		local pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
		local m = ply:GetBoneMatrix(bone)

		if m then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		pos = pos + ang:Forward() * grenades[i].pos.x + ang:Right() * grenades[i].pos.y + ang:Up() * grenades[i].pos.z

		ang:RotateAroundAxis(ang:Up(), grenades[i].ang.y)
		ang:RotateAroundAxis(ang:Right(), grenades[i].ang.p)
		ang:RotateAroundAxis(ang:Forward(), grenades[i].ang.r)

		render.Model({model = "models/weapons/w_eq_fraggrenade.mdl", pos = pos, angle = ang})
	end
end)
