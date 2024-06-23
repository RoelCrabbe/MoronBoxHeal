MBH_TITLE = 'MoronBoxHeal'
MBH_AUTHOR = 'MoRoN'
MBH_OPTIONS = 'Options'
MBH_GENERAL = 'General'
MBH_HIDE = 'Close'

MBG_DEBUGTIME = date("%H:%M:%S")

MBH_INFORMATION = "WELCOME TO MORONBOXHEAL\n\n" ..
                "Addon based on 420's MultiBoxHeal based on Renew's VHM addon!\n" ..
                "Check out the original : github.com/voidmenull.\n" ..
                "Now optimised by MoRoN for custom box support.\n\n" ..

                "Example on how to use this:\n\n" ..

                "/script MBH_CastHeal(\"Healing Wave\")\n\n" ..

                "Or define heal-rank:\n\n" ..

                "/script MBH_CastHeal(\"Healing Wave\", LowestAllowedRank, HighestAllowedRank);\n\n" ..

                "That would look like this:\n\n" ..

                "/script MBH_CastHeal(\"Healing Wave\", 3, 7);\n\n" ..

                "- LowestAllowedRank (number): The lowest heal a player is allowed to use.\n" ..
                "- HighestAllowedRank (number): The highest heal a player is allowed to use.\n\n" ..
                      
                "Supported spells are:\n" ..
                "Priest: Lesser Heal, Heal, Flash Heal, Greater Heal.\n" ..
                "Druids: Healing Touch, Regrowth.\n" ..
                "Shamans: Healing Wave, Lesser Healing Wave, Chain Heal.\n" ..
                "Paladins: Holy Light, Flash of Light.\n\n" ..

                "Be sure to checkout the option's panel!";


                --/script MBH_CastHeal("Lesser Heal")

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