define_custom_obj_fields(
    {
        oYoshiNestRespawnDelay = "f32"
    }
)

function bhv_yoshi_nest_init(obj)
    obj.collisionData = YOSHI_NEST_COLLISION
    obj.oCollisionDistance = 1000000
    obj.oFlags = (OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    obj.oGravity = -3
    obj.oFriction = 1

    obj.activeFlags = obj.activeFlags | ACTIVE_FLAG_UNK9
    cur_obj_scale(1)

    -- animations
    obj.oFaceAnglePitch = 0x00
    obj.oFaceAngleRoll = 0x00
    obj.oYoshiNestRespawnDelay = 10

    -- hitbox
    obj.oHealth = 1
    obj.oIntangibleTimer = 0

    obj.hitboxRadius = obj.header.gfx.scale.x * 50
    obj.hitboxHeight = obj.header.gfx.scale.y * 50

    -- start synchronizing object
    -- network_init_object(obj, nil, {"oYoshiNestRespawnDelay"})
end

function bhv_yoshi_nest_loop(o)
    load_object_collision_model()
    local player = nearest_mario_state_to_object(o)
    local egg = obj_get_nearest_object_with_behavior_id(o, id_bhvYoshiSpawnEgg)

    if (egg == nil or dist_between_objects(o, egg) > 40) then
        o.oYoshiNestRespawnDelay = o.oYoshiNestRespawnDelay - 1
        if o.oYoshiNestRespawnDelay <= 0 then
            if player.playerIndex == 0 then
                spawn_sync_object(
                    id_bhvYoshiSpawnEgg,
                    E_MODEL_YOSHI_RIDEABLE_EGG,
                    o.oPosX,
                    o.oPosY,
                    o.oPosZ,
                    function(obj)
                        spawn_mist_particles()
                    end
                )
            end
            o.oYoshiNestRespawnDelay = 600
        end
    end
end

id_bhvYoshiNest = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_yoshi_nest_init, bhv_yoshi_nest_loop)
