streamed_collosal_circuits = audio_stream_load("ColossalCircuits.mp3")
local streamed_mmm_ice = audio_stream_load("MeltyMoltenMountainsIceside.mp3")

local debugsound = {
    [streamed_mmm_ice] = "ice",
    --[streamed_mmm_fire] = "friee",
}

local default_volume = 0.9
currentAudio = nil

---@param audio ModAudio
function play_seq_streamed(audio)
    audio_stream_set_looping(audio, true)
    audio_stream_play(audio, true, default_volume)
    currentAudio = audio
end

local audios = {
    { course = COURSE_THI, audio = streamed_collosal_circuits, area = 1 },
    { course = COURSE_THI, audio = streamed_collosal_circuits, area = 2 },
    { course = 27,         audio = streamed_mmm_ice,           area = 1 },
}

function audio_stop_all()
    for i = 1, #audios do
        audio_stream_stop(audios[i].audio)
        currentAudio = nil
    end
end

local function streamed_init()
    if not obj_get_first_with_behavior_id(id_bhvActSelector) then
        ---@type NetworkPlayer
        local np = gNetworkPlayers[0]
        audio_stop_all()

        for i = 1, #audios do
            if np.currAreaIndex == audios[i].area and np.currCourseNum == audios[i].course then
                play_seq_streamed(audios[i].audio)
            end
        end
    end
end

local function streamed_loop()
    for i = 1, #audios do
        if audios[i].audio ~= nil then
            if is_game_paused() or gMarioStates[0].action == ACT_START_SLEEPING or gMarioStates[0].action == ACT_SLEEPING then
                audio_stream_set_volume(audios[i].audio, 0.3)
            else
                audio_stream_set_volume(audios[i].audio, default_volume)
            end
        end
    end
end

local function update_mario_stream(m)
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

---@param o Object
local function bhv_ssl_changes_music_init(o)
    o.hitboxHeight = 60000
    o.hitboxRadius = 3700
    o.hitboxDownOffset = 2000
    o.oIntangibleTimer = 0
end

---@param o Object
local function bhv_ssl_changes_music_loop(o)
    -- djui_chat_message_create(tostring(debugsound[currentAudio]))
    if obj_check_hitbox_overlap(gMarioStates[0].marioObj, obj_get_nearest_object_with_behavior_id(gMarioStates[0].marioObj, bhvSSLChangesMusic)) then
        if currentAudio ~= streamed_mmm_ice then
            play_seq_streamed(streamed_mmm_ice)
            set_background_music(0, 0,0)
        end
    else
        if get_current_background_music() ~= 47 then
            set_background_music(0, 47, 0)
            audio_stop_all()
        end
    end
    if o.oBehParams == 1 then
        o.hitboxRadius = 6000
    end
    if o.oBehParams == 2 then
        o.hitboxRadius = 5600 * 2.3
    end
end

bhvSSLChangesMusic = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_ssl_changes_music_init, bhv_ssl_changes_music_loop)

hook_event(HOOK_UPDATE, streamed_loop)
hook_event(HOOK_MARIO_UPDATE, update_mario_stream)
hook_event(HOOK_ON_SYNC_VALID, streamed_init)
