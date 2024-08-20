-- Last Impact Hud Port By xLuigiGamerx --

gGlobalSyncTable.playtime = 0

if network_is_server() then
    gameTime = 0
    lastPlaytime = mod_storage_load_number("seconds") or 0
    function playtime_update()
        if is_game_paused() then return end
        gameTime = gameTime + 1
        mod_storage_save_number("seconds", math.floor(gameTime / 30) + lastPlaytime)
        gGlobalSyncTable.playtime = mod_storage_load_number("seconds")
    end

    hook_event(HOOK_UPDATE, playtime_update)
end

function new_file_hud()
    local screenWidth = djui_hud_get_screen_width()
    local screenHeight = djui_hud_get_screen_height()

    local p = {
        seconds = gGlobalSyncTable.playtime,
        minutes = math.floor(gGlobalSyncTable.playtime / 60),
        hours = math.floor(math.floor(gGlobalSyncTable.playtime / 60) / 60)
    }
    local playtimeString = string.format("PLAYTIME'%.04dH'%.02dM'%.02dS", p.hours, p.minutes - (60 * p.hours),
        p.seconds - (60 * p.minutes))

    djui_hud_print_text("NEW FILE", screenWidth / 2 - 56, screenHeight / 2 - 81, 1)
    djui_hud_print_text(playtimeString, screenWidth / 2 - 134, screenHeight / 2 + 69, 1)
end

-- Power Meter Enum

POWER_METER_LEFT = get_texture_info("Left Power Meter")
POWER_METER_RIGHT = get_texture_info("Right Power Meter")
POWER_METER_ONE = get_texture_info("One Power Meter")
POWER_METER_TWO = get_texture_info("Two Power Meter")
POWER_METER_THREE = get_texture_info("Three Power Meter")
POWER_METER_FOUR = get_texture_info("Four Power Meter")
POWER_METER_FIVE = get_texture_info("Five Power Meter")
POWER_METER_SIX = get_texture_info("Six Power Meter")

local sPowerMeterTexturesInfo = {
    POWER_METER_LEFT,
    POWER_METER_RIGHT,
    POWER_METER_ONE,
    POWER_METER_TWO,
    POWER_METER_THREE,
    POWER_METER_FOUR,
    POWER_METER_FIVE,
    POWER_METER_SIX
}

--- Overrides the original `hud_render_power_meter()` function
--- @param health integer
--- @param x number
--- @param y number
--- @param width number
--- @param height number
function hud_render_power_meter(health, x, y, width, height)
    djui_hud_render_texture(sPowerMeterTexturesInfo[1], x, y, width / 64, height / 64)
    djui_hud_render_texture(sPowerMeterTexturesInfo[2], x + (width - 2) / 2, y, width / 64, height / 64)
    local numWedges = math.min(math.max(math.floor((health >> 8) * 3 / 4), 0), 6)
    if numWedges ~= 0 then
        djui_hud_render_texture(sPowerMeterTexturesInfo[numWedges + 2], x + (width - 4) / 4, y + height / 4, width / 64,
            height / 64)
    end
end

function base_hud()
    if _G.OmmEnabled and _G.OmmApi.omm_get_setting(gMarioStates[0], "hud") == 0 or not _G.OmmEnabled then
        local screenWidth = djui_hud_get_screen_width()
        local screenHeight = djui_hud_get_screen_height()

        ---@type MarioState
        local m = gMarioStates[0]

        -- Life Counter

        local lifeIcon = charSelect and charSelect.character_get_life_icon(0) or m.character.hudHeadTexture
        djui_hud_render_texture(lifeIcon, 22, 15, charSelect and 16/lifeIcon.width or 1, charSelect and 16/lifeIcon.height or 1)

        djui_hud_print_text("@", 38, 15, 1)
        djui_hud_print_text(tostring(m.numLives), 54, 15, 1)

        -- Star Counter

        local starIcon = charSelect and charSelect.character_get_current_table(0).starIcon or gTextures.star
        djui_hud_render_texture(starIcon, 22, screenHeight - 32, charSelect and 16/starIcon.width or 1, charSelect and 16/starIcon.height or 1)

        djui_hud_print_text("@", 38, screenHeight - 32, 1)
        djui_hud_print_text(tostring(m.numStars), 54, screenHeight - 32, 1)

        -- Coin Counter + Reds

        djui_hud_render_texture(gTextures.coin, screenWidth - 76, screenHeight - 32, 1, 1)
        djui_hud_print_text("@", screenWidth - 76 + 16, screenHeight - 32, 1)
        djui_hud_print_text(tostring(m.numCoins), screenWidth - 76 + 32, screenHeight - 32, 1)
        numRedCoins = gMarioStates[0].area.numRedCoins - obj_count_objects_with_behavior_id(id_bhvRedCoin)

        if is_game_paused() and numRedCoins > 0 then
            djui_hud_print_text("\"@" .. tostring(numRedCoins), screenWidth / 2 + 16, screenHeight - 32, 1)
        end

        -- Custom 6 Slice Power Meter

        hud_render_power_meter(m.health, screenWidth - 66, 8, 64, 64)
    end
end

function on_hud_render_behind()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)

    local inStarSelect = obj_get_nearest_object_with_behavior_id(gMarioStates[0].marioObj, id_bhvActSelector)
    if not inStarSelect then
        hud_hide()
        base_hud()
    else
        djui_hud_print_text("COURSE", (djui_hud_get_screen_width() / 2) - djui_hud_measure_text("COURSE") + 35,
            (djui_hud_get_screen_height() / 2) + 6, 1)
    end
    --new_file_hud() unused
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_hud_render_behind)
