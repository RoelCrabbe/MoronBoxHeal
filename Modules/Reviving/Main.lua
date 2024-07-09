-------------------------------------------------------------------------------
-- Local Variables {{{
-------------------------------------------------------------------------------

local _G, _M = getfenv(0), {}
setfenv(1, setmetatable(_M, {__index=_G}))

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
-- Core Ress Code {{{
-------------------------------------------------------------------------------

function _G.MBH_Resurrection()

    local pClassInfo = MBH_GetClassInfo(MBH.Session.PlayerClass)
    local pSpellName = pClassInfo.Spell
    local GroupType = MBH.Session.Group[3]

    if (MBH.Session.Group and GroupType == "player" and not pSpellName) or mb_imBusy() or MBH.Session.InCombat then
        return
    end

    local GroupSize = MBH.Session.Group[2]
    local GroupChannel = string.upper(GroupType)
    local RessTable = {}

    for n = 1, GroupSize, 1 do

        local UnitID = GroupType..n
        local tName = UnitName(UnitID)

        if UnitIsDead(UnitID) and UnitIsConnected(UnitID) and UnitIsVisible(UnitID) and mb_in28yardRange(UnitID) and not MBH_IsPlayerBlackListed(tName) then

            local tClassInfo = MBH_GetClassInfo(UnitClass(UnitID))
            local tPriority = tClassInfo.Priority
            local ptName = UnitName("playertarget")

            if ptName and ptName == tName then
                tPriority = 100
            end
            
            tPriority = tPriority + math.random()
            table.insert(RessTable, { UnitID = UnitID, Priority = tPriority })
        end
    end	
    
    if table.getn(RessTable) == 0 then
        if next(MBH.Session.Reviving.ResurrectionBlackList) ~= nil then
            MBH_ErrorMessage("There is no one to resurrect.") 
        else
            MBH_ErrorMessage("All targets have received a res.") 
            mb_setup()
        end
        return
    end
    
    CastSpellByName(pSpellName)

    local UnitID = MBH_ChooseCorpse(RessTable)	

    if UnitID then
        SpellTargetUnit(UnitID)

        if not SpellIsTargeting() then
            local tName = UnitName(UnitID)
            MBH_BlackListPlayer(tName)
            SendAddonMessage(MBH.Session.Reviving.Add_BlackList, tName, GroupChannel)
            mb_message("Ressing <"..tName..">")
        else
            SpellStopTargeting()
        end
    else
        SpellStopTargeting()
    end
end

-------------------------------------------------------------------------------
-- Local Helpers {{{
-------------------------------------------------------------------------------

function MBH_ChooseCorpse(Table)
    table.sort(Table, function(a, b) return a.Priority > b.Priority end)

    for _, v in ipairs(Table) do
        if SpellCanTargetUnit(v.UnitID) then
            return v.UnitID
        end
    end
	return nil
end

function MBH_GetClassInfo(Class)
    for _, v in ipairs(ResurrectionInfo) do
        if v.Class == Class then
            return v
        end
    end
    return nil
end

function MBH_IsPlayerBlackListed(Name)
    return MBH.Session.Reviving.ResurrectionBlackList[Name] ~= nil
end