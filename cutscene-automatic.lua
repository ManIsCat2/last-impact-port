-- automatic cutscene triggers go here i guess

local delayedCutsceneTimer = -1
local delayedCutsceneData = nil
local delayedCutsceneSkipable = false

local function play_delayed_cutscene(nFrames, data, skipable)
    delayedCutsceneTimer = nFrames
    delayedCutsceneData = data
    delayedCutsceneSkipable = skipable
end

local function update_delayed_cutscene()
    if delayedCutsceneTimer > -1 then
        delayedCutsceneTimer = delayedCutsceneTimer - 1
    end

    if delayedCutsceneTimer == 0 then
        kaze_cutscene_play(delayedCutsceneData, delayedCutsceneSkipable)
    end
end

local function try_play_star_cutscene()
    kaze_cutscene_end()

    ---@type NetworkPlayer
    local np = gNetworkPlayers[0]

    local cNum, aNum = np.currCourseNum, np.currActNum

    if gStarCutscenes[cNum] then
        local cutscene = gStarCutscenes[cNum][aNum]

        if cutscene then
            play_delayed_cutscene(2, cutscene, true)
        end
    end
end

-- this is messy
-- todo play if not set function
-- plays a cutscene if var is not set, and set it to true

local shouldTryIntro = true

local function on_level_init()
    local course = gNetworkPlayers[0].currCourseNum

    if course == COURSE_NONE then
        if shouldTryIntro and get_curr_star_count() == 0 then
            play_delayed_cutscene(2, CUTSCENE_INTRO, false)
        end

        shouldTryIntro = false

        -- overworld cutscene priority:
        -- 1. intro
        -- 2. door open
        -- 3. boat
        -- 4. rocket open
        -- 5. moon

        -- peach being kidnapped is NOT a custom cutscene
        -- it should play after overworld cutscenes
    else
        try_play_star_cutscene()
    end
end

hook_event(HOOK_UPDATE, update_delayed_cutscene)
hook_event(HOOK_ON_LEVEL_INIT, on_level_init)


