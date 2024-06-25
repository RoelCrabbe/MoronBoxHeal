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
    MBH_InitializeSlider(Frame, MBH_ALLOWEDOVERHEAL, MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage)
end

function MBH_AllowedOverhealPercentageSlider_OnValueChanged()
    MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage, MBH_ALLOWEDOVERHEAL)
end

function MBH_HealTargetNumberSlider_OnShow()
    local Frame = MoronBoxHealOptionFrameHealTargetNumberSlider
    MBH_InitializeSlider(Frame, MBH_HEALTARGETNUMBER, MoronBoxHeal_Options.AutoHeal.Heal_Target_Number, 1, 5, 1)
end

function MBH_HealTargetNumberSlider_OnValueChanged()
    MoronBoxHeal_Options.AutoHeal.Heal_Target_Number = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.AutoHeal.Heal_Target_Number, MBH_HEALTARGETNUMBER)
end

function MBH_ExtendedRangeFrequencySlider_OnShow()
    local Frame = MoronBoxHealOptionExtendedRangeSlider
    MBH_InitializeSlider(Frame, MBH_EXTENDEDRANGEFREQUENCY, MoronBoxHeal_Options.ExtendedRange.Frequency, 1, 5, 0.25)
end

function MBH_ExtendedRangeFrequencySlider_OnValueChanged()
    MoronBoxHeal_Options.ExtendedRange.Frequency = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ExtendedRange.Frequency, MBH_EXTENDEDRANGEFREQUENCY)
end

function MBH_LineOfSightTimeOutSlider_OnShow()
    local Frame = MoronBoxHealOptionLineOfSightSlider
    MBH_InitializeSlider(Frame, MBH_LINEOFSIGHTFREQUENCY, MoronBoxHeal_Options.LineOfSight.TimeOut, 0.5, 5, 0.25)
end

function MBH_LineOfSightTimeOutSlider_OnValueChanged()
    MoronBoxHeal_Options.LineOfSight.TimeOut = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.LineOfSight.TimeOut, MBH_LINEOFSIGHTFREQUENCY)
end

function MBH_FlashHealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealFlashHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_FLASHHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold)
end

function MBH_FlashHealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold, MBH_FLASHHEALPROTECTIONTHRESHOLD)
end

function MBH_HealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_HEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold)
end

function MBH_HealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold, MBH_HEALPROTECTIONTHRESHOLD)
end

function MBH_GreaterHealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealGreaterHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_GREATERHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold)
end

function MBH_GreaterHealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold, MBH_GREATERHEALPROTECTIONTHRESHOLD)
end

function MBH_ChainHealProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealChainHealProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_CHAINHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold)
end

function MBH_ChainHealProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Chain_Heal_Threshold = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold, MBH_CHAINHEALPROTECTIONTHRESHOLD)
end

function MBH_LesserHealingWaveProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealLesserHealingWaveProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold)
end

function MBH_LesserHealingWaveProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold, MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD)
end

function MBH_HolyLightProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealHolyLightProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_HOLYLIGHTPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold)
end

function MBH_HolyLightProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold, MBH_HOLYLIGHTPROTECTIONTHRESHOLD)
end

function MBH_RegrowthProtectionThresholdSlider_OnShow()
    local Frame = MoronBoxHealRegrowthProtectionhresholdSlider
    MBH_InitializeSlider(Frame, MBH_REGROWTHPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold)
end

function MBH_RegrowthProtectionThresholdSlider_OnValueChanged()
    MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold = this:GetValue()
    MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold, MBH_REGROWTHPROTECTIONTHRESHOLD)
end

function MBH_SliderValueChanged(Value, String)
    getglobal(this:GetName().."Text"):SetText(string.gsub(String, "$p", Value))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_InitializeSlider(Frame, String, Value, MinStep, MaxStep, ValStep)
    getglobal(Frame:GetName().."Text"):SetText(string.gsub(String, "$p", Value))
    getglobal(Frame:GetName().."Text"):SetPoint("BOTTOM", Frame, "TOP", 0, 5)

    MinStep = MinStep or 1
    MaxStep = MaxStep or 100

    Frame:SetMinMaxValues(MinStep, MaxStep)
    Frame:SetValueStep(ValStep or 1)
    Frame:SetValue(Value)

    getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

    local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText(MinStep)
    minValueText:SetPoint("CENTER", Frame, "LEFT", -10, 0)

    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText(MaxStep)
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
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
    local LARValue = tonumber(this:GetText())
    local HARValue = tonumber(FrameHAR:GetText())

    if ( LARValue and LARValue >= 1) then
        if ( HARValue and LARValue <= HARValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_LAR"] = LARValue
        end
        
        this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_LAR"])
    end
end

function MBH_ValidateHAR(FrameLAR, MaxRank, Value)
    local HARValue = tonumber(this:GetText())
    local LARValue = tonumber(FrameLAR:GetText())

    if ( HARValue ) then
        if ( HARValue <= MaxRank ) and ( LARValue and HARValue >= LARValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"] = HARValue
        else
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"] = MaxRank
        end

        this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"])
    end
end

-------------------------------------------------------------------------------
-- Helpers {{{
-------------------------------------------------------------------------------

function MBH_ProtectionSettingCheck(newVal)
    if ( Session.PlayerClass == "Priest" ) then
        MBH_PriestProtectionCheck(newVal)
    elseif ( Session.PlayerClass == "Shaman" ) then
        MBH_ShamanProtectionCheck(newVal)
    elseif ( Session.PlayerClass == "Paladin" ) then
        MBH_PaladinProtectionCheck(newVal)
    elseif ( Session.PlayerClass == "Druid" ) then
        MBH_DruidProtectionCheck(newVal)
    end
end

function MBH_PriestProtectionCheck(newVal)
    local FlashHealCheck = not MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch
    local HealCheck = not MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch
    local GreaterHealCheck = not MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch

    if ( MoronBoxHeal_Options.AdvancedOptions.Mana_Protection ) and ( FlashHealCheck and HealCheck and GreaterHealCheck ) then
        MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch = true
        MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch = true
        MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch = true
    end

    if ( FlashHealCheck and HealCheck and GreaterHealCheck ) then
        MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = newVal
    end
end

function MBH_ShamanProtectionCheck(newVal)
    local ChainHealCheck = not MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch
    local LesserHealingWaveCheck = not MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch

    if ( MoronBoxHeal_Options.AdvancedOptions.Mana_Protection ) and ( ChainHealCheck and LesserHealingWaveCheck ) then
        MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch = true
        MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch = true
    end

    if ( ChainHealCheck and LesserHealingWaveCheck ) then
        MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = newVal
    end
end

function MBH_PaladinProtectionCheck(newVal)
    local HolyLightCheck = not MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch

    if ( MoronBoxHeal_Options.AdvancedOptions.Mana_Protection ) and ( HolyLightCheck ) then
        MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch = true
    end

    if ( HolyLightCheck ) then
        MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = newVal
    end
end

function MBH_DruidProtectionCheck(newVal)
    local RegrowthCheck = not MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch

    if ( MoronBoxHeal_Options.AdvancedOptions.Mana_Protection ) and ( RegrowthCheck ) then
        MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch = true
    end

    if ( RegrowthCheck ) then
        MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = newVal
    end
end

function MBH_ResetAllWindow()
    MBH_ResetFramePosition(MoronBoxHealMainFrame)
    MBH_ResetFramePosition(MoronBoxHealOptionFrame)
    MBH_ResetFramePosition(MoronBoxHealProtectionFrame)
    MBH_RaceChangeMoronBoxHealProtectionFrame()
end

function MBH_ResetFramePosition(Frame)
    if not Frame then return end

    Frame:ClearAllPoints()
    Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    Frame:Hide()
end

function MBH_RaceChangeMoronBoxHealProtectionFrame()
    local isPriest = Session.PlayerClass == "Priest";
    local isShaman = Session.PlayerClass == "Shaman";
    local isPaladin = Session.PlayerClass == "Paladin";
    local isDruid = Session.PlayerClass == "Druid";

    MoronBoxHealProtectionFramePriestContainer:Hide()
    MoronBoxHealProtectionFrameShamanContainer:Hide()
    MoronBoxHealProtectionFramePaladinContainer:Hide()
    MoronBoxHealProtectionFrameDruidContainer:Hide()

    if ( isPriest ) then
        MoronBoxHealProtectionFramePriestContainer:Show()
    elseif ( isShaman ) then
        MoronBoxHealProtectionFrameShamanContainer:Show()
    elseif ( isPaladin ) then
        MoronBoxHealProtectionFramePaladinContainer:Show()
    elseif ( isDruid ) then
        MoronBoxHealProtectionFrameDruidContainer:Show()
    end
end

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

function MBH_UpdateCheckBox(Frame, Value)
	Frame:SetChecked(Value)
end

function MBH_UpdateInputField(Frame, Value)
	Frame:SetText(Value)
end