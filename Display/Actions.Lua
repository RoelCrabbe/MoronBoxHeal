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
    MBH_InitializeSlider(Frame, MBH_ALLOWEDOVERHEAL, "AutoHeal", "Allowed_Overheal_Percentage")
end

function MBH_HealTargetNumberSlider_OnShow()
    local Frame = MoronBoxHealOptionFrameHealTargetNumberSlider
    MBH_InitializeSlider(Frame, MBH_HEALTARGETNUMBER, "AutoHeal", "Heal_Target_Number", 1, 5, 1)
end

function MBH_ExtendedRangeFrequencySlider_OnShow()
    local Frame = MoronBoxHealOptionExtendedRangeSlider
    MBH_InitializeSlider(Frame, MBH_EXTENDEDRANGEFREQUENCY, "ExtendedRange", "Frequency", 1, 5, 0.25)
end

function MBH_LineOfSightTimeOutSlider_OnShow()
    local Frame = MoronBoxHealOptionLineOfSightSlider
    MBH_InitializeSlider(Frame, MBH_LINEOFSIGHTFREQUENCY, "LineOfSight", "TimeOut", 0.5, 5, 0.25)
end

function MBH_FlashHealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealFlashHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_FLASHHEALPROTECTIONTHRESHOLD, "ManaProtectionValues", "Flash_Heal_Threshold")
end

function MBH_HealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_HEALPROTECTIONTHRESHOLD, "ManaProtectionValues", "Heal_Threshold")
end

function MBH_GreaterHealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealGreaterHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_GREATERHEALPROTECTIONTHRESHOLD, "ManaProtectionValues", "Greater_Heal_Threshold")
end

function MBH_ChainHealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealChainHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_CHAINHEALPROTECTIONTHRESHOLD, "ManaProtectionValues", "Chain_Heal_Threshold")
end

function MBH_LesserHealingWaveProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealLesserHealingWaveProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, "ManaProtectionValues", "Lesser_Healing_Wave_Threshold")
end

function MBH_HolyLightProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealHolyLightProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_HOLYLIGHTPROTECTIONTHRESHOLD, "ManaProtectionValues", "Holy_Light_Threshold")
end

function MBH_RegrowthProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealRegrowthProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_REGROWTHPROTECTIONTHRESHOLD, "ManaProtectionValues", "Regrowth_Threshold")
end

function MBH_AllowedOverhealPercentageSlider_OnValueChanged()
    MBH_SliderValueChanged("AutoHeal", "Allowed_Overheal_Percentage", MBH_ALLOWEDOVERHEAL)
end

function MBH_HealTargetNumberSlider_OnValueChanged()
    MBH_SliderValueChanged("AutoHeal", "Heal_Target_Number", MBH_HEALTARGETNUMBER)
end

function MBH_ExtendedRangeFrequencySlider_OnValueChanged()
    MBH_SliderValueChanged("ExtendedRange", "Frequency", MBH_EXTENDEDRANGEFREQUENCY)
end

function MBH_LineOfSightTimeOutSlider_OnValueChanged()
    MBH_SliderValueChanged("LineOfSight", "TimeOut", MBH_LINEOFSIGHTFREQUENCY)
end

function MBH_FlashHealProtectionThresholdSlider_OnValueChanged()
    MBH_SliderValueChanged("ManaProtectionValues", "Flash_Heal_Threshold", MBH_FLASHHEALPROTECTIONTHRESHOLD)
end

function MBH_HealProtectionThresholdSlider_OnValueChanged()
    MBH_SliderValueChanged("ManaProtectionValues", "Heal_Threshold", MBH_HEALPROTECTIONTHRESHOLD)
end

function MBH_GreaterHealProtectionThresholdSlider_OnValueChanged()
    MBH_SliderValueChanged("ManaProtectionValues", "Greater_Heal_Threshold", MBH_GREATERHEALPROTECTIONTHRESHOLD)
end

function MBH_ChainHealProtectionThresholdSlider_OnValueChanged()
    MBH_SliderValueChanged("ManaProtectionValues", "Chain_Heal_Threshold", MBH_CHAINHEALPROTECTIONTHRESHOLD)
end

function MBH_LesserHealingWaveProtectionThresholdSlider_OnValueChanged()
    MBH_SliderValueChanged("ManaProtectionValues", "Lesser_Healing_Wave_Threshold", MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD)
end

function MBH_HolyLightProtectionThresholdSlider_OnValueChanged()
    MBH_SliderValueChanged("ManaProtectionValues", "Holy_Light_Threshold", MBH_HOLYLIGHTPROTECTIONTHRESHOLD)
end

function MBH_RegrowthProtectionThresholdSlider_OnValueChanged()
    MBH_SliderValueChanged("ManaProtectionValues", "Regrowth", MBH_REGROWTHPROTECTIONTHRESHOLD)
end

function MBH_InitializeSlider(Frame, String, Category, Value, MinStep, MaxStep, ValStep)
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(String, "$p", MoronBoxHeal_Options[Category][Value]))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    MinStep = MinStep or 1
    MaxStep = MaxStep or 100

    Frame:SetMinMaxValues(MinStep, MaxStep)
    Frame:SetValueStep(ValStep or 1)
    Frame:SetValue(MoronBoxHeal_Options[Category][Value])

    getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

    local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText(MinStep)
    minValueText:SetPoint("CENTER", Frame, "LEFT", -10, 0)

    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText(MaxStep)
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
end

function MBH_SliderValueChanged(Category, Value, String)
    MoronBoxHeal_Options[Category][Value] = this:GetValue()
    getglobal(this:GetName().."Text"):SetText(string.gsub(String, "$p", MoronBoxHeal_Options[Category][Value]))
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

function MBH_ValidateLAR(FrameHAR, Value)
    local larValue = tonumber(this:GetText())
    local harValue = tonumber(FrameHAR:GetText())

    if ( larValue and larValue >= 1) then
        if ( harValue and larValue >= harValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Value .. "_LAR"] = larValue
        end
        
        this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Value .. "_LAR"])
    end
end

function MBH_ValidateHAR(FrameLAR, MaxRank, Value)
    local harValue = tonumber(this:GetText())
    local larValue = tonumber(FrameLAR:GetText())

    if ( harValue ) then
        if ( harValue <= MaxRank ) and ( larValue and harValue >= larValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Value .. "_HAR"] = harValue
        else
            MoronBoxHeal_Options.ManaProtectionValues[Value .. "_HAR"] = MaxRank
        end

        this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Value .. "_HAR"])
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