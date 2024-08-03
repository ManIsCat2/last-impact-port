local repack = function(value, pack_fmt, unpack_fmt)
    return string.unpack(unpack_fmt, string.pack(pack_fmt, value))
end

---@param m MarioState
---@return boolean
local function is_bubbled(m)
    return m.action == ACT_BUBBLED
end

function spawn_object(parent, model, behaviorId)
    local obj = spawn_sync_object(behaviorId, model, 0, 0, 0, nil)
    if not obj then return nil end

    obj_copy_pos_and_angle(obj, parent)
    return obj
end

---function from SM64: Through the ages
---@param clampFloor boolean
---@param o Object
function move_obj_with_physics(clampFloor, o)
    local bounciness = o.oBounciness
    o.oVelY = o.oVelY + o.oGravity
    if o.oVelY < -70.0 then
        o.oVelY = -70.0
    end
    o.oPosY = o.oPosY + o.oVelY
    o.oMoveFlags = o.oMoveFlags & ~OBJ_MOVE_ON_GROUND

    if o.oPosY < find_floor_height(o.oPosX, o.oPosY + 70.0, o.oPosZ) and clampFloor then
        o.oPosY = find_floor_height(o.oPosX, o.oPosY + 70.0, o.oPosZ)
        o.oVelY = o.oVelY * bounciness / 100.0
        o.oMoveFlags = o.oMoveFlags | (OBJ_MOVE_ON_GROUND)
    end

    o.oPosX = o.oPosX + o.oForwardVel * sins(o.oMoveAngleYaw)
    o.oPosZ = o.oPosZ + o.oForwardVel * coss(o.oMoveAngleYaw)

    -- wall collision
    cur_obj_resolve_wall_collisions()
end

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
    nearkey = obj_get_nearest_object_with_behavior_id(o, bhvTapTapKey)
    if nearkey and nearkey.oAction == 1 then
        o.oPosY = o.oPosY - 10
    end

    if o.oPosY < -3900 then
        obj_mark_for_deletion(nearkey)
        obj_mark_for_deletion(o)
    end
end

hook_behavior(id_bhvBitfsSinkingPlatforms, OBJ_LIST_SURFACE, true, bhv_bob_prison_gate_init, bhv_bob_prison_gate_loop)

---@param o Object
function bhv_parent_rabbit_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE |OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    if o.oBehParams2ndByte == 46 or o.oBehParams2ndByte == 43 then
        o.oInteractType = INTERACT_TEXT
        o.hitboxRadius = 256
        o.hitboxHeight = 256
    else
        o.oMoveAngleYaw = -25182
        o.hitboxRadius = 120
        o.hitboxHeight = 120
    end
    o.oIntangibleTimer = 0
    o.oAnimations = gObjectAnimations.mips_seg6_anims_06015634
    cur_obj_init_animation(0)
end

MODEL_RABBIT = smlua_model_util_get_id("parent_mips_geo")

---@param o Object
function bhv_parent_rabbit_loop(o)
    obj_set_model_extended(o, MODEL_RABBIT)
    neargate = obj_get_nearest_object_with_behavior_id(o, id_bhvBitfsSinkingPlatforms)

    if o.oAction == 0 then
        if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
            gMarioStates[0].action = ACT_READING_NPC_DIALOG
            if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, o.oBehParams2ndByte) ~= 0 then
                o.oInteractStatus = 0
            end
        end
    elseif o.oAction == 1 then
        o.oSubAction = o.oSubAction + 1
        o.oPosY = find_floor_height(o.oPosX, o.oPosY, o.oPosZ)
        cur_obj_init_animation(1)
        if o.oSubAction >= 115 then
            o.oMoveAngleYaw = -18704
        end

        if o.oSubAction >= 200 then
            o.oForwardVel = 0
            o.oPosX = -286
            o.oPosY = -2655
            o.oPosZ = -12644
            o.oMoveAngleYaw = 320
            o.oSubAction = 0
            o.oAction = 0
            cur_obj_init_animation(0)
        end
    end

    if o.oBehParams2ndByte == 46 or o.oBehParams2ndByte == 43 then
        obj_scale(o, 3)
    end

    if neargate and neargate.oPosY < -3890 and o.oBehParams2ndByte == 12 then
        o.oAction = 1
        o.oForwardVel = 40
    end

    if o.oBehParams2ndByte == 12 and o.oAction == 0 then
        if o.oPosX == -286 and o.oPosY == -2655 and o.oPosZ == -12644 then
            if obj_check_hitbox_overlap(nearest_player_to_object(o), o) then
                gMarioStates[0].action = ACT_READING_NPC_DIALOG
                if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, 36) ~= 0 then
                    neareastplayer = nearest_mario_state_to_object(o)
                    spawn_default_star(neareastplayer.pos.x, neareastplayer.pos.y + 230, neareastplayer.pos.z)
                    o.oAction = 2
                end
            end
        end
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
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO |
        OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE
    o.oDamageOrCoinValue = 2
    o.hitboxRadius = 80
    o.hitboxHeight = 80
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_DAMAGE
    cur_obj_set_home_once()
    o.oGravity = 3
    o.oForwardVel = 4.1
    o.oFriction = 1
    o.oBuoyancy = 1
    o.oGraphYOffset = 51
    o.header.gfx.animInfo.animAccel = 65536 * 2
    network_init_object(o, true,
        { "oPosX", "oPosY", "oPosZ", "oMoveAngleYaw", "oNumLootCoins", "oAction", "oFaceAngleYaw" })
end

MODEL_TAPTAP_KEY = smlua_model_util_get_id("taptap_key_geo")

---@param o Object
function bhv_taptap_loop(o)
    smlua_anim_util_set_animation(o, "anim_taptap_walk")
    object_step()
    o.oInteractStatus = 0

    if o.oAction == 0 then
        if o.oDistanceToMario < 1100 then
            o.oSubAction = 1
        end

        if o.oSubAction == 1 then
            o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, obj_angle_to_object(o, nearest_player_to_object(o)),
                500)
            if o.oDistanceToMario > 1250 then
                o.oSubAction = 0
            end
        elseif o.oSubAction == 0 then
            o.oMoveAngleYaw = o.oMoveAngleYaw + 400
        end
    elseif o.oAction == 1 then
        o.oGraphYOffset = o.oGraphYOffset - 4
        o.oForwardVel = 0
        o.oBowserUnk106 = o.oBowserUnk106 + 1
        if o.oBowserUnk106 > 80 then
            if o.oBehParams2ndByte == 1 then
                spawn_sync_object(bhvTapTapKey, MODEL_TAPTAP_KEY, o.oPosX, o.oPosY, o.oPosZ, nil)
                obj_mark_for_deletion(o)
            else
                o.oNumLootCoins = 2
                obj_explode_and_spawn_coins(46.0, 1);
            end
        end
    end

    if o.oPosY == -2998 then
        o.oAction = 1
    end
end

bhvTapTap = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_taptap_init, bhv_taptap_loop)

---@param o Object
function bhv_taptap_key_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 70
    o.hitboxHeight = 70
    o.oIntangibleTimer = 0
end

---@param o Object
function bhv_taptap_key_loop(o)
    o.oPosY = o.oPosY + math.sin(o.oTimer * 0.07) * 2
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x120
    if obj_check_hitbox_overlap(nearest_player_to_object(o), o) then
        if o.oAction == 0 then
            play_puzzle_jingle()
        end
        cur_obj_disable_rendering()
        o.oAction = 1
    end
end

bhvTapTapKey = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_taptap_key_init, bhv_taptap_key_loop)

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
    o.oInteractType = INTERACT_BREAKABLE
    o.hitboxRadius = 160
    o.hitboxHeight = 256
    o.oIntangibleTimer = 0
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
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x66
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    o.oMoveAngleYaw = o.parentObj.oDoorUnk100
    bhv_pole_base_loop()
    o.oPosY = o.oPosY - 1.6

    if o.oTimer > 15 and o.oTimer < 90 then
        o.oPosX = -3214
        o.oPosY = 650
        o.oPosZ = -4576
    end
    if o.oTimer > 700 then
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

--[[
[0021DAFC / 13003CFC] 00 04 0000 // Start Behavior (Object type = 4)
[0021DB00 / 13003D00] 08 00 00 00 // Start of loop
[0021DB04 / 13003D04]    0C 00 00 00 802F71E0 // Call ASM function 0x802F71E0
[0021DB0C / 13003D0C]    09 00 00 00 // End of loop
]]

LAUNCH_STAR_ACT_IDLE = 0
LAUNCH_STAR_ACT_LAUNCH = 1

local playerLaunched = false

---@param o Object
function bhv_launch_star_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 200
    o.hitboxHeight = 200
    o.oIntangibleTimer = 0
    o.oTimer = 0
end

---@param o Object
function bhv_launch_star_loop(o)
    local m = gMarioStates[0]
    if obj_check_hitbox_overlap(m.marioObj, o) and o.oAction == LAUNCH_STAR_ACT_IDLE and m.action ~= ACT_SHOT_FROM_CANNON then
        o.oTimer = 0
        m.vel.y = 0
        o.oAction = LAUNCH_STAR_ACT_LAUNCH
        playerLaunched = true
    end

    if o.oAction == LAUNCH_STAR_ACT_LAUNCH then
        if o.oTimer == 0 then
            pos = { x = o.oPosX, y = o.oPosY, z = o.oPosZ }
            vec3f_copy(m.pos, pos)
            set_mario_action(m, ACT_GROUND_POUND, 0)
        end

        if m.vel.y < -50 then
            set_mario_action(m, ACT_SHOT_FROM_CANNON, 0)
            yVel = (o.oBehParams >> 24) & 0XFF
            forwardVel = o.oBehParams2ndByte
            m.vel.y = yVel
            m.forwardVel = forwardVel % 8 == 0 and forwardVel or forwardVel + 2
            m.faceAngle.y = o.oFaceAngleYaw
            o.oAction = LAUNCH_STAR_ACT_IDLE
        end
    end
end

local function launch_star_update(m)
    if m.playerIndex ~= 0 then return end

    if playerLaunched == true and m.action & ACT_FLAG_AIR == 0 then
        set_mario_action(m, ACT_TRIPLE_JUMP_LAND, 0)
        playerLaunched = false
    end
end

hook_event(HOOK_MARIO_UPDATE, launch_star_update)

bhvLaunchStar = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_launch_star_init, bhv_launch_star_loop)

bhvFakeStar = hook_behavior(nil, OBJ_LIST_LEVEL, true,
    function(o)
        o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    end,

    function(o)
        o.oFaceAngleYaw = o.oFaceAngleYaw + 0x660
    end)

local NOTEBLOCK_ACT_IDLE = 0
local NOTEBLOCK_ACT_BOUNCING = 1

---@param o Object
function bhv_noteblock_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("col_Noteblock_MOP_0xaa6444")
    cur_obj_set_home_once()
    obj_scale(o, 0.64)
end

---@param obj Object
function bhv_noteblock_loop(obj)
    load_object_collision_model()
    local m = gMarioStates[0]
    local y_spd = 64

    if cur_obj_is_mario_on_platform() == 1 and not is_bubbled(m) then
        if m.controller.buttonDown & A_BUTTON ~= 0 then
            y_spd = y_spd + 12 * 3
            spawn_mist_particles()
        end
        set_mario_action(m, ACT_DOUBLE_JUMP, 0)

        -- Calculates y speed
        local intermediate_y_spd = repack(y_spd, "f", "I")
        intermediate_y_spd = intermediate_y_spd + (obj.oBehParams2ndByte << 16)
        y_spd = repack(intermediate_y_spd, "I", "f")
        m.vel.y = y_spd

        obj.oAction = NOTEBLOCK_ACT_BOUNCING
    end

    if obj.oAction == NOTEBLOCK_ACT_BOUNCING then
        if obj.oTimer == 4 then
            obj.oAction = NOTEBLOCK_ACT_IDLE
            obj.oPosY = obj.oHomeY
        else
            -- Moves the noteblock slightly up and down, to give it a "bounce"
            if obj.oTimer > 2 then
                obj.oPosY = obj.oHomeY + (obj.oTimer % 3) * 6
            else
                obj.oPosY = obj.oHomeY - obj.oTimer * 6
            end
        end
    end
end

bhvNoteblock_MOP = hook_behavior(nil, OBJ_LIST_SURFACE, false, bhv_noteblock_init, bhv_noteblock_loop)

function bhv_crystal_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 3000
    o.collisionData = smlua_collision_util_get("cave_crystal_collision")
    o.header.gfx.skipInViewCheck = true
end

---scalebyparam2
function bhv_crystal_loop(o)
    load_object_collision_model()
    obj_scale(o, o.oBehParams2ndByte / 100)
end

bhvCaveCrystal = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_crystal_init, bhv_crystal_loop)

function bhv_silver_star_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
end

function bhv_silver_star_loop(o)
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x880
end

bhvSilverStar = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_silver_star_init, bhv_silver_star_loop)

--[[
[0021B224 / 13001424] 00 04 0000 // Start Behavior (Object type = 4)
[0021B228 / 13001428] 11 01 0009 // (Set bits) obj->_0x8C |= 0x0009
[0021B22C / 1300142C] 23 00 00 00 00C0 00C0 // Set Collision sphere size (XZ radius = 210, Y radius = 192)
[0021B234 / 13001434] 10 2A 0008 // (Set value) obj->_0x130 = 8
[0021B238 / 13001438] 10 3E 0001 // (Set value) obj->_0x180 = 1
[0021B23C / 1300143C] 0E 15 0020 // (Set value) obj->_0xDC = (float)32 //oGraphYOffset
[0021B240 / 13001440] 08 00 00 00 // Start of loop
[0021B244 / 13001444]    0C 00 00 00 8065EE00 // Call ASM function 0x8065EE00
[0021B24C / 1300144C]    09 00 00 00 // End of loop
]]

---@param o Object
function bhv_yellow_falling_rock_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 210
    o.hitboxHeight = 192
    o.oGravity = 5
    o.oDamageOrCoinValue = 1
    o.oInteractType = INTERACT_DAMAGE
    o.oIntangibleTimer = 0
    o.oGraphYOffset = 32
end

---@param o Object
function bhv_yellow_falling_rock_loop(o)
    if o.oAction == 0 then
        if dist_between_objects(o, nearest_player_to_object(o)) < 1350 then
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        result = object_step()
        if result & OBJ_COL_FLAG_GROUNDED == 1 then
            cur_obj_play_sound_2(SOUND_GENERAL_BIG_POUND)
            obj_mark_for_deletion(o)
        end
    end
end

bhvYellowFallingRock = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_yellow_falling_rock_init,
    bhv_yellow_falling_rock_loop)


---@param o Object
function bhv_bee_npc_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oInteractType = INTERACT_TEXT
    o.hitboxRadius = 100
    o.hitboxHeight = 200
    o.hitboxDownOffset = 160
    o.oIntangibleTimer = 0
    smlua_anim_util_set_animation(o, "anim_bee_npc_idle")
end

---@param o Object
function bhv_bee_npc_loop(o)
    o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, o.oAngleToMario, 0x170)
    if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        gMarioStates[0].action = ACT_READING_NPC_DIALOG
        if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, o.oBehParams2ndByte) ~= 0 then
            o.oInteractStatus = 0
        end
    end
end

bhvBeeNPC = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_bee_npc_init, bhv_bee_npc_loop)

---@param o Object
function bhv_lilypad_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 800
    o.collisionData = smlua_collision_util_get("lilypad_collision")
end

---@param o Object
function bhv_lilypad_loop(o)
    load_object_collision_model()
end

bhvLilyPad = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_lilypad_init, bhv_lilypad_loop)

--[[
[0021A078 / 13000278] 00 04 0000 // Start Behavior (Object type = 4)
[0021A07C / 1300027C] 23 00 00 00 00A0 0360 // Set Collision sphere size (XZ radius = 160, Y radius = 864)
[0021A084 / 13000284] 0E 45 4BFF // (Set value) obj->_0x19C = (float)19455
[0021A088 / 13000288] 0E 2A 0002 // (Set value) obj->_0x130 = (float)2
[0021A08C / 1300028C] 08 00 00 00 // Start of loop
[0021A090 / 13000290]    10 05 0000 // (Set value) obj->_0x9C = 0
[0021A094 / 13000294]    10 2B 0000 // (Set value) obj->_0x134 = 0
[0021A098 / 13000298]    09 00 00 00 // End of loop
]]

---@param o Object
function bhv_cotmc_tree_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 160
    o.hitboxHeight = 864
    o.oIntangibleTimer = 0
    --o.oAnimations = gObjectAnimations.goomba_seg8_anims_0801DA4C
    --o.oGraphYOffset = 200
    --o.oCollisionDistance = 19455 --kaze what the fuck
    --o.oInteractType = INTERACT_BREAKABLE
    --o.collisionData = smlua_collision_util_get("cotmc_tree_collision")
end

---@param o Object
function bhv_cotmc_tree_loop(o)
    djui_chat_message_create("GG")
end

bhvCustomCotmcTrees = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cotmc_tree_init, bhv_cotmc_tree_loop)

function bhv_gummy_bear_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1200
    o.header.gfx.skipInViewCheck = true
end

---animstatebyparam2
function bhv_gummy_bear_loop(o)
    load_object_collision_model()
    o.oAnimState = o.oBehParams2ndByte
end

bhvGummyBear = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_gummy_bear_init, bhv_gummy_bear_loop)

---param2 = 0 is donut, param2 = 1 is candy cane
function bhv_hmc_static_obj_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    if o.oBehParams2ndByte == 0 then
        o.collisionData = smlua_collision_util_get("donut_collision")
    elseif o.oBehParams2ndByte == 1 then
        o.collisionData = smlua_collision_util_get("candy_cane_collision")
    end
end

function bhv_hmc_static_obj_loop(o)
    load_object_collision_model()
end

bhvCollisionHmcStaticObject = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_hmc_static_obj_init, bhv_hmc_static_obj_loop)

MODEL_OCTOOMBA_ROCK = smlua_model_util_get_id("octoomba_rock_geo")

---@param o Object
function bhv_octooomba_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    o.oInteractType = INTERACT_BOUNCE_TOP2
    o.hitboxHeight = 100
    o.hitboxRadius = 100
    o.oIntangibleTimer = 0
    o.oDamageOrCoinValue = 2
    o.oGravity = 3
    o.oFriction = 1
    o.oBuoyancy = 1
    network_init_object(o, true, { "oPosX", "oPosY", "oPosZ", "oMoveAngleYaw", "oFaceAngleYaw", "oAction" })
end

---@param o Object
function bhv_octooomba_loop(o)
    smlua_anim_util_set_animation(o, "anim_octoomba")
    --djui_chat_message_create(tostring(o.oDistanceToMario))
    object_step()

    if o.oAction == 0 then
        o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, obj_angle_to_object(o, nearest_player_to_object(o)), 0x200)
        if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
            o.oTimer = 0
            o.oAction = 1
        else
            o.oInteractStatus = 0
        end

        if o.oDistanceToMario < 750 then --scared
            o.oForwardVel = 5
            o.oSubAction = o.oSubAction + 1
            o.oMoveAngleYaw = obj_angle_to_object(o, nearest_player_to_object(o)) + 32768
        end

        if o.oDistanceToMario > 1300 then
            o.oForwardVel = 0
        end

        if o.oSubAction > 120 then
            o.oHiddenBlueCoinSwitch = spawn_object(o, MODEL_OCTOOMBA_ROCK, bhvOctoombaRock)
            o.oHiddenBlueCoinSwitch.oAction = 1
            o.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch = o
            o.oSubAction = 0
        end
    elseif o.oAction == 1 then
        o.oForwardVel = 0
        obj_scale_xyz(o, 1, 0.1, 1)
        if o.oTimer > 25 then
            spawn_mist_particles()
            obj_mark_for_deletion(o)
            cur_obj_play_sound_1(SOUND_OBJ_DEFAULT_DEATH)
        end
    end
end

bhvOctoomba = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_octooomba_init, bhv_octooomba_loop)
---@param o Object
function octoomba_rock_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oDamageOrCoinValue = 2
    o.oIntangibleTimer = 0
    o.hitboxHeight = 110
    o.hitboxRadius = 110
    o.oGraphYOffset = 40
    o.oGravity = -3
    o.oFriction = 1
    spawn_mist_particles()
    cur_obj_set_home_once()
    o.oInteractType = INTERACT_DAMAGE
end

---@param o Object
function octoomba_rock_loop(o)
    local floor = o.oFloor
    o.oForwardVel = 15
    move_obj_with_physics(true, o)
    o.oFaceAnglePitch = o.oFaceAnglePitch + 1300
    o.oMoveAngleYaw = obj_angle_to_object(o.oHiddenBlueCoinSwitch, nearest_player_to_object(o))
    if o.oTimer > (4 * 30) then -- 4 seconds
        obj_mark_for_deletion(o)
        spawn_mist_particles()
    end

    if o.oInteractStatus ~= 0 then
        obj_mark_for_deletion(o)
        spawn_mist_particles()
    end
end

bhvOctoombaRock = hook_behavior(nil, OBJ_LIST_GENACTOR, true, octoomba_rock_init, octoomba_rock_loop)

---@param o Object
function bhv_crocodile_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    o.oDamageOrCoinValue = 2
    o.oIntangibleTimer = 0
    o.hitboxHeight = 70
    o.hitboxRadius = 360
    o.oInteractType = INTERACT_DAMAGE
    network_init_object(o, true, {"oAction", "oTimer"})
end

---@param o Object
function bhv_crocodile_loop(o)
    o.oInteractStatus = 0
    o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, obj_angle_to_object(o, nearest_player_to_object(o)), 0x160)
    if o.oAction == 0 then
        smlua_anim_util_set_animation(o, "anim_croc_idle")
        if o.oDistanceToMario < 460 then
            cur_obj_play_sound_1(SOUND_OBJ2_BOWSER_ROAR)
            o.oAction = 1
            o.oTimer = 0
        end
    elseif o.oAction == 1 then
        smlua_anim_util_set_animation(o, "anim_croc_attack")
        if o.oTimer > 50 then
            o.oAction = 0
        end
    end
end

--bhvCrocodile
hook_behavior(id_bhvCcmTouchedStarSpawn, OBJ_LIST_GENACTOR, true, bhv_crocodile_init, bhv_crocodile_loop)
