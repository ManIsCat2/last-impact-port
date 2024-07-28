---@param o Object
local function wiggler_loop(o)
    if o.oWigglerTextStatus == WIGGLER_TEXT_STATUS_SHOWING_DIALOG then
        o.oWigglerTextStatus = WIGGLER_TEXT_STATUS_COMPLETED_DIALOG
    end
end

hook_behavior(id_bhvWigglerHead, OBJ_LIST_GENACTOR, true, nil, wiggler_loop, "bhvWigglerHead")

---@param o Object
function bhv_fuzzy_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_MOVE_XZ_USING_FVEL | OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE
    -- according to quad64
    -- Set Hitbox size (XZ radius = 288, Y radius = 288)
    o.hitboxHeight = 288
    o.hitboxRadius = 288
    o.hitboxDownOffset = 100
    o.oIntangibleTimer = 0
    network_init_object(o, true, { "oPosX", "oPosY", "oPosZ", "oMoveAngleYaw", "oFaceAngleYaw" })
end

---@param o Object
function bhv_fuzzy_loop(o)
    o.oForwardVel = 5
    o.oPosY = o.oPosY + math.sin(o.oTimer * 0.07) * 2
    o.oMoveAngleYaw = o.oMoveAngleYaw + 90
    for i = 0, 15 do
        local m = gMarioStates[i]

        if (obj_check_hitbox_overlap(o, m.marioObj)) then
            gMarioStateExtras[i].fuzzied = true
            spawn_mist_particles()
            obj_mark_for_deletion(o)
        end
    end
end

bhvFuzzy = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fuzzy_init, bhv_fuzzy_loop)

---@param o Object
function bhv_bob_cloud_platform_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1600
    o.collisionData = smlua_collision_util_get("bob_cloud_platform_collision")
    cur_obj_set_home_once()
end

---@param o Object
function bhv_bob_cloud_platform_loop(o)
    load_object_collision_model()
    o.oVelY = approach_f32_asymptotic(o.oVelY, (o.oHomeY - o.oPosY) / 8, 0.1)
    if cur_obj_is_mario_on_platform() == 1 then
        o.oVelY = o.oVelY - 0.5
    end
    object_step()
end

hook_behavior(id_bhvCutOutObject, OBJ_LIST_SURFACE, true, bhv_bob_cloud_platform_init, bhv_bob_cloud_platform_loop)

---@param o Object
function bhv_bob_prison_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1600
    o.collisionData = smlua_collision_util_get("bob_prison_gate_collision")
end

---@param o Object
function bhv_bob_prison_gate_loop(o)
    load_object_collision_model()
end

hook_behavior(id_bhvBitfsSinkingPlatforms, OBJ_LIST_SURFACE, true, bhv_bob_prison_gate_init, bhv_bob_prison_gate_loop)

---@param o Object
function bhv_parent_rabbit_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractType = INTERACT_TEXT
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.hitboxRadius = 256
    o.hitboxHeight = 256
    o.oIntangibleTimer = 0
    o.oAnimations = gObjectAnimations.mips_seg6_anims_06015634
    cur_obj_init_animation(0)
end

MODEL_RABBIT = smlua_model_util_get_id("parent_mips_geo")

---@param o Object
function bhv_parent_rabbit_loop(o)
    obj_set_model_extended(o, MODEL_RABBIT)

    if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        gMarioStates[0].action = ACT_READING_NPC_DIALOG
        if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, o.oBehParams2ndByte) ~= 0 then
            o.oInteractStatus = 0
        end
    end

    if o.oBehParams2ndByte == 46 or o.oBehParams2ndByte == 43 then
        obj_scale(o, 3)
    end
end

id_bhvParentAndChildRabbit = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_parent_rabbit_init, bhv_parent_rabbit_loop)
