-- Handles Yoshi egg.

define_custom_obj_fields(
    {
        oYoshiEggScale = "f32",
        oYoshiEggRespawnTimer = "f32"
    }
)

local SOUND_YOSHI_EGG_HATCH = audio_sample_load("egg_hatch.mp3")

function bhv_yoshi_spawn_egg_init(obj)
    obj.oFlags = (OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    obj.oGravity = -3
    obj.oFriction = 1

    obj.oHomeX = obj.oPosX
    obj.oHomeY = obj.oPosY
    obj.oHomeZ = obj.oPosZ

    obj.activeFlags = obj.activeFlags | ACTIVE_FLAG_UNK9

    -- animations
    obj.oFaceAnglePitch = 0x00
    obj.oFaceAngleRoll = 0x00

    -- hitbox
    obj.oInteractType = INTERACT_BREAKABLE
    obj.oHealth = 1
    obj.oIntangibleTimer = 0
    obj.oYoshiEggScale = 1.8
    obj.hitboxRadius = obj.oYoshiEggScale * 50
    obj.hitboxHeight = obj.oYoshiEggScale * 50

    obj_set_billboard(obj)

    -- start synchronizing object
    network_init_object(
        obj,
        true,
        {
            "oYoshiEggScale"
        }
    )
end

function bhv_yoshi_spawn_egg_loop(o)
    local player = nearest_mario_state_to_object(o)
    local distanceToPlayer = dist_between_objects(o, player.marioObj)
    local e = gStateExtras[player.playerIndex]
    cur_obj_scale(o.oYoshiEggScale)

    if o.oAnimState > 7 then
        o.oAnimState = 0
    end

    o.oAnimState = o.oAnimState + 1
    if (o.oInteractStatus & INT_STATUS_INTERACTED) ~= 0 then
        spawn_yoshi_from_egg(o)
        o.oInteractStatus = 0
    end

    cur_obj_move_standard(-78)
    cur_obj_update_floor_and_walls()
    cur_obj_if_hit_wall_bounce_away()
    o.oForwardVel = 0
    if distanceToPlayer < 100 * o.oYoshiEggScale then
        if (player.action & ACT_FLAG_AIR) == 0 then
            lua_push_mario_out_of_object(player, o, 2)
        end
    end
    return 0
end

function spawn_yoshi_from_egg(o)
    local player = nearest_mario_state_to_object(o)
    if player.playerIndex == 0 then
        spawn_sync_object(
            id_bhvYoshiRideable,
            E_MODEL_YOSHI,
            o.oPosX,
            o.oPosY,
            o.oPosZ,
            function(obj)
                spawn_mist_particles()
                obj.oVelY = 0
            end
        )
    end
    audio_sample_play(SOUND_YOSHI_EGG_HATCH, o.header.gfx.cameraToObject, 4)
    obj_mark_for_deletion(o)
end

id_bhvYoshiSpawnEgg = hook_behavior(nil, OBJ_LIST_PUSHABLE, true, bhv_yoshi_spawn_egg_init, bhv_yoshi_spawn_egg_loop)
