-- name: \\#FF4500\\SM64 Last Impact
-- incompatible: romhack
-- description: Port of Last Impact by Kaze Emanuar.\n\nPorted By:\n\\#00ff00\\I'mYourCat\\#FF0000\\2\n\\#dcdcdc\\x\\#00FF00\\Luigi\\#434343\\Gamer\\#dcdcdc\\x\n\\#0000FF\\Woissil\n\\#FFFF00\\EmeraldSniper\n\\#A9A9A9\\Fearl

gMarioStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gMarioStateExtras[i] = {}
    local e = gMarioStateExtras[i]
    e.fuzzied = false
    e.fuzziedtimer = 0
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

hook_event(HOOK_MARIO_UPDATE, fuzzy_dizziness)
