MBH_TITLE = 'MoronBoxHeal'
MBH_AUTHOR = 'MoRoN'
MBH_OPTIONS = 'Options'
MBH_GENERAL = 'General'
MBH_HIDE = 'Close'
MBH_PROTECTION = 'Mana Protection'

MBG_DEBUGTIME = date("%H:%M:%S")

MBH_WELCOME = "|cffe3e3e3Welcome To "..MBH_TITLE.."|r"
MBH_INFORMATION = 
"The addon is based on 420's & Renew's MultiBoxHeal\n" ..
"UI & Features optimised by MoRoN for custom box support.\n\n" ..

"|cffe3e3e3How to use the addon?|r\n" ..
"This functions is build as follows : |cffC79C6EMBH_CastHeal(spell, LowRank, HighestRank);|r\n\n" ..

"|cffe3e3e3Example:|r\n" ..
"|cffC79C6E/script MBH_CastHeal(\"Healing Wave\");|r\n\n" ..

"|cffe3e3e3Or define spell ranks:|r\n" ..
"|cffC79C6E/script MBH_CastHeal(\"Healing Wave\", 3, 7);|r\n\n" ..

"- LowRank: The lowest rank a player is allowed to use.\n" ..
"- HighestRank: The highest rank a player is allowed to use.\n\n" ..
        
"|cffe3e3e3Supported spells are:|r \n" ..
"|cffffffffPriest|r: Lesser Heal, Heal, Flash Heal, Greater Heal.\n" ..
"|cffFF7D0ADruids|r: Healing Touch, Regrowth.\n" ..
"|cff0070DEShamans|r: Healing Wave, Lesser Healing Wave, Chain Heal.\n" ..
"|cffF58CBAPaladins|r: Holy Light, Flash of Light.\n\n" ..

"Be sure to checkout the option's panel!";

MBH_SHOW_SLASH = '/MBH'
MBH_SHOW_SLASH_OPTIONS = '/MBHO'

MBH_OPTIONSTEXT = "This the option menu"

MBH_RANDOMTARGET = "Random Target:"
MBH_SMARTHEAL = "Smart Heal:"
MBH_ALLOWEDOVERHEAL = "Allowed Overheal: $p %"
MBH_HEALTARGETNUMBER = "Heal Target Number: $p"
MBH_RESTOREDEFAULT = "Restore Default Settings"

MBH_RESTOREDEFAULTCONFIRM = "Are you sure you want to restore default values?"
MBH_YES = "Yes"
MBH_NO = "No"
MBH_CLOSE = "X"
MBH_EXIT = "Get lost!"
MBH_RESTOREDEFAULTSUCCES = "Default values restored successfully."
MBH_RESTOREDEFAULTUPTODATE = "Values are already up to date."

MBH_EXTENDEDRANGE = "Extended Range:"
MBH_EXTENDEDRANGEFREQUENCY = "Update every: $p sec"

MBH_LINEOFSIGHT = "Timeout when line of sight: "
MBH_LINEOFSIGHTFREQUENCY = "Update every: $p sec"

MBH_MORONSETTINGS = "Advanced Settings Loaded"

MBH_PRESETSETTINGSCONFIRM = "Are you sure you want to load preset values?"
MBH_PRESETSETTINGS = "Advanced Settings"

MBH_MANAPROTECTION = "Mana Protection:"

MBH_SPECIALSETTINGS = "Special Settings: "
MBH_LOSETTINGS = "Line of Sight Settings: "
MBH_RANGSETTINGS = "Extended Range Settings: "
MBH_HEALSETTINGS = "Healing Settings: "

MBH_SPELL_FLASH_HEAL = "Flash Heal"
MBH_SPELL_HEAL = "Heal"
MBH_SPELL_GREATER_HEAL = "Greater Heal"

MBH_SPELL_CHAIN_HEAL = "Chain Heal"
MBH_SPELL_LESSER_HEALING_WAVE = "Lesser Healing Wave"

MBH_SPELL_HOLY_LIGHT = "Holy Light"

MBH_SPELL_REGROWTH = "Regrowth"

MBH_FLASHHEALPROTECTIONTHRESHOLD = "Mana Percentage to cast Heal: $p %"
MBH_HEALPROTECTIONTHRESHOLD = "Mana Percentage to cast Lesser Heal: $p %"
MBH_GREATERHEALPROTECTIONTHRESHOLD = "Mana Percentage to cast Heal: $p %"

MBH_CHAINHEALPROTECTIONTHRESHOLD = "Mana Percentage to Healing Wave: $p %"
MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD = "Mana Percentage to Healing Wave: $p %"

MBH_HOLYLIGHTPROTECTIONTHRESHOLD = "Mana Percentage to Flash of Light: $p %"

MBH_REGROWTHPROTECTIONTHRESHOLD = "Mana Percentage to Healing Touch: $p %"

MBH_LOWEST_RANK = "Lowest Rank: "
MBH_HIGHEST_RANK = "Highest Rank: "

MBH_RELOADUI = "(This settings will reload your UI)"

MNH_ACTIVESWITCH = " Active Switch:"

MBH_ACTIVE_FLASH_HEAL_SWITCH = MBH_SPELL_FLASH_HEAL..MNH_ACTIVESWITCH
MBH_ACTIVE_HEAL_SWITCH = MBH_SPELL_HEAL..MNH_ACTIVESWITCH
MBH_ACTIVE_GREATER_HEAL_SWITCH = MBH_SPELL_GREATER_HEAL..MNH_ACTIVESWITCH

MBH_ACTIVE_CHAIN_HEAL_SWITCH = MBH_SPELL_CHAIN_HEAL..MNH_ACTIVESWITCH
MBH_ACTIVE_LESSER_HEALING_WAVE_SWITCH = MBH_SPELL_LESSER_HEALING_WAVE..MNH_ACTIVESWITCH