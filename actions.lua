ACT_BACKWARD_AIR_KB_MODIFIED = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_INVULNERABLE | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
ACT_BOBOMB_GAURD_DEATH = allocate_mario_action(ACT_GROUP_CUTSCENE | ACT_FLAG_STATIONARY)


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

function act_bobomb_gaurd_death(m)

    --cant use char anim here? idk
    common_death_handler(m, MARIO_ANIM_FIRST_PERSON, 10)
    return 0;
end

hook_mario_action(ACT_BACKWARD_AIR_KB_MODIFIED, {every_frame = act_backward_air_kb_modified})
hook_mario_action(ACT_BOBOMB_GAURD_DEATH, {every_frame = act_bobomb_gaurd_death})