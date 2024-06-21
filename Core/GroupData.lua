-------------------------------------------------------------------------------
-- Group Data / Calculating
-------------------------------------------------------------------------------

function MBH_SetupData()

	if UnitInRaid("player") and GetNumRaidMembers() > 0 then

		Session.Group = {
            3,
            GetNumRaidMembers(), -- Raid Members
            "raid"
        }

	elseif not UnitInRaid("player") and GetNumPartyMembers() > 0 then 

		Session.Group = {
            2,
            GetNumPartyMembers(), -- Party Members
            "party"
        }

	elseif not UnitInRaid("player") and GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then
        
		Session.Group = {
            1,
            1,
            "player"
        }
	end 
end

function MBH_InitalData()
	if not MultiBoxHeal.GroupData then MultiBoxHeal.GroupData = {} end
	
	for i = 1, Session.MaxData do
		MultiBoxHeal.GroupData[i] = {}
		MultiBoxHeal.GroupData[i].UnitID = ""
		MultiBoxHeal.GroupData[i].HealthDeficite = 0
		MultiBoxHeal.GroupData[i].UnitRange = nil
		MultiBoxHeal.GroupData[i].ExtRange = nil
		MultiBoxHeal.GroupData[i].LOS = nil
		MultiBoxHeal.GroupData[i].Visible = nil
		MultiBoxHeal.GroupData[i].HealValue = 1
	end

	if not MultiBoxHeal.Track then MultiBoxHeal.Track = {} end
	
	for i = 1, 40 do
		MultiBoxHeal.Track["raid"..i] = {}
		MultiBoxHeal.Track["raid"..i].ExtRange = nil
		MultiBoxHeal.Track["raid"..i].LOS = nil
		MultiBoxHeal.Track["raid"..i].Heal = nil
		MultiBoxHeal.Track["raid"..i].HealTime = nil
		MultiBoxHeal.Track["raid"..i].HealName = nil
	end
	
	for i = 1, 4 do
		MultiBoxHeal.Track["party"..i] = {}
		MultiBoxHeal.Track["party"..i].ExtRange = nil
		MultiBoxHeal.Track["party"..i].LOS = nil
		MultiBoxHeal.Track["party"..i].Heal = nil
		MultiBoxHeal.Track["party"..i].HealTime = nil
		MultiBoxHeal.Track["party"..i].HealName = nil
	end
	
	MultiBoxHeal.Track["player"] = {}
	MultiBoxHeal.Track["player"].Heal = nil
	MultiBoxHeal.Track["player"].HealTime = nil
	MultiBoxHeal.Track["player"].HealName = nil
end

function MBH_ClearData(elapsed)
	Session.Elapsed = elapsed
	
	for i = 1, Session.MaxData do
		MultiBoxHeal.GroupData[i].HealthDeficite = 0
		MultiBoxHeal.GroupData[i].UnitID = ""
		MultiBoxHeal.GroupData[i].UnitRange = nil
		MultiBoxHeal.GroupData[i].ExtRange = false
		MultiBoxHeal.GroupData[i].Visible = nil
		MultiBoxHeal.GroupData[i].HealValue = 1	
	end
end

function MBH_UpdateData()
	Session.I = 1
	
	if Session.Group[1] == 3 or Session.Group[1] == 2 then -- We are in raid or party
		for i = 1, Session.Group[2] do -- Members

			MultiBoxHeal.GroupData[Session.I].UnitID = Session.Group[3]..Session.I
			MultiBoxHeal.GroupData[Session.I].HealthDeficite = UnitHealthMax(MultiBoxHeal.GroupData[Session.I].UnitID)-UnitHealth(MultiBoxHeal.GroupData[Session.I].UnitID)
			MultiBoxHeal.GroupData[Session.I].UnitRange = CheckInteractDistance(MultiBoxHeal.GroupData[Session.I].UnitID, 4)
			MultiBoxHeal.GroupData[Session.I].Visible = UnitIsVisible(MultiBoxHeal.GroupData[Session.I].UnitID) and UnitIsConnected(MultiBoxHeal.GroupData[Session.I].UnitID) and not UnitIsGhost(MultiBoxHeal.GroupData[Session.I].UnitID) and not UnitIsDead(MultiBoxHeal.GroupData[Session.I].UnitID) and not UnitIsEnemy(MultiBoxHeal.GroupData[Session.I].UnitID,"player") and not UnitCanAttack("player",MultiBoxHeal.GroupData[Session.I].UnitID)

			-- Extended Range
			if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].ExtRange then
				MultiBoxHeal.GroupData[Session.I].ExtRange = true
			else 
				MultiBoxHeal.GroupData[Session.I].ExtRange = nil 
			end
			
			-- LOS
			if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS then
				if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS > 0 then 
					MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS = MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS - Session.Elapsed
				else 
					MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS = nil 
				end 
			end
			
			-- Healcomm
			if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime then 
				if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime > 0 then 
					MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime = MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime - Session.Elapsed
					MultiBoxHeal.GroupData[Session.I].HealValue = (UnitHealth(MultiBoxHeal.GroupData[Session.I].UnitID)+MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].Heal)/UnitHealthMax(MultiBoxHeal.GroupData[Session.I].UnitID)
					if MultiBoxHeal.GroupData[Session.I].HealValue > 1 then 
						MultiBoxHeal.GroupData[Session.I].HealValue = 1 
					end
				else 
					MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].Heal = nil
					MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime = nil
					MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealName = nil
				end
			end
			
			Session.I = Session.I + 1
		end
	end
	
	if Session.Group[1] == 2 or Session.Group[1] == 1 then -- Add player

		MultiBoxHeal.GroupData[Session.I].UnitID = "player"
		MultiBoxHeal.GroupData[Session.I].HealthDeficite = UnitHealthMax(MultiBoxHeal.GroupData[Session.I].UnitID)-UnitHealth(MultiBoxHeal.GroupData[Session.I].UnitID)
		MultiBoxHeal.GroupData[Session.I].UnitRange = CheckInteractDistance(MultiBoxHeal.GroupData[Session.I].UnitID, 4)
		MultiBoxHeal.GroupData[Session.I].Visible = true
		
		-- Extended Range
		MultiBoxHeal.GroupData[Session.I].ExtRange = true
		
		-- LOS
		if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS then
			if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS > 0 then 
				MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS = MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS - Session.Elapsed
			else 
				MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].LOS = nil 
			end 
		end
		
		-- Healcomm
		if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime then 
			if MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime > 0 then 
				MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime = MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime - Session.Elapsed
				MultiBoxHeal.GroupData[Session.I].HealValue = (UnitHealth(MultiBoxHeal.GroupData[Session.I].UnitID)+MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].Heal)/UnitHealthMax(MultiBoxHeal.GroupData[Session.I].UnitID)
				if MultiBoxHeal.GroupData[Session.I].HealValue > 1 then 
					MultiBoxHeal.GroupData[Session.I].HealValue = 1 
				end
			else 
				MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].Heal = nil
				MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealTime = nil
				MultiBoxHeal.Track[MultiBoxHeal.GroupData[Session.I].UnitID].HealName = nil
			end
		end
		
		Session.I = Session.I + 1
	end
	
	table.sort(MultiBoxHeal.GroupData, function(a, b) return a.HealthDeficite > b.HealthDeficite end)
	Session.Autoheal.SortBuffer = MultiBoxHeal.GroupData
end

function MBH_GetHealUnitID(SpellName)

	local CastTime = Session.CastTime[SpellName]

	if MoronBoxHeal_Options.AutoHeal.Smart_Heal and CastTime then
		
		for i = 1, Session.MaxData do	
			if Session.Autoheal.SortBuffer[i].Visible and (Session.Autoheal.SortBuffer[i].UnitRange or Session.Autoheal.SortBuffer[i].ExtRange) and not MultiBoxHeal.Track[Session.Autoheal.SortBuffer[i].UnitID].LOS then
				if not MultiBoxHeal.Track[Session.Autoheal.SortBuffer[i].UnitID].HealTime then 
					return Session.Autoheal.SortBuffer[i].UnitID
				elseif MultiBoxHeal.Track[Session.Autoheal.SortBuffer[i].UnitID].HealTime and CastTime < MultiBoxHeal.Track[Session.Autoheal.SortBuffer[i].UnitID].HealTime then 
					return Session.Autoheal.SortBuffer[i].UnitID
				end
			end
		end
		
		for i = 1, Session.MaxData do
			if Session.Autoheal.SortBuffer[i].Visible and (Session.Autoheal.SortBuffer[i].UnitRange or Session.Autoheal.SortBuffer[i].ExtRange) and not MultiBoxHeal.Track[Session.Autoheal.SortBuffer[i].UnitID].LOS then
				return Session.Autoheal.SortBuffer[i].UnitID
			end
		end
		
	else
		local RandomTarget = MoronBoxHeal_Options.AutoHeal.Heal_Target_Number

		if MoronBoxHeal_Options.AutoHeal.Random_Target then
			RandomTarget = random(5)
		end
		
		for i = RandomTarget, Session.MaxData do
			if Session.Autoheal.SortBuffer[i].Visible and (Session.Autoheal.SortBuffer[i].UnitRange or Session.Autoheal.SortBuffer[i].ExtRange) and not MultiBoxHeal.Track[Session.Autoheal.SortBuffer[i].UnitID].LOS then
				return Session.Autoheal.SortBuffer[i].UnitID
			end
		end
	end
	return nil	
end