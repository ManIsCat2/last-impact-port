function lua_push_mario_out_of_object(m, o, padding)
    local minDistance = o.hitboxRadius + m.marioObj.hitboxRadius + padding

    local offsetX = m.pos.x - o.oPosX
    local offsetZ = m.pos.z - o.oPosZ
    local distance = math.sqrt(offsetX * offsetX + offsetZ * offsetZ)

    if (distance < minDistance) then
        local floor = m.floor
        local pushAngle = 0
        local newMarioX = 0
        local newMarioZ = 0

        if (distance == 0) then
            pushAngle = m.faceAngle.y
        else
            pushAngle = atan2s(offsetZ, offsetX)
        end

        newMarioX = o.oPosX + minDistance * sins(pushAngle)
        newMarioZ = o.oPosZ + minDistance * coss(pushAngle)

        if (floor ~= nil) then
            --! Doesn't update Mario's referenced floor (allows oob death when
            -- an object pushes you into a steep slope while in a ground action)
            --  <Fixed when gLevelValues.fixCollisionBugs != 0>
            m.pos.x = newMarioX
            m.pos.z = newMarioZ
        end
    end
end

function lua_attack_object(o, interaction)
    local attackType = 0

    if interaction == INT_GROUND_POUND_OR_TWIRL then
        attackType = ATTACK_GROUND_POUND_OR_TWIRL
    elseif interaction == INT_PUNCH then
        attackType = ATTACK_PUNCH
    elseif interaction == INT_KICK or interaction == INT_TRIP then
        attackType = ATTACK_KICK_OR_TRIP
    elseif interaction == INT_SLIDE_KICK or interaction == INT_FAST_ATTACK_OR_SHELL then
        attackType = ATTACK_FAST_ATTACK
    elseif interaction == INT_HIT_FROM_ABOVE then
        attackType = ATTACK_FROM_ABOVE
    elseif interaction == INT_HIT_FROM_BELOW then
        attackType = ATTACK_FROM_BELOW
    end

    o.oInteractStatus = attackType + (INT_STATUS_INTERACTED | INT_STATUS_WAS_ATTACKED)
    return attackType
end

function lua_yosh_bounce_off_object(m, o, velY)
    m.vel.y = velY

    m.flags = m.flags & ~MARIO_UNKNOWN_08

    play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
    return 0
end

function lua_bounce_back_from_attack(m, interaction)
    if (interaction & (INT_PUNCH | INT_KICK | INT_TRIP)) ~= 0 then
        if (m.action == ACT_PUNCHING) then
            m.action = ACT_MOVE_PUNCHING
        end

        if (m.action & ACT_FLAG_AIR) ~= 0 then
            mario_set_forward_vel(m, -16.0)
        else
            mario_set_forward_vel(m, -48.0)
        end

        set_camera_shake_from_hit(SHAKE_ATTACK)
        set_mario_particle_flags(m, PARTICLE_TRIANGLE, false)
    end

    if (interaction & (INT_PUNCH | INT_KICK | INT_TRIP | INT_FAST_ATTACK_OR_SHELL)) ~= 0 then
        play_sound(SOUND_ACTION_HIT_2, m.marioObj.header.gfx.cameraToObject)
    end
end

function allow_interact(m, o, intType)
    local e = gStateExtras[m.playerIndex]
    e.interactionType = intType
end
hook_event(HOOK_ALLOW_INTERACT, allow_interact)
