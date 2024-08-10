-- name: Rideable Yoshi v1.8
-- description: Run around with a Yoshi friend with this mod. \n\nMod by \\#00ffff\\steven.
ACT_RIDE_YOSHI_IDLE = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_STATIONARY | ACT_FLAG_IDLE)
ACT_RIDE_YOSHI_WALK = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING)
ACT_RIDE_YOSHI_JUMP = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_CONTROL_JUMP_HEIGHT)
ACT_RIDE_YOSHI_FLUTTER = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_CONTROL_JUMP_HEIGHT)
ACT_RIDE_YOSHI_FALL = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_MOVING)

local SOUND_YOSHI_FLUTTER = audio_sample_load("flutter.mp3")

E_MODEL_YOSHI_NEST = smlua_model_util_get_id("yoshi_nest_geo")
YOSHI_NEST_COLLISION = smlua_collision_util_get("yoshi_nest_collision")
E_MODEL_YOSHI_RIDEABLE_EGG = smlua_model_util_get_id("yoshi_rideable_egg_geo")

RY_DEBUG_MODE = false
gGlobalSyncTable.host_only = true

gStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gStateExtras[i] = {}
    local m = gMarioStates[i]
    local e = gStateExtras[i]
    e.flutterDelay = 0
    e.interactionType = 0
end

function convert_s16(num)
    local min = -32768
    local max = 32767
    while (num < min) do
        num = max + (num - min)
    end
    while (num > max) do
        num = min + (num - max)
    end
    return num
end

function yoshi_dismount_check(m)
    if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
        mario_stop_riding_object(m)
        m.pos.y = m.marioObj.header.gfx.pos.y
        set_mario_action(m, ACT_TRIPLE_JUMP, 0)
    end
end

function yoshi_mount_update_walking_speed(m)
    local maxTargetSpeed = 0
    local targetSpeed = 0

    if (m.floor ~= nil and m.floor.type == SURFACE_SLOW) then
        maxTargetSpeed = 32.0
    else
        maxTargetSpeed = 48.0
    end
    
    if m.intendedMag < 24 then
        targetSpeed = m.intendedMag
    else
        targetSpeed = maxTargetSpeed
    end

    if (m.quicksandDepth > 10.0) then
        targetSpeed = targetSpeed * (6.25 / m.quicksandDepth)
    end

    if (m.forwardVel <= 0.0) then
        m.forwardVel = m.forwardVel + 1.1
    elseif (m.forwardVel <= targetSpeed) then
        m.forwardVel = m.forwardVel + (1.1 - m.forwardVel / targetSpeed)
    elseif (m.floor ~= nil and m.floor.normal.y >= 0.95) then
        m.forwardVel = m.forwardVel - 1.0
    end

    if (m.forwardVel > 64.0) then
        m.forwardVel = 64.0
    end
    
    m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x800, 0x800)
    
    apply_slope_accel(m)
end

function act_ride_yoshi_idle(m)
    local e = gStateExtras[m.playerIndex]
    set_mario_animation(m, MARIO_ANIM_SLIDING_ON_BOTTOM_WITH_LIGHT_OBJ)
    smlua_anim_util_set_animation(m.marioObj, "MARIO_RIDING_YOSHI_IDLE")

    yoshi_dismount_check(m)
    local stepResult = stationary_ground_step(m)
    if stepResult == GROUND_STEP_LEFT_GROUND then
        return set_mario_action(m, ACT_RIDE_YOSHI_FALL, 0)
    end
    if (m.input & INPUT_A_PRESSED) ~= 0 then
        return set_mario_action(m, ACT_RIDE_YOSHI_JUMP, 0)
    end
    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        m.faceAngle.y = m.intendedYaw
        set_mario_action(m, ACT_RIDE_YOSHI_WALK, 0)
    else
        mario_set_forward_vel(m, 0)
    end
end

function act_ride_yoshi_walk(m)
    local e = gStateExtras[m.playerIndex]

    set_mario_animation(m, MARIO_ANIM_SLIDING_ON_BOTTOM_WITH_LIGHT_OBJ)
    smlua_anim_util_set_animation(m.marioObj, "MARIO_RIDING_YOSHI_RUN")

    yoshi_mount_update_walking_speed(m)
    local stepResult = perform_ground_step(m)

    if stepResult == GROUND_STEP_LEFT_GROUND then
        return set_mario_action(m, ACT_RIDE_YOSHI_FALL, 1)
    elseif stepResult == GROUND_STEP_HIT_WALL then
        m.forwardVel = 6
        if (m.input & INPUT_ZERO_MOVEMENT) ~= 0 then
            return set_mario_action(m, ACT_RIDE_YOSHI_IDLE, 0)
        end
    elseif stepResult == GROUND_STEP_NONE then
        if (m.intendedMag - m.forwardVel > 16.0) then
            m.particleFlags = m.particleFlags | PARTICLE_DUST
        end
    end

    if (m.input & INPUT_A_PRESSED) ~= 0 then
        return set_mario_action(m, ACT_RIDE_YOSHI_JUMP, 0)
    end
    if math.abs(m.forwardVel) <= 1 then
        set_mario_action(m, ACT_RIDE_YOSHI_IDLE, 0)
    end
    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        if m.forwardVel <= 5 then
            mario_set_forward_vel(m, 5)
        end
    end
    yoshi_dismount_check(m)
end

function act_ride_yoshi_flutter(m)
    local e = gStateExtras[m.playerIndex]

    if m.actionTimer == 0 then
        if m.vel.y < -10 then
            m.vel.y = -10
        elseif m.vel.y > 0 then
            m.vel.y = 0
        end
    end

    if m.actionTimer <= 20 then
        if (m.controller.buttonDown & A_BUTTON) ~= 0 then
            if m.flags & (MARIO_WING_CAP) ~= 0 then
                m.vel.y = m.vel.y + 10
            else
                m.vel.y = m.vel.y + 5
            end
        else
            audio_sample_play(SOUND_YOSHI_FLUTTER, m.marioObj.header.gfx.cameraToObject, 1)
            e.flutterDelay = 15
            set_mario_action(m, ACT_RIDE_YOSHI_FALL, 1)
        end
    else
        audio_sample_play(SOUND_YOSHI_FLUTTER, m.marioObj.header.gfx.cameraToObject, 1)
        e.flutterDelay = 15
        set_mario_action(m, ACT_RIDE_YOSHI_FALL, 1)
    end

    local stepResult = perform_air_step(m, 0)
    update_air_without_turn(m)
    if stepResult == AIR_STEP_LANDED then
        set_mario_action(m, ACT_RIDE_YOSHI_WALK, 0)
    end

    yoshi_dismount_check(m)
    set_mario_animation(m, MARIO_ANIM_SLIDING_ON_BOTTOM_WITH_LIGHT_OBJ)
    smlua_anim_util_set_animation(m.marioObj, "MARIO_RIDING_YOSHI_FLUTTER")

    if m.flags & (MARIO_WING_CAP) ~= 0 then
        m.actionTimer = 0
        m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x800, 0x800)
    else
        m.actionTimer = m.actionTimer + 1
    end
end

function act_ride_yoshi_jump(m)
    local e = gStateExtras[m.playerIndex]

    if m.actionTimer == 0 then
        play_character_sound(m, CHAR_SOUND_YAH_WAH_HOO)
    end

    if m.actionTimer > 0 then
        if (m.controller.buttonDown & A_BUTTON) ~= 0 and e.flutterDelay <= 0 then
            return set_mario_action(m, ACT_RIDE_YOSHI_FLUTTER, 0)
        end
    end

    local stepResult = perform_air_step(m, 0)
    update_air_without_turn(m)
    if stepResult == AIR_STEP_LANDED then
        set_mario_action(m, ACT_RIDE_YOSHI_WALK, 0)
    end

    yoshi_dismount_check(m)
    set_mario_animation(m, MARIO_ANIM_SLIDING_ON_BOTTOM_WITH_LIGHT_OBJ)
    smlua_anim_util_set_animation(m.marioObj, "MARIO_RIDING_YOSHI_JUMP")
    m.actionTimer = m.actionTimer + 1
end

function act_ride_yoshi_fall(m)
    local e = gStateExtras[m.playerIndex]

    local stepResult = perform_air_step(m, 0)
    if m.actionTimer > 0 then
        if (m.controller.buttonDown & A_BUTTON) ~= 0 and e.flutterDelay <= 0 then
            return set_mario_action(m, ACT_RIDE_YOSHI_FLUTTER, 0)
        end
    end

    update_air_without_turn(m)

    if stepResult == AIR_STEP_LANDED then
        set_mario_action(m, ACT_RIDE_YOSHI_WALK, 0)
    end

    yoshi_dismount_check(m)
    set_mario_animation(m, MARIO_ANIM_SLIDING_ON_BOTTOM_WITH_LIGHT_OBJ)
    smlua_anim_util_set_animation(m.marioObj, "MARIO_RIDING_YOSHI_FALL")
    m.actionTimer = m.actionTimer + 1
end

function act_yoshi_dismount_after_star_grab(m)
    if (m.pos.y < m.waterLevel - 130) then
        play_sound(SOUND_ACTION_UNKNOWN430, m.marioObj.header.gfx.cameraToObject)
        set_mario_particle_flags(m, PARTICLE_WATER_SPLASH, false)
        return set_mario_action(m, ACT_STAR_DANCE_WATER, m.actionArg)
    end
    if (perform_air_step(m, 1) == AIR_STEP_LANDED) then
        play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
        if m.actionArg == 1 then
            set_mario_action(m, ACT_STAR_DANCE_NO_EXIT, m.actionArg)
        else
            set_mario_action(m, ACT_STAR_DANCE_EXIT, m.actionArg)
        end
    end
    set_mario_animation(m, MARIO_ANIM_GENERAL_FALL)
    return false
end

function mario_on_set_action(m)
    if m.action == ACT_RIDE_YOSHI_JUMP then
        m.vel.y = 50
    end
end

function mario_update(m)
    local e = gStateExtras[m.playerIndex]

    if (gGlobalSyncTable.host_only == true and not network_is_server()) and RY_DEBUG_MODE == true then
        djui_popup_create("Debug Mode access has been revoked by the host.", 1)
        RY_DEBUG_MODE = false
    end

    if RY_DEBUG_MODE == true then
        if m.playerIndex == 0 then
            if (m.controller.buttonPressed & D_JPAD) ~= 0 then
                spawn_sync_object(id_bhvYoshiRideable, E_MODEL_YOSHI, m.pos.x + 150, m.pos.y, m.pos.z, nil)
            end
            if (m.controller.buttonPressed & U_JPAD) ~= 0 then
                spawn_sync_object(id_bhvYoshiSpawnEgg, E_MODEL_YOSHI_RIDEABLE_EGG, m.pos.x + 150, m.pos.y, m.pos.z, nil)
            end
            if (m.controller.buttonPressed & R_JPAD) ~= 0 then
                spawn_sync_object(id_bhvYoshiNest, E_MODEL_YOSHI_NEST, m.pos.x + 150, m.pos.y, m.pos.z, nil)
            end
        end
    end

    if m.pos.y == m.floorHeight then
        e.flutterDelay = 10
    else
        e.flutterDelay = e.flutterDelay - 1
    end

    return 0
end

function allow_interact(m, o, intType)
    local e = gStateExtras[m.playerIndex]

    local yoshiRidingActions = {
        [ACT_RIDE_YOSHI_IDLE] = true,
        [ACT_RIDE_YOSHI_WALK] = true,
        [ACT_RIDE_YOSHI_JUMP] = true,
        [ACT_RIDE_YOSHI_FALL] = true,
        [ACT_RIDE_YOSHI_FLUTTER] = true
    }

    if intType == INTERACT_POLE or intType == INTERACT_KOOPA_SHELL then
        if yoshiRidingActions[m.action] then
            return false
        end
    end

    e.interactionType = intType
end

function on_interact(m, obj, intType)
    local e = gStateExtras[m.playerIndex]
    if obj_has_behavior_id(obj, id_bhvYoshiSpawnEgg) ~= 0 then
        if (m.action & ACT_FLAG_AIR) ~= 0 and (m.pos.y <= obj.oPosY + obj.hitboxHeight and m.vel.y < 0) then
            lua_yosh_bounce_off_object(m, obj, 30.0)
            obj.oInteractStatus = obj.oInteractStatus | INT_STATUS_INTERACTED
        end
        if
            (m.action & ACT_FLAG_AIR) == 0 and
                ((m.action & ACT_FLAG_ATTACKING) ~= 0 and
                    (m.action & (ACT_FLAG_BUTT_OR_STOMACH_SLIDE | ACT_FLAG_DIVING)) == 0)
         then
            lua_bounce_back_from_attack(m, e.interactionType)
        end
    end
    return 0
end

function debug_mode_command(msg)
    local m = gMarioStates[0]

    if msg == "host-only" and network_is_server() then
        if gGlobalSyncTable.host_only == false then
            djui_popup_create("Debug Mode limited to \\#FFF700\\host\\#FFFFFF\\.", 1)
            gGlobalSyncTable.host_only = true
        elseif gGlobalSyncTable.host_only == true then
            djui_popup_create("Debug Mode available to \\#00C7FF\\everyone\\#FFFFFF\\!", 1)
            gGlobalSyncTable.host_only = false
        end
        return true
    end

    if gGlobalSyncTable.host_only == false or (gGlobalSyncTable.host_only == true and network_is_server()) then
        if msg == "on" then
            djui_popup_create("Debug Mode \\#00C7FF\\Activated\\#FFFFFF\\!", 1)
            RY_DEBUG_MODE = true
            return true
        elseif msg == "off" then
            djui_popup_create("Debug Mode \\#A02200\\Deactivated\\#FFFFFF\\.", 1)
            RY_DEBUG_MODE = false
            return true
        end
    else
        if msg == "on" or msg == "off" then
            djui_popup_create("Sorry, but only the \\#FFF700\\host\\#FFFFFF\\ can use Debug Mode!", 1)
        end
    end

    return false
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_SET_MARIO_ACTION, mario_on_set_action)
hook_event(HOOK_ALLOW_INTERACT, allow_interact)
hook_event(HOOK_ON_INTERACT, on_interact)

hook_mario_action(ACT_RIDE_YOSHI_IDLE, {every_frame = act_ride_yoshi_idle})
hook_mario_action(ACT_RIDE_YOSHI_WALK, {every_frame = act_ride_yoshi_walk})
hook_mario_action(ACT_RIDE_YOSHI_JUMP, {every_frame = act_ride_yoshi_jump})
hook_mario_action(ACT_RIDE_YOSHI_FLUTTER, {every_frame = act_ride_yoshi_flutter})
hook_mario_action(ACT_RIDE_YOSHI_FALL, {every_frame = act_ride_yoshi_fall})