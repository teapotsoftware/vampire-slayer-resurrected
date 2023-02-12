
function IsDownedVampire(ply)
	return (not CONVARS.knockdown_ragdoll:GetBool()) and ply:Team() == TEAM_VAMP and ply:Health() == 1
end

function GM:SetupMove(ply, mv, cmd)
	if IsDownedVampire(ply) then
		mv:SetVelocity(Vector(0, 0, -200))
		mv:SetButtons(0)
	end

	if ply:IsCarryingFlag() then
		mv:SetMaxClientSpeed(300)
	end
end

if CLIENT then
	net.Receive("SyncRagdollColor", function()
		local rag = net.ReadEntity()
		local clr = net.ReadVector()
		if IsValid(rag) then
			rag.GetPlayerColor = function() return clr end
		end
	end)

	hook.Add("CalcView", "VampireCalcView", function(ply, pos, ang, fov, znear, zfar)
		if IsDownedVampire(ply) then
			return {
				origin = ply:GetPos() + Vector(0, 0, 6),
				angles = ang + Angle(0, 0, 90),
				fov = fov,
				znear = znear,
				zfar = zfar
			}
		end
	end)

	function GM:PreDrawViewModel(vm, ply, wep)
		return IsDownedVampire(ply)
	end

	function GM:AdjustMouseSensitivity(sens)
		if IsDownedVampire(LocalPlayer()) then
			return 0.00001
		end

		return nil
	end
end
