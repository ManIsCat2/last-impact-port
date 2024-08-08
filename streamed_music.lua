streamed_collosal_circuits = audio_stream_load("ColossalCircuits.mp3")

default_volume = 0.6

---@param audio ModAudio
local function play_seq_streamed(audio)
    audio_stream_set_looping(audio, true)
    audio_stream_play(audio, true, default_volume)
end

local audios = {
    { course = COURSE_THI, audio = streamed_collosal_circuits, area = 1 },
    { course = COURSE_THI, audio = streamed_collosal_circuits, area = 2 },
}

function audio_stop_all()
    for i = 1, #audios do
        audio_stream_stop(audios[i].audio)
    end
end

function streamed_init()
    if not obj_get_first_with_behavior_id(id_bhvActSelector) then
        ---@type NetworkPlayer
        local np = gNetworkPlayers[0]
        audio_stop_all()

        for i = 1, #audios do
            if np.currAreaIndex == audios[i].area and np.currCourseNum == audios[i].course then
                set_background_music(0, 0, 0)
                play_seq_streamed(audios[i].audio)
            end
        end
    end
end

function streamed_loop()
    for i = 1, #audios do
        if audios[i].audio ~= nil then
            if is_game_paused() then
                audio_stream_set_volume(audios[i].audio, 0.3)
            else
                audio_stream_set_volume(audios[i].audio, default_volume)
            end
        end
    end
end

function update_mario_stream(m)
    if m.actionTimer < 80 then
        if m.action == ACT_STAR_DANCE_EXIT or m.action == ACT_STAR_DANCE_NO_EXIT or m.action == ACT_STAR_DANCE_WATER then
            if m.playerIndex == 0 then
                if gServerSettings.stayInLevelAfterStar == 0 then
                    audio_stop_all()
                end
            end
        end
    end
end

hook_event(HOOK_UPDATE, streamed_loop)
hook_event(HOOK_MARIO_UPDATE, update_mario_stream)
hook_event(HOOK_ON_SYNC_VALID, streamed_init)
