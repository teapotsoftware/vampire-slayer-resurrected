
local PLY = FindMetaTable("Player")

function PLY:IsCarryingFlag()
	return CONVARS.ctc_enabled:GetBool() and self:GetNWBool("carrying_flag", false)
end

function PLY:IsPraying()
	if self:IsCarryingFlag() then return false end
	if CurTime() - self:GetNWFloat("last_prayer", -4.1) > 4 then
		return false
	end
	local wep = self:GetActiveWeapon()
	return IsValid(wep) and wep.IsCrucifix
end
