-------------------------------------------------------------------------------
-- Variables {{{
-------------------------------------------------------------------------------

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
        Mana_Protection = true
    }
}

Session = {
    SpellName = nil,
    CurrentUnit = nil,
    MaxData = 60, -- Max. amount of players in the buffer -- change this to increase/decrease performance.
    -- Sort = true, -- We sort by % auto
    -- DisplayPet = true; -- I don't want to track Pets
    HealSpell = nil, -- Track Spell Location
    InCombat = nil,
    PlayerName = UnitName("player"),
	PlayerClass = UnitClass("player"),
    Elapsed = 0, -- elapsed time for onupdate function
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

function MBH_OnLoad(Frame)
    Frame:RegisterEvent("ADDON_LOADED")
end

function MBH_OnEvent(event)
    local Frame = this

    if (event == "ADDON_LOADED" and arg1 == "MoronBoxHeal") then

		Session.CurrentUnit = nil
		Session.Autoheal.IsCasting = nil
		Session.Autoheal.PlusHeal = 0
		Session.Autoheal.UnitID = nil

		MBH_Init()

    elseif (event == "SPELLCAST_STOP" or event ==  "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED") then

		Session.CurrentUnit = nil
		Session.Autoheal.IsCasting = nil
		Session.Autoheal.PlusHeal = 0
		Session.Autoheal.UnitID = nil
		
	elseif (event == "SPELLCAST_START") then

		if Session.CastTime[arg1] then
			Session.Autoheal.IsCasting = true
			
			if not Session.CurrentUnit then 
				Session.CurrentUnit = "target" 
			end
		end

	elseif (event == "PLAYER_REGEN_ENABLED") then

		Session.InCombat = nil
		-- MBH_ClearAggro()

	elseif (event == "PLAYER_REGEN_DISABLED") then

		Session.InCombat = nil
		
	elseif (event == "RAID_ROSTER_UPDATE") then

		MBH_SetupData()

	elseif (event == "PARTY_MEMBERS_CHANGED") then

		MBH_SetupData()

	elseif (event == "UI_ERROR_MESSAGE") then

		if MoronBoxHeal_Options.LineOfSight.Enable and arg1 == "Target not in line of sight" and Session.CurrentUnit then

			for i = 1, Session.MaxData do 
				if MultiBoxHeal.GroupData[i].UnitID == Session.CurrentUnit then
                    MultiBoxHeal.Track[MultiBoxHeal.GroupData[i].UnitID].LOS = MoronBoxHeal_Options.LineOfSight.TimeOut
                    break
                end
			end
		end

	elseif (event == "ACTIONBAR_SLOT_CHANGED") then

		MBH_getHealSpell()
	
    elseif (event == "UNIT_INVENTORY_CHANGED") then

        MBH_UpdateHealCastTime()
    end
end

function MBH_OnUpdate(arg1)
    MBH_ClearData(arg1)
    MBH_UpdateData()
    if MoronBoxHeal_Options.ExtendedRange.Enable then MBH_UpdateRange() end
end

function MBH_DisableAddon()
    if GetAddOnInfo(MBH_TITLE) then
        DisableAddOn(MBH_TITLE)
        MBH_ErrorMessage("Addon Has Been Disabled! Be Sure To ReloadUI.")
    end
end

local MBH_Post_Init = CreateFrame("Button", "MBH", UIParent)

MBH_Post_Init.Timer = GetTime()

function MBH_Post_Init:OnUpdate()
	if GetTime() - MBH_Post_Init.Timer < 2.6 then return end

	--------------------------------------------------------

    MBH_PrintMessage("Has been succesfully loaded.")

    if (UnitClass("player") == "Rogue" or UnitClass("player") == "Mage" or UnitClass("player") == "Warrior" or UnitClass("player") == "Hunter" or UnitClass("player") == "Warlock" or MB_mySpecc == "Feral") then
        MBH_DisableAddon()
    end

	--------------------------------------------------------

	MBH_Post_Init:SetScript("OnUpdate", nil)
	MBH_Post_Init.Timer = nil
	MBH_Post_Init.OnUpdate = nil
end

function MBH_Init()

    MBH_Post_Init:SetScript("OnUpdate", MBH_Post_Init.OnUpdate) -- >  Starts a second INIT after logging in

    MBH_DefaultSettings()

    MBH_UpdateHealCastTime()

    MBH_Config()

    SLASH_MORONBOXHEALSHOW1 = MBH_SHOW_SLASH;
    SlashCmdList["MORONBOXHEALSHOW"] = function(msg)
        MBH_ResetAllWindow()
        MoronBoxHealMainFrame:Show()
    end
end

function MBH_Config()
    MBH_ResetAllWindow()

    MBH_SetupData()
    MBH_getHealSpell()
    MBH_InitalData()

    MBH_SetupAceData()

    MultiBoxHeal:RegisterEvent("RAID_ROSTER_UPDATE")
    MultiBoxHeal:RegisterEvent("PARTY_MEMBERS_CHANGED")
    MultiBoxHeal:RegisterEvent("SPELLCAST_START")
    MultiBoxHeal:RegisterEvent("SPELLCAST_STOP")
    MultiBoxHeal:RegisterEvent("SPELLCAST_FAILED")
    MultiBoxHeal:RegisterEvent("UNIT_INVENTORY_CHANGED")
    MultiBoxHeal:RegisterEvent("SPELLCAST_INTERRUPTED")
    MultiBoxHeal:RegisterEvent("UI_ERROR_MESSAGE")
    MultiBoxHeal:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
    MultiBoxHeal:RegisterEvent("PLAYER_REGEN_ENABLED")
    MultiBoxHeal:RegisterEvent("PLAYER_REGEN_DISABLED")
end

function MBH_UpdateHealCastTime()

    if mb_equippedSetCount("Stormcaller's Garb") == 5 then
        Session.CastTime["Chain Heal"] = 2.1
    else
        Session.CastTime["Chain Heal"] = 2.5
    end
end

function MBH_ResetAllWindow()
    MBH_ResetMoronBoxHealMainFramePosition()
    MBH_ResetMoronBoxHealOptionFramePosition()
end

function MBH_ResetMoronBoxHealMainFramePosition()
    MoronBoxHealMainFrame:ClearAllPoints()
    MoronBoxHealMainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    MoronBoxHealMainFrame:Hide()
end

function MBH_ResetMoronBoxHealOptionFramePosition()
    MoronBoxHealOptionFrame:ClearAllPoints()
    MoronBoxHealOptionFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    MoronBoxHealOptionFrame:Hide()
end

function MBH_SetupAceData()
    MultiBoxHeal.ACE = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")
    MultiBoxHeal.ACE.HealComm = AceLibrary("HealComm-1.0")
    MultiBoxHeal.ACE.Banzai = AceLibrary("Banzai-1.0")
    MultiBoxHeal.ACE.ItemBonus = AceLibrary("ItemBonusLib-1.0")
end

function MBH_DefaultSettings()
    if not MoronBoxHeal_Options then 
        MoronBoxHeal_Options = DefaultOptions
    else
        for key, value in pairs(DefaultOptions) do
            if MoronBoxHeal_Options[key] == nil then
                MoronBoxHeal_Options[key] = value
            end
        end
    end

    if not MoronBoxHeal_Debug then
        MoronBoxHeal_Debug = {}
	else
		MoronBoxHeal_Debug = {}
	end
end

local COOLDOWN_DURATION = 60
local lastMessage = ""
local lastMessageTime = 0

function MBH_LogDebug(Msg)
    if Session.Debug then
        local currentTime = GetTime()
        local debugMessage = MBG_DEBUGTIME .. " - " .. Msg
        
        if Msg == lastMessage and (currentTime - lastMessageTime) < COOLDOWN_DURATION then
            return
        end
        
        lastMessage = Msg
        lastMessageTime = currentTime
        
        table.insert(MoronBoxHeal_Debug, debugMessage)
    end
end

function MBH_DisableTargetEvents()
	-- Blizzard Actionbuttons
	for i = 1, 12 do
		getglobal("ActionButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarLeftButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarRightButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomLeftButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomRightButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("BonusActionButton"..i):UnregisterEvent("PLAYER_TARGET_CHANGED")
	end
end

function MBH_EnableTargetEvents()
	-- Blizzard Actionbuttons
	for i = 1, 12 do
		getglobal("ActionButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarLeftButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarRightButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomLeftButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("MultiBarBottomRightButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
		getglobal("BonusActionButton"..i):RegisterEvent("PLAYER_TARGET_CHANGED")
	end
end


function MBH_ConvertToPrecentage(value)
	local commaValue = value / 100
	local newValue = 1 - commaValue
	return newValue
end

function MBH_Cast(spellName, lowestAllowedRank, highestAllowedRank)
	local healUnitID

	if Session.Autoheal.IsCasting and Session.Autoheal.UnitID then
		if Session.Autoheal.PlusHeal * MBH_ConvertToPrecentage(MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage) > UnitHealthMax(Session.Autoheal.UnitID) - UnitHealth(Session.Autoheal.UnitID) then
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

    if MultiBoxHeal.ACE.HealComm.Spells[Cache.Spell] then
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
    local bonus = MultiBoxHeal.ACE.ItemBonus:GetBonus("HEAL")

    -- Get maximum spell rank
    local max_rank = MBH_GetMaxSpellRank(spell)

    -- Get unit spell power
    local target_power, target_mod = MultiBoxHeal.ACE.HealComm:GetUnitSpellPower(unitID, spell)

    -- Get buff spell power 
    local buff_power, buff_mod = MultiBoxHeal.ACE.HealComm:GetBuffSpellPower()

    -- Add bonus to spell power
    bonus = bonus + buff_power

    -- Calculate heal need
    local heal_need = UnitHealthMax(unitID) - UnitHealth(unitID)

    -- Initialize result and heal variables
    local result = 1
    local heal = 0

    -- Iterate through spell ranks
    for rank = max_rank, 1, -1 do
        local amount = ((math.floor(MultiBoxHeal.ACE.HealComm.Spells[spell][rank](bonus)) + target_power) * buff_mod * target_mod)

        -- Check if amount is sufficient to fulfill heal need
        if amount < heal_need then
            if rank < max_rank then
                result = rank + 1
                heal = ((math.floor(MultiBoxHeal.ACE.HealComm.Spells[spell][rank + 1](bonus)) + target_power) * buff_mod * target_mod)
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
	local bonus = MultiBoxHeal.ACE.ItemBonus:GetBonus("HEAL")

    -- Get unit spell power
    local target_power, target_mod = MultiBoxHeal.ACE.HealComm:GetUnitSpellPower(unitID, spell)

    -- Get buff spell power
    local buff_power, buff_mod = MultiBoxHeal.ACE.HealComm:GetUnitSpellPower()

    -- Add bonus to spell power
    bonus = bonus + buff_power

    -- Subtract 1 from the number, but ensure it doesn't go below 1
    if rank > 1 then
        rank = rank - 1
    end

    -- Calculate heal amount
    local heal = ((math.floor(MultiBoxHeal.ACE.HealComm.Spells[spell][rank](bonus)) + target_power) * buff_mod * target_mod)

    return heal
end


function MBH_ExtractRank(str)
    local num = ""
    local foundDigit = false
    for i = 1, string.len(str) do
        local char = string.sub(str, i, i)
        if tonumber(char) then
            num = num .. char
            foundDigit = true
        elseif foundDigit then
            break
        end
    end
    return tonumber(num)
end

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

function MBH_PrintMessage(message)
    local titleColor = "|cffC71585" -- This color code represents gold
    local messageColor = "|cff00ff00" -- This color code represents green

    DEFAULT_CHAT_FRAME:AddMessage(titleColor .. MBH_TITLE .. ": " .. messageColor .. message)
end

function MBH_ErrorMessage(message)
    local titleColor = "|cffC71585" -- This color code represents gold
    local errorMessageColor = "|cFFFF0000" -- This color code represents red

    DEFAULT_CHAT_FRAME:AddMessage(titleColor .. MBH_TITLE .. ": " .. errorMessageColor .. message)
end

function MBH_SetDefaultValues()
	if MoronBoxHeal_Options then
		MoronBoxHeal_Options = {}
        MoronBoxHeal_Options = DefaultOptions
		MBH_UpdateDisplay()
        MBH_PrintMessage(MBH_RESTOREDEFAULTSUCCES)
	end
end

function MBH_LoadPresetSettings()

	if MB_myHealSpell == "Chain Heal" then

        MoronBoxHeal_Options = {
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
                Mana_Protection = true
            }
        }

		MBH_UpdateDisplay(MBH_MORONSETTINGS)

	elseif (Session.PlayerClass == "Paladin") then

        MoronBoxHeal_Options = {
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
                Mana_Protection = true
            }
        }

		MBH_UpdateDisplay(MBH_MORONSETTINGS)

	elseif (MB_myHealSpell == "Healing Wave" or MB_myHealSpell == "Heal") then

		MoronBoxHeal_Options = {
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
                Mana_Protection = true
            }
		}

		MBH_UpdateDisplay(MBH_MORONSETTINGS)

	elseif MB_myHealSpell == "Flash Heal" then

		MoronBoxHeal_Options = {
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
                Mana_Protection = true
            }
		}

		MBH_UpdateDisplay(MBH_MORONSETTINGS)

	elseif MB_myHealSpell == "Rejuvenation" then

		MoronBoxHeal_Options = {
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
                Mana_Protection = true
            }
		}

		MBH_UpdateDisplay(MBH_MORONSETTINGS)
    else
		
		MoronBoxHeal_Options = DefaultOptions
		MBH_UpdateDisplay()
        MBH_ErrorMessage("There is no preset for you.")
    end
end

function MBH_UpdateDisplay(message)

	MBH_AllowedOverhealPercentageSlider_OnShow()
	MBH_HealTargetNumberSlider_OnShow()
	MBH_ExtendedRangeFrequencySlider_OnShow()
	MBH_LineOfSightTimeOutSlider_OnShow()
	MBH_UpdateCheckBox(MoronBoxHealOptionFrameSmartHealCheckbox, MoronBoxHeal_Options.AutoHeal.Smart_Heal)
	MBH_UpdateCheckBox(MoronBoxHealOptionFrameRandomTargetCheckbox, MoronBoxHeal_Options.AutoHeal.Random_Target)
	MBH_UpdateCheckBox(MoronBoxHealOptionExtendedRangeCheckbox, MoronBoxHeal_Options.ExtendedRange.Enable)
	MBH_UpdateCheckBox(MoronBoxHealOptionLineOfSightCheckbox, MoronBoxHeal_Options.ExtendedRange.Enable)
    MBH_UpdateCheckBox(MoronBoxHealOptionManaProtectionCheckbox, MoronBoxHeal_Options.AdvancedOptions.Mana_Protection)

	if message then MBH_PrintMessage(message) end
end

function MBH_UpdateCheckBox(Frame, Value)
	Frame:SetChecked(Value)
end

function MBH_CastHeal(SpellName, LowestAllowedRank, HighestAllowedRank)
	LowestAllowedRank = LowestAllowedRank or 1
	HighestAllowedRank = HighestAllowedRank or MBH_GetMaxSpellRank(SpellName)
    ManaProtectedHeal, ManaProtectedLowRank , ManaProtectedHighRank = MBH_ManaProtection(SpellName, LowestAllowedRank, HighestAllowedRank)
	Session.SpellName = ManaProtectedHeal
	if Session.CastTime[Session.SpellName] then
		MBH_Cast(Session.SpellName, ManaProtectedLowRank, ManaProtectedHighRank)
	end
end

function MBH_ManaProtection(SpellName, LowestAllowedRank, HighestAllowedRank)

    if MoronBoxHeal_Options.AdvancedOptions.Mana_Protection then
        if SpellName == "Flash Heal" then

            if mb_manaPct("player") < 0.05 then

                SpellName = "Lesser Heal"
                LowestAllowedRank = 3
                HighestAllowedRank = 3

            elseif mb_manaPct("player") < 0.3 then

                SpellName = "Heal"
                LowestAllowedRank = 1
                HighestAllowedRank = MBH_GetMaxSpellRank(SpellName)
            end

        elseif SpellName == "Lesser Healing Wave" then

            if mb_manaPct("player") < 0.3 then

                SpellName = "Healing Wave"
                LowestAllowedRank = 1
                HighestAllowedRank = MBH_GetMaxSpellRank(SpellName)
            end
        end
    end
    return SpellName, LowestAllowedRank, HighestAllowedRank
end

function MBH_RestoreDefaultValues()
    -- Define the popup dialog
    StaticPopupDialogs["RESTORE_DEFAULT_VALUES_CONFIRM"] = {
        text = MBH_RESTOREDEFAULTCONFIRM,
        button1 = MBH_YES,
        button2 = MBH_NO,
        OnAccept = function()
            MBH_SetDefaultValues()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3, -- Avoids UI taint issues
    }

    -- Show the confirmation popup
    StaticPopup_Show("RESTORE_DEFAULT_VALUES_CONFIRM")
end

function MBH_SetPresetValues()
    -- Define the popup dialog
    StaticPopupDialogs["SET_PRESET_VALUES_CONFIRM"] = {
        text = MBH_PRESETSETTINGSCONFIRM,
        button1 = MBH_YES,
        button2 = MBH_NO,
        OnAccept = function()
			MBH_LoadPresetSettings()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3, -- Avoids UI taint issues
    }

    -- Show the confirmation popup
    StaticPopup_Show("SET_PRESET_VALUES_CONFIRM")
end


function MBH_SetText(text)
    getglobal(this:GetName().."Text"):SetText(text);
end

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

    Frame:SetMinMaxValues(1, 10)
    Frame:SetValueStep(1)
    Frame:SetValue(MoronBoxHeal_Options.AutoHeal.Heal_Target_Number)

	getglobal(Frame:GetName().."Low"):Hide()
    getglobal(Frame:GetName().."High"):Hide()

	local minValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText("1")
    minValueText:SetPoint("CENTER", Frame, "LEFT", -8, 0)
    
    local maxValueText = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText("10")
    maxValueText:SetPoint("CENTER", Frame, "RIGHT", 10, 0)
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
    Frame:SetValueStep(0.5)
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
    Frame:SetValueStep(0.5)
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