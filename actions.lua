--[[
#define ACT_BACKWARD_AIR_KB            0x010208B0 // (0x0B0 | ACT_FLAG_AIR | ACT_FLAG_INVULNERABLE | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)

s32 act_backward_air_kb(struct MarioState *m) {
    if (check_wall_kick(m)) {
        return TRUE;
    }

#ifndef VERSION_JP
    play_knockback_sound(m);
#else
    play_character_sound_if_no_flag(m, CHAR_SOUND_UH, MARIO_MARIO_SOUND_PLAYED);
#endif
    common_air_knockback_step(m, ACT_BACKWARD_GROUND_KB, ACT_HARD_BACKWARD_GROUND_KB, 0x0002, -16.0f);
    return FALSE;
}]]

ACT_BACKWARD_AIR_KB_MODIFIED = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_INVULNERABLE | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)


function act_backward_air_kb_modified(m)
    if (check_wall_kick(m)) ~= 0 then
        return true;
    end

    if VERSION_JP == true then
        play_knockback_sound(m);
    else
        play_character_sound_if_no_flag(m, CHAR_SOUND_UH, MARIO_MARIO_SOUND_PLAYED);
    end
    common_air_knockback_step(m, ACT_BACKWARD_GROUND_KB, ACT_HARD_BACKWARD_GROUND_KB, 0x0002, -m.actionArg);
    return 0;
end

hook_mario_action(ACT_BACKWARD_AIR_KB_MODIFIED, {every_frame = act_backward_air_kb_modified})