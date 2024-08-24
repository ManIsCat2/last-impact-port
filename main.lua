-- name: [WIP] \\#FF4500\\SM64 Last Impact
-- incompatible: romhack
-- description: Romhack from the legendary Kaze, written with over 100,000\nlines of custom assembly code.\n\nPorted By:\n\\#00ff00\\I'mYourCat\\#FF0000\\2 (Creator)\n\\#dcdcdc\\x\\#00FF00\\Luigi\\#434343\\Gamer\\#dcdcdc\\x (Programmer)\n\\#0000FF\\Woissil (Model Porter)\n\\#105009\\Emeraldsniper (Programmer, Tester)\n\\#FFC0CB\\OneCalledRPG (Programmer)\n\\#A9A9A9\\Fearl (Custom Skyboxes)\n\\#FFC0CB\\MaiskX3 (Music Porter, Tester)\n\\#FF0000\\NinteNerd (Model Porter)\n\\#8B8000\\CaptainT (Tester)\n\\#ADD8E6\\Saniky (Tester)\n\\#AA336A\\Occam (Emotional Support)\n\\#FFC0CB\\Sunk (MOPS)\n\\#00FFFF\\Steven (Rideable Yoshi)

gMarioStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gMarioStateExtras[i] = {}
    local e = gMarioStateExtras[i]
    e.fuzzied = false
    e.fuzziedtimer = 0
    e.hasMagicWand = false
end

function fuzzy_dizziness(m)
    local e = gMarioStateExtras[m.playerIndex]

    if e.fuzzied and m.playerIndex == 0 then
        e.fuzziedtimer = e.fuzziedtimer + 1
        m.faceAngle.y = m.faceAngle.y + 0x240
        local fuzzytimer_max = 15 * 30
        if e.fuzziedtimer >= fuzzytimer_max then
            e.fuzziedtimer = 0
            e.fuzzied = false
        end
    end
end

function health_fix(m)
    if m.playerIndex ~= 0 then return end

    if (m.health >> 8) > 6 then
        m.health = 6 << 8
    end
end

local wdwmodf1 = 0.002
local wdwmodf2 = 500
local wdwmodf3 = 3100

function wdw_water_behavior(m)
    ---o.oPosY = o.oPosY + math_sin(o.oTimer * 0.07) * 2
    if gNetworkPlayers[0].currLevelNum == LEVEL_WDW and gNetworkPlayers[0].currAreaIndex == 1 and obj_get_nearest_object_with_behavior_id(gMarioStates[0].marioObj, bhvMouthWaterThing).oAction ~= 1 then
        set_water_level(0, (math.sin(get_global_timer() * wdwmodf1) * wdwmodf2) - wdwmodf3, true)
        set_water_level(1, (math.sin(get_global_timer() * wdwmodf1) * wdwmodf2) - wdwmodf3, true)
        set_water_level(2, (math.sin(get_global_timer() * wdwmodf1) * wdwmodf2) - wdwmodf3, true)
    end
end

function mario_update_hooks(m)
    health_fix(m)
    fuzzy_dizziness(m)
    wdw_water_behavior(m)
end

function remove_all_extra_states()
    local e = gMarioStateExtras[0]
    e.fuzzied = false
    e.fuzziedtimer = 0
    if gNetworkPlayers[0].currLevelNum ~= LEVEL_LLL then
        e.hasMagicWand = false
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update_hooks)
hook_event(HOOK_ON_DEATH, remove_all_extra_states)
hook_event(HOOK_ON_WARP, remove_all_extra_states)
