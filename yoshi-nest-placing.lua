gLevelData = nil

local placementprofile = {}
local placementlist = {nil}

local placementData = nil


function insert_romhack_placement_data(name, placementTable)
    table.insert(placementprofile, name)
    table.insert(placementlist, placementTable)
end

function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

function rom_hack_detection()
    for _, romhacks in pairs(gActiveMods) do
        if romhacks.incompatible == "romhack" then
            for i, hack in ipairs(placementprofile) do
                if hack == romhacks.name then
                    local hackIndex = indexOf(placementprofile, romhacks.name)
                    placementData = placementlist[hackIndex]

                    --djui_chat_message_create(tostring(romhacks.name) .. " Loaded.")
                    --djui_chat_message_create(tostring(i))
                    break
                else
                    placementData = nil
                    --djui_chat_message_create("Hack not found.")
                end
            end
            return 0
        else
            placementData = NestPlacementsVanilla
        end
    end

    return placementData
end

function spawn_nests()
    local currentArea = gNetworkPlayers[0].currAreaIndex
    -- spawn nests
    for _, nest in pairs(gLevelData.nests) do
        if nest.area == currentArea then
            spawn_non_sync_object(
                id_bhvYoshiNest,
                E_MODEL_YOSHI_NEST,
                nest.x,
                nest.y,
                nest.z,
                function(obj)
                    --djui_chat_message_create("Successfully spawned Yoshi nest.")
                end
            )
        end
    end
end

function on_level_init()
    rom_hack_detection()
    -- set level data
    local level = gNetworkPlayers[0].currLevelNum
    local currentArea = gNetworkPlayers[0].currAreaIndex

    --djui_chat_message_create("Entered area number " .. tostring(currentArea) .. " of level " .. tostring(level) .. ".")

    if placementData == nil then
        return
    else
        gLevelData = placementData[-1]
        if placementData[level] ~= nil then
            gLevelData = placementData[level]
        else
            gLevelData = placementData[-1]
        end
        return spawn_nests()
    end
end

hook_event(HOOK_ON_SYNC_VALID, on_level_init)

_G.RideableYoshi = {
    insert_romhack_placement_data = insert_romhack_placement_data
}

_G.RYExists = true
