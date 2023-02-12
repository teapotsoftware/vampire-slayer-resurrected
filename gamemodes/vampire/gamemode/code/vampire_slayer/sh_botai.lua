
-- Temporary bot AI
-- When the gamemode is more developed, we can give the bots directions to fight each other

local rePathDelay = 1

function Astar( start, goal )
	if ( !IsValid( start ) || !IsValid( goal ) ) then return false end
	if ( start == goal ) then return true end

	start:ClearSearchLists()

	start:AddToOpenList()

	local cameFrom = {}

	start:SetCostSoFar( 0 )

	start:SetTotalCost( heuristic_cost_estimate( start, goal ) )
	start:UpdateOnOpenList()

	while ( !start:IsOpenListEmpty() ) do
		local current = start:PopOpenList() -- Remove the area with lowest cost in the open list and return it
		if ( current == goal ) then
			return reconstruct_path( cameFrom, current )
		end

		current:AddToClosedList()

		for k, neighbor in pairs( current:GetAdjacentAreas() ) do
			local newCostSoFar = current:GetCostSoFar() + heuristic_cost_estimate( current, neighbor )

			if ( neighbor:IsUnderwater() ) then -- Add your own area filters or whatever here
				continue
			end
			
			if ( ( neighbor:IsOpen() || neighbor:IsClosed() ) && neighbor:GetCostSoFar() <= newCostSoFar ) then
				continue
			else
				neighbor:SetCostSoFar( newCostSoFar );
				neighbor:SetTotalCost( newCostSoFar + heuristic_cost_estimate( neighbor, goal ) )

				if ( neighbor:IsClosed() ) then
				
					neighbor:RemoveFromClosedList()
				end

				if ( neighbor:IsOpen() ) then
					-- This area is already on the open list, update its position in the list to keep costs sorted
					neighbor:UpdateOnOpenList()
				else
					neighbor:AddToOpenList()
				end

				cameFrom[ neighbor:GetID() ] = current:GetID()
			end
		end
	end

	return false
end

function heuristic_cost_estimate( start, goal )
	-- Perhaps play with some calculations on which corner is closest/farthest or whatever
	return start:GetCenter():Distance( goal:GetCenter() )
end

-- using CNavAreas as table keys doesn't work, we use IDs
function reconstruct_path( cameFrom, current )
	local total_path = { current }

	current = current:GetID()
	while ( cameFrom[ current ] ) do
		current = cameFrom[ current ]
		table.insert( total_path, navmesh.GetNavAreaByID( current ) )
	end
	return total_path
end

function GM:StartCommand(ply, cmd)
	if not ply:IsBot() or not ply:Alive() or ply:IsFrozen() then return end

	cmd:ClearMovement()
	cmd:ClearButtons()

	if not ply.Bot_NextTargetScan then ply.Bot_NextTargetScan = CurTime() end
	if ply.Bot_NextTargetScan <= CurTime() then
		ply.Bot_NextTargetScan = CurTime() + 1

		local closestDist = 9999999999
		local closestTarget = null
		for _, t in ipairs(player.GetAll()) do
			if ply:Team() == t:Team() or t:Team() == TEAM_SPECTATE or not t:Alive() then continue end

			local dist = ply:GetPos():DistToSqr(t:GetPos())
			if dist < closestDist then
				closestTarget = t
				closestDist = dist
			end
		end

		ply.Bot_Target = closestTarget
	end

	if IsValid(ply.Bot_Target) then
		local currentArea = navmesh.GetNearestNavArea( ply:GetPos() )

		-- internal variable to regenerate the path every X seconds to keep the pace with the target player
		ply.lastRePath = ply.lastRePath or 0

		-- internal variable to limit how often the path can be (re)generated
		ply.lastRePath2 = ply.lastRePath2 or 0 

		if ( ply.path && ply.lastRePath + rePathDelay < CurTime() && currentArea != ply.targetArea ) then
			ply.path = nil
			ply.lastRePath = CurTime()
		end

		if ( !ply.path && ply.lastRePath2 + rePathDelay < CurTime() ) then

			local targetPos = ply.Bot_Target:GetPos() -- target position to go to
			local targetArea = navmesh.GetNearestNavArea( targetPos )

			ply.targetArea = nil
			ply.path = Astar( currentArea, targetArea )
			if ( !istable( ply.path ) ) then -- We are in the same area as the target, or we can't navigate to the target
				ply.path = nil -- Clear the path, bail and try again next time
				ply.lastRePath2 = CurTime()
				return
			end
			--PrintTable( ply.path )

			-- TODO: Add inbetween points on area intersections
			-- TODO: On last area, move towards the target position, not center of the last area
			table.remove( ply.path ) -- Just for this example, remove the starting area, we are already in it!
		end

		-- We have no path, or its empty (we arrived at the goal), try to get a new path.
		if ( !ply.path || #ply.path < 1 ) then
			ply.path = nil
			ply.targetArea = nil
			return
		end

		-- Select the next area we want to go into
		if ( !IsValid( ply.targetArea ) ) then
			ply.targetArea = ply.path[ #ply.path ]
		end

		-- The area we selected is invalid or we are already there, remove it, bail and wait for next cycle
		if ( !IsValid( ply.targetArea ) || ( ply.targetArea == currentArea && ply.targetArea:GetCenter():DistToSqr( ply:GetPos() ) < 3600 ) ) then
			table.remove( ply.path ) -- Removes last element
			ply.targetArea = nil
			return
		end

		local targetpos = ply.targetArea:GetCenter()
		if #ply.path <= 1 then
			targetpos = ply.Bot_Target:GetPos()
		end

		-- We got the target to go to, aim there and MOVE
		local targetang = ( ply.targetArea:GetCenter() - ply:GetPos() ):GetNormalized():Angle()

		cmd:SetViewAngles(targetang)
		cmd:SetForwardMove(1000)
		cmd:AddKey(IN_ATTACK)
	else -- engage wander AI
		if not ply.Bot_NextWander then ply.Bot_NextWander = 0 end
		if CurTime() > ply.Bot_NextWander then
			ply.Bot_NextWander = CurTime() + math.Rand(1, 4) -- float rand

			local rand = math.random(5)
			if rand == 1 then -- go
				ply.Bot_IsWalking = true
			elseif rand == 2 then -- stop
				ply.Bot_IsWalking = false
			elseif rand == 3 then -- change direction
				ply.Bot_DesiredYaw = math.random(360) - 180
			elseif rand == 4 and math.random(3) == 1 then -- sometimes tell a joke
				RadialTaunt(ply, "joke")
			end
			-- 5 does nothing
		end

		if ply.Bot_IsWalking then
			cmd:SetForwardMove(ply:GetWalkSpeed()) -- walk
		end
	end
end
