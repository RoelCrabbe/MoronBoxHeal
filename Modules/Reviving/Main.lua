-------------------------------------------------------------------------------
-- Local Variables {{{
-------------------------------------------------------------------------------

local ResurrectionInfo = {
    { Class = "Druid",   Priority = 40, Spell = "Rebirth" },
    { Class = "Hunter",  Priority = 30, Spell = nil },
    { Class = "Mage",    Priority = 40, Spell = nil },
    { Class = "Paladin", Priority = 50, Spell = "Redemption" },
    { Class = "Priest",  Priority = 50, Spell = "Resurrection" },
    { Class = "Rogue",   Priority = 10, Spell = nil },
    { Class = "Shaman",  Priority = 50, Spell = "Ancestral Spirit" },
    { Class = "Warlock", Priority = 30, Spell = nil },
    { Class = "Warrior", Priority = 20, Spell = nil }
}

function MBH_GetClassInfo(Class)
    for _, v in ipairs(ResurrectionInfo) do
        if v.Class == Class then
            return v
        end
    end
    return nil
end

function MBH_BlackListPlayer(UnitID)
    if not MBH.Session.Reviving.ResurrectionBlackList[UnitID] then
        MBH.Session.Reviving.ResurrectionBlackList[UnitID] = 10
    end
end

function MBH_IsPlayerBlackListed(UnitID)
    return MBH.Session.Reviving.ResurrectionBlackList[UnitID] ~= nil
end

function MBH_PriorityReviving() -- /run MBH_PriorityReviving()

    local pClassInfo = MBH_GetClassInfo(MBH.Session.PlayerClass)
    local pSpellName = pClassInfo.Spell

    if (MBH.Session.Group and MBH.Session.Group[3] == "player" and not pSpellName) or mb_imBusy() or MBH.Session.InCombat then
        return
    end

    local GroupSize = MBH.Session.Group[2]
    local GroupType = MBH.Session.Group[3] 
    local RessTable = {}

    for n = 1, GroupSize, 1 do

        local UnitID = GroupType..n
        
        if not MBH_IsPlayerBlackListed(UnitID) and UnitIsDead(UnitID) and UnitIsConnected(UnitID) and UnitIsVisible(UnitID) and mb_in28yardRange(UnitID) then

            local tClassInfo = MBH_GetClassInfo(UnitClass(UnitID))
            local tPriority = tClassInfo.Priority
            local tName = UnitName(UnitID)
            local ptName = UnitName("playertarget")

            if ptName and ptName == tName then
                tPriority = 100
            end
            
            tPriority = tPriority + math.random()
            RessTable[table.getn(RessTable) + 1] = { UnitID, tPriority }
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
    
    MBH_SortTableDescending(RessTable, 2)
    
    CastSpellByName(pSpellName)

    local UnitID = MBH_ChooseCorpse(RessTable)	
    
    if UnitID then
        -- PlayerName = UnitName(UnitID)
        
        SpellTargetUnit(UnitID)

        if not SpellIsTargeting() then
            MBH_BlackListPlayer(UnitID)
            SendAddonMessage(MBH.Session.Reviving.Add_BlackList, UnitID, "RAID")
            mb_message("Ressing <"..UnitName(UnitID)..">", 15)
        else
            SpellStopTargeting()
        end
    else
        SpellStopTargeting()
    end
end

function MBH_ChooseCorpse(Table)
	for key, val in Table do
		if SpellCanTargetUnit(val[1]) then
			return val[1]
		end
	end
	return nil
end

function MBH_SortTableDescending(SourceTable, Index)
    local doSort = true

    while doSort do
        doSort = false

        for n = 1, table.getn(SourceTable) - 1, 1 do

            local a = SourceTable[n]
            local b = SourceTable[n + 1]

            if tonumber(a[Index]) and tonumber(b[Index]) then
                if tonumber(a[Index]) < tonumber(b[Index]) then
                    SourceTable[n] = b
                    SourceTable[n + 1] = a
                    doSort = true
                end
            end
        end
    end
end
