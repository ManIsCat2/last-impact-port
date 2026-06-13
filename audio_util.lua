local streams = {}
local prevMusic = -1

function audio_utils_replace_sequence_streamed(seqId, soundFile, looping, loopStart, loopEnd)
    smlua_audio_utils_replace_sequence(seqId, 0, 75, "00_Seq_custom")
    local stream = audio_stream_load(soundFile)

    if looping then
        audio_stream_set_looping(stream, true)

        if loopStart and loopEnd then
            audio_stream_set_loop_points(stream, loopStart, loopEnd)
        end
    end

    streams[seqId] = stream
end

local function streamed_music_update()
    local curMusic = get_current_background_music()

    if curMusic ~= prevMusic then
        local prevStream = streams[prevMusic]

        if prevStream then
            audio_stream_stop(prevStream)
        end

        local nextStream = streams[curMusic]

        if nextStream then
            audio_stream_play(nextStream, false, 1.0)
        end
    end

    local curStream = streams[curMusic]

    if curStream then
        local baseVolume = get_current_background_music_default_volume() / 127
        local fadeVolume = sequence_player_get_fade_volume(SEQ_PLAYER_LEVEL)

        audio_stream_set_volume(curStream, baseVolume > 0 and fadeVolume / baseVolume or 0)
    end

    prevMusic = curMusic
end

hook_event(HOOK_UPDATE, streamed_music_update)

