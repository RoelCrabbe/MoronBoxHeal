function MBH_AllowedOverhealPercentageSlider_OnShow()

	local Frame = MoronBoxHealOptionFrameAllowedOverhealSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_ALLOWEDOVERHEAL, "$p", MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_AllowedOverhealPercentageSlider_OnValueChanged()
    MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_ALLOWEDOVERHEAL, "$p", MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_HealTargetNumberSlider_OnShow()

	local Frame = MoronBoxHealOptionFrameHealTargetNumberSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_HEALTARGETNUMBER, "$p", MoronBoxHeal_Options.AutoHeal.Heal_Target_Number))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 5)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AutoHeal.Heal_Target_Number)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("5")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 8, 0)
end

function MBH_HealTargetNumberSlider_OnValueChanged()
    MoronBoxHeal_Options.AutoHeal.Heal_Target_Number = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_HEALTARGETNUMBER, "$p", MoronBoxHeal_Options.AutoHeal.Heal_Target_Number))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_ExtendedRangeFrequencySlider_OnShow()

	local Frame = MoronBoxHealOptionExtendedRangeSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_EXTENDEDRANGEFREQUENCY, "$p", MoronBoxHeal_Options.ExtendedRange.Frequency))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 5)
    Frame:SetValueStep(0.25)
    Frame:SetValue(MoronBoxHeal_Options.ExtendedRange.Frequency)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("5")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 8, 0)
end

function MBH_ExtendedRangeFrequencySlider_OnValueChanged()
    MoronBoxHeal_Options.ExtendedRange.Frequency = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_EXTENDEDRANGEFREQUENCY, "$p", MoronBoxHeal_Options.ExtendedRange.Frequency))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_LineOfSightTimeOutSlider_OnShow()

	local Frame = MoronBoxHealOptionLineOfSightSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_LINEOFSIGHTFREQUENCY, "$p", MoronBoxHeal_Options.LineOfSight.TimeOut))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(0.5, 5)
    Frame:SetValueStep(0.25)
    Frame:SetValue(MoronBoxHeal_Options.LineOfSight.TimeOut)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("0.5")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -10, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("5")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 8, 0)
end

function MBH_LineOfSightTimeOutSlider_OnValueChanged()
    MoronBoxHeal_Options.LineOfSight.TimeOut = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_LINEOFSIGHTFREQUENCY, "$p", MoronBoxHeal_Options.LineOfSight.TimeOut))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_FlashHealProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealFlashHealProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_FLASHHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_Threshold)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_FlashHealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_FLASHHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_HealProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealHealProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_HEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AdvancedOptions.Heal_Threshold)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_HealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.AdvancedOptions.Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_HEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_GreaterHealProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealGreaterHealProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_GREATERHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_Threshold)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_GreaterHealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_GREATERHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_ChainHealProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealChainHealProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_CHAINHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_Threshold)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_ChainHealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_CHAINHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_LesserHealingWaveProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealLesserHealingWaveProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_Threshold)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_LesserHealingWaveProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_ValidateFlashHealInputLAR()
    local larValue = tonumber(this:GetText())
    local harValue = tonumber(MoronBoxHealFlashHealProtectionhresholdHAR:GetText())

    if ( larValue ) then
        if ( harValue and larValue <= harValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_LAR = larValue
        end

        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_LAR)
    end
end

function MBH_ValidateFlashHealInputHAR()
    local harValue = tonumber(this:GetText())
    local larValue = tonumber(MoronBoxHealFlashHealProtectionhresholdLAR:GetText())
    local maxRank = MBH_GetMaxSpellRank("Heal")

    if ( harValue ) then
        if ( harValue <= maxRank ) and ( larValue and harValue >= larValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_HAR = harValue
        else
            MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_HAR = maxRank
        end

        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Flash_Heal_HAR)
    end
end

function MBH_ValidateHealInputLAR()
    local larValue = tonumber(this:GetText())
    local harValue = tonumber(MoronBoxHealHealProtectionhresholdHAR:GetText())

    if ( larValue ) then
        if ( harValue and larValue <= harValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Heal_LAR = larValue
        end
        
        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Heal_LAR)
    end
end

function MBH_ValidateHealInputHAR()
    local harValue = tonumber(this:GetText())
    local larValue = tonumber(MoronBoxHealHealProtectionhresholdLAR:GetText())
    local maxRank = MBH_GetMaxSpellRank("Lesser Heal")

    if ( harValue ) then
        if ( harValue <= maxRank ) and ( larValue and harValue >= larValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Heal_HAR = harValue
        else
            MoronBoxHeal_Options.AdvancedOptions.Heal_HAR = maxRank
        end

        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Heal_HAR)
    end
end

function MBH_ValidateGreaterHealInputLAR()
    local larValue = tonumber(this:GetText())
    local harValue = tonumber(MoronBoxHealHealProtectionhresholdHAR:GetText())

    if ( larValue ) then
        if ( harValue and larValue <= harValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_LAR = larValue
        end
        
        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_LAR)
    end
end

function MBH_ValidateGreaterHealInputHAR()
    local harValue = tonumber(this:GetText())
    local larValue = tonumber(MoronBoxHealGreaterHealProtectionhresholdLAR:GetText())
    local maxRank = MBH_GetMaxSpellRank("Heal")

    if ( harValue ) then
        if ( harValue <= maxRank ) and ( larValue and harValue >= larValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_HAR = harValue
        else
            MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_HAR = maxRank
        end

        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Greater_Heal_HAR)
    end
end

function MBH_ValidateChainHealInputLAR()
    local larValue = tonumber(this:GetText())
    local harValue = tonumber(MoronBoxHealChainHealProtectionhresholdHAR:GetText())

    if ( larValue ) then
        if ( harValue and larValue <= harValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_LAR = larValue
        end
        
        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_LAR)
    end
end

function MBH_ValidateChainHealInputHAR()
    local harValue = tonumber(this:GetText())
    local larValue = tonumber(MoronBoxHealChainHealProtectionhresholdLAR:GetText())
    local maxRank = MBH_GetMaxSpellRank("Healing Wave")

    if ( harValue ) then
        if ( harValue <= maxRank ) and ( larValue and harValue >= larValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_HAR = harValue
        else
            MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_HAR = maxRank
        end

        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Chain_Heal_HAR)
    end
end

function MBH_ValidateLesserHealingWaveInputLAR()
    local larValue = tonumber(this:GetText())
    local harValue = tonumber(MoronBoxHealLesserHealingWaveProtectionhresholdHAR:GetText())

    if ( larValue ) then
        if ( harValue and larValue <= harValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_LAR = larValue
        end
        
        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_LAR)
    end
end

function MBH_ValidateLesserHealingWaveInputHAR()
    local harValue = tonumber(this:GetText())
    local larValue = tonumber(MoronBoxHealLesserHealingWaveProtectionhresholdLAR:GetText())
    local maxRank = MBH_GetMaxSpellRank("Healing Wave")

    if ( harValue ) then
        if ( harValue <= maxRank ) and ( larValue and harValue >= larValue ) then
            MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_HAR = harValue
        else
            MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_HAR = maxRank
        end

        this:SetText(MoronBoxHeal_Options.AdvancedOptions.Lesser_Healing_Wave_HAR)
    end
end