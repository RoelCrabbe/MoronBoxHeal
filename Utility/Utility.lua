
function MBH_SetDefaultValues()
	if MoronBoxHeal_Options then
		MoronBoxHeal_Options = {}
        MoronBoxHeal_Options = DefaultOptions
        ReloadUI()
        return
	end
    MBH_ErrorMessage(MBH_RESTOREUNSUCCESS)
end

function MBH_LoadPresetSettings()
    local Settings = PresetSettings[Session.PlayerClass]

    if Settings then
        local SpecialSettings = Settings[MB_myHealSpell] or Settings["Default"]
        
        if SpecialSettings then
            MoronBoxHeal_Options = SpecialSettings
            ReloadUI()
            return
        end
    end
    MBH_ErrorMessage(MBH_PRESETSETTINGSUNSUCCESS)
end

function GetColorValue(colorKey)
    return ColorPicker[colorKey].r, ColorPicker[colorKey].g, ColorPicker[colorKey].b, ColorPicker[colorKey].a
end

function MBH_ConvertToFractionFromPercentage(value)
	local commaValue = value / 100
	local newValue = 1 - commaValue
	return newValue
end

function MBH_ManaProtectionThresholdCheck(PCT) 
    return mb_manaPct("player") < (PCT / 100)
end

function MBH_PrintMessage(message)
    local titleColor = "|cffC71585"
    local messageColor = "|cff00ff00"

    DEFAULT_CHAT_FRAME:AddMessage(titleColor..MBH_TITLE..": "..messageColor..message)
end

function MBH_ErrorMessage(message)
    local titleColor = "|cffC71585"
    local errorMessageColor = "|cFFFF0000"
    DEFAULT_CHAT_FRAME:AddMessage(titleColor..MBH_TITLE..": "..errorMessageColor..message)
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
