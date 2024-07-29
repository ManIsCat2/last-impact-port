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
            gMarioStateExtras[i].fuzziedtimer = 0
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
        o.oVelY = o.oVelY - 1.0
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

id_bhvParentAndChildRabbit = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_parent_rabbit_init, bhv_parent_rabbit_loop)

--[[[0021AD60 / 13000F60] 00 04 0000 // Start Behavior (Object type = 4)
[0021AD64 / 13000F64] 11 01 0049 // (Set bits) obj->_0x8C |= 0x0049
[0021AD68 / 13000F68] 27 26 00 00 0700EBB0 // (Set word) obj->_0x120 = 0x0700EBB0
[0021AD70 / 13000F70] 28 00 00 00 // Set obj->_0x3C from (obj->_0x120 + 0x0)
[0021AD74 / 13000F74] 10 2A 0008 // (Set value) obj->_0x130 = 8 //oInteractType
[0021AD78 / 13000F78] 23 00 00 00 0050 0050 // Set Collision sphere size (XZ radius = 80, Y radius = 80)
[0021AD80 / 13000F80] 10 3E 0002 // (Set value) obj->_0x180 = 2 //oDamageOrCoinValue
[0021AD84 / 13000F84] 2D 00 00 00 // Set inital position. (Used in Dorrie, Fly guys, etc. to determine in which range they can move)
[0021AD88 / 13000F88] 08 00 00 00 // Start of loop
[0021AD8C / 13000F8C]    10 05 0000 // (Set value) obj->_0x9C = 0 --oInteractStatus
[0021AD90 / 13000F90]    0C 00 00 00 802AEB44 // Call ASM function 0x802AEB44 //bhv_taptap_loop
[0021AD98 / 13000F98]    09 00 00 00 // End of loop]]

---@param o Object
function bhv_taptap_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO |
        OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE
    o.oDamageOrCoinValue = 2
    o.hitboxRadius = 80
    o.hitboxHeight = 80
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_DAMAGE
    cur_obj_set_home_once()
    o.oGravity = 3
    o.oForwardVel = 4
    o.oFriction = 1
    o.oBuoyancy = 1
    o.oGraphYOffset = 51
end

---@param o Object
function bhv_taptap_loop(o)
    smlua_anim_util_set_animation(o, "anim_taptap_walk")
    object_step()
    o.oInteractStatus = 0

    if o.oAction == 0 then
        if o.oDistanceToMario < 450 then
            o.oSubAction = 1
        end

        if o.oSubAction == 1 then
            o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, o.oAngleToMario, 500)
            if o.oDistanceToMario > 600 then
                o.oSubAction = 0
            end
        elseif o.oSubAction == 0 then
            o.oMoveAngleYaw = o.oMoveAngleYaw + 400
        end
    elseif o.oAction == 1 then
        o.oGraphYOffset = o.oGraphYOffset - 6
        o.oForwardVel = 0
        o.oBowserUnk106 = o.oBowserUnk106 + 1
        if o.oBowserUnk106 > 80 then
            o.oNumLootCoins = 2
            obj_explode_and_spawn_coins(46.0, 1);
        end
    end

    if o.oPosY == -2998 then
        o.oAction = 1
    end
end

bhvTapTap = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_taptap_init, bhv_taptap_loop)

--[[
[0021ADBC / 13000FBC] 00 09 0000 // Start Behavior (Object type = 9) --OBJ_LIST_SURFACE
[0021ADC0 / 13000FC0] 11 01 0041 // (Set bits) obj->_0x8C |= 0x0041 -- OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
[0021ADC4 / 13000FC4] 27 26 00 00 07017590 // (Set word) obj->_0x120 = 0x07017590 --oAnimations
[0021ADCC / 13000FCC] 28 00 00 00 // Set obj->_0x3C from (obj->_0x120 + 0x0) -- ANIMATE()
[0021ADD0 / 13000FD0] 0E 43 0500 // (Set value) obj->_0x194 = (float)1280 --oCollisionDistance
[0021ADD4 / 13000FD4] 2A 00 00 00 070176D0 // Set collision address (obj->_0x218) from address 0x070176D0
[0021ADDC / 13000FDC] 23 00 00 00 0050 0100 // Set Collision sphere size (XZ radius = 80, Y radius = 256)
[0021ADE4 / 13000FE4] 0E 2A 0002 // (Set value) obj->_0x130 = (float)2 //oINTERACTTYPE
[0021ADE8 / 13000FE8] 08 00 00 00 // Start of loop
[0021ADEC / 13000FEC]    0C 00 00 00 803839CC // Call ASM function 0x803839CC --
[0021ADF4 / 13000FF4]    0C 00 00 00 802AEF10 // Call ASM function 0x802AEF10 --load_object_collison_model
[0021ADFC / 13000FFC]    09 00 00 00 // End of loop]]

---@param o Object
function bhv_flower_generator_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1280
    o.oInteractType = INTERACT_GRABBABLE --???
    o.hitboxRadius = 80
    o.hitboxHeight = 256
    o.collisionData = smlua_collision_util_get("bob_flower_generator_collision")
    smlua_anim_util_set_animation(o, "anim_flower_generator")
end

MODEL_WHITE_FLOWER = smlua_model_util_get_id("bob_white_flower_geo")

---@param o Object
function bhv_flower_generator_loop(o)
    load_object_collision_model()

    if o.oAction == 0 then
        o.header.gfx.animInfo.curAnim.loopEnd = 0
        if (cur_obj_was_attacked_or_ground_pounded()) == 1 then
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        o.header.gfx.animInfo.curAnim.loopEnd = 88

        if o.oTimer == 40 then
            o.oDoorUnk100 = 27184
            spawn_sync_object(bhvWhiteFlower, MODEL_WHITE_FLOWER, -3428, o.oPosY + 500, -4409,
                function(obj) obj.parentObj = o end)
        end
        if o.oTimer == 88 then
            o.oAction = 0
        end
    end
end

bhvFlowerGenerator = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_flower_generator_init, bhv_flower_generator_loop)


---@param o Object
function bhv_white_flower_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.oInteractType = INTERACT_POLE
    o.hitboxHeight = 270
    o.hitboxRadius = 60
    o.hitboxDownOffset = 70
    o.oIntangibleTimer = 0
    o.oForwardVel = 22
end

---@param o Object
function bhv_white_flower_loop(o)
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x300
    o.oMoveAngleYaw = o.parentObj.oDoorUnk100
    bhv_pole_base_loop()
    o.oPosY = o.oPosY - 1.6

    if o.oTimer > 750 then
        obj_mark_for_deletion(o)
    end
end

bhvWhiteFlower = hook_behavior(nil, OBJ_LIST_POLELIKE, true, bhv_white_flower_init, bhv_white_flower_loop)

--[[
[00219EC0 / 130000C0] 00 04 0000 // Start Behavior (Object type = 4)
[00219EC4 / 130000C4] 11 01 2449 // (Set bits) obj->_0x8C |= 0x2449
[00219EC8 / 130000C8] 27 26 00 00 007EF5E0 // (Set word) obj->_0x120 = 0x007EF5E0
[00219ED0 / 130000D0] 28 00 00 00 // Set obj->_0x3C from (obj->_0x120 + 0x0)
[00219ED4 / 130000D4] 10 2A 0008 // (Set value) obj->_0x130 = 8
[00219ED8 / 130000D8] 10 3E 0002 // (Set value) obj->_0x180 = 2
[00219EDC / 130000DC] 23 00 00 00 0050 00A0 // Set Collision sphere size (XZ radius = 80, Y radius = 160)
[00219EE4 / 130000E4] 08 00 00 00 // Start of loop
[00219EE8 / 130000E8]    0C 00 00 00 802A5E84 // Call ASM function 0x802A5E84
[00219EF0 / 130000F0]    10 05 0000 // (Set value) obj->_0x9C = 0
[00219EF4 / 130000F4]    10 2B 0000 // (Set value) obj->_0x134 = 0
[00219EF8 / 130000F8]    09 00 00 00 // End of loop]]

---@param o Object
function bhv_pink_piranha_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    o.oInteractType = INTERACT_BOUNCE_TOP
    o.oDamageOrCoinValue = 2
    o.hitboxHeight = 300
    o.hitboxRadius = 130
    --o.hitboxDownOffset = 70
    o.oIntangibleTimer = 0
    o.oGraphYOffset = 150
    --o.oForwardVel = 22
end

---@param o Object
function bhv_pink_piranha_loop(o)
    obj_mark_for_deletion(o) -----not coded for now
    if o.oInteractStatus ~= 0 then
        o.oInteractStatus = 0
    end

    if o.oDistanceToMario < 1000 then
        o.oFaceAngleYaw = o.oAngleToMario + 32768
    end

    if o.oAction == 1 then
        o.oSubAction = o.oSubAction + 1

        if o.oSubAction > 30 then
            obj_mark_for_deletion(o)
            spawn_mist_particles()
        end
    end
end

bhvPinkPiranha = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_pink_piranha_init, bhv_pink_piranha_loop)
