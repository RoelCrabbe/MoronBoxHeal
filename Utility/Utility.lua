-------------------------------------------------------------------------------
-- Table Settings {{{
-------------------------------------------------------------------------------

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