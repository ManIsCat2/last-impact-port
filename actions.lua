ACT_BACKWARD_AIR_KB_MODIFIED = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_INVULNERABLE |
    ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
ACT_BOBOMB_GAURD_DEATH = allocate_mario_action(ACT_GROUP_CUTSCENE | ACT_FLAG_STATIONARY)
ACT_FLUDD_FLOAT = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)

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

function act_fludd_float(m)
    play_mario_sound(m, SOUND_ACTION_TERRAIN_JUMP, 0);
    common_air_action_step(m, ACT_JUMP_LAND, CHAR_ANIM_DOUBLE_JUMP_RISE,
        AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG);
    m.faceAngle.y = approach_s16_symmetric(m.faceAngle.y, s16(m.intendedYaw), 0x280)
    targetSpeed = m.intendedMag < 12 and m.intendedMag or 12;
    if (m.forwardVel <= 0.0) then
        m.forwardVel = m.forwardVel + 1.1;
    elseif (m.forwardVel <= targetSpeed) then
        m.forwardVel = m.forwardVel + 1.1 - m.forwardVel / 43.0;
    elseif (m.floor ~= nil and m.floor.normal.y >= 0.95) then
        m.forwardVel = m.forwardVel - 1.0;
    end
    m.pos.y = m.pos.y +1
    if (m.forwardVel > 12) then
        m.forwardVel = 12;
    end
end

local function act_kaze_cutscene(m)
    if not gCutsceneActive then
        set_mario_action(m, m.prevAction, 0)
    end
end

ACT_KAZE_CUTSCENE = allocate_mario_action(ACT_FLAG_CUSTOM_ACTION | ACT_FLAG_INTANGIBLE)

hook_mario_action(ACT_BACKWARD_AIR_KB_MODIFIED, { every_frame = act_backward_air_kb_modified })
hook_mario_action(ACT_BOBOMB_GAURD_DEATH, { every_frame = act_bobomb_gaurd_death })
hook_mario_action(ACT_FLUDD_FLOAT, { every_frame = act_fludd_float })
hook_mario_action(ACT_KAZE_CUTSCENE, act_kaze_cutscene)
