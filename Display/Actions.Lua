-------------------------------------------------------------------------------
-- Slicer Actions {{{
-------------------------------------------------------------------------------

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

function LineOfSightFrequencySlider_OnValueChanged()
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