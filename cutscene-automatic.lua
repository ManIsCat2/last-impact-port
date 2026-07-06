local function try_play_star_cutscene()
    kaze_cutscene_end()

    local np = gNetworkPlayers[0]
    local cNum, aNum = np.currCourseNum, np.currActNum

    if gStarCutscenes[cNum] then
        local cutscene = gStarCutscenes[cNum][aNum]

        if cutscene then
            kaze_cutscene_play(cutscene, true)
        end
    end
end

hook_event(HOOK_ON_LEVEL_INIT, try_play_star_cutscene)


