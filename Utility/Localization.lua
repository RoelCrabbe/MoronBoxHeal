
-------------------------------------------------------------------------------
-- English Language {{{
-------------------------------------------------------------------------------

MBG_DEBUGTIME = date("%H:%M:%S")

MBH_TITLE = 'MoronBoxHeal'
MBH_AUTHOR = 'MoRoN'
MBH_GENERAL = 'General'
MBH_OPTIONS = 'Options'
MBH_PROTECTION = 'Mana Protection'
MBH_HIDE = 'Close'
MBH_EXIT = "Get lost!"
MBH_MINIMAPHOVER = "Click to show/hide the main frame."

MBH_WELCOME = "|cffe3e3e3Welcome To "..MBH_TITLE.."|r"
MBH_INFORMATION = 
"The addon is based on 420's & Renew's MultiBoxHeal\n"..
"UI & Features optimised by MoRoN for custom box support.\n\n"..

"|cffe3e3e3How to use the addon?|r\n"..
"This functions is build as follows : |cffC79C6EMBH_CastHeal(spell, LowRank, HighestRank);|r\n\n"..

"|cffe3e3e3Example:|r\n"..
"|cffC79C6E/script MBH_CastHeal(\"Healing Wave\");|r\n\n"..

"|cffe3e3e3Or define spell ranks:|r\n"..
"|cffC79C6E/script MBH_CastHeal(\"Healing Wave\", 3, 7);|r\n\n"..

"- LowRank: The lowest rank a player is allowed to use.\n"..
"- HighestRank: The highest rank a player is allowed to use.\n\n"..

"|cffe3e3e3Supported spells are:|r \n"..
"|cffffffffPriest|r: Lesser Heal, Heal, Flash Heal, Greater Heal.\n"..
"|cffFF7D0ADruids|r: Healing Touch, Regrowth.\n"..
"|cff0070DEShamans|r: Healing Wave, Lesser Healing Wave, Chain Heal.\n"..
"|cffF58CBAPaladins|r: Holy Light, Flash of Light.\n\n"..

"Be sure to checkout the option's panel!";

MBH_HEALSETTINGS = "Healing Settings"
MBH_RANGSETTINGS = "Extended Range Settings"
MBH_LOSETTINGS = "Line of Sight Settings"
MBH_SPECIALSETTINGS = "Special Settings"

MBH_SMARTHEAL = "Smart Heal:"
MBH_ALLOWEDOVERHEAL = "Allowed Overheal: $p %"
MBH_RANDOMTARGET = "Random Target:"
MBH_HEALTARGETNUMBER = "Heal Target Number: $p"

MBH_EXTENDEDRANGE = "Extended Range:"
MBH_EXTENDEDRANGEFREQUENCY = "Update Every: $p Sec"

MBH_LINEOFSIGHT = "LOS TimeOut:"
MBH_LINEOFSIGHTFREQUENCY = "Update every: $p sec"

MBH_MANAPROTECTION = "Mana Protection:"
MBH_IDLEPROTECTIONENABLE = "Idle Protection:"
MBH_IDLEPROTECTIONFREQUENCY = "Idle Update every: $p sec"

MBH_SPELL_FLASH_HEAL = "Flash Heal"
MBH_SPELL_HEAL = "Heal"
MBH_SPELL_GREATER_HEAL = "Greater Heal"
MBH_SPELL_CHAIN_HEAL = "Chain Heal"
MBH_SPELL_LESSER_HEALING_WAVE = "Lesser Healing Wave"
MBH_SPELL_HOLY_LIGHT = "Holy Light"
MBH_SPELL_REGROWTH = "Regrowth"

MBH_MANAPERCENTAGETO = "Mana Percentage to Cast "
MBH_FLASHHEALPROTECTIONTHRESHOLD = MBH_MANAPERCENTAGETO..MBH_SPELL_HEAL..": $p %"
MBH_HEALPROTECTIONTHRESHOLD = MBH_MANAPERCENTAGETO.."Lesser "..MBH_SPELL_HEAL..": $p %"
MBH_GREATERHEALPROTECTIONTHRESHOLD = MBH_MANAPERCENTAGETO..MBH_SPELL_HEAL..": $p %"
MBH_CHAINHEALPROTECTIONTHRESHOLD = MBH_MANAPERCENTAGETO.."Healing Wave: $p %"
MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD = MBH_MANAPERCENTAGETO.."Healing Wave: $p %"
MBH_HOLYLIGHTPROTECTIONTHRESHOLD = MBH_MANAPERCENTAGETO.."Flash of Light: $p %"
MBH_REGROWTHPROTECTIONTHRESHOLD = MBH_MANAPERCENTAGETO.."Healing Touch: $p %"

MBH_LOWEST_RANK = "Lowest Rank:"
MBH_HIGHEST_RANK = "Highest Rank:"
MNH_ACTIVESWITCH = " Active Switch:"

MBH_RESTOREDEFAULT = "Restore Default Settings"
MBH_RESTOREDEFAULTCONFIRM = "Are you sure you want to restore default values?"
MBH_RESTOREUNSUCCESS = "Unable To Reset Back To Defaults! Try And Clear WDB."

MBH_PRESETSETTINGS = "Advanced Settings"
MBH_PRESETSETTINGSCONFIRM = "Are you sure you want to load preset values?"
MBH_PRESETSETTINGSUNSUCCESS = "There Is No Preset For You!"

MBH_RELOADUI = "(This settings will reload your UI)"
MBH_YES = "Yes"
MBH_NO = "No"