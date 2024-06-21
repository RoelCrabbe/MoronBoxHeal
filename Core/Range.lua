-------------------------------------------------------------------------------
-- Healing Range / Calculating
-------------------------------------------------------------------------------

function MBH_getHealSpell()

	local spellNames = {
		"Holy Light", 
		"Flash of Light",
		"Healing Wave",
		"Lesser Healing Wave",
		"Chain Heal",
		"Lesser Heal",
		"Heal",
		"Flash Heal",
		"Greater Heal",
		"Renew",
		"Healing Touch",
		"Regrowth",
	}

	Session.HealSpell = nil

	for i = 1, 120 do

		ScanningTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		ScanningTooltip:SetAction(i)

		if ScanningTooltipTextLeft1:GetText() == spellNames[1] or ScanningTooltipTextLeft1:GetText() == spellNames[2] or ScanningTooltipTextLeft1:GetText() == spellNames[3] or ScanningTooltipTextLeft1:GetText() == spellNames[4] or ScanningTooltipTextLeft1:GetText() == spellNames[5] or ScanningTooltipTextLeft1:GetText() == spellNames[6] or ScanningTooltipTextLeft1:GetText() == spellNames[7] or ScanningTooltipTextLeft1:GetText() == spellNames[8] or ScanningTooltipTextLeft1:GetText() == spellNames[3] or ScanningTooltipTextLeft1:GetText() == spellNames[10] or ScanningTooltipTextLeft1:GetText() == spellNames[11] or ScanningTooltipTextLeft1:GetText() == spellNames[12] or ScanningTooltipTextLeft1:GetText() == spellNames[13] then
			Session.HealSpell = i
			break 
		end
	end
end

function MBH_UpdateRange()
	local TargetCache

    Session.ExtendedRange.Time = Session.ExtendedRange.Time + Session.Elapsed
	if Session.ExtendedRange.Time >= MoronBoxHeal_Options.ExtendedRange.Frequency and Session.HealSpell then
		
        Session.ExtendedRange.Time = 0
        Session.ExtendedRange.OpenedFrames = nil
		
		for i = 1, 40 do
			MultiBoxHeal.Track["raid"..i].ExtRange = true
		end

		for i = 1, 4 do
			MultiBoxHeal.Track["party"..i].ExtRange = true
		end

		if Session.InCombat then 
			if UnitName("target") then
				TargetCache = UnitName("target")
			end
			ClearTarget()
        end
		
		if Session.InCombat and not UnitIsEnemy("player", "target") then
			Session.ExtendedRange.OpenedFrames = (InspectFrame and InspectFrame:IsVisible()) or (LootFrame and LootFrame:IsVisible()) or (XLootFrame and XLootFrame:IsVisible()) or (TradeFrame and TradeFrame:IsVisible()) 
			
			Session.ExtendedRange.UnitName = UnitName("target")

			MBH_DisableTargetEvents()

			for i = 1, Session.MaxData do
                
				if MultiBoxHeal.GroupData[i].UnitID == UNKNOWNOBJECT or MultiBoxHeal.GroupData[i].UnitID == UKNOWNBEING or not MultiBoxHeal.GroupData[i].UnitID then
					return
				end

				if MultiBoxHeal.GroupData[i].Visible and not MultiBoxHeal.GroupData[i].UnitRange and not UnitIsUnit("target", MultiBoxHeal.GroupData[i].UnitID) and not UnitIsUnit("player", MultiBoxHeal.GroupData[i].UnitID) and not Session.ExtendedRange.OpenedFrames then
					
					TargetUnit(MultiBoxHeal.GroupData[i].UnitID)
					
					if IsActionInRange(Session.HealSpell) then
						MultiBoxHeal.Track[MultiBoxHeal.GroupData[i].UnitID].ExtRange = true
					end

				elseif UnitIsUnit("target", MultiBoxHeal.GroupData[i].UnitID) and not UnitIsUnit("player", "target") then
					
					if IsActionInRange(Session.HealSpell) then
						MultiBoxHeal.Track[MultiBoxHeal.GroupData[i].UnitID].ExtRange = true
					end
				end
			end

			ClearTarget()

			if TargetCache then
				TargetByName(TargetCache)
			end

			MBH_EnableTargetEvents()

			if Session.ExtendedRange.UnitName then
                TargetByName(Session.ExtendedRange.UnitName, true)
            end
		end
	end
end

