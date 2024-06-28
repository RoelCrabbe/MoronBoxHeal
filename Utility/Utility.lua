-------------------------------------------------------------------------------
-- Table Settings {{{
-------------------------------------------------------------------------------

local PresetSettings = {
    ["Priest"] = {
        ["Flash Heal"] = {
            AutoHeal = {
                Allowed_Overheal_Percentage = 9,
                Random_Target = true,
                Heal_Target_Number = 2
            },
            ManaProtectionValues = {
                Priest = {
                    Flash_Heal_Threshold = 12.5,
                    Heal_LAR = 3,
                    Heal_HAR = 3,
                }
            }
        },
        ["Heal"] = {
            AutoHeal = {
                Allowed_Overheal_Percentage = 25,
            },
            ManaProtectionValues = {
                Priest = {
                    Heal_Threshold = 7.5,
                    Heal_LAR = 3,
                    Heal_HAR = 3,
                }
            }
        },
        ["Greater Heal"] = {
            AutoHeal = {
                Allowed_Overheal_Percentage = 35,
            },
            ManaProtectionValues = {
                Priest = {
                    Greater_Heal_Threshold = 35,
                    Greater_Heal_LAR = 1,
                    Greater_Heal_HAR = 4
                },
            }
        },
    },
    ["Shaman"] = {
        ["Chain Heal"] = {
            AutoHeal = {
                Random_Target = true,
                Heal_Target_Number = 2
            }
        },
        ["Healing Wave"] = {
            AutoHeal = {
                Allowed_Overheal_Percentage = 25,
            },
            ManaProtectionValues = {
                Shaman = {
                    Chain_Heal_Threshold = 25,
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
                Allowed_Overheal_Percentage = 35,
                Random_Target = true,
                Heal_Target_Number = 2
            },
        }
    },
    ["Druid"] = {
        ["Default"] = {
            AutoHeal = {
                Allowed_Overheal_Percentage = 13,
                Random_Target = true,
            },
            AdvancedOptions = {
                Mana_Protection = true
            },
            ManaProtectionValues = {
                Druid = {
                    Regrowth_Switch = true,
                    Regrowth_Threshold = 50,
                    Regrowth_LAR = 3,
                    Regrowth_HAR = 3,
                }
            }
        }
    }
}

function MBH_LoadPresetSettings()
    local Settings = PresetSettings[Session.PlayerClass]

    if Settings then
        local SpecialSettings = Settings[MB_myHealSpell] or Settings["Default"]

        if SpecialSettings then
            MoronBoxHeal_Options = MBH_DeepCopyTable(DefaultOptions)
            MBH_SetPresetSettings(MoronBoxHeal_Options, SpecialSettings)
            ReloadUI()
            return
        end
    end

    MBH_ErrorMessage(MBH_PRESETSETTINGSUNSUCCESS)
end

function MBH_SetDefaultValues()
	if MoronBoxHeal_Options then
        MoronBoxHeal_Options = MBH_DeepCopyTable(DefaultOptions)
        ReloadUI()
        return
	end
end

-------------------------------------------------------------------------------
-- Table Functions {{{
-------------------------------------------------------------------------------

function MBH_DeepCopyTable(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[MBH_DeepCopyTable(orig_key)] = MBH_DeepCopyTable(orig_value)
        end
        setmetatable(copy, MBH_DeepCopyTable(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function MBH_SetPresetSettings(targetTable, presetTable)
    if type(targetTable) ~= "table" or type(presetTable) ~= "table" then
        return
    end

    for key, value in pairs(presetTable) do
        if type(value) == "table" then
            if type(targetTable[key]) ~= "table" then
                targetTable[key] = {}
            end
            MBH_SetPresetSettings(targetTable[key], value)
        else
            targetTable[key] = value
        end
    end
end

-------------------------------------------------------------------------------
-- Spell Functions {{{
-------------------------------------------------------------------------------

function MBH_GetMaxSpellRank(SpellName)
    local i = 1;
    local List = {};
    local SpellNamei, spellRank;

    while true do
        SpellNamei, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
        if not SpellNamei then return table.getn(List) end

        if SpellNamei == SpellName then
            _,_,spellRank = string.find(spellRank, " (%d+)$");
            spellRank = tonumber(spellRank);
            if not spellRank then return i end
            List[spellRank] = i;
        end
        i = i + 1;
    end
end

function MBH_ExtractSpell(spell)
	local s = spell
	local _, i, r
	_, _, s = string.find(s, "^(.*);?%s*$")
	while ( string.sub( s, -2 ) == "()" ) do
		s = string.sub( s, 1, -3 )
	end
	_, _, s = string.find(s, "^%s*(.*)$")
	_, _, i, r = string.find(s, "(.*)%(.*(%d)%)$")
	if (i and r) then
		s = i
		r = tonumber(r)
		return s, r
	end
end

-------------------------------------------------------------------------------
-- Calc Functions {{{
-------------------------------------------------------------------------------

function MBH_ConvertToFractionFromPercentage(value)
	local commaValue = value / 100
	local newValue = 1 - commaValue
	return newValue
end

function MBH_ManaProtectionThresholdCheck(PCT) 
    return mb_manaPct("player") < (PCT / 100)
end

function MBH_PrintMessage(message) 
    DEFAULT_CHAT_FRAME:AddMessage("|cffC71585"..MBH_TITLE..": |cff00ff00"..message) 
end

function MBH_ErrorMessage(message) 
    DEFAULT_CHAT_FRAME:AddMessage("|cffC71585"..MBH_TITLE..": |cFFFF0000"..message) 
end