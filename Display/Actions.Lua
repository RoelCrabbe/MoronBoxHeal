-------------------------------------------------------------------------------
-- Slicers {{{
-------------------------------------------------------------------------------

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

function MBH_ValidateLAR(FrameHAR, Value)
    local LARValue = tonumber(this:GetText())
    local HARValue = tonumber(FrameHAR:GetText())

    if ( LARValue and LARValue >= 1 ) then
        if ( HARValue and LARValue <= HARValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_LAR"] = LARValue
        end
    end

    this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_LAR"])
end

function MBH_ValidateHAR(FrameLAR, MaxRank, Value)
    local HARValue = tonumber(this:GetText())
    local LARValue = tonumber(FrameLAR:GetText())

    if ( HARValue and HARValue >= 1 ) then
        if ( HARValue <= MaxRank ) and ( LARValue and HARValue >= LARValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"] = HARValue
        else
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"] = MaxRank
        end
    end

    this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"])
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

function MBH_ResetFramePosition(Frame)
    if not Frame then return end

    Frame:ClearAllPoints()
    Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    Frame:Hide()
end

-- Slicer
    -- Options
    function OverHealHealSlider_OnValueChanged()
        MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage, MBH_ALLOWEDOVERHEAL)
    end

    function HealTargetSlider_OnValueChanged()
        MoronBoxHeal_Options.AutoHeal.Heal_Target_Number = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.AutoHeal.Heal_Target_Number, MBH_HEALTARGETNUMBER)
    end

    function ExtendedRangeFrequencySlider_OnValueChanged()
        MoronBoxHeal_Options.ExtendedRange.Frequency = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ExtendedRange.Frequency, MBH_EXTENDEDRANGEFREQUENCY)
    end

    function LightOfSightFrequencySlider_OnValueChanged()
        MoronBoxHeal_Options.LineOfSight.TimeOut = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.LineOfSight.TimeOut, MBH_LINEOFSIGHTFREQUENCY)
    end

    function IdleProtectionFrequencySlider_OnValueChanged()
        MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Frequency = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Frequency, MBH_IDLEPROTECTIONFREQUENCY)
    end

    -- Mana Protection
    function FlashHealThresholdSlider__OnValueChanged()
        MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold, MBH_FLASHHEALPROTECTIONTHRESHOLD)
    end

    function HealThresholdSlider_OnValueChanged()
        MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold, MBH_HEALPROTECTIONTHRESHOLD)
    end

    function GreaterHealThresholdSlider_OnValueChanged()
        MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold, MBH_GREATERHEALPROTECTIONTHRESHOLD)
    end

    function ChainHealThresholdSlider_OnValueChanged()
        MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold, MBH_CHAINHEALPROTECTIONTHRESHOLD)
    end

    function LesserHealingWaveThresholdSlider_OnValueChanged()
        MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold, MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD)
    end

    function HolyLightThresholdSlider_OnValueChanged()
        MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold, MBH_HOLYLIGHTPROTECTIONTHRESHOLD)
    end

    function RegrowthThresholdSlider_OnValueChanged()
        MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold = this:GetValue()
        MBH_SliderValueChanged(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold, MBH_REGROWTHPROTECTIONTHRESHOLD)
    end