-------------------------------------------------------------------------------
-- Group Data / Calculating
-------------------------------------------------------------------------------

function MBH_SetupData()

	if UnitInRaid("player") and GetNumRaidMembers() > 0 then

		MBH.Session.Group = { 3, GetNumRaidMembers(), "raid" }

	elseif not UnitInRaid("player") and GetNumPartyMembers() > 0 then 

		MBH.Session.Group = { 2, GetNumPartyMembers(), "party" }

	elseif not UnitInRaid("player") and GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then
        
		MBH.Session.Group = { 1, 1, "player" }
	end 
end

function MBH_InitalData()
	if not MBH.GroupData then MBH.GroupData = {} end
	
	for i = 1, MBH.Session.MaxData do
		MBH.GroupData[i] = {}
		MBH.GroupData[i].UnitID = ""
		MBH.GroupData[i].HealthDeficite = 0
		MBH.GroupData[i].UnitRange = nil
		MBH.GroupData[i].ExtRange = nil
		MBH.GroupData[i].LOS = nil
		MBH.GroupData[i].Visible = nil
		MBH.GroupData[i].HealValue = 1
	end

	if not MBH.Track then MBH.Track = {} end
	
	for i = 1, 40 do
		MBH.Track["raid"..i] = {}
		MBH.Track["raid"..i].ExtRange = nil
		MBH.Track["raid"..i].LOS = nil
		MBH.Track["raid"..i].Heal = nil
		MBH.Track["raid"..i].HealTime = nil
		MBH.Track["raid"..i].HealName = nil
	end
	
	for i = 1, 4 do
		MBH.Track["party"..i] = {}
		MBH.Track["party"..i].ExtRange = nil
		MBH.Track["party"..i].LOS = nil
		MBH.Track["party"..i].Heal = nil
		MBH.Track["party"..i].HealTime = nil
		MBH.Track["party"..i].HealName = nil
	end
	
	MBH.Track["player"] = {}
	MBH.Track["player"].Heal = nil
	MBH.Track["player"].HealTime = nil
	MBH.Track["player"].HealName = nil
end

function MBH_ClearData()
	for i = 1, MBH.Session.MaxData do
		MBH.GroupData[i].HealthDeficite = 0
		MBH.GroupData[i].UnitID = ""
		MBH.GroupData[i].UnitRange = nil
		MBH.GroupData[i].ExtRange = false
		MBH.GroupData[i].Visible = nil
		MBH.GroupData[i].HealValue = 1	
	end
end

function MBH_UpdateData()
	MBH.Session.I = 1
	
	if MBH.Session.Group[1] == 3 or MBH.Session.Group[1] == 2 then -- We are in raid or party
		for i = 1, MBH.Session.Group[2] do -- Members

			MBH.GroupData[MBH.Session.I].UnitID = MBH.Session.Group[3]..MBH.Session.I
			MBH.GroupData[MBH.Session.I].HealthDeficite = UnitHealthMax(MBH.GroupData[MBH.Session.I].UnitID)-UnitHealth(MBH.GroupData[MBH.Session.I].UnitID)
			MBH.GroupData[MBH.Session.I].UnitRange = CheckInteractDistance(MBH.GroupData[MBH.Session.I].UnitID, 4)
			MBH.GroupData[MBH.Session.I].Visible = UnitIsVisible(MBH.GroupData[MBH.Session.I].UnitID) and UnitIsConnected(MBH.GroupData[MBH.Session.I].UnitID) and not UnitIsGhost(MBH.GroupData[MBH.Session.I].UnitID) and not UnitIsDead(MBH.GroupData[MBH.Session.I].UnitID) and not UnitIsEnemy(MBH.GroupData[MBH.Session.I].UnitID,"player") and not UnitCanAttack("player",MBH.GroupData[MBH.Session.I].UnitID)

			-- Extended Range
			if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].ExtRange then
				MBH.GroupData[MBH.Session.I].ExtRange = true
			else 
				MBH.GroupData[MBH.Session.I].ExtRange = nil 
			end
			
			-- LOS
			if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS then
				if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS > 0 then 
					MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS = MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS - MBH.Session.Elapsed
				else 
					MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS = nil 
				end 
			end
			
			-- Healcomm
			if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime then 
				if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime > 0 then 
					MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime = MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime - MBH.Session.Elapsed
					MBH.GroupData[MBH.Session.I].HealValue = (UnitHealth(MBH.GroupData[MBH.Session.I].UnitID)+MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].Heal)/UnitHealthMax(MBH.GroupData[MBH.Session.I].UnitID)
					if MBH.GroupData[MBH.Session.I].HealValue > 1 then 
						MBH.GroupData[MBH.Session.I].HealValue = 1 
					end
				else 
					MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].Heal = nil
					MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime = nil
					MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealName = nil
				end
			end
			
			MBH.Session.I = MBH.Session.I + 1
		end
	end
	
	if MBH.Session.Group[1] == 2 or MBH.Session.Group[1] == 1 then -- Add player

		MBH.GroupData[MBH.Session.I].UnitID = "player"
		MBH.GroupData[MBH.Session.I].HealthDeficite = UnitHealthMax(MBH.GroupData[MBH.Session.I].UnitID)-UnitHealth(MBH.GroupData[MBH.Session.I].UnitID)
		MBH.GroupData[MBH.Session.I].UnitRange = CheckInteractDistance(MBH.GroupData[MBH.Session.I].UnitID, 4)
		MBH.GroupData[MBH.Session.I].Visible = true
		
		-- Extended Range
		MBH.GroupData[MBH.Session.I].ExtRange = true
		
		-- LOS
		if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS then
			if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS > 0 then 
				MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS = MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS - MBH.Session.Elapsed
			else 
				MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].LOS = nil 
			end 
		end
		
		-- Healcomm
		if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime then 
			if MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime > 0 then 
				MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime = MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime - MBH.Session.Elapsed
				MBH.GroupData[MBH.Session.I].HealValue = (UnitHealth(MBH.GroupData[MBH.Session.I].UnitID)+MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].Heal)/UnitHealthMax(MBH.GroupData[MBH.Session.I].UnitID)
				if MBH.GroupData[MBH.Session.I].HealValue > 1 then 
					MBH.GroupData[MBH.Session.I].HealValue = 1 
				end
			else 
				MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].Heal = nil
				MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealTime = nil
				MBH.Track[MBH.GroupData[MBH.Session.I].UnitID].HealName = nil
			end
		end
		
		MBH.Session.I = MBH.Session.I + 1
	end
	
	table.sort(MBH.GroupData, function(a, b) return a.HealthDeficite > b.HealthDeficite end)
	MBH.Session.Autoheal.SortBuffer = MBH.GroupData
end

function MBH_GetHealUnitID(SpellName)

	local CastTime = MBH.Session.CastTime[SpellName]

	if MoronBoxHeal_Options.AutoHeal.Smart_Heal and CastTime then
		
		for i = 1, MBH.Session.MaxData do	
			if MBH.Session.Autoheal.SortBuffer[i].Visible and (MBH.Session.Autoheal.SortBuffer[i].UnitRange or MBH.Session.Autoheal.SortBuffer[i].ExtRange) and not MBH.Track[MBH.Session.Autoheal.SortBuffer[i].UnitID].LOS then
				if not MBH.Track[MBH.Session.Autoheal.SortBuffer[i].UnitID].HealTime then 
					return MBH.Session.Autoheal.SortBuffer[i].UnitID
				elseif MBH.Track[MBH.Session.Autoheal.SortBuffer[i].UnitID].HealTime and CastTime < MBH.Track[MBH.Session.Autoheal.SortBuffer[i].UnitID].HealTime then 
					return MBH.Session.Autoheal.SortBuffer[i].UnitID
				end
			end
		end
		
		for i = 1, MBH.Session.MaxData do
			if MBH.Session.Autoheal.SortBuffer[i].Visible and (MBH.Session.Autoheal.SortBuffer[i].UnitRange or MBH.Session.Autoheal.SortBuffer[i].ExtRange) and not MBH.Track[MBH.Session.Autoheal.SortBuffer[i].UnitID].LOS then
				return MBH.Session.Autoheal.SortBuffer[i].UnitID
			end
		end
		
	else
		local RandomTarget = MoronBoxHeal_Options.AutoHeal.Heal_Target_Number

		if MoronBoxHeal_Options.AutoHeal.Random_Target then
			RandomTarget = random(5)
		end
		
		for i = RandomTarget, MBH.Session.MaxData do
			if MBH.Session.Autoheal.SortBuffer[i].Visible and (MBH.Session.Autoheal.SortBuffer[i].UnitRange or MBH.Session.Autoheal.SortBuffer[i].ExtRange) and not MBH.Track[MBH.Session.Autoheal.SortBuffer[i].UnitID].LOS then
				return MBH.Session.Autoheal.SortBuffer[i].UnitID
			end
		end
	end
	return nil	
end