-------------------------------------------------------------------------------
-- Local Variables {{{
-------------------------------------------------------------------------------

ManaProtectionThresholds = {}

function MBH_InitializeManaProtectionThresholds()
    ManaProtectionThresholds = {
        ["Flash Heal"] = {
            ["ThresholdCheck"] = function() 
                return ( 
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch 
                )
            end,
            ["Spell"] = "Heal",
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR,
        },
        ["Heal"] = {
            ["ThresholdCheck"] = function() 
                return ( 
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch 
                )
            end,
            ["Spell"] = "Lesser Heal",
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR,
        },
        ["Greater Heal"] = {
            ["ThresholdCheck"] = function() 
                return ( 
                    MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold) 
                    and MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch 
                )
            end,
            ["Spell"] = "Heal",
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR,
        },
        ["Chain Heal"] = {
            ["ThresholdCheck"] = function() return MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold) end,
            ["Spell"] = "Healing Wave",
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_HAR,
        },
        ["Lesser Healing Wave"] = {
            ["ThresholdCheck"] = function() return MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold) end,
            ["Spell"] = "Healing Wave",
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR,
        },
        ["Holy Light"] = {
            ["ThresholdCheck"] = function() return MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold) end,
            ["Spell"] = "Flash of Light",
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR,
        },
        ["Regrowth"] = {
            ["ThresholdCheck"] = function() return MBH_ManaProtectionThresholdCheck(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold) end,
            ["Spell"] = "Healing Touch",
            ["LAR"] = MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_LAR,
            ["HAR"] = MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR,
        },
    }
end

PresetSettings = {
    ["Shaman"] = {
        ["Chain Heal"] = {
            AutoHeal = {
                Smart_Heal = true,
                Allowed_Overheal_Percentage = 19,
                Random_Target = true,
                Heal_Target_Number = 2
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
            },
            ManaProtectionValues = {
                Shaman = {
                    Chain_Heal_Threshold = 12.5,
                    Chain_Heal_LAR = 3,
                    Chain_Heal_HAR = 7,
                    Lesser_Healing_Wave_Threshold = 35,
                    Lesser_Healing_Wave_LAR = 3,
                    Lesser_Healing_Wave_HAR = 7
                }
            }
        },
        ["Healing Wave"] = {
            AutoHeal = {
                Smart_Heal = true,
                Allowed_Overheal_Percentage = 25,
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
            },
            ManaProtectionValues = {
                Shaman = {
                    Chain_Heal_Threshold = 12.5,
                    Chain_Heal_LAR = 3,
                    Chain_Heal_HAR = 7,
                    Lesser_Healing_Wave_Threshold = 35,
                    Lesser_Healing_Wave_LAR = 3,
                    Lesser_Healing_Wave_HAR = 7
                }
            }
        }
    },
    ["Paladin"] = {
        ["Default"] = {
            AutoHeal = {
                Smart_Heal = true,
                Allowed_Overheal_Percentage = 35,
                Random_Target = true,
                Heal_Target_Number = 2
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
            },
            ManaProtectionValues = {
                Paladin = {
                    Holy_Light_Threshold = 5,
                    Holy_Light_LAR = 1,
                    Holy_Light_HAR = 6
                }
            }
        }
    },
    ["Priest"] = {
        ["Heal"] = {
            AutoHeal = {
                Smart_Heal = true,
                Allowed_Overheal_Percentage = 25,
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
            },
            ManaProtectionValues = {
                Priest = {
                    Flash_Heal_Threshold = 20,
                    Flash_Heal_LAR = 1,
                    Flash_Heal_HAR = 4,
                    Heal_Threshold = 5,
                    Heal_LAR = 1,
                    Heal_HAR = 3,
                    Greater_Heal_Threshold = 50,
                    Greater_Heal_LAR = 1,
                    Greater_Heal_HAR = 4
                }
            }
        },
        ["Flash Heal"] = {
            AutoHeal = {
                Smart_Heal = true,
                Allowed_Overheal_Percentage = 9,
                Random_Target = false,
                Heal_Target_Number = 2
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
            },
            ManaProtectionValues = {
                Priest = {
                    Flash_Heal_Threshold = 20,
                    Flash_Heal_LAR = 1,
                    Flash_Heal_HAR = 4,
                    Heal_Threshold = 5,
                    Heal_LAR = 1,
                    Heal_HAR = 3,
                    Greater_Heal_Threshold = 50,
                    Greater_Heal_LAR = 1,
                    Greater_Heal_HAR = 4
                }
            }
        }
    },
    ["Druid"] = {
        ["Default"] = {
            AutoHeal = {
                Smart_Heal = true,
                Allowed_Overheal_Percentage = 13,
                Random_Target = true,
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
            },
            ManaProtectionValues = {
                Druid = {
                    Regrowth_Threshold = 50,
                    Regrowth_LAR = 1,
                    Regrowth_HAR = 11,
                }
            }
        }
    }
}

ColorPicker = {
    White = { r = 1, g = 1, b = 1, a = 1 },                 -- #ffffff equivalent
    Black = { r = 0, g = 0, b = 0, a = 1 },                 -- #000000 equivalent
    -- Gray shades
    Gray50 = { r = 0.976, g = 0.976, b = 0.976, a = 1 },    -- #f9f9f9
    Gray100 = { r = 0.925, g = 0.925, b = 0.925, a = 1 },   -- #ececec
    Gray200 = { r = 0.890, g = 0.890, b = 0.890, a = 1 },   -- #e3e3e3
    Gray300 = { r = 0.804, g = 0.804, b = 0.804, a = 1 },   -- #cdcdcd
    Gray400 = { r = 0.706, g = 0.706, b = 0.706, a = 1 },   -- #b4b4b4
    Gray500 = { r = 0.608, g = 0.608, b = 0.608, a = 1 },   -- #9b9b9b
    Gray600 = { r = 0.404, g = 0.404, b = 0.404, a = 1 },   -- #676767
    Gray700 = { r = 0.259, g = 0.259, b = 0.259, a = 1 },   -- #424242
    Gray800 = { r = 0.184, g = 0.184, b = 0.184, a = 1 },   -- #2f2f2f

    -- Blue shades
    Blue50 = { r = 0.678, g = 0.725, b = 0.776, a = 1 },    -- #adb9c6
    Blue100 = { r = 0.620, g = 0.675, b = 0.737, a = 1 },   -- #9eaebd
    Blue200 = { r = 0.561, g = 0.624, b = 0.698, a = 1 },   -- #8fa0b2
    Blue300 = { r = 0.502, g = 0.576, b = 0.659, a = 1 },   -- #8093a8
    Blue400 = { r = 0.443, g = 0.529, b = 0.620, a = 1 },   -- #71879e
    Blue500 = { r = 0.384, g = 0.482, b = 0.682, a = 1 },   -- #627bb0
    Blue600 = { r = 0.325, g = 0.435, b = 0.643, a = 1 },   -- #5370a4
    Blue700 = { r = 0.267, g = 0.388, b = 0.604, a = 1 },   -- #44639a
    Blue800 = { r = 0.208, g = 0.341, b = 0.565, a = 1 },   -- #355791

    -- Green shades
    Green50 = { r = 0.561, g = 0.698, b = 0.624, a = 1 },   -- #8fb28f
    Green100 = { r = 0.502, g = 0.659, b = 0.576, a = 1 },  -- #80a89a
    Green200 = { r = 0.443, g = 0.620, b = 0.529, a = 1 },  -- #719e86
    Green300 = { r = 0.384, g = 0.682, b = 0.482, a = 1 },  -- #62ae7b
    Green400 = { r = 0.325, g = 0.643, b = 0.435, a = 1 },  -- #53a480
    Green500 = { r = 0.267, g = 0.604, b = 0.388, a = 1 },  -- #439a63
    Green600 = { r = 0.208, g = 0.565, b = 0.341, a = 1 },  -- #359155
    Green700 = { r = 0.149, g = 0.525, b = 0.294, a = 1 },  -- #27864b
    Green800 = { r = 0.090, g = 0.486, b = 0.247, a = 1 },  -- #176f3f
    Red500 = { r = 0.937, g = 0.267, b = 0.267, a = 1 },    -- #ef4444 equivalent
    Red700 = { r = 0.725, g = 0.110, b = 0.110, a = 1 },    -- #b91c1c equivalent
}

-------------------------------------------------------------------------------
-- The Stored Variables {{{
-------------------------------------------------------------------------------

DefaultOptions = {
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
            Chain_Heal_Threshold = 20,
            Chain_Heal_LAR = 1,
            Chain_Heal_HAR = 10,
            Lesser_Healing_Wave_Threshold = 35,
            Lesser_Healing_Wave_LAR = 1,
            Lesser_Healing_Wave_HAR = 10
        },
        Paladin = {
            Holy_Light_Threshold = 35,
            Holy_Light_LAR = 1,
            Holy_Light_HAR = 6
        },
        Druid = {
            Regrowth_Threshold = 50,
            Regrowth_LAR = 1,
            Regrowth_HAR = 11
        }
    }
}

-------------------------------------------------------------------------------
-- DO NOT CHANGE {{{
-------------------------------------------------------------------------------

Session = {
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
        ["Chain Heal"] = 2.5,
		["Holy Light"] = 2.5,
		["Flash of Light"] = 1.5,
		["Healing Wave"] = 2,
		["Lesser Healing Wave"] = 1.5,
		["Lesser Heal"] = 2,
		["Heal"] = 2.5,
		["Flash Heal"] = 1.5,
		["Greater Heal"] = 2.5,
		["Healing Touch"] = 2.5,
		["Regrowth"] = 2,
        ["Renew"] = 15,
		["Rejuvenation"] = 12,
	},
    Autoheal = {
		IsCasting = nil,
        UnitID = nil,
        PlusHeal = 0,
        SortBuffer = {}
    },
    ExtendedRange = {
        UnitName = nil,
        OpenedFrames = nil,
        Time = 0
    },
    Debug = false
}
-------------------------------------------------------------------------------
-- Core Event Code {{{
-------------------------------------------------------------------------------

MBH = CreateFrame("Frame", "MBH", UIParent)
MBH:SetScript("OnEvent", MBH.OnEvent) 

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
    if ( event == "ADDON_LOADED" and arg1 == "MoronBoxHeal" ) then

        MBH_SetupSavedVariables()

		Session.CurrentUnit = nil
		Session.Autoheal.IsCasting = nil
		Session.Autoheal.PlusHeal = 0
		Session.Autoheal.UnitID = nil

        if mb_equippedSetCount("Stormcaller's Garb") == 5 then
            Session.CastTime["Chain Heal"] = 2.1
        else
            Session.CastTime["Chain Heal"] = 2.5
        end

        MBH.ACE = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")
        MBH.ACE.HealComm = AceLibrary("HealComm-1.0")
        MBH.ACE.Banzai = AceLibrary("Banzai-1.0")
        MBH.ACE.ItemBonus = AceLibrary("ItemBonusLib-1.0")

        MBH_ResetAllWindow()
        MBH_SetupData()
        MBH_GetHealSpell()
        MBH_InitalData()

    elseif ( event == "SPELLCAST_STOP" or event ==  "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED" ) then

		Session.CurrentUnit = nil
		Session.Autoheal.IsCasting = nil
		Session.Autoheal.PlusHeal = 0
		Session.Autoheal.UnitID = nil
		
	elseif ( event == "SPELLCAST_START" ) then

		if Session.CastTime[arg1] then
			Session.Autoheal.IsCasting = true
			
			if not Session.CurrentUnit then 
				Session.CurrentUnit = "target" 
			end
		end

    elseif ( event == "UI_ERROR_MESSAGE" ) then

		if MoronBoxHeal_Options.LineOfSight.Enable and arg1 == "Target not in line of sight" and Session.CurrentUnit then

			for i = 1, Session.MaxData do 
				if MBH.GroupData[i].UnitID == Session.CurrentUnit then
                    MBH.Track[MBH.GroupData[i].UnitID].LOS = MoronBoxHeal_Options.LineOfSight.TimeOut
                    break
                end
			end
		end

    elseif ( event == "PLAYER_REGEN_ENABLED" ) then

		Session.InCombat = nil

	elseif ( event == "PLAYER_REGEN_DISABLED" ) then

		Session.InCombat = true
		
	elseif ( event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" ) then

		MBH_SetupData()

	elseif ( event == "ACTIONBAR_SLOT_CHANGED" ) then

		MBH_GetHealSpell()
	
    elseif ( event == "UNIT_INVENTORY_CHANGED" ) then

        if mb_equippedSetCount("Stormcaller's Garb") == 5 then
            Session.CastTime["Chain Heal"] = 2.1
        else
            Session.CastTime["Chain Heal"] = 2.5
        end
    end
end

MBH:SetScript("OnEvent", MBH.OnEvent) 

function MBH:OnUpdate()
    MBH_ClearData(arg1)
    MBH_UpdateData()
    if MoronBoxHeal_Options.ExtendedRange.Enable then MBH_UpdateRange() end
end

MBH:SetScript("OnUpdate", MBH.OnUpdate) 

function MBH_SetupSavedVariables()
    if not MoronBoxHeal_Options then 
        MoronBoxHeal_Options = DefaultOptions
    end

    if not MoronBoxHeal_Debug then
        MoronBoxHeal_Debug = {}
	end
end

-------------------------------------------------------------------------------
-- Core Code {{{
-------------------------------------------------------------------------------

function MBH_Cast(spellName, lowestAllowedRank, highestAllowedRank)
	local healUnitID

	if Session.Autoheal.IsCasting and Session.Autoheal.UnitID then
		if Session.Autoheal.PlusHeal * MBH_ConvertToFractionFromPercentage(MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage) > UnitHealthMax(Session.Autoheal.UnitID) - UnitHealth(Session.Autoheal.UnitID) then
			SpellStopCasting()
		end
	else
		healUnitID = MBH_GetHealUnitID(spellName)
		
		if healUnitID then
			Session.Autoheal.UnitID = healUnitID
			Session.CurrentUnit = healUnitID

			MBH_CastSpell(spellName, lowestAllowedRank, highestAllowedRank, Session.Autoheal.UnitID)
		end
	end
end

function MBH_CastSpell(spellName, lowestAllowedRank, highestAllowedRank, unitID)
    -- Error handling for invalid unit
    if unitID == UNKNOWNOBJECT or unitID == UKNOWNBEING then
        return
    end

    local Cache = {
        HealNeed = 0,
        Spell = nil,
        Rank = nil,
        DefaultSpell = spellName .. "(Rank 1)"
    }

    Cache.Spell, Cache.Rank = MBH_ExtractSpell(Cache.DefaultSpell)

    if MBH.ACE.HealComm.Spells[Cache.Spell] then
        Cache.Rank, Cache.HealNeed = MBH_CalculateRank(Cache.Spell, unitID)

		-- Ensure spell rank is within allowed range
		if lowestAllowedRank then
			Cache.Rank = math.max(Cache.Rank, lowestAllowedRank)
		end

		if highestAllowedRank then
			Cache.Rank = math.min(Cache.Rank, highestAllowedRank)
		end

        -- Adjust spell rank for specific spells
        if Cache.Spell == "Healing Touch" then
            if mb_hasBuffOrDebuff("Nature's Grace", "player", "buff") then
                Cache.Rank = 4
            else
                Cache.Rank = 3
            end
        end

        -- Adjust spell name for Chain Heal
        if Cache.Spell == "Chain Heal" and Cache.LowestRank == 1 and Cache.HighestRank == 1 then
            spellName = "Chain Heal(Rank 1)"
        else
            spellName = Cache.Spell .. "(Rank " .. Cache.Rank .. ")"
        end

        -- mb_cooldownPrint(spellName)

        -- Check if the heal amount is sufficient and cast the spell
        if Cache.HealNeed >= MBH_CalculateHeal(Cache.Spell, Cache.Rank, unitID) then
            -- Clear target if necessary
            if UnitCanAttack("player", unitID) or (UnitExists("target") and not UnitCanAttack("player", "target") and not UnitIsUnit(unitID, "target")) then
                ClearTarget()
            end

            -- Cast the spell
            CastSpellByName(spellName)
            MBH_LogDebug("Casting: " .. spellName .. " on " .. UnitName(unitID))

            -- Target the unit if the spell requires targeting
            if SpellIsTargeting() then
                SpellTargetUnit(unitID)
            end

            -- Stop targeting if still targeting
            if SpellIsTargeting() then
                SpellStopTargeting()
            end

            -- Clear target after casting
            ClearTarget()
        end
    end
end

function MBH_CalculateRank(spell, unitID)

    -- Error handling for invalid unit
    if unitID == UNKNOWNOBJECT or unitID == UKNOWNBEING then
        return nil
    end

    -- Get item bonus
    local bonus = MBH.ACE.ItemBonus:GetBonus("HEAL")

    -- Get maximum spell rank
    local max_rank = MBH_GetMaxSpellRank(spell)

    -- Get unit spell power
    local target_power, target_mod = MBH.ACE.HealComm:GetUnitSpellPower(unitID, spell)

    -- Get buff spell power 
    local buff_power, buff_mod = MBH.ACE.HealComm:GetBuffSpellPower()

    -- Add bonus to spell power
    bonus = bonus + buff_power

    -- Calculate heal need
    local heal_need = UnitHealthMax(unitID) - UnitHealth(unitID)

    -- Initialize result and heal variables
    local result = 1
    local heal = 0

    -- Iterate through spell ranks
    for rank = max_rank, 1, -1 do
        local amount = ((math.floor(MBH.ACE.HealComm.Spells[spell][rank](bonus)) + target_power) * buff_mod * target_mod)

        -- Check if amount is sufficient to fulfill heal need
        if amount < heal_need then
            if rank < max_rank then
                result = rank + 1
                heal = ((math.floor(MBH.ACE.HealComm.Spells[spell][rank + 1](bonus)) + target_power) * buff_mod * target_mod)
                break
            else
                result = rank
                heal = amount
                break
            end
        else
            heal = amount
        end
    end

    -- Store calculated plus heal in session
    Session.Autoheal.PlusHeal = heal

    -- Return result and heal need
    return result, heal_need
end

function MBH_CalculateHeal(spell, rank, unitID)

    -- Error handling for invalid unit
    if unitID == UNKNOWNOBJECT or unitID == UKNOWNBEING then
        return nil
    end

	-- Get item bonus
	local bonus = MBH.ACE.ItemBonus:GetBonus("HEAL")

    -- Get unit spell power
    local target_power, target_mod = MBH.ACE.HealComm:GetUnitSpellPower(unitID, spell)

    -- Get buff spell power
    local buff_power, buff_mod = MBH.ACE.HealComm:GetUnitSpellPower()

    -- Add bonus to spell power
    bonus = bonus + buff_power

    -- Subtract 1 from the number, but ensure it doesn't go below 1
    if rank > 1 then
        rank = rank - 1
    end

    -- Calculate heal amount
    local heal = ((math.floor(MBH.ACE.HealComm.Spells[spell][rank](bonus)) + target_power) * buff_mod * target_mod)

    return heal
end

function MBH_CastHeal(SpellName, LowestAllowedRank, HighestAllowedRank)
    ManaProtectedHeal, ManaProtectedLowRank , ManaProtectedHighRank = MBH_ManaProtection(SpellName, LowestAllowedRank, HighestAllowedRank)
    Session.SpellName = ManaProtectedHeal
	if Session.CastTime[Session.SpellName] then
		MBH_Cast(Session.SpellName, ManaProtectedLowRank, ManaProtectedHighRank)
	end
end

function MBH_ManaProtection(SPN, LAR, HAR)

    if not MoronBoxHeal_Options.AdvancedOptions.Mana_Protection then
        return SPN, LAR or 1, HAR or MBH_GetMaxSpellRank(SPN)
    end

    if not next(ManaProtectionThresholds) then
        MBH_InitializeManaProtectionThresholds()
    end

    local spellData = ManaProtectionThresholds[SPN]

    if spellData and spellData.ThresholdCheck() then
        SPN = spellData.Spell
        LAR = spellData.LAR or 1
        HAR = spellData.HAR or MBH_GetMaxSpellRank(SPN)
    else
        LAR = LAR or 1
        HAR = HAR or MBH_GetMaxSpellRank(SPN)
    end
    return SPN, LAR, HAR
end

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------