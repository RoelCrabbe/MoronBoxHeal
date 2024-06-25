-------------------------------------------------------------------------------
-- MiniMap {{{
-------------------------------------------------------------------------------

function MBH_MoronBoxHealMiniMapButton_OnUpdate(self)
    if ( this.isMiniMapMoving ) then

        local xpos, ypos = GetCursorPosition()
        local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
        xpos = xmin - xpos / UIParent:GetScale() + 70
        ypos = ypos / UIParent:GetScale() - ymin - 70
        local iconPos = math.deg(math.atan2(ypos, xpos))

        if iconPos < 0 then
            iconPos = iconPos + 360
        end

        MoronBoxHealMiniMapButton:SetPoint(
            "TOPLEFT",
            "Minimap",
            "TOPLEFT",
            54 - (78 * cos(iconPos)),
            (78 * sin(iconPos)) - 55
        )
    end
end

-------------------------------------------------------------------------------
-- Slicers {{{
-------------------------------------------------------------------------------

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
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_FLASHHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Flash_Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.ManaProtectionValues.Flash_Heal_Threshold)

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
    MoronBoxHeal_Options.ManaProtectionValues.Flash_Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_FLASHHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Flash_Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_HealProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealHealProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_HEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.ManaProtectionValues.Heal_Threshold)

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
    MoronBoxHeal_Options.ManaProtectionValues.Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_HEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_GreaterHealProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealGreaterHealProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_GREATERHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Greater_Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.ManaProtectionValues.Greater_Heal_Threshold)

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
    MoronBoxHeal_Options.ManaProtectionValues.Greater_Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_GREATERHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Greater_Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_ChainHealProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealChainHealProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_CHAINHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Chain_Heal_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.ManaProtectionValues.Chain_Heal_Threshold)

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
    MoronBoxHeal_Options.ManaProtectionValues.Chain_Heal_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_CHAINHEALPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Chain_Heal_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_LesserHealingWaveProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealLesserHealingWaveProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Lesser_Healing_Wave_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.ManaProtectionValues.Lesser_Healing_Wave_Threshold)

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
    MoronBoxHeal_Options.ManaProtectionValues.Lesser_Healing_Wave_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Lesser_Healing_Wave_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_HolyLightProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealHolyLightProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_HOLYLIGHTPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Holy_Light_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.ManaProtectionValues.Holy_Light_Threshold)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_HolyLightProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Holy_Light_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_HOLYLIGHTPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Holy_Light_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_RegrowthProtectionThresholdSlider_OnShow()

	local Frame = MoronBoxHealRegrowthProtectionhresholdSlider
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(MBH_REGROWTHPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Regrowth_Threshold))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    Frame:SetMinMaxValues(1, 100)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.ManaProtectionValues.Regrowth_Threshold)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("100")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_RegrowthProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Regrowth_Threshold = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(MBH_REGROWTHPROTECTIONTHRESHOLD, "$p", MoronBoxHeal_Options.ManaProtectionValues.Regrowth_Threshold))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

-------------------------------------------------------------------------------
-- EditBox {{{
-------------------------------------------------------------------------------

function MBH_ValidateFlashHealInputLAR()
    MBH_ValidateLAR(MoronBoxHealFlashHealProtectionhresholdHAR, "Flash_Heal")
end

function MBH_ValidateFlashHealInputHAR()
    MBH_ValidateHAR(MoronBoxHealFlashHealProtectionhresholdLAR, MBH_GetMaxSpellRank("Heal"), "Flash_Heal")
end

function MBH_ValidateHealInputLAR()
    MBH_ValidateLAR(MoronBoxHealHealProtectionhresholdHAR, "Heal")
end

function MBH_ValidateHealInputHAR()
    MBH_ValidateHAR(MoronBoxHealFlashHealProtectionhresholdLAR, MBH_GetMaxSpellRank("Lesser Heal"), "Heal")
end

function MBH_ValidateGreaterHealInputLAR()
    MBH_ValidateLAR(MoronBoxHealHealProtectionhresholdHAR, "Greater_Heal")
end

function MBH_ValidateGreaterHealInputHAR()
    MBH_ValidateHAR(MoronBoxHealGreaterHealProtectionhresholdLAR, MBH_GetMaxSpellRank("Heal"), "Greater_Heal")
end

function MBH_ValidateChainHealInputLAR()
    MBH_ValidateLAR(MoronBoxHealChainHealProtectionhresholdHAR, "Chain_Heal")
end

function MBH_ValidateChainHealInputHAR()
    MBH_ValidateHAR(MoronBoxHealChainHealProtectionhresholdLAR, MBH_GetMaxSpellRank("Healing Wave"), "Chain_Heal")
end

function MBH_ValidateLesserHealingWaveInputLAR()
    MBH_ValidateLAR(MoronBoxHealLesserHealingWaveProtectionhresholdHAR, "Lesser_Healing_Wave")
end

function MBH_ValidateLesserHealingWaveInputHAR()
    MBH_ValidateHAR(MoronBoxHealLesserHealingWaveProtectionhresholdLAR, MBH_GetMaxSpellRank("Healing Wave"), "Lesser_Healing_Wave")
end

function MBH_ValidateHolyLightInputLAR()
    MBH_ValidateLAR(MoronBoxHealHolyLightProtectionhresholdHAR, "Holy_Light")
end

function MBH_ValidateHolyLightInputHAR()
    MBH_ValidateHAR(MoronBoxHealHolyLightProtectionhresholdLAR, MBH_GetMaxSpellRank("Flash of Light"), "Holy_Light")
end

function MBH_ValidateRegrowthInputLAR()
    MBH_ValidateLAR(MoronBoxHealRegrowthProtectionhresholdHAR, "Regrowth")
end

function MBH_ValidateRegrowthInputHAR()
    MBH_ValidateHAR(MoronBoxHealRegrowthProtectionhresholdLAR, MBH_GetMaxSpellRank("Healing Touch"), "Regrowth")
end

function MBH_ValidateLAR(harThresholdTextbox, spellName)
    local larValue = tonumber(this:GetText())
    local harValue = tonumber(harThresholdTextbox:GetText())

    if ( larValue and larValue >= 1) then
        if ( harValue and larValue >= harValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[spellName .. "_LAR"] = larValue
        end
        
        this:SetText(MoronBoxHeal_Options.ManaProtectionValues[spellName .. "_LAR"])
    end
end

function MBH_ValidateHAR(larThresholdTextbox, maxRank, spellName)
    local harValue = tonumber(this:GetText())
    local larValue = tonumber(larThresholdTextbox:GetText())

    if ( harValue ) then
        if ( harValue <= maxRank ) and ( larValue and harValue >= larValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[spellName .. "_HAR"] = harValue
        else
            MoronBoxHeal_Options.ManaProtectionValues[spellName .. "_HAR"] = maxRank
        end

        this:SetText(MoronBoxHeal_Options.ManaProtectionValues[spellName .. "_HAR"])
    end
end

-------------------------------------------------------------------------------
-- Helpers {{{
-------------------------------------------------------------------------------

function MBH_ShowFrameAndHideParent(Frame)

    local ParentUI = this:GetParent()

    if not (ParentUI and Frame) then return end

    if ( not Frame:IsShown() ) then
        MBH_ResetAllWindow()
        Frame:Show()
    end

    if ParentUI:GetName() == Frame:GetName() then
        return
    end

    ParentUI:Hide();
end

function MBH_SetBackdropColors(Name)

    if not Name then
        return
    end

    this:SetBackdropColor(GetColorValue(Name))
    this:SetBackdropBorderColor(GetColorValue(Name))
end

function MBH_IsFrameOnShowOrLeave(Frame)

    local ParentUI = this:GetParent()

    if not (ParentUI and Frame) then return end

    if ParentUI:GetName() == Frame:GetName() then

        MBH_SetBackdropColors("Blue600");
        return
    end

    MBH_SetBackdropColors("Gray600");
end

function MBH_IsFrameOnEnter(Frame)

    local ParentUI = this:GetParent()

    if not (ParentUI and Frame) then return end

    if ParentUI:GetName() == Frame:GetName() then

        MBH_SetBackdropColors("Blue500");
        return
    end

    MBH_SetBackdropColors("Gray400");
end

function MBH_SetFontSize(fontString, size)
    local font, _, flags = fontString:GetFont()
    fontString:SetFont(font, size, flags)
end