-------------------------------------------------------------------------------
-- Local Variables {{{
-------------------------------------------------------------------------------

local ResurrectionInfo = {
    { Class = "Druid",   Priority = 40, Spell = "Rebirth" },
    { Class = "Hunter",  Priority = 10, Spell = nil },
    { Class = "Mage",    Priority = 40, Spell = nil },
    { Class = "Paladin", Priority = 50, Spell = "Redemption" },
    { Class = "Priest",  Priority = 50, Spell = "Resurrection" },
    { Class = "Rogue",   Priority = 20, Spell = nil },
    { Class = "Shaman",  Priority = 55, Spell = "Ancestral Spirit" },
    { Class = "Warlock", Priority = 30, Spell = nil },
    { Class = "Warrior", Priority = 20, Spell = nil }
}

-------------------------------------------------------------------------------
-- Local Helpers {{{
-------------------------------------------------------------------------------

local function MBH_ChooseCorpse(Table)
    table.sort(Table, function(a, b) return a.Priority > b.Priority end)

    for _, v in ipairs(Table) do
        if SpellCanTargetUnit(v.UnitID) then
            return v.UnitID
        end
    end
	return nil
end

local function MBH_GetClassInfo(Class)
    for _, v in ipairs(ResurrectionInfo) do
        if v.Class == Class then
            return v
        end
    end
    return nil
end

local function MBH_IsPlayerBlackListed(Name)
    return MBH.Session.Reviving.ResurrectionBlackList[Name] ~= nil
end

-------------------------------------------------------------------------------
-- Core Ress Code {{{
-------------------------------------------------------------------------------

function MBH_Resurrection()

    local pClassInfo = MBH_GetClassInfo(MBH.Session.PlayerClass)
    local pSpellName = pClassInfo.Spell
    local pGroupType = MBH.Session.Group[3]

    if (pGroupType == "player" and not pSpellName) or mb_imBusy() or MBH.Session.InCombat then
        return
    end

    local pGroupSize = MBH.Session.Group[2]
    local pGroupChannel = string.upper(pGroupType)
    local RessTable = {}

    for n = 1, pGroupSize do

        local UnitID = pGroupType..n
        local Name = UnitName(UnitID)

        if UnitIsDead(UnitID) and UnitIsConnected(UnitID) and UnitIsVisible(UnitID) and 
            mb_in28yardRange(UnitID) and not MBH_IsPlayerBlackListed(Name) then

            local tClassInfo = MBH_GetClassInfo(UnitClass(UnitID))
            local tPriority = tClassInfo.Priority
            local ptName = UnitName("playertarget")

            if ptName and ptName == Name then
                tPriority = 100
            end
            
            tPriority = tPriority + math.random()
            table.insert(RessTable, { UnitID = UnitID, Priority = tPriority })
        end
    end	
    
    if table.getn(RessTable) == 0 then
        if next(MBH.Session.Reviving.ResurrectionBlackList) then
            MBH_ErrorMessage("There is no one to resurrect.") 
        else
            MBH_ErrorMessage("All targets have received a res.") 
            mb_setup()
        end
        return
    end
    
    CastSpellByName(pSpellName)
    local tUnitID = MBH_ChooseCorpse(RessTable)	

    if tUnitID then

        SpellTargetUnit(tUnitID)

        if not SpellIsTargeting() then
            local tName = UnitName(tUnitID)
            MBH_ResurrectionBlackPlayer(tName)
            SendAddonMessage(MBH.Session.Reviving.Add_BlackList, tName, pGroupChannel)
            mb_message("Ressing <"..tName..">")
        else
            SpellStopTargeting()
        end
    else
        SpellStopTargeting()
    end
end