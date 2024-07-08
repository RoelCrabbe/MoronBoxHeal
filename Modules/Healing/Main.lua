-------------------------------------------------------------------------------
-- Local Variables {{{
-------------------------------------------------------------------------------

local ManaProtectionThresholds = {}

function MBH_InitializeManaProtectionThresholds()
    ManaProtectionThresholds = {
        [MBH_SPELL_FLASH_HEAL] = {
            ["ThresholdCheck"] = function() 
                return ( 
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch 
                )
            end,
            ["Spell"] = MBH_SPELL_HEAL,
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR,
        },
        [MBH_SPELL_HEAL] = {
            ["ThresholdCheck"] = function() 
                return ( 
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch 
                )
            end,
            ["Spell"] = MBH_SPELL_LESSER_HEAL,
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR,
        },
        [MBH_SPELL_GREATER_HEAL] = {
            ["ThresholdCheck"] = function() 
                return ( 
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch 
                )
            end,
            ["Spell"] = MBH_SPELL_HEAL,
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR,
        },
        [MBH_SPELL_CHAIN_HEAL] = {
            ["ThresholdCheck"] = function() 
                return ( 
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch
                )
            end,
            ["Spell"] = MBH_SPELL_HEALING_WAVE,
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_HAR,
        },
        [MBH_SPELL_LESSER_HEALING_WAVE] = {
            ["ThresholdCheck"] = function() 
                return (
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch
                )
            end,
            ["Spell"] = MBH_SPELL_HEALING_WAVE,
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR,
        },
        [MBH_SPELL_HOLY_LIGHT] = {
            ["ThresholdCheck"] = function() 
                return (
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch
                )
            end,
            ["Spell"] = MBH_SPELL_FLASH_OF_LIGHT,
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR,
        },
        [MBH_SPELL_REGROWTH] = {
            ["ThresholdCheck"] = function() 
                return (
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch
                )
            end,
            ["Spell"] = MBH_SPELL_HEALING_TOUCH,
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR,
        },
    }
end

-------------------------------------------------------------------------------
-- Core Code {{{
-------------------------------------------------------------------------------

function MBH_Cast(SPN, LAR, HAR)

	if MBH.Session.Autoheal.IsCasting and MBH.Session.Autoheal.UnitID then
        local OverHealVal = MBH.Session.Autoheal.OutgoingHeal * MBH_ConvertToFractionFromPercentage(MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage)

		if OverHealVal > mb_healthDown(MBH.Session.Autoheal.UnitID) then
			SpellStopCasting()
		end
	else
		local HealUnitID = MBH_GetHealUnitID(SPN)
		
		if HealUnitID then
			MBH.Session.Autoheal.UnitID = HealUnitID
			MBH.Session.CurrentUnit = HealUnitID

			MBH_CastSpell(SPN, LAR, HAR, MBH.Session.Autoheal.UnitID)
		end
	end
end

function MBH_CastSpell(SPN, LAR, HAR, UnitID)

    if UnitID == UNKNOWNOBJECT or UnitID == UKNOWNBEING then
        return
    end

    local Cache = {
        HealthDown = 0,
        Spell = nil,
        Rank = nil,
        DefaultSpell = SPN.."(Rank 1)"
    }

    Cache.Spell, Cache.Rank = MBH_ExtractSpell(Cache.DefaultSpell)

    if MBH.ACE.HealComm.Spells[Cache.Spell] then
        
        Cache.Rank, Cache.HealthDown = MBH_CalculateRank(Cache.Spell, LAR, HAR, UnitID)

        if Cache.HealthDown >= MBH.Session.Autoheal.CalculatedHeal then

            local Castable = Cache.Spell.."(Rank "..Cache.Rank..")"   

            if UnitCanAttack("player", UnitID) or (UnitExists("target") and not UnitCanAttack("player", "target") and not UnitIsUnit(UnitID, "target")) then
                ClearTarget()
            end

            CastSpellByName(Castable)

            if SpellIsTargeting() then
                SpellTargetUnit(UnitID)
            end

            if SpellIsTargeting() then
                SpellStopTargeting()
            end

            ClearTarget()
        end
    end
end

function MBH_CalculateRank(SPN, LAR, HAR, UnitID)

    if UnitID == UNKNOWNOBJECT or UnitID == UKNOWNBEING then
        return
    end

    local HealBonus = MBH.ACE.ItemBonus:GetBonus("HEAL")
    local MaxRank = MBH_GetMaxSpellRank(SPN)
	local HealthDown = mb_healthDown(UnitID)

    local TargetPower, TargetMod = MBH.ACE.HealComm:GetUnitSpellPower(UnitID, SPN)
    local BuffPower, BuffMod = MBH.ACE.HealComm:GetBuffSpellPower()

    HealBonus = HealBonus + BuffPower

    local CalculatedRank = 1
    local OutgoingHeal = 0
    local CalculatedHeal = 0

    if (SPN == MBH_SPELL_HEALING_TOUCH and MoronBoxHeal_Options.ManaProtectionValues.Druid.Only_Rank_3) then

        CalculatedRank = 3
        if mb_hasBuffOrDebuff("Nature's Grace", "player", "buff") then
            CalculatedRank = 4
        end
    else
        for i = MaxRank, 1, -1 do
            local HealOutput = ((MBH.ACE.HealComm.Spells[SPN][i](HealBonus) + TargetPower) * BuffMod * TargetMod)
            
            if HealOutput < HealthDown then
                if i < MaxRank then
                    CalculatedRank = i + 1
                    break
                else
                    CalculatedRank = i
                    break
                end
            end
        end

        if LAR then
            CalculatedRank = math.max(CalculatedRank, LAR)
        end

        if HAR then
            CalculatedRank = math.min(CalculatedRank, HAR)
        end
    end

    local CalculatedHealRank = (CalculatedRank > 1) and (CalculatedRank - 1) or 1
    OutgoingHeal = ((math.floor(MBH.ACE.HealComm.Spells[SPN][CalculatedRank](HealBonus)) + TargetPower) * BuffMod * TargetMod)
    CalculatedHeal = ((math.floor(MBH.ACE.HealComm.Spells[SPN][CalculatedHealRank](HealBonus)) + TargetPower) * BuffMod * TargetMod)
  
    MBH.Session.Autoheal.OutgoingHeal = OutgoingHeal
    MBH.Session.Autoheal.CalculatedHeal = CalculatedHeal
    return CalculatedRank, HealthDown
end

function MBH_ManaProtection(SPN, LAR, HAR)

    if not MoronBoxHeal_Options.AdvancedOptions.Mana_Protection then
        return SPN, LAR or 1, HAR or MBH_GetMaxSpellRank(SPN)
    end

    if not next(ManaProtectionThresholds) then
        MBH_InitializeManaProtectionThresholds()
    end

    local MPData = ManaProtectionThresholds[SPN]

    if MPData and MPData.ThresholdCheck() then
        SPN = MPData.Spell
        LAR = MPData.LAR or 1
        HAR = MPData.HAR or MBH_GetMaxSpellRank(SPN)
    else
        LAR = LAR or 1
        HAR = HAR or MBH_GetMaxSpellRank(SPN)
    end
    return SPN, LAR, HAR
end

function MBH_CastHeal(SPN, LAR, HAR)
    local MPH, MPLAR , MPHAR = MBH_ManaProtection(SPN, LAR, HAR)
    MBH.Session.SpellName = MPH
	if MBH.Session.CastTime[MBH.Session.SpellName] then
		MBH_Cast(MBH.Session.SpellName, MPLAR, MPHAR)
	end
end