-------------------------------------------------------------------------------
-- Healing Range / Calculating
-------------------------------------------------------------------------------

function MBH_GetHealSpell()

	MBH.Session.HealSpell = nil

	for i = 1, 120 do

		MBH.ScanningTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		MBH.ScanningTooltip:SetAction(i)

		for SPN, Time in pairs(MBH.Session.CastTime) do
			if tooltipText == SPN then
				MBH.Session.HealSpell = i
				break
			end
		end
	end
end

function MBH_UpdateRange()
	local TargetCache

    MBH.Session.ExtendedRange.Time = MBH.Session.ExtendedRange.Time + MBH.Session.Elapsed
	if MBH.Session.ExtendedRange.Time >= MoronBoxHeal_Options.ExtendedRange.Frequency and MBH.Session.HealSpell then
		
        MBH.Session.ExtendedRange.Time = 0
        MBH.Session.ExtendedRange.OpenedFrames = nil
		
		for i = 1, 40 do
			MBH.Track["raid"..i].ExtRange = true
		end

		for i = 1, 4 do
			MBH.Track["party"..i].ExtRange = true
		end

		if MBH.Session.InCombat then 
			if UnitName("target") then
				TargetCache = UnitName("target")
			end
			ClearTarget()
        end
		
		if MBH.Session.InCombat and not UnitIsEnemy("player", "target") then
			MBH.Session.ExtendedRange.OpenedFrames = (InspectFrame and InspectFrame:IsVisible()) or (LootFrame and LootFrame:IsVisible()) or (XLootFrame and XLootFrame:IsVisible()) or (TradeFrame and TradeFrame:IsVisible()) 
			
			MBH.Session.ExtendedRange.UnitName = UnitName("target")

			MBH_DisableTargetEvents()

			for i = 1, MBH.Session.MaxData do
                
				if MBH.GroupData[i].UnitID == UNKNOWNOBJECT or MBH.GroupData[i].UnitID == UKNOWNBEING or not MBH.GroupData[i].UnitID then
					return
				end

				if MBH.GroupData[i].Visible and not MBH.GroupData[i].UnitRange and not UnitIsUnit("target", MBH.GroupData[i].UnitID) and not UnitIsUnit("player", MBH.GroupData[i].UnitID) and not MBH.Session.ExtendedRange.OpenedFrames then
					
					TargetUnit(MBH.GroupData[i].UnitID)
					
					if IsActionInRange(MBH.Session.HealSpell) then
						MBH.Track[MBH.GroupData[i].UnitID].ExtRange = true
					end

				elseif UnitIsUnit("target", MBH.GroupData[i].UnitID) and not UnitIsUnit("player", "target") then
					
					if IsActionInRange(MBH.Session.HealSpell) then
						MBH.Track[MBH.GroupData[i].UnitID].ExtRange = true
					end
				end
			end

			ClearTarget()

			if TargetCache then
				TargetByName(TargetCache)
			end

			MBH_EnableTargetEvents()

			if MBH.Session.ExtendedRange.UnitName then
                TargetByName(MBH.Session.ExtendedRange.UnitName, true)
            end
		end
	end
end

function MBH_DisableTargetEvents()
	for i = 1, 12 do
		getglobal("ActionButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarLeftButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarRightButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomLeftButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomRightButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("BonusActionButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
	end
end

function MBH_EnableTargetEvents()
	for i = 1, 12 do
		getglobal("ActionButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarLeftButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarRightButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomLeftButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomRightButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("BonusActionButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
	end
end