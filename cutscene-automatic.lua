local function try_play_star_cutscene()
    kaze_cutscene_end()

    ---@type NetworkPlayer
    local np = gNetworkPlayers[0]

    local cNum, aNum = np.currCourseNum, np.currActNum

    if gStarCutscenes[cNum] then
        local cutscene = gStarCutscenes[cNum][aNum]

        if cutscene then
            kaze_cutscene_play(cutscene, true)
        end
    end
end

-- this is messy
local shouldTryIntro = true

local function on_level_init()
    local course = gNetworkPlayers[0].currCourseNum

    if course == COURSE_NONE then
        if shouldTryIntro and get_curr_star_count() == 0 then
            kaze_cutscene_play(CUTSCENE_INTRO, false)
        end

        shouldTryIntro = false
    else
        try_play_star_cutscene()
    end
end

hook_event(HOOK_ON_LEVEL_INIT, on_level_init)


