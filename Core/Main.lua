-------------------------------------------------------------------------------
-- InterFace Frames {{{
-------------------------------------------------------------------------------

MBH = CreateFrame("Frame", "MBH", UIParent)
MBH.ScanningTooltip = CreateFrame("GameTooltip", "MBH_ScanningTooltip", nil, "GameTooltipTemplate")

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
-- The Stored Variables {{{
-------------------------------------------------------------------------------

MBH.DefaultOptions = {
    AutoHeal = {
        Smart_Heal = true,
        Allowed_Overheal_Percentage = 11,
        Random_Target = false,
        Heal_Target_Number = 1
    },
    ExtendedRange = {
        Enable = true,
        Frequency = 5
    },
    LineOfSight = {
        Enable = true,
        TimeOut = 4
    },
    AdvancedOptions = {
        Mana_Protection = true,
        LagPrevention = {
            Enabled = false,
            Frequency = 1,
        },
    },
    ManaProtectionValues = {
        Priest = {
            Flash_Heal_Switch = true,
            Flash_Heal_Threshold = 20,
            Flash_Heal_LAR = 1,
            Flash_Heal_HAR = 4,
            Heal_Switch = true,
            Heal_Threshold = 5,
            Heal_LAR = 1,
            Heal_HAR = 3,
            Greater_Heal_Switch = true,
            Greater_Heal_Threshold = 50,
            Greater_Heal_LAR = 1,
            Greater_Heal_HAR = 4
        },
        Shaman = {
            Chain_Heal_Switch = true,
            Chain_Heal_Threshold = 20,
            Chain_Heal_LAR = 1,
            Chain_Heal_HAR = 10,
            Lesser_Healing_Wave_Switch = true,
            Lesser_Healing_Wave_Threshold = 35,
            Lesser_Healing_Wave_LAR = 1,
            Lesser_Healing_Wave_HAR = 10
        },
        Paladin = {
            Holy_Light_Switch = true,
            Holy_Light_Threshold = 35,
            Holy_Light_LAR = 1,
            Holy_Light_HAR = 6
        },
        Druid = {
            Regrowth_Switch = true,
            Regrowth_Threshold = 50,
            Regrowth_LAR = 1,
            Regrowth_HAR = 11
        }
    }
}

-------------------------------------------------------------------------------
-- DO NOT CHANGE {{{
-------------------------------------------------------------------------------

MBH.Session = {
    SpellName = nil,
    CurrentUnit = nil,
    MaxData = 60, -- Max. amount of players in the buffer -- change this to increase/decrease performance.
    HealSpell = nil, -- Track Spell Location
    InCombat = nil,
    PlayerName = UnitName("player"),
	PlayerClass = UnitClass("player"),
    Elapsed = 0,
    I = 1,
    Group = {
        1,
        1,
        "player"
    },
    CastTime = {
        [MBH_SPELL_CHAIN_HEAL] = 2.5,
		[MBH_SPELL_HOLY_LIGHT] = 2.5,
		[MBH_SPELL_FLASH_OF_LIGHT] = 1.5,
		[MBH_SPELL_HEALING_WAVE] = 2,
		[MBH_SPELL_LESSER_HEALING_WAVE] = 1.5,
		[MBH_SPELL_LESSER_HEAL] = 2,
		[MBH_SPELL_HEAL] = 2.5,
		[MBH_SPELL_FLASH_HEAL] = 1.5,
		[MBH_SPELL_GREATER_HEAL] = 2.5,
		[MBH_SPELL_HEALING_TOUCH] = 2.5,
		[MBH_SPELL_REGROWTH] = 2
	},
    Autoheal = {
		IsCasting = nil,
        UnitID = nil,
        OutgoingHeal = 0,
        CalculatedHeal = 0,
        SortBuffer = {}
    },
    ExtendedRange = {
        UnitName = nil,
        OpenedFrames = nil,
        Time = 0
    },
    AdvancedOptions = {
        LagPrevention = {
            Time = 0,
        },
    }
}

-------------------------------------------------------------------------------
-- Core Event Code {{{
-------------------------------------------------------------------------------

do
	for _, event in {
		"ADDON_LOADED", 
        "RAID_ROSTER_UPDATE",
        "PARTY_MEMBERS_CHANGED",
        "SPELLCAST_START",
        "SPELLCAST_STOP",
        "SPELLCAST_FAILED",
        "UNIT_INVENTORY_CHANGED",
        "SPELLCAST_INTERRUPTED",
        "UI_ERROR_MESSAGE",
        "ACTIONBAR_SLOT_CHANGED",
        "PLAYER_REGEN_ENABLED",
        "PLAYER_REGEN_DISABLED"
		} 
		do MBH:RegisterEvent(event)
	end
end

function MBH:OnEvent()
    if ( event == "ADDON_LOADED" and arg1 == MBH_TITLE ) then

        MBH_SetupSavedVariables()
        
		MBH.Session.CurrentUnit = nil
		MBH.Session.Autoheal.IsCasting = nil
		MBH.Session.Autoheal.OutgoingHeal = 0
        MBH.Session.Autoheal.CalculatedHeal = 0
		MBH.Session.Autoheal.UnitID = nil

        if mb_equippedSetCount("Stormcaller's Garb") == 5 then
            MBH.Session.CastTime[MBH_SPELL_CHAIN_HEAL] = 2.1
        else
            MBH.Session.CastTime[MBH_SPELL_CHAIN_HEAL] = 2.5
        end

        MBH.ACE = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")
        MBH.ACE.HealComm = AceLibrary("HealComm-1.0")
        MBH.ACE.Banzai = AceLibrary("Banzai-1.0")
        MBH.ACE.ItemBonus = AceLibrary("ItemBonusLib-1.0")

        MBH_SetupData()
        MBH_GetHealSpell()
        MBH_InitalData()
        MBH:CreateWindows()

    elseif ( event == "SPELLCAST_STOP" or event ==  "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED" ) then

		MBH.Session.CurrentUnit = nil
		MBH.Session.Autoheal.IsCasting = nil
		MBH.Session.Autoheal.OutgoingHeal = 0
        MBH.Session.Autoheal.CalculatedHeal = 0
		MBH.Session.Autoheal.UnitID = nil
		
	elseif ( event == "SPELLCAST_START" ) then

		if MBH.Session.CastTime[arg1] then
			MBH.Session.Autoheal.IsCasting = true
			
			if not MBH.Session.CurrentUnit then 
				MBH.Session.CurrentUnit = "target" 
			end
		end

    elseif ( event == "UI_ERROR_MESSAGE" ) then

		if MoronBoxHeal_Options.LineOfSight.Enable and arg1 == "Target not in line of sight" and MBH.Session.CurrentUnit then

			for i = 1, MBH.Session.MaxData do 
				if MBH.GroupData[i].UnitID == MBH.Session.CurrentUnit then
                    MBH.Track[MBH.GroupData[i].UnitID].LOS = MoronBoxHeal_Options.LineOfSight.TimeOut
                    break
                end
			end
		end

    elseif ( event == "PLAYER_REGEN_ENABLED" ) then

		MBH.Session.InCombat = nil

	elseif ( event == "PLAYER_REGEN_DISABLED" ) then

		MBH.Session.InCombat = true
		
	elseif ( event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" ) then

		MBH_SetupData()

	elseif ( event == "ACTIONBAR_SLOT_CHANGED" ) then

		MBH_GetHealSpell()
	
    elseif ( event == "UNIT_INVENTORY_CHANGED" ) then

        if mb_equippedSetCount("Stormcaller's Garb") == 5 then
            MBH.Session.CastTime[MBH_SPELL_CHAIN_HEAL] = 2.1
        else
            MBH.Session.CastTime[MBH_SPELL_CHAIN_HEAL] = 2.5
        end
    end
end

MBH:SetScript("OnEvent", MBH.OnEvent) 

function MBH:OnUpdate()
    MBH.Session.Elapsed = arg1

    local Time = 0

    if MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Enabled and not MBH.Session.InCombat then
        Time = MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Frequency
    end

    MBH.Session.AdvancedOptions.LagPrevention.Time = MBH.Session.AdvancedOptions.LagPrevention.Time + MBH.Session.Elapsed
	if ( MBH.Session.AdvancedOptions.LagPrevention.Time >= Time ) then

        MBH.Session.AdvancedOptions.LagPrevention.Time = 0

        MBH_ClearData()
        MBH_UpdateData()

        if MoronBoxHeal_Options.ExtendedRange.Enable then 
            MBH_UpdateRange() 
        end
    end
end

MBH:SetScript("OnUpdate", MBH.OnUpdate) 

function MBH_SetupSavedVariables()
    if not MoronBoxHeal_Options then 
        MoronBoxHeal_Options = MBH.DefaultOptions
    end
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

    if (SPN == MBH_SPELL_HEALING_TOUCH) then

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

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------