-- Rideable Yoshi behavior.

E_MODEL_YOSHI_RIDEABLE = smlua_model_util_get_id("yoshi_rideable_geo")
E_MODEL_YOSHI_RIDEABLE_RECOLORABLE = smlua_model_util_get_id("yoshi_rideable_recolorable_geo")
E_MODEL_YOSHI_METAL = smlua_model_util_get_id("yoshi_metal_geo")
-- E_MODEL_YOSHI_NEST = smlua_model_util_get_id("yoshi_nest_geo")



local SOUND_YOSHI_FLUTTER_SHORT = audio_sample_load("flutter-short.mp3")
local SOUND_YOSHI_HIT = audio_sample_load("yoshi_hit.mp3")

define_custom_obj_fields(
    {
        oYoshiIdleTimer = "f32",
        oYoshiCustomBlinkTimer = "s32"
    }
)

function bhv_yoshi_rideable_init(obj)
    cur_obj_init_animation(0)
    obj.oFlags = (OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    obj.oGravity = -3
    obj.oFriction = 1

    obj.activeFlags = obj.activeFlags | ACTIVE_FLAG_UNK9
    cur_obj_scale(1)

    -- animations
    obj.oAnimations = gObjectAnimations.yoshi_seg5_anims_05024100
    obj.oFaceAnglePitch = 0x00
    obj.oFaceAngleRoll = 0x00
    obj.oAction = 0

    -- hitbox
    obj.oHealth = 1
    obj.oIntangibleTimer = 0
    obj.oYoshiCustomBlinkTimer = 0

    obj.hitboxRadius = obj.header.gfx.scale.x * 50
    obj.hitboxHeight = obj.header.gfx.scale.y * 40

    -- start synchronizing object
    network_init_object(
        obj,
        true,
        {
            "oYoshiIdleTimer",
            "oYoshiCustomBlinkTimer"
        }
    )
end

function bhv_yoshi_rideable_loop(o)
    -- o.oAnimState = 0
    local player = nearest_mario_state_to_object(o)
    local distanceToPlayer = dist_between_objects(o, player.marioObj)
    local rider = nil

    yoshi_set_model(o)

    if o.oAction == 0 then -- Unridden.
        cur_obj_init_animation(0)
        o.oForwardVel = 0
        return bhv_yoshi_unridden(o)
    elseif o.oAction == 2 then
        cur_obj_init_animation_with_accel_and_sound(1, 3)
        cur_obj_play_sound_at_anim_range(0, 15, SOUND_GENERAL_YOSHI_WALK)
        o.oForwardVel = 30
        return bhv_yoshi_unridden(o)
    elseif o.oAction == 1 then -- Ridden.
        local animFrame = o.header.gfx.animInfo.animFrame
        rider = gMarioStates[o.heldByPlayerIndex]
        o.oYoshiIdleTimer = 0

        obj_copy_pos(o, rider.marioObj)
        set_anim_to_frame(rider, o.header.gfx.animInfo.animFrame)
        o.oMoveAngleYaw = rider.faceAngle.y
        o.oFaceAnglePitch = 0x00
        o.oFaceAngleRoll = 0x00

        if rider.action == ACT_RIDE_YOSHI_IDLE then
            cur_obj_init_animation(0)
        elseif rider.action == ACT_RIDE_YOSHI_WALK then
            cur_obj_init_animation_with_accel_and_sound(1, math.abs(rider.forwardVel) / 14)
            cur_obj_play_sound_at_anim_range(0, 15, SOUND_GENERAL_YOSHI_WALK)
        elseif rider.action == ACT_RIDE_YOSHI_JUMP then
            if rider.vel.y >= -21 then
                cur_obj_init_animation(2)
                if o.header.gfx.animInfo.animFrame >= 4 then
                    o.header.gfx.animInfo.animFrame = 4
                end
            else
                smlua_anim_util_set_animation(o, "YOSHI_FALL")
            end
        elseif rider.action == ACT_RIDE_YOSHI_FALL then
            smlua_anim_util_set_animation(o, "YOSHI_FALL_STATIC")
        elseif rider.action == ACT_RIDE_YOSHI_FLUTTER then
            smlua_anim_util_set_animation(o, "YOSHI_FLUTTER")
            if animFrame == 0 or animFrame == 3 then
                audio_sample_play(SOUND_YOSHI_FLUTTER_SHORT, rider.marioObj.header.gfx.cameraToObject, 1)
            end
        else
            mario_stop_riding_object(rider)
        end

        if (o.oInteractStatus & INT_STATUS_STOP_RIDING) ~= 0 then
            o.heldByPlayerIndex = 0
            if rider.hurtCounter ~= 0 then
                audio_sample_play(SOUND_YOSHI_HIT, rider.marioObj.header.gfx.cameraToObject, 1)
                o.oAction = 2
            else
                o.oAction = 0
            end
            o.oInteractStatus = 0
        end
    end
end

function bhv_yoshi_unridden(o)
    local player = nearest_mario_state_to_object(o)
    local distanceToPlayer = dist_between_objects(o, player.marioObj)
    local rider = nil

    o.oYoshiIdleTimer = o.oYoshiIdleTimer + 1
    cur_obj_move_standard(-78)
    cur_obj_update_floor_and_walls()
    cur_obj_if_hit_wall_bounce_away()
    if distanceToPlayer < 100 then
        lua_push_mario_out_of_object(player, o, 2)
    end

    if o.oYoshiIdleTimer >= 600 then
        spawn_mist_particles_with_sound(SOUND_OBJ_DYING_ENEMY1)
        obj_mark_for_deletion(o)
    end

    o.oInteractStatus = 0

    local yoshiRidingActions = {
        [ACT_RIDE_YOSHI_IDLE] = true,
        [ACT_RIDE_YOSHI_WALK] = true,
        [ACT_RIDE_YOSHI_JUMP] = true,
        [ACT_RIDE_YOSHI_FALL] = true,
        [ACT_RIDE_YOSHI_FLUTTER] = true,
        [ACT_FALL_AFTER_STAR_GRAB] = true
    }

    local yoshiGrabbingActions = {
        [ACT_PUNCHING] = true,
        [ACT_MOVE_PUNCHING] = true,
        [ACT_DIVE] = true,
        [ACT_DIVE_SLIDE] = true
    }

    if not yoshiRidingActions[player.action] then
        if
            (((player.action & ACT_FLAG_AIR) ~= 0 and (player.action & ACT_FLAG_SWIMMING_OR_FLYING) == 0 and
                player.vel.y <= 0) and
                distanceToPlayer < 85) or
                (((yoshiGrabbingActions[player.action]) and player.actionArg == 2) and distanceToPlayer < 100)
         then
            player.pos.x = o.oPosX
            player.pos.z = o.oPosZ
            player.faceAngle.y = o.oMoveAngleYaw
            cur_obj_play_sound_2(SOUND_GENERAL_YOSHI_TALK)
            player.interactObj = o
            player.usedObj = o
            player.riddenObj = o
            o.oAction = 1
            o.heldByPlayerIndex = player.playerIndex

            return set_mario_action(player, ACT_RIDE_YOSHI_FALL, 0)
        end
    end
end

function yoshi_set_model(o)
    local rider = gMarioStates[o.heldByPlayerIndex]
    o.globalPlayerIndex = network_global_index_from_local(rider.playerIndex)
    
    
    if gPlayerSyncTable[rider.playerIndex].yoshi_model == true then
        if o.oAction == 0 then
            obj_set_model_extended(o, E_MODEL_YOSHI_RIDEABLE)
        else
            if (rider.flags & MARIO_METAL_CAP) ~= 0 then
                obj_set_model_extended(o, E_MODEL_YOSHI_METAL)
            else
                obj_set_model_extended(o, E_MODEL_YOSHI_RIDEABLE_RECOLORABLE)
            end
        end
    else
        obj_set_model_extended(o, E_MODEL_YOSHI)
    end

    yoshi_update_blinking(o, 30, 60, 4)
end

function yoshi_update_blinking(o, baseCycleLength, cycleLengthRange, blinkLength)
    if (o.oYoshiCustomBlinkTimer ~= 0) then
        o.oYoshiCustomBlinkTimer = o.oYoshiCustomBlinkTimer - 1
    else
        o.oYoshiCustomBlinkTimer = random_linear_offset(baseCycleLength, cycleLengthRange)
    end

    if (o.oYoshiCustomBlinkTimer > blinkLength) then
        o.oAnimState = 0
    else
        o.oAnimState = 1
    end
end

id_bhvYoshiRideable = hook_behavior(nil, OBJ_LIST_PUSHABLE, true, bhv_yoshi_rideable_init, bhv_yoshi_rideable_loop)


gPlayerSyncTable[0].yoshi_model = true

function yoshi_model_command(msg)

    if msg == "on" then
        gPlayerSyncTable[0].yoshi_model = true
        djui_popup_create("Your Yoshi is now using the modded model.", 1)
        return true
    elseif msg == "off" then
        gPlayerSyncTable[0].yoshi_model = false
        djui_popup_create("Your Yoshi is now using the vanilla model.", 1)
        return true
    end

    if msg == "" then
        if gPlayerSyncTable[0].yoshi_model == true then
            gPlayerSyncTable[0].yoshi_model = false
            djui_popup_create("Your Yoshi is now using the vanilla model.", 1)
            return true
        else
            gPlayerSyncTable[0].yoshi_model = true
            djui_popup_create("Your Yoshi is now using the modded model.", 1)
            return true
        end
    end

    return false
end

hook_chat_command(
    "yoshi-model",
    "[\\#00C7FF\\on\\#ffffff\\|\\#A02200\\off\\#ffffff\\] Toggle between Ridable Yoshi's model and the vanilla model.",
    yoshi_model_command
)