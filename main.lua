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

vec3f_set(gLevelValues.starPositions.KoopaBobStarPos, 3030, 4500, -4600)
vec3f_set(gLevelValues.starPositions.KoopaThiStarPos, 7100, -1300, -6000)
vec3f_set(gLevelValues.starPositions.KingBobombStarPos, 2000.0, 4500.0, -4500.0)
vec3f_set(gLevelValues.starPositions.KingWhompStarPos, 180.0, 3880.0, 340.0)
vec3f_set(gLevelValues.starPositions.EyerockStarPos, 0.0, -900.0, -3700.0)
vec3f_set(gLevelValues.starPositions.BigBullyStarPos, 144.0, -2750.0, -67.0)
vec3f_set(gLevelValues.starPositions.ChillBullyStarPos, 130.0, 1600.0, -4335.0)
vec3f_set(gLevelValues.starPositions.BigPiranhasStarPos, -6300.0, -1850.0, -6300.0)
vec3f_set(gLevelValues.starPositions.TuxieMotherStarPos, 3167.0, -4300.0, 5108.0)
vec3f_set(gLevelValues.starPositions.WigglerStarPos, 0.0, 2048.0, 0.0)
vec3f_set(gLevelValues.starPositions.PssSlideStarPos, -6358.0, -4300.0, 4700.0)
vec3f_set(gLevelValues.starPositions.RacingPenguinStarPos, -7339.0, -5700.0, -6774.0)
vec3f_set(gLevelValues.starPositions.TreasureChestStarPos, -1800.0, -2500.0, -1700.0)
vec3f_set(gLevelValues.starPositions.GhostHuntBooStarPos, 980.0, 1100.0, 250.0)
vec3f_set(gLevelValues.starPositions.KleptoStarPos, -5550.0, 300.0, -930.0)
vec3f_set(gLevelValues.starPositions.MerryGoRoundStarPos, -1600.0, -2100.0, 205.0)
vec3f_set(gLevelValues.starPositions.MrIStarPos, 1370.0, 2000.0, -320.0)
vec3f_set(gLevelValues.starPositions.BalconyBooStarPos, 700.0, 3200.0, 1900.0)
vec3f_set(gLevelValues.starPositions.BigBullyTrioStarPos, 3700.0, 600.0, -5500.0)

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

local wdwmodf1 = 0.006
local wdwmodf2 = 1000
local wdwmodf3 = 3000

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
