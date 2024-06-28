-------------------------------------------------------------------------------
-- Group Data / Calculating
-------------------------------------------------------------------------------

function MBH_SetupData()

	if UnitInRaid("player") and GetNumRaidMembers() > 0 then

		Session.Group = { 3, GetNumRaidMembers(), "raid" }

	elseif not UnitInRaid("player") and GetNumPartyMembers() > 0 then 

		Session.Group = { 2, GetNumPartyMembers(), "party" }

	elseif not UnitInRaid("player") and GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then
        
		Session.Group = { 1, 1, "player" }
	end 
end

function MBH_InitalData()
	if not MBH.GroupData then MBH.GroupData = {} end
	
	for i = 1, Session.MaxData do
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
	for i = 1, Session.MaxData do
		MBH.GroupData[i].HealthDeficite = 0
		MBH.GroupData[i].UnitID = ""
		MBH.GroupData[i].UnitRange = nil
		MBH.GroupData[i].ExtRange = false
		MBH.GroupData[i].Visible = nil
		MBH.GroupData[i].HealValue = 1	
	end
end

function MBH_UpdateData()
	Session.I = 1
	
	if Session.Group[1] == 3 or Session.Group[1] == 2 then -- We are in raid or party
		for i = 1, Session.Group[2] do -- Members

			MBH.GroupData[Session.I].UnitID = Session.Group[3]..Session.I
			MBH.GroupData[Session.I].HealthDeficite = UnitHealthMax(MBH.GroupData[Session.I].UnitID)-UnitHealth(MBH.GroupData[Session.I].UnitID)
			MBH.GroupData[Session.I].UnitRange = CheckInteractDistance(MBH.GroupData[Session.I].UnitID, 4)
			MBH.GroupData[Session.I].Visible = UnitIsVisible(MBH.GroupData[Session.I].UnitID) and UnitIsConnected(MBH.GroupData[Session.I].UnitID) and not UnitIsGhost(MBH.GroupData[Session.I].UnitID) and not UnitIsDead(MBH.GroupData[Session.I].UnitID) and not UnitIsEnemy(MBH.GroupData[Session.I].UnitID,"player") and not UnitCanAttack("player",MBH.GroupData[Session.I].UnitID)

			-- Extended Range
			if MBH.Track[MBH.GroupData[Session.I].UnitID].ExtRange then
				MBH.GroupData[Session.I].ExtRange = true
			else 
				MBH.GroupData[Session.I].ExtRange = nil 
			end
			
			-- LOS
			if MBH.Track[MBH.GroupData[Session.I].UnitID].LOS then
				if MBH.Track[MBH.GroupData[Session.I].UnitID].LOS > 0 then 
					MBH.Track[MBH.GroupData[Session.I].UnitID].LOS = MBH.Track[MBH.GroupData[Session.I].UnitID].LOS - Session.Elapsed
				else 
					MBH.Track[MBH.GroupData[Session.I].UnitID].LOS = nil 
				end 
			end
			
			-- Healcomm
			if MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime then 
				if MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime > 0 then 
					MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime = MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime - Session.Elapsed
					MBH.GroupData[Session.I].HealValue = (UnitHealth(MBH.GroupData[Session.I].UnitID)+MBH.Track[MBH.GroupData[Session.I].UnitID].Heal)/UnitHealthMax(MBH.GroupData[Session.I].UnitID)
					if MBH.GroupData[Session.I].HealValue > 1 then 
						MBH.GroupData[Session.I].HealValue = 1 
					end
				else 
					MBH.Track[MBH.GroupData[Session.I].UnitID].Heal = nil
					MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime = nil
					MBH.Track[MBH.GroupData[Session.I].UnitID].HealName = nil
				end
			end
			
			Session.I = Session.I + 1
		end
	end
	
	if Session.Group[1] == 2 or Session.Group[1] == 1 then -- Add player

		MBH.GroupData[Session.I].UnitID = "player"
		MBH.GroupData[Session.I].HealthDeficite = UnitHealthMax(MBH.GroupData[Session.I].UnitID)-UnitHealth(MBH.GroupData[Session.I].UnitID)
		MBH.GroupData[Session.I].UnitRange = CheckInteractDistance(MBH.GroupData[Session.I].UnitID, 4)
		MBH.GroupData[Session.I].Visible = true
		
		-- Extended Range
		MBH.GroupData[Session.I].ExtRange = true
		
		-- LOS
		if MBH.Track[MBH.GroupData[Session.I].UnitID].LOS then
			if MBH.Track[MBH.GroupData[Session.I].UnitID].LOS > 0 then 
				MBH.Track[MBH.GroupData[Session.I].UnitID].LOS = MBH.Track[MBH.GroupData[Session.I].UnitID].LOS - Session.Elapsed
			else 
				MBH.Track[MBH.GroupData[Session.I].UnitID].LOS = nil 
			end 
		end
		
		-- Healcomm
		if MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime then 
			if MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime > 0 then 
				MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime = MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime - Session.Elapsed
				MBH.GroupData[Session.I].HealValue = (UnitHealth(MBH.GroupData[Session.I].UnitID)+MBH.Track[MBH.GroupData[Session.I].UnitID].Heal)/UnitHealthMax(MBH.GroupData[Session.I].UnitID)
				if MBH.GroupData[Session.I].HealValue > 1 then 
					MBH.GroupData[Session.I].HealValue = 1 
				end
			else 
				MBH.Track[MBH.GroupData[Session.I].UnitID].Heal = nil
				MBH.Track[MBH.GroupData[Session.I].UnitID].HealTime = nil
				MBH.Track[MBH.GroupData[Session.I].UnitID].HealName = nil
			end
		end
		
		Session.I = Session.I + 1
	end
	
	table.sort(MBH.GroupData, function(a, b) return a.HealthDeficite > b.HealthDeficite end)
	Session.Autoheal.SortBuffer = MBH.GroupData
end

function MBH_GetHealUnitID(SpellName)

	local CastTime = Session.CastTime[SpellName]

	if MoronBoxHeal_Options.AutoHeal.Smart_Heal and CastTime then
		
		for i = 1, Session.MaxData do	
			if Session.Autoheal.SortBuffer[i].Visible and (Session.Autoheal.SortBuffer[i].UnitRange or Session.Autoheal.SortBuffer[i].ExtRange) and not MBH.Track[Session.Autoheal.SortBuffer[i].UnitID].LOS then
				if not MBH.Track[Session.Autoheal.SortBuffer[i].UnitID].HealTime then 
					return Session.Autoheal.SortBuffer[i].UnitID
				elseif MBH.Track[Session.Autoheal.SortBuffer[i].UnitID].HealTime and CastTime < MBH.Track[Session.Autoheal.SortBuffer[i].UnitID].HealTime then 
					return Session.Autoheal.SortBuffer[i].UnitID
				end
			end
		end
		
		for i = 1, Session.MaxData do
			if Session.Autoheal.SortBuffer[i].Visible and (Session.Autoheal.SortBuffer[i].UnitRange or Session.Autoheal.SortBuffer[i].ExtRange) and not MBH.Track[Session.Autoheal.SortBuffer[i].UnitID].LOS then
				return Session.Autoheal.SortBuffer[i].UnitID
			end
		end
		
	else
		local RandomTarget = MoronBoxHeal_Options.AutoHeal.Heal_Target_Number

		if MoronBoxHeal_Options.AutoHeal.Random_Target then
			RandomTarget = random(5)
		end
		
		for i = RandomTarget, Session.MaxData do
			if Session.Autoheal.SortBuffer[i].Visible and (Session.Autoheal.SortBuffer[i].UnitRange or Session.Autoheal.SortBuffer[i].ExtRange) and not MBH.Track[Session.Autoheal.SortBuffer[i].UnitID].LOS then
				return Session.Autoheal.SortBuffer[i].UnitID
			end
		end
	end
	return nil	
end