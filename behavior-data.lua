local find_floor_height, spawn_mist_particles, obj_get_nearest_object_with_behavior_id, obj_scale, cutscene_object_with_dialog, smlua_anim_util_set_animation, obj_angle_to_object, obj_check_hitbox_overlap, play_puzzle_jingle, approach_s16_symmetric, math_sin, nearest_mario_state_to_object, nearest_player_to_object, save_file_get_total_star_count, spawn_sync_object, get_current_save_file_num, sins, coss, cur_obj_resolve_wall_collisions, load_object_collision_model, object_step, smlua_collision_util_get, smlua_model_util_get_id, cur_obj_is_mario_on_platform, approach_f32_asymptotic, cur_obj_init_animation, dist_between_objects, cur_obj_play_sound_1, cur_obj_play_sound_2, approach_f32_symmetric, cur_obj_is_mario_ground_pounding_platform, cur_obj_hide, cur_obj_become_intangible, cur_obj_unhide, cur_obj_become_tangible, cur_obj_scale_over_time, obj_scale_xyz, cur_obj_was_attacked_or_ground_pounded, bhv_pole_base_loop, obj_get_next_with_same_behavior_id, obj_get_first_with_behavior_id, save_file_get_flags, save_file_get_star_flags, set_water_level =
    find_floor_height, spawn_mist_particles, obj_get_nearest_object_with_behavior_id, obj_scale,
    cutscene_object_with_dialog,
    smlua_anim_util_set_animation, obj_angle_to_object, obj_check_hitbox_overlap, play_puzzle_jingle,
    approach_s16_symmetric, math.sin, nearest_mario_state_to_object, nearest_player_to_object,
    save_file_get_total_star_count, spawn_sync_object, get_current_save_file_num, sins, coss,
    cur_obj_resolve_wall_collisions, load_object_collision_model, object_step, smlua_collision_util_get,
    smlua_model_util_get_id, cur_obj_is_mario_on_platform, approach_f32_asymptotic, cur_obj_init_animation,
    dist_between_objects, cur_obj_play_sound_1, cur_obj_play_sound_2, approach_f32_symmetric,
    cur_obj_is_mario_ground_pounding_platform, cur_obj_hide,
    cur_obj_become_intangible, cur_obj_unhide,
    cur_obj_become_tangible, cur_obj_scale_over_time, obj_scale_xyz, cur_obj_was_attacked_or_ground_pounded,
    bhv_pole_base_loop, obj_get_next_with_same_behavior_id, obj_get_first_with_behavior_id, save_file_get_flags,
    save_file_get_star_flags, set_water_level

mark_obj_for_deletion = obj_mark_for_deletion

--[[
how 2 Dilaog sync game source code edition:
if (marioState && should_start_or_continue_dialog(marioState, o) && cur_obj_update_dialog_with_cutscene(&gMarioStates[0], 2, 1, CUTSCENE_DIALOG, gBehaviorValues.dialogs.KingBobombIntroDialog, king_bobomb_act_0_continue_dialog)) {
        o->oAction = 2;
        o->oFlags |= OBJ_FLAG_HOLDABLE;
    }
]]

gGlobalSyncTable.goombabros1killed = false
gGlobalSyncTable.goombabros1 = false

local repack = function(value, pack_fmt, unpack_fmt)
    return string.unpack(unpack_fmt, string.pack(pack_fmt, value))
end

obj_delete_if_flood = function(obj)
    if gFloodIsOn then
        obj_mark_for_deletion(obj)
    end
end
-- (can) place Mario in dialog?
-- initiate dialog?
-- return values:
-- 0 = not in dialog
-- 1 = starting dialog
-- 2 = speaking

MARIO_DIALOG_STATUS_NONE = 0
MARIO_DIALOG_STATUS_START = 1
MARIO_DIALOG_STATUS_SPEAK = 2

MARIO_DIALOG_STOP = 0
MARIO_DIALOG_LOOK_FRONT = 1
MARIO_DIALOG_LOOK_UP = 2
MARIO_DIALOG_LOOK_DOWN = 3

function set_mario_npc_dialog(actionArg, object)
    local dialogState = MARIO_DIALOG_STATUS_NONE
    local gMarioState = nearest_mario_state_to_object(object)

    -- in dialog
    if gMarioState.action == ACT_READING_NPC_DIALOG then
        if gMarioState.actionState < 8 then
            dialogState = MARIO_DIALOG_STATUS_START -- starting dialog
        end
        if gMarioState.actionState == 8 then
            if actionArg == MARIO_DIALOG_STOP then
                gMarioState.actionState = gMarioState.actionState + 1 -- exit dialog
            else
                dialogState = MARIO_DIALOG_STATUS_SPEAK
            end
        end
    elseif actionArg ~= MARIO_DIALOG_STOP and mario_ready_to_speak(gMarioState) == 1 then
        gMarioState.usedObj = object
        set_mario_action(gMarioState, ACT_READING_NPC_DIALOG, actionArg)
        dialogState = MARIO_DIALOG_STATUS_START -- starting dialog
    end

    return dialogState
end

---@param m MarioState
---@param button number
function is_button_down(m, button)
    return m.controller.buttonDown & button ~= 0
end

--- @param num integer
--- Limits an integer in the s16 range
function s16(num)
    num = math.floor(num) & 0xFFFF
    if num >= 32768 then return num - 65536 end
    return num
end

function obj_pitch_angle_to_object(obj1, obj2)
    --if not (obj1 and obj2) then return 0 end

    local z1, x1, y1, z2, x2, y2, h, v
    local angle

    z1 = obj1.oPosZ
    z2 = obj2.oPosZ
    x1 = obj1.oPosX
    x2 = obj2.oPosX
    y1 = obj1.oPosY
    y2 = obj2.oPosY

    h = math.sqrt((z2 - z1) ^ 2 + (x2 - x1) ^ 2)
    v = y2 - y1

    angle = -atan2s(h, v)
    return angle
end

---@param param any
---@param case_table table<any, function>
---@return function | nil
function switch(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table['default']
    return def and def() or nil
end

function for_each_object_with_behavior(behavior, func) --* function by Isaac
    local o = obj_get_first_with_behavior_id(behavior)
    while o do
        func(o)
        o = obj_get_next_with_same_behavior_id(o)
    end
end

---function from SM64 Land
---@param course integer
---@param star integer
---@param is100star boolean|nil
---@return boolean
function is_star_colected(course, star, is100star)
    local courseReal = course - 1
    local starflags = save_file_get_star_flags(get_current_save_file_num() - 1, courseReal)
    if starflags & (1 << star) ~= 0 then
        return true
    else
        return false
    end
end

function obj_get_model_id(obj)
    if (obj ~= nil) then
        ---@type ModelExtendedId
        for i = E_MODEL_NONE, E_MODEL_MAX - 1 do
            if (obj_has_model_extended(obj, i) ~= 0) then
                return i;
            end
        end
    end
    return E_MODEL_NONE;
end

---@param obj Object
---@param animTable table
---@param animIndex integer
function obj_init_animation_from_custom_table(obj, animTable, animIndex, vanillaAnim, speed)
    ---@type string|Animation
    local setAnim = animTable[animIndex]
    if animTable then
        obj.header.gfx.animInfo.animAccel = speed and speed * 65536 or 65536
        if not vanillaAnim then
            smlua_anim_util_set_animation(obj, setAnim)
        else
            obj.header.gfx.animInfo.curAnim = setAnim
        end
    end
end

---@param m MarioState
---@return boolean
function is_bubbled(m)
    return m.action == ACT_BUBBLED
end

---@param o Object
---@return boolean
function is_any_mario_groundpounding_obj(o)
    for i = 0, 15 do
        local mstate = gMarioStates[network_local_index_from_global(i)]
        if mstate.marioObj.platform == o then
            if mstate.action == ACT_GROUND_POUND_LAND then
                return true
            else
                return (_G.OmmEnabled and nearest_mario_state_to_object(o).action == _G.OmmApi["ACT_OMM_SPIN_POUND_LAND"] and nearest_mario_state_to_object(o).marioObj.platform == o)
            end
        end
    end
    return false
end

function get_curr_star_count()
    return save_file_get_total_star_count(get_current_save_file_num() - 1, COURSE_NONE, COURSE_SA)
end

---@param key integer
---@return boolean
function save_has_key(key)
    return (save_file_get_flags() & key) ~= 0
end

function spawn_object(parent, model, behaviorId)
    local obj = spawn_non_sync_object(behaviorId, model, 0, 0, 0, nil)
    if not obj then return nil end

    obj_copy_pos_and_angle(obj, parent)
    return obj
end

function spawn_object2(parent, model, behaviorId)
    local obj = spawn_sync_object(behaviorId, model, 0, 0, 0, nil)
    if not obj then return nil end

    obj_copy_pos_and_angle(obj, parent)
    return obj
end

---function from SM64: Through the ages
---@param clampFloor boolean
---@param o Object
local function move_obj_with_physics(clampFloor, o)
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

function spawn_object_relative(behaviorParam, relativePosX, relativePosY,
                               relativePosZ, parent, model,
                               behavior)
    obj = spawn_object(parent, model, behavior);

    obj_copy_pos_and_angle(obj, parent);
    obj_set_parent_relative_pos(obj, relativePosX, relativePosY, relativePosZ);
    obj_build_relative_transform(obj);

    obj.oBehParams2ndByte = behaviorParam;
    obj.oBehParams = (behaviorParam & 0xFF) << 16;

    return obj;
end

MODEL_MAGIKOOPA_WAND = smlua_model_util_get_id("magikoopa_wand_geo")
MODEL_TOTWC_STATIC_CLOUD = smlua_model_util_get_id("totwc_static_cloud_geo")

function bhv_update()
    for_each_object_with_behavior(id_bhvStaticObject,
        function(o)
            if obj_has_model_extended(o, MODEL_MAGIKOOPA_WAND) ~= 0 then
                spawn_non_sync_object(id_bhvSparkleSpawn, E_MODEL_NONE, o.oPosX, o.oPosY, o.oPosZ, nil)
                o.hitboxHeight = 50
                o.hitboxRadius = 50
                for i = 0, 15 do
                    local state = gMarioStates[i]
                    if obj_check_hitbox_overlap(o, state.marioObj) then
                        obj_mark_for_deletion(o)
                        gMarioStateExtras[i].hasMagicWand = true
                        play_sound(SOUND_MENU_STAR_SOUND, gGlobalSoundSource);
                    end
                end
            end

            if obj_has_model_extended(o, MODEL_TOTWC_STATIC_CLOUD) ~= 0 then
                o.header.gfx.skipInViewCheck = true
            end
        end)

    for_each_object_with_behavior(id_bhvHiddenStarTrigger,
        function(s)
            if obj_has_model_extended(s, MODEL_SILVER_STAR) == 1 then
                s.oFaceAngleYaw = s.oFaceAngleYaw + 0x880
            end
        end)
end

hook_event(HOOK_UPDATE, bhv_update)

---@param o Object
local function wiggler_loop(o)
    if o.oWigglerTextStatus == WIGGLER_TEXT_STATUS_SHOWING_DIALOG then
        o.oWigglerTextStatus = WIGGLER_TEXT_STATUS_COMPLETED_DIALOG
    end
end

hook_behavior(id_bhvWigglerHead, OBJ_LIST_GENACTOR, true, nil, wiggler_loop, "bhvWigglerHead")

---@param o Object
local function bhv_fuzzy_init(o)
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
local function bhv_fuzzy_loop(o)
    o.oForwardVel = 5
    o.oPosY = o.oPosY + math_sin(o.oTimer * 0.07) * 2
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
local function bhv_bob_cloud_platform_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1600
    o.collisionData = smlua_collision_util_get("bob_cloud_platform_collision")
    cur_obj_set_home_once()
end

---@param o Object
local function bhv_bob_cloud_platform_loop(o)
    load_object_collision_model()
    o.oVelY = approach_f32_asymptotic(o.oVelY, (o.oHomeY - o.oPosY) / 8, 0.1)
    if cur_obj_is_mario_on_platform() == 1 then
        o.oVelY = o.oVelY - 1.0
    end
    object_step()
end

hook_behavior(id_bhvCutOutObject, OBJ_LIST_SURFACE, true, bhv_bob_cloud_platform_init, bhv_bob_cloud_platform_loop)

---@param o Object
local function bhv_bob_prison_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1600
    o.collisionData = smlua_collision_util_get("bob_prison_gate_collision")
end

---@param o Object
local function bhv_bob_prison_gate_loop(o)
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
local function bhv_parent_rabbit_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE |OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    if o.oBehParams2ndByte == 46 or o.oBehParams2ndByte == 43 or o.oBehParams2ndByte == 148 then
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
    --network_init_object(o, true, { "oAction", "oSubAction", "oMoveAngleYaw", "oPosX", "oPosY", "oPosZ", "oForwardVel" })
end

MODEL_RABBIT = smlua_model_util_get_id("parent_mips_geo")

---@param o Object
local function bhv_parent_rabbit_loop(o)
    obj_set_model_extended(o, MODEL_RABBIT)
    neargate = obj_get_nearest_object_with_behavior_id(o, id_bhvBitfsSinkingPlatforms)

    if o.oAction == 0 then
        if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
            gMarioStates[0].action = ACT_READING_NPC_DIALOG
            if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, o.oBehParams2ndByte) ~= 0 then
                o.oInteractStatus = 0
                if o.oBehParams2ndByte == 148 then
                    local ntpppp = nearest_mario_state_to_object(o)
                    spawn_default_star(ntpppp.pos.x, ntpppp.pos.y + 230, ntpppp.pos.z)
                    o.oInteractType = INTERACT_IGLOO_BARRIER
                end
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

    if o.oBehParams2ndByte == 46 or o.oBehParams2ndByte == 43 or o.oBehParams2ndByte == 148 then
        obj_scale(o, 3)
    end

    if neargate and neargate.oPosY < -3890 and o.oBehParams2ndByte == 12 then
        o.oAction = 1
        o.oForwardVel = 40
    end

    if o.oBehParams2ndByte == 12 and o.oAction == 0 then
        if o.oPosX == -286 and o.oPosY == -2655 and o.oPosZ == -12644 then
            if obj_check_hitbox_overlap(gMarioStates[0].marioObj, o) then
                gMarioStates[0].action = ACT_READING_NPC_DIALOG
                if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, 36) ~= 0 then
                    local neareastplayer = nearest_mario_state_to_object(o)
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
local function bhv_taptap_init(o)
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
        { "oPosX", "oPosY", "oPosZ", "oMoveAngleYaw", "oNumLootCoins", "oAction", "oFaceAngleYaw", "oBowserUnk106" })
end

MODEL_TAPTAP_KEY = smlua_model_util_get_id("taptap_key_geo")

---@param o Object
local function bhv_taptap_loop(o)
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
        o.oInteractType = 0
        o.oForwardVel = 0
        o.oBowserUnk106 = o.oBowserUnk106 + 1
        if o.oBowserUnk106 > 80 then
            if o.oBehParams2ndByte == 1 then
                spawn_non_sync_object(bhvTapTapKey, MODEL_TAPTAP_KEY, o.oPosX, o.oPosY, o.oPosZ, nil)
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
local function bhv_taptap_key_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 70
    o.hitboxHeight = 70
    o.oIntangibleTimer = 0
end

---@param o Object
local function bhv_taptap_key_loop(o)
    o.oPosY = o.oPosY + math_sin(o.oTimer * 0.07) * 2
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
[0021ADEC / 13000FEC]    0C 00 00 00 803839CC // Call ASM function 0x803839CC --load_object_collison_model
[0021ADF4 / 13000FF4]    0C 00 00 00 802AEF10 // Call ASM function 0x802AEF10 --bhv_flower_generator_loop
[0021ADFC / 13000FFC]    09 00 00 00 // End of loop]]

---@param o Object
local function bhv_flower_generator_init(o)
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
local function bhv_flower_generator_loop(o)
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
            spawn_non_sync_object(bhvWhiteFlower, MODEL_WHITE_FLOWER, -3428, o.oPosY + 500, -4409,
                function(obj) obj.parentObj = o end)
        end
        if o.oTimer == 88 then
            o.oAction = 0
        end
    end
end

bhvFlowerGenerator = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_flower_generator_init, bhv_flower_generator_loop)

---@param o Object
local function bhv_white_flower_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.oInteractType = INTERACT_POLE
    o.hitboxHeight = 270
    o.hitboxRadius = 60
    o.hitboxDownOffset = 70
    o.oIntangibleTimer = 0
    o.oForwardVel = 22
end

---@param o Object
local function bhv_white_flower_loop(o)
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
    obj_mark_for_deletion(o) -----not done for now
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
local function bhv_launch_star_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 200
    o.hitboxHeight = 200
    o.oIntangibleTimer = 0
    o.oTimer = 0
end

---@param o Object
local function bhv_launch_star_loop(o)
    local m = gMarioStates[0]
    if obj_check_hitbox_overlap(m.marioObj, o) and o.oAction == LAUNCH_STAR_ACT_IDLE and m.action ~= ACT_SHOT_FROM_CANNON and m.action == ACT_GROUND_POUND then
        o.oTimer = 0
        m.vel.y = 0
        o.oAction = LAUNCH_STAR_ACT_LAUNCH
        playerLaunched = true
    end

    if o.oAction == LAUNCH_STAR_ACT_IDLE then
        o.oFaceAngleRoll = o.oFaceAngleRoll + 340
    end

    if o.oAction == LAUNCH_STAR_ACT_LAUNCH then
        o.oFaceAngleRoll = o.oFaceAngleRoll + 400 * 6
        if o.oTimer == 0 then
            pos = { x = o.oPosX, y = o.oPosY, z = o.oPosZ }
            vec3f_copy(m.pos, pos)
            set_mario_action(m, ACT_GROUND_POUND, 0)
        end

        if m.actionTimer > 14 then
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

MODEL_NOTEBLOCKS = smlua_model_util_get_id("Noteblock_MOP")

---@param o Object
local function bhv_noteblock_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("col_Noteblock_MOP_0xaa6444")
    cur_obj_set_home_once()
    obj_scale(o, 0.64)
end

---@param obj Object
local function bhv_noteblock_loop(obj)
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

local function bhv_crystal_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 3000
    o.collisionData = smlua_collision_util_get("cave_crystal_collision")
    o.header.gfx.skipInViewCheck = true
end

local function scalebyparam2(o)
    load_object_collision_model()
    obj_scale(o, o.oBehParams2ndByte / 100)
end

bhvCaveCrystal = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_crystal_init, scalebyparam2)

MODEL_SILVER_STAR = smlua_model_util_get_id("silver_star_geo")

local function bhv_silver_star_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
end

local function bhv_silver_star_loop(o)
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
local function bhv_yellow_falling_rock_init(o)
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
local function bhv_yellow_falling_rock_loop(o)
    if o.oAction == 0 then
        if dist_between_objects(o, nearest_player_to_object(o)) < 1350 then
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        local result = object_step()
        if result & OBJ_COL_FLAG_GROUNDED == 1 then
            cur_obj_play_sound_2(SOUND_GENERAL_BIG_POUND)
            obj_mark_for_deletion(o)
        end
    end
end

bhvYellowFallingRock = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_yellow_falling_rock_init,
    bhv_yellow_falling_rock_loop)


---@param o Object
local function bhv_bee_npc_init(o)
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
local function bhv_bee_npc_loop(o)
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
local function bhv_lilypad_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 800
    o.collisionData = smlua_collision_util_get("lilypad_collision")
end

---@param o Object
local function bhv_lilypad_loop(o)
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

MODEL_COTMC_TREE = smlua_model_util_get_id("cotmc_tree_geo")

---@param o Object
local function bhv_cotmc_tree_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 160
    o.hitboxHeight = 864
    o.oIntangibleTimer = 0
    o.oCollisionDistance = 19455 --kaze what the fuck
    o.oInteractType = INTERACT_BREAKABLE
    o.collisionData = smlua_collision_util_get("cotmc_tree_collision")
    obj_set_model_extended(o, MODEL_COTMC_TREE)
end

---@param o Object
local function bhv_cotmc_tree_loop(o)
    load_object_collision_model()
end

bhvCustomCotmcTrees = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cotmc_tree_init, bhv_cotmc_tree_loop)

local function bhv_gummy_bear_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("gummy_bear_collision")
    o.oCollisionDistance = 1200
    o.header.gfx.skipInViewCheck = true
end

local function bhv_animstate_by_param2(o)
    load_object_collision_model()
    o.oAnimState = o.oBehParams2ndByte
end

bhvGummyBear = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_gummy_bear_init, bhv_animstate_by_param2)

---param2 = 0 is donut, param2 = 1 is candy cane
local function bhv_hmc_static_obj_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    if o.oBehParams2ndByte == 0 then
        o.collisionData = smlua_collision_util_get("donut_collision")
    elseif o.oBehParams2ndByte == 1 then
        o.collisionData = smlua_collision_util_get("candy_cane_collision")
    end
end

local function bhv_hmc_static_obj_loop(o)
    load_object_collision_model()
end

bhvCollisionHmcStaticObject = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_hmc_static_obj_init, bhv_hmc_static_obj_loop)

MODEL_OCTOOMBA_ROCK = smlua_model_util_get_id("octoomba_rock_geo")

---@param o Object
local function bhv_octooomba_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    o.oInteractType = INTERACT_BOUNCE_TOP2
    o.hitboxHeight = 100
    o.hitboxRadius = 100
    o.oIntangibleTimer = 0
    o.oDamageOrCoinValue = 2
    o.oGravity = 3
    o.oFriction = 1
    o.oBuoyancy = 1
    o.oNumLootCoins = 1
    network_init_object(o, true,
        { "oPosX", "oPosY", "oPosZ", "oMoveAngleYaw", "oFaceAngleYaw", "oAction", "oSubAction" })
end

---@param o Object
local function bhv_octooomba_loop(o)
    smlua_anim_util_set_animation(o, "anim_octoomba")
    --djui_chat_message_create(tostring(o.oDistanceToMario))
    object_step()

    if o.oAction == 0 then
        o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, obj_angle_to_object(o, nearest_player_to_object(o)),
            0x200)
        if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
            o.oTimer = 0
            o.oAction = 1
        else
            o.oInteractStatus = 0
        end

        if dist_between_objects(o, nearest_player_to_object(o)) < 750 then --scared
            o.oForwardVel = 5
            o.oSubAction = o.oSubAction + 1
            o.oMoveAngleYaw = obj_angle_to_object(o, nearest_player_to_object(o)) + 32768
        end

        if dist_between_objects(o, nearest_player_to_object(o)) > 1300 then
            o.oForwardVel = 0
        end

        if o.oSubAction > 120 then
            o.oHiddenBlueCoinSwitch = spawn_object2(o, MODEL_OCTOOMBA_ROCK, bhvOctoombaRock)
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
            obj_spawn_yellow_coins(o, o.oNumLootCoins)
        end
    end
end

bhvOctoomba = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_octooomba_init, bhv_octooomba_loop)

---@param o Object
local function octoomba_rock_init(o)
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
    o.oMoveAngleYaw = obj_angle_to_object(o.oHiddenBlueCoinSwitch, nearest_player_to_object(o))
end

---@param o Object
local function octoomba_rock_loop(o)
    local floor = o.oFloor
    o.oForwardVel = 15
    move_obj_with_physics(true, o)
    o.oFaceAnglePitch = o.oFaceAnglePitch + 1300
    if o.oTimer > (4 * 30) or o.oInteractStatus ~= 0 then -- 4 seconds
        obj_mark_for_deletion(o)
        spawn_mist_particles()
    end
end

bhvOctoombaRock = hook_behavior(nil, OBJ_LIST_GENACTOR, true, octoomba_rock_init, octoomba_rock_loop)

---@param o Object
local function bhv_crocodile_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    o.oDamageOrCoinValue = 2
    o.oIntangibleTimer = 0
    o.hitboxHeight = 70
    o.hitboxRadius = 360
    o.oNumLootCoins = 3
    o.oInteractType = INTERACT_DAMAGE
    network_init_object(o, true, { "oAction", "oTimer" })
end

---@param o Object
local function bhv_crocodile_loop(o)
    o.oInteractStatus = 0
    o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, obj_angle_to_object(o, nearest_player_to_object(o)), 0x160)
    if o.oAction == 0 then
        smlua_anim_util_set_animation(o, "anim_croc_idle")
        if dist_between_objects(o, nearest_player_to_object(o)) < 625 then
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

    local nearestfire = obj_get_nearest_object_with_behavior_id(o, bhvFireFlowerFire)

    if nearestfire then
        if obj_check_hitbox_overlap(o, nearestfire) then
            play_sound(SOUND_GENERAL_BREAK_BOX, gGlobalSoundSource)
            obj_explode_and_spawn_coins(46, 1)
            obj_mark_for_deletion(nearestfire)
            obj_mark_for_deletion(o)
        end
    end
end

--bhvCrocodile
hook_behavior(id_bhvCcmTouchedStarSpawn, OBJ_LIST_GENACTOR, true, bhv_crocodile_init, bhv_crocodile_loop)

---@param o Object
local function bhv_spinning_star_custom_loop(o)
    --djui_chat_message_create(tostring(o.oAnimState))
    if (o.oBehParams >> 8) & 0xFF == 25 and o.oOpacity == 0 then
        local colresult = 0
        colresult = object_step()
        o.oGravity = 3.4
        o.oFriction = 1
        o.oBounciness = 5
        o.oForwardVel = 15

        if colresult & OBJ_COL_FLAG_GROUNDED == 1 then
            cur_obj_play_sound_2(SOUND_ENV_STAR)
            o.oVelY = 60
            o.oAnimState = o.oAnimState + 1
            o.oMoveAngleYaw = math.random(65536)
        end

        if o.oAnimState >= 4 then
            cur_obj_hide()
            cur_obj_become_intangible()
            o.oAnimState = 0
            --Bounced = true
            o.oOpacity = 1
            o.oSubAction = 0
        end
    end

    if o.oOpacity == 1 then
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > (5 * 30) then -- 5 seconds
            cur_obj_unhide()
            cur_obj_become_tangible()
            o.oSubAction = 0
            o.oAnimState = 0
            o.oOpacity = 0
            o.oPosX = math.random(-17874, -4089)
            o.oPosZ = math.random(-17881, -1084)
            o.oPosY = 15000 + math.random(50, 100)
        end
    end
end

function obj_rotate_pitch_toward(o, target, increment)
    local startPitch = o.oMoveAnglePitch
    o.oMoveAnglePitch = approach_s16_symmetric(o.oMoveAnglePitch, target, increment)
    o.oFaceAnglePitch = approach_s16_symmetric(o.oFaceAnglePitch, target, increment)

    o.oAngleVelPitch = o.oMoveAnglePitch - startPitch

    return o.oAngleVelPitch == 0
end

--bhvSpinningStar (BBH)
hook_behavior(id_bhvStar, OBJ_LIST_LEVEL, false, nil, bhv_spinning_star_custom_loop)

---@param o Object
local function bhv_rockshooter_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oDamageOrCoinValue = 2
    o.oIntangibleTimer = 0
    o.hitboxHeight = 400
    o.hitboxRadius = 400
    o.oInteractType = INTERACT_DAMAGE
    smlua_anim_util_set_animation(o, "anim_rockshooter_idle")
    network_init_object(o, true, { "oAction", "oTimer" })
end

function red_rock_shooter_rock(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oDamageOrCoinValue = 2
    o.oIntangibleTimer = 0
    o.hitboxHeight = 110
    o.hitboxRadius = 110
    o.oGraphYOffset = 40
    o.oForwardVel = 10
    o.oFriction = 1
    spawn_mist_particles()
    cur_obj_set_home_once()
    o.oInteractType = INTERACT_DAMAGE
    network_init_object(o, true, { "oPosX", "oPosY", "oPosZ" })
end

function red_rock_shooter_rock_loop(o)
    object_step()
    local player = nearest_player_to_object(o)
    local distanceToPlayer = player and dist_between_objects(o, player) or 10000
    local angleToPlayer = obj_pitch_angle_to_object(o, player)
    obj_rotate_pitch_toward(o, angleToPlayer, 0x300)
    --o.oVelY = -o.oForwardVel
    o.oPosY = approach_f32_symmetric(o.oPosY, player.oPosY, 0x100)
    if o.oInteractStatus ~= 0 then
        spawn_mist_particles()
        obj_mark_for_deletion(o)
    end
end

bhvRedRockShooterRock = hook_behavior(nil, OBJ_LIST_GENACTOR, true, red_rock_shooter_rock, red_rock_shooter_rock_loop)

---@param o Object
local function bhv_rockshooter_loop(o)
    o.oInteractStatus = 0
    local m = nearest_mario_state_to_object(o)
    if dist_between_objects(o, nearest_player_to_object(o)) < 5400 then
        o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, obj_angle_to_object(o, nearest_player_to_object(o)),
            0x130)
        local player = nearest_player_to_object(o)
        local distanceToPlayer = player and dist_between_objects(o, player) or 10000
        local angleToPlayer = obj_pitch_angle_to_object(o, player)
        obj_rotate_pitch_toward(o, angleToPlayer, 0x100)
        o.oVelY = -o.oForwardVel
        o.oPosY = o.oPosY + o.oVelY * sins(o.oFaceAnglePitch)
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > (6 * 30) then -- 6 seconds
            o.oSubAction = 0
            --spawn_object2(o, MODEL_OCTOOMBA_ROCK, bhvRedRockShooterRock)
        end
    end
end

bhvRedRockShooter = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_rockshooter_init, bhv_rockshooter_loop)

MODEL_ROCKET_DOOR = smlua_model_util_get_id("rocket_door_geo")

---@param o Object
local function bhv_rocket_door_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("rocket_door_collision")
    o.header.gfx.skipInViewCheck = true
end

---@param o Object
local function bhv_rocket_door_loop(o)
    load_object_collision_model()
    if get_curr_star_count() >= 15 then
        obj_mark_for_deletion(o)
    end

    obj_delete_if_flood(o)
end

bhvRocketDoor = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rocket_door_init, bhv_rocket_door_loop)

MODEL_ROCKET = smlua_model_util_get_id("rocket_geo")

---@param o Object
local function bhv_rocket_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.hitboxHeight = 900
    o.hitboxRadius = 310
    o.oIntangibleTimer = 0
    cur_obj_set_home_once()
    network_init_object(o, true, { "oPosY", "oAction", "oTimer" })
end

---@param o Object
local function bhv_rocket_loop(o)
    if obj_check_hitbox_overlap(o, nearest_player_to_object(o)) and o.oAction == 0 then
        o.oAction = 1
    end

    if o.oAction == 1 then
        o.oPosY = o.oPosY + 45
        spawn_non_sync_object(id_bhvBobombFuseSmoke, E_MODEL_SMOKE, o.oPosX, o.oPosY - 150, o.oPosZ, nil)
        cur_obj_play_sound_2(SOUND_GENERAL2_BOBOMB_EXPLOSION);
        vec3f_set(nearest_mario_state_to_object(o).pos, o.oPosX, o.oPosY + 200, o.oPosZ)
        if o.oTimer == 90 then
            o.oAction = 2
            o.oTimer = 0
            cur_obj_set_pos_to_home()
        end
    end

    if o.oAction == 2 then
        if o.oTimer == 50 then
            o.oAction = 0
        end
    end

    obj_delete_if_flood(o)
end

bhvRocket = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_rocket_init, bhv_rocket_loop)

---@param o Object
local function bhv_cage_opener_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("cage_opener_collision")
    network_init_object(o, true, { "oSubAction", "oAction", "oAnimState" })
end

---@param o Object
local function bhv_cage_opener_loop(o)
    load_object_collision_model()
    local currM = nearest_mario_state_to_object(o)
    if currM.floor.object == o and currM.pos.y == currM.floorHeight then
        --0: unopened 1: opened
        o.oSubAction = 1
        --end
        o.oAction = 1
    end

    if o.oAction == 1 then
        o.oAnimState = o.oAnimState + 1
        if o.oAnimState < 50 then
            cur_obj_scale_over_time(2, 3, 1.5, 0.2);
        else
            obj_scale(o, 0)
        end
    end
end

bhvRedCageOpener = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cage_opener_init, bhv_cage_opener_loop)
bhvYellowCageOpener = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cage_opener_init, bhv_cage_opener_loop)
bhvBlueCageOpener = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cage_opener_init, bhv_cage_opener_loop)

---@param o Object
local function bhv_bbh_cage_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bbh_cage_collision")
    cur_obj_set_home_once()
    network_init_object(o, true, { "oPosY", "oAction" })
end

local sBBHCageInfo = {
    [1] = bhvRedCageOpener,
    [2] = bhvBlueCageOpener,
    [4] = bhvYellowCageOpener
}

---@param o Object
local function bhv_bbh_cage_loop(o)
    load_object_collision_model()
    local currP = nearest_player_to_object(o)
    local curBhv
    curBhv = sBBHCageInfo[o.oBehParams2ndByte]
    if o.oAction == 0 then
        if curBhv then
            if obj_get_nearest_object_with_behavior_id(o, curBhv) then
                if obj_get_nearest_object_with_behavior_id(o, curBhv).oSubAction == 1 then
                    if dist_between_objects(o, currP) < 1000 then
                        o.oAction = 1
                    end
                end
            end
        end
    elseif o.oAction == 1 then
        o.oPosY = o.oPosY - 10
    end

    if o.oPosY < (o.oHomeY - 2300) then
        obj_mark_for_deletion(o)
    end

    if o.oBehParams2ndByte == 2 and gNetworkPlayers[0].currActNum >= 2 then
        if dist_between_objects(o, currP) < 1000 then
            o.oAction = 1
        end
    end
end

hook_behavior(id_bhvHiddenObject, OBJ_LIST_SURFACE, true, bhv_bbh_cage_init, bhv_bbh_cage_loop)

MODEL_FLASHING_LIGHT = smlua_model_util_get_id("flashing_light_geo")

local function bhv_flashing_light(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
end

hook_behavior(id_bhvFloorSwitchAnimatesObject, OBJ_LIST_LEVEL, true, bhv_flashing_light, bhv_animstate_by_param2)

local function bhv_talking_yoshi_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE| OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    o.oInteractType = INTERACT_TEXT
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oAnimations = gObjectAnimations.yoshi_seg5_anims_05024100
    cur_obj_init_animation(0)
    o.hitboxRadius = 150
    o.hitboxHeight = 120
    o.oIntangibleTimer = 0
    bhv_bobomb_buddy_init()
end

local function bhv_talking_yoshi_loop(o)
    bhv_bobomb_buddy_loop()
end

bhvTalkingYoshi = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_talking_yoshi_init, bhv_talking_yoshi_loop)

---@param o Object
local function bhv_mario_galaxy_block_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    cur_obj_set_home_once()
    o.collisionData = smlua_collision_util_get("mario_galaxy_block_collision")
    o.oVelY = math.random(1000, 4000)
    o.oHeldState = math.random(3000, 5000)
    o.hitboxDownOffset = o.oPosY + 895
    o.oAnimState = o.oBehParams2ndByte

    -- home Face angles
    o.oAngleVelPitch = o.oFaceAnglePitch
    o.oAngleVelRoll = o.oFaceAngleRoll
    --oAngleVelYaw breaks it lol
    o.oFishYawVel = o.oFaceAngleYaw
    network_init_object(o, true,
        { "oAction", "oSubAction", "oFaceAnglePitch", "oFaceAngleRoll", "oFaceAngleYaw", "oPosX", "oPosY", "oPosZ" })
end

---@param o Object
local function bhv_mario_galaxy_block_loop(o)
    if o.oSubAction == 0 then
        o.oHiddenBlueCoinSwitch = spawn_non_sync_object(id_bhvStaticObject, E_MODEL_NONE, o.oHomeX, o.oHomeY, o.oHomeZ,
            nil)
        o.oSubAction = 1
    end
    local currP = nearest_player_to_object(o)
    if o.oAction == 0 then
        o.oFaceAnglePitch = o.oFaceAnglePitch + math.random(1, 900) + (o.oBehParams2ndByte * 17) * 2
        o.oFaceAngleRoll = o.oFaceAngleRoll + math.random(1, 900) + (o.oBehParams2ndByte * 17) * 2
        o.oFaceAngleYaw = 0
        if dist_between_objects(o.oHiddenBlueCoinSwitch, currP) < 900 then
            o.oAction = 1
            o.oFaceAngleRoll = 16384
            o.oFaceAnglePitch = 16384
        else
            o.oPosX = approach_f32_symmetric(o.oPosX, o.oVelY, 50)
            o.oPosZ = approach_f32_symmetric(o.oPosZ, o.oHeldState, 60)
            o.oPosY = approach_f32_symmetric(o.oPosY, o.hitboxDownOffset, 70)
        end
    elseif o.oAction == 1 then
        load_object_collision_model()
        o.oPosX = approach_f32_symmetric(o.oPosX, o.oHomeX, 100)
        o.oPosZ = approach_f32_symmetric(o.oPosZ, o.oHomeZ, 120)
        o.oPosY = approach_f32_symmetric(o.oPosY, o.oHomeY, 140)
        o.oFaceAngleRoll = approach_f32_symmetric(o.oFaceAngleRoll, o.oAngleVelRoll, 800)
        o.oFaceAnglePitch = approach_f32_symmetric(o.oFaceAnglePitch, o.oAngleVelPitch, 800)
        o.oFaceAngleYaw = approach_f32_symmetric(o.oFaceAngleYaw, o.oFishYawVel, 800)
        if dist_between_objects(o.oHiddenBlueCoinSwitch, currP) > 900 + 300 then
            o.oAction = 0
        end
    end
end

bhvMarioGalaxyBlock = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_mario_galaxy_block_init, bhv_mario_galaxy_block_loop)

--[[const BehaviorScript bhvFadingWarp[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvFadingWarp),
    SET_INT(oInteractionSubtype, INT_SUBTYPE_FADING_WARP),
    OR_INT(oFlags, (OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    SET_INT(oInteractType, INTERACT_WARP),
    SET_INT(oIntangibleTimer, 0),
    BEGIN_LOOP(),
        CALL_NATIVE(bhv_fading_warp_loop),
    END_LOOP(),
};
]]

local function rr_fading_warp_init(o)
    o.oFlags = (OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oInteractionSubtype = INT_SUBTYPE_FADING_WARP
    o.oInteractType = INTERACT_WARP
    o.oIntangibleTimer = 0
end

local function rr_fading_warp_loop(o)
    bhv_fading_warp_loop()
    if get_curr_star_count() < 70 then
        obj_mark_for_deletion(o)
    end
end

bhvRRFadingWarp = hook_behavior(nil, OBJ_LIST_LEVEL, true, rr_fading_warp_init, rr_fading_warp_loop)

local function rr_rotating_thing_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 4000
    o.collisionData = smlua_collision_util_get("rr_rotating_thing_collision")
end

local function rr_rotating_thing_loop(o)
    load_object_collision_model()
    o.oFaceAngleRoll = o.oFaceAngleRoll + 230
    o.oFaceAngleYaw = 69500
end

bhvRRrotatingThing = hook_behavior(nil, OBJ_LIST_SURFACE, true, rr_rotating_thing_init, rr_rotating_thing_loop)

local function bhv_thi_fan_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
end

local function rotate_fan(o, param1)
    o.oFaceAnglePitch = o.oFaceAnglePitch + o.oBehParams2ndByte + (param1 * 120)
end

local function rotate_fan2(o, param1)
    o.oFaceAngleYaw = o.oFaceAngleYaw + o.oBehParams2ndByte + (param1 * 120)
end

local function bhv_thi_fan_loop(o)
    local param1 = (o.oBehParams >> 24) & 0xFF
    --load_object_collision_model()
    if param1 ~= 4 and param1 ~= 22 and param1 ~= 1 and param1 ~= 43 then
        o.oFaceAngleYaw = o.oFaceAngleYaw + o.oBehParams2ndByte + (param1 * 120)
    elseif param1 == 4 then
        obj_scale(o, 0.65)
        rotate_fan(o, param1)
    elseif param1 == 22 then
        rotate_fan(o, param1)
    elseif param1 == 1 then
        obj_scale(o, 0.8)
        rotate_fan2(o, 6.5)
    end
    if o.oBehParams == 43 then
        obj_scale(o, 0.8)
        rotate_fan2(o, 6.5)
        o.hitboxRadius = 500 * 3
        o.hitboxHeight = 745 * 3
        o.oIntangibleTimer = 0
        if obj_check_hitbox_overlap(o, gMarioStates[0].marioObj) then
            gMarioStates[0].action = ACT_DOUBLE_JUMP
            gMarioStates[0].vel.y = 15
        end
    end
end

bhvTHIFan = hook_behavior(nil, --[[not sure]] OBJ_LIST_LEVEL, true, bhv_thi_fan_init, bhv_thi_fan_loop)

--[[
slimesize_amount = 0.015
slimesize_amount_fast = 0.045
]]
marshmallow_inc_dec_slow = 0.015
marshmallow_inc_dec_fast = 0.082

local function bhv_marshmallow_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("marshmallow_collision")
    cur_obj_set_home_once()
end

local function bhv_marshmallow_loop(o)
    load_object_collision_model()

    if o.oAction == 0 then
        if cur_obj_is_mario_on_platform() == 1 then
            o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 0.7, marshmallow_inc_dec_slow)
            o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 1.1, marshmallow_inc_dec_slow)
            o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 1.1, marshmallow_inc_dec_slow)
            if o.oAnimState == 1 then
                gMarioStates[0].action = ACT_TRIPLE_JUMP
                gMarioStates[0].vel.y = 120
                o.oAnimState = 0
            end
        else
            o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 1, marshmallow_inc_dec_slow)
            o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 1, marshmallow_inc_dec_slow)
            o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 1, marshmallow_inc_dec_slow)
            o.oAnimState = 0
        end
        if cur_obj_is_mario_ground_pounding_platform() == 1 then
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 0.4, marshmallow_inc_dec_fast)
        o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 2, marshmallow_inc_dec_fast)
        o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 2, marshmallow_inc_dec_fast)

        o.oSubAction = o.oSubAction + 1

        if o.oSubAction > 15 then
            o.oAction = 2
        end
    elseif o.oAction == 2 then
        o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 1, marshmallow_inc_dec_fast)
        o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 1, marshmallow_inc_dec_fast)
        o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 1, marshmallow_inc_dec_fast)

        o.oSubAction = o.oSubAction + 1

        if o.oSubAction > 5 then
            o.oAction = 0
            o.oSubAction = 0
            o.oAnimState = 1
        end
    end
end

bhvMarshMallow = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_marshmallow_init, bhv_marshmallow_loop)

local function bhv_fading_warp_stand_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("fading_warp_stand_collision")
end

local function bhv_fading_warp_stand_loop(o)
    load_object_collision_model()
end

---bhvFadingWarpStand
hook_behavior(id_bhvBowserKeyCourseExit, OBJ_LIST_SURFACE, true, bhv_fading_warp_stand_init, bhv_fading_warp_stand_loop)

local function bhv_rotating_cupcake_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("cupcake_collision")
    o.oCollisionDistance = 1200
    o.oAngleVelYaw = 0x200
end

local function bhv_rotating_cupcake_loop(o)
    load_object_collision_model()
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x200
end

bhvRotatingCupcake = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rotating_cupcake_init, bhv_rotating_cupcake_loop)

local function bhv_spinning_cheese_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("spinning_cheese_collision")
    o.oCollisionDistance = 4000
    o.oAngleVelYaw = -64
    network_init_object(o, true, { "oFaceAngleYaw" })
end

local function bhv_spinning_cheese_loop(o)
    load_object_collision_model()
    o.oFaceAngleYaw = o.oFaceAngleYaw + -64
end

bhvSpinningCheese = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_spinning_cheese_init, bhv_spinning_cheese_loop)

---@param o Object
local function bhv_spike_fire_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("hmc_spike_collision")
    o.oCollisionDistance = 1500
    network_init_object(o, true, { "oSubAction", "oAction", "oPosY" })
end

---@param o Object
local function bhv_spike_fire_loop(o)
    load_object_collision_model()
    o.oSubAction = o.oSubAction + 1
    if o.oSubAction > 70 then
        o.oAction = o.oAction ~ 1
        o.oSubAction = 0
        cur_obj_play_sound_1(SOUND_GENERAL_WATER_LEVEL_TRIG)
    end

    if o.oAction == 1 then
        o.oPosY = -282
    else
        o.oPosY = -42
    end
end

hook_behavior(id_bhvFlameMovingForwardGrowing, OBJ_LIST_SURFACE, true, bhv_spike_fire_init, bhv_spike_fire_loop)

local function bhv_chocolate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("chocolate_collision")
end

bhvChocolate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_chocolate_init,
    function(o)
        load_object_collision_model()
    end)

function bhv_whomp_moving_platform_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE|OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("whomp_moving_car_collision")
    o.oMoveAngleYaw = -15300
    network_init_object(o, true, nil)
end

local sHMCWhompCarTraj = {
    { timer = 400, moveangle = -18688, pitch = -7000 },
}

---@param o Object
function bhv_whomp_moving_platform_loop(o)
    load_object_collision_model() -- not done

    --djui_chat_message_create(tostring(o.oAnimState))

    --o.oPosY = find_floor_height(o.oPosX, o.oPosY, o.oPosZ)

    --o.oAngleVelYaw = o.oForwardVel * sins(o.oMoveAngleYaw)
    --o.oPosZ = o.oPosZ + o.oForwardVel * coss(o.oMoveAngleYaw)


    --cur_obj_update_floor_and_walls()
    --cur_obj_move_standard(-78)

    for i = 1, #sHMCWhompCarTraj do
        if o.oAnimState == sHMCWhompCarTraj[i].timer then
            o.oMoveAngleYaw = sHMCWhompCarTraj[i].moveangle
            o.oMoveAnglePitch = sHMCWhompCarTraj[i].pitch
        end
    end

    if o.oAction == 0 then
        o.oForwardVel = 0
        if cur_obj_is_any_player_on_platform() == 1 then
            --o.oAction = 1
        end
    elseif o.oAction == 1 then
        o.oForwardVel = 15
        o.oAnimState = o.oAnimState + 1
    end
end

bhvWhompMovingCar = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_whomp_moving_platform_init,
    bhv_whomp_moving_platform_loop)


---@param o Object
local function bhv_whomp_npc_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oInteractType = INTERACT_TEXT
    o.collisionData = gGlobalObjectCollisionData.whomp_seg6_collision_06020A0C
    o.oIntangibleTimer = 0
    o.oAnimations = gObjectAnimations.whomp_seg6_anims_06020A04
    o.oCollisionDistance = 900
    cur_obj_init_animation(0)
    --network_init_object(o, true, nil)
end

MODEL_WHOMP_MOVING_CAR = smlua_model_util_get_id("whomp_moving_car_geo")

---@param o Object
local function bhv_whomp_npc_loop(o)
    load_object_collision_model()
    o.oBehParams = (3 << 24)
    local mariostate = nearest_mario_state_to_object(o)

    if o.oAction == 0 then
        if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
            gMarioStates[0].action = ACT_READING_NPC_DIALOG
            if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, DIALOG_069) ~= 0 then
                spawn_default_star(mariostate.pos.x, mariostate.pos.y + 200, mariostate.pos.z)
                o.oInteractStatus = 0
                o.oAction = 1
                o.oInteractType = INTERACT_IGLOO_BARRIER
            end
            --[[if response == 1 then
                spawn_sync_object(bhvWhompMovingCar, MODEL_WHOMP_MOVING_CAR, -1912, -493, 10909, nil).oMoveAngleYaw = -15300
                o.oInteractType = 0

                mariostate.action = ACT_IDLE
                o.oInteractStatus = 0
            elseif response == 2 then
                mariostate.action = ACT_IDLE
                o.oInteractStatus = 0
            end
        end]]
        end
    end
end

bhvWhompNPC = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_whomp_npc_init, bhv_whomp_npc_loop)

local function bhv_thi2_platform(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("thi2_platform_collision")
end

bhvTHI2Platform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_thi2_platform,
    function(o)
        load_object_collision_model()
    end)

local function bhv_talking_peach(o)
    o.oFlags = (OBJ_FLAG_PERSISTENT_RESPAWN | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oInteractType = INTERACT_TEXT
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oAnimations = gObjectAnimations.peach_seg5_anims_0501C41C
    cur_obj_init_animation(6)
    o.hitboxRadius = 110
    o.hitboxHeight = 70
    o.oIntangibleTimer = 0
    bhv_toad_message_init()
end

bhvTalkingPeach = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_talking_peach,
    function(o)
        bhv_toad_message_loop()
        if get_curr_star_count() >= 45 then obj_mark_for_deletion(o) end
    end)

local function bhv_ssl_rotating_platform(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("ssl_rotating_platform_collision")
    o.oCollisionDistance = 5000
    o.oAngleVelYaw = 50
end

bhvSSLRotatingPlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_ssl_rotating_platform,
    function(o)
        load_object_collision_model()
        o.oFaceAngleYaw = o.oFaceAngleYaw + 50
    end)

---@param o Object
local function bhv_queen_bee_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oInteractType = INTERACT_TEXT
    o.hitboxRadius = 140
    o.hitboxHeight = 260
    o.hitboxDownOffset = 0
    o.oIntangibleTimer = 0
    smlua_anim_util_set_animation(o, "anim_queen_bee")
end

---@param o Object
local function bhv_queen_bee_loop(o)
    o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, o.oAngleToMario, 0x130)
    if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        gMarioStates[0].action = ACT_READING_NPC_DIALOG
        if cutscene_object_with_dialog(CUTSCENE_RACE_DIALOG, o, o.oBehParams2ndByte) ~= 0 then
            o.oInteractStatus = 0
        end
    end
end

--bhvQueenBee
hook_behavior(id_bhvBetaBowserAnchor, OBJ_LIST_GENACTOR, true, bhv_queen_bee_init, bhv_queen_bee_loop)

---@param o Object
local function bhv_und_magikoopa_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO
    o.oInteractType = INTERACT_IGLOO_BARRIER
    o.hitboxRadius = 80
    o.hitboxHeight = 90
    o.oIntangibleTimer = 0
    o.oOpacity = 255
    o.oAnimations = gObjectAnimations.toad_seg6_anims_0600FB58
    cur_obj_init_animation(6)
    network_init_object(o, true, { "oAction", "oPosX", "oPosY", "oPosZ", "oBehParams2ndByte" })
end

---@param o Object
local function bhv_und_magikoopa_loop(o)
    o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, o.oAngleToMario, 0x170)
    local currP = nearest_player_to_object(o)
    local curPsync = o.oBehParams2ndByte == DIALOG_103 and currP or gMarioStates[0].marioObj
    if dist_between_objects(o, curPsync) < 200 then
        if o.oAction == 0 then
            if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, o.oBehParams2ndByte) ~= 0 then
                if o.oBehParams2ndByte == 102 then
                    o.oAction = 1
                else
                    network_send_object(o, true)
                    o.oAction = 2
                    spawn_triangle_break_particles(20, 138, 3.0, 4);
                    spawn_sync_object(id_bhvStar, E_MODEL_STAR, o.oPosX, o.oPosY + 100, o.oPosZ,
                        function(o) o.oBehParams = (3 << 24) end)
                    obj_mark_for_deletion(o)
                end
            end
        end
    end

    if o.oAction == 1 then
        if dist_between_objects(o, currP) > 200 then
            o.oAction = 0
        end
    elseif o.oAction == 2 then

    end

    if gMarioStateExtras[0].hasMagicWand == true then
        o.oBehParams2ndByte = DIALOG_103
    else
        o.oBehParams2ndByte = DIALOG_102
    end
end

bhvUnderCoverMagikoopa = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_und_magikoopa_init, bhv_und_magikoopa_loop)

MODEL_CG_20_GATE = smlua_model_util_get_id("cg_20_gate_geo")

---@param o Object
local function bhv_cg_20_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("cg_20_gate_collision")
    o.header.gfx.skipInViewCheck = true
end

---@param o Object
local function bhv_cg_20_gate_loop(o)
    load_object_collision_model()
    if get_curr_star_count() >= 20 then
        obj_mark_for_deletion(o)
    end

    obj_delete_if_flood(o)
end

bhvCG20Gate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cg_20_gate_init, bhv_cg_20_gate_loop)

MODEL_FIRE_BULLY = smlua_model_util_get_id("fire_bully_geo") -- for bitdw (bowsers fiery castle)

---@param o Object
local function bhv_bitdw_floating_boat_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("bitdw_floating_boat_collision")
    o.oCollisionDistance = 1000
    o.header.gfx.skipInViewCheck = true
    o.oMoveAngleYaw = -16384
    o.oFaceAngleYaw = o.oFaceAngleYaw + 16384
    --save_file_set_flags(SAVE_FLAG_HAVE_KEY_1)
    --network_init_object(o, true, { "oAction", "oSubAction", "oForwardVel" })
end

---@param o Object
local function bhv_bitdw_floating_boat_loop(o) -- not done yet
    load_object_collision_model()

    --[[local currP = nearest_player_to_object(o)
    if o.oAction == 0 then
        if cur_obj_is_mario_on_platform() == 1 then
            o.oAction = 1
        end
    end
    if o.oAction == 1 then
        o.oForwardVel = 12
    end]]
end

bhvBITDWBoat = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bitdw_floating_boat_init, bhv_bitdw_floating_boat_loop)

---@param o Object
local function bhv_thi_floating_platform_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_MOVE_XZ_USING_FVEL | OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("thi_flying_train_collision")
    o.oForwardVel = 15
    cur_obj_set_home_once()
    network_init_object(o, true, { "oAnimState", "oAction", "oMoveAngleYaw", "oPosX", "oPosY", "oPosZ" })
end

local sThiTrainTrajectoryInfo = {
    { timer = 150, action = 1, moveangle = -5459 },
    { timer = 265, action = 2, moveangle = 6109 },
    { timer = 360, action = 3, moveangle = 13725 },
    { timer = 470, action = 4, moveangle = 16384 },
    { timer = 575, action = 5, moveangle = 19549 },
    { timer = 675, action = 6, moveangle = 26941 },
    { timer = 730, action = 7, moveangle = -27251 },
    { timer = 820, action = 8, moveangle = -19612 },
    { timer = 920, action = 9, moveangle = -16384 },
}

---@param o Object
local function bhv_thi_floating_platform_loop(o)
    load_object_collision_model()
    --djui_chat_message_create(tostring(o.oAnimState))
    o.oAnimState = o.oAnimState + 1
    for i = 1, #sThiTrainTrajectoryInfo do
        if o.oAnimState == sThiTrainTrajectoryInfo[i].timer then
            o.oAction = sThiTrainTrajectoryInfo[i].action
        end
    end

    if o.oAction ~= 0 then
        o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, sThiTrainTrajectoryInfo[o.oAction].moveangle, 200)
        if o.oMoveAngleYaw == sThiTrainTrajectoryInfo[o.oAction].moveangle then
            o.oAction = 0
        end
    end

    if o.oAnimState == 950 then
        cur_obj_set_pos_to_home()
        o.oAnimState = 0
    end
end

---bhvThiFlyingBus
hook_behavior(id_bhvBigBullyWithMinions, OBJ_LIST_SURFACE, true, bhv_thi_floating_platform_init,
    bhv_thi_floating_platform_loop)

-- the door in CG area 2

MODEL_BOWSER_KEY_GATE = smlua_model_util_get_id("bowser_door_key_geo")

---@param o Object
local function bhv_bowser_door_key_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("bowser_door_key_collision")
    o.header.gfx.skipInViewCheck = true
    o.oAnimState = o.oFaceAngleYaw
    network_init_object(o, true, { "oFaceAngleYaw", "oAction" })
end

---@param o Object
local function bhv_bowser_door_key_loop(o)
    load_object_collision_model()
    if is_star_colected(COURSE_BITDW, 5) then
        if dist_between_objects(o, nearest_player_to_object(o)) < 1200 then
            o.oAction = 1
        end
    end
    if o.oAction == 1 then
        o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, (o.oAnimState == 0 and -13000 or -16384 - 3384), 300)
    end
end

bhvBowserKeyGate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bowser_door_key_init, bhv_bowser_door_key_loop)

local function bhv_soup(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 2000
    o.collisionData = smlua_collision_util_get("soup_collision")
end

bhvSoup = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_soup, function(o) load_object_collision_model() end)

---@param o Object
local function bhv_animated_hands_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oIntangibleTimer = 0
    o.oDamageOrCoinValue = 2
    network_init_object(o, true, nil)
end

---@param o Object
local function bhv_animated_hands_loop(o)
    local curP = nearest_player_to_object(o)
    o.oInteractStatus = 0

    if dist_between_objects(o, curP) < 500 then
        smlua_anim_util_set_animation(o, "anim_animated_hand_attack")
    else
        smlua_anim_util_set_animation(o, "anim_animated_hand_idle")
        o.oInteractType = INTERACT_IGLOO_BARRIER
        o.hitboxRadius = 0
        o.hitboxHeight = 0
    end
    if dist_between_objects(o, curP) < 2400 then
        o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, obj_angle_to_object(o, curP), 0x180)
    end

    if smlua_anim_util_get_current_animation_name(o) == "anim_animated_hand_attack" and o.header.gfx.animInfo.animFrame == 38 then
        o.oInteractType = INTERACT_DAMAGE
        o.hitboxRadius = 450
        o.hitboxHeight = 700
    end
end

hook_behavior(id_bhvPyramidElevator, OBJ_LIST_GENACTOR, true, bhv_animated_hands_init, bhv_animated_hands_loop)


---@param o Object
local function bhv_hmc_gear_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
end

local s50Time10 = 50 * 10
local Ns50Time10 = -(50 * 10)

local angleAdjust = {
    [16] = s50Time10,
    [240] = Ns50Time10,
    [12] = s50Time10,
    [244] = Ns50Time10,
    [24] = s50Time10,
    [232] = Ns50Time10
}

---@param o Object
local function bhv_hmc_gear_loop(o)
    local beh1st = (o.oBehParams >> 24) & 0xFF

    if angleAdjust[beh1st] then
        o.oFaceAngleRoll = o.oFaceAngleRoll + angleAdjust[beh1st]
    end
end

bhvHMCGear = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_hmc_gear_init, bhv_hmc_gear_loop)

---@param o Object
local function bhv_hmc_moving_platform_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.collisionData = smlua_collision_util_get("hmc_moving_platform_collision")
    o.oCollisionDistance = 1000
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
    --network_init_object(o, true, { "oAction", "oSubAction", "oForwardVel" })
end

---@param o Object
local function bhv_hmc_moving_platform_loop(o)
    load_object_collision_model()

    --- only moves for the local player, others player wont see it moving.
    if o.oAction == 0 then
        o.oForwardVel = 0
        if gMarioStates[0].marioObj.platform == o then
            o.oAction = 1
        end
    end
    if o.oAction == 1 then
        o.oForwardVel = -12
    end

    if o.oPosZ < -15500 then
        o.oAction = 0
        cur_obj_set_pos_to_home()
    end
end

bhvHMCMovingPlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_hmc_moving_platform_init,
    bhv_hmc_moving_platform_loop)

local function bhv_2d_star_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
end

local function bhv_2d_star_loop(o)
    o.oAnimState = o.oAnimState + 1

    --[[local thestar = obj_get_first_with_behavior_id(id_bhvStar)

    if thestar.oBehParams ~= (5 << 24) then
        thestar = obj_get_next_with_same_behavior_id(thestar)
    else
        if thestar.oInteractStatus ~= 0 then
            obj_mark_for_deletion(o)
        end
    end]]
end

bhv2DStar = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_2d_star_init, bhv_2d_star_loop)

--//bhvYellowBackgroundInMenu
MODEL_MINIGAME_HOUSE = smlua_model_util_get_id("minigame_house_geo")

MODEL_BOAT = smlua_model_util_get_id("boat_geo")

---@param o Object
local function bhv_boat_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.collisionData = smlua_collision_util_get("boat_collision")
    o.oCollisionDistance = 1200
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
end

--only moves for local player
---@param o Object
local function bhv_boat_loop(o)
    load_object_collision_model()

    obj_delete_if_flood(o)

    if o.oAction == 0 then
        o.oForwardVel = 0
        if o.oBehParams2ndByte == 0 then
            if get_curr_star_count() >= 4 then
                obj_mark_for_deletion(o)
            end
        end

        if o.oBehParams2ndByte == 1 then
            if get_curr_star_count() < 4 then
                obj_mark_for_deletion(o)
            end

            if cur_obj_is_mario_on_platform() == 1 then
                o.oAction = 1
            end
        end
    elseif o.oAction == 1 then
        o.oForwardVel = 25
        local CurrM = nearest_mario_state_to_object(o)
        local realM = gMarioStates[0]
        realM.pos.x = o.oPosX
        realM.pos.y = o.oPosY + 90
        realM.pos.z = o.oPosZ
    end
end

bhvBoat = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_boat_init, bhv_boat_loop)

MODEL_BOB_RAINBOW = smlua_model_util_get_id("bob_level_model_rainbow_geo")
MODEL_BOB_NORMAL = smlua_model_util_get_id("bob_level_model_geo")

---@param o Object
local function bhv_bob_level_model_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
end

---@param o Object
local function bhv_bob_level_model_loop(o)
    if gMarioStateExtras[0].fuzzied then
        obj_set_model_extended(o, MODEL_BOB_RAINBOW)
        if o.oAction ~= 1 and o.oAction ~= 2 then
            o.oAction = math.random(1, 3)
        end
    else
        obj_set_model_extended(o, MODEL_BOB_NORMAL)
        o.oAction = 0
    end

    if o.oAction == 0 then
        cur_obj_set_pos_to_home()
        o.oFaceAnglePitch = 0
        o.oFaceAngleRoll = 0
        o.oFaceAngleYaw = 0
    end

    if o.oAction == 1 then
        o.oPosX = o.oPosX + math.random(2, 3)
        o.oPosZ = o.oPosZ + math.random(2, 6)
    end

    if o.oAction == 2 then
        o.oFaceAnglePitch = o.oFaceAnglePitch + 2
        o.oFaceAngleRoll = o.oFaceAngleRoll + 3
    end

    if o.oAction == 3 then
        o.oPosY = o.oPosY - 1.5
    end
end

bhvBOBLevelModel = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_bob_level_model_init, bhv_bob_level_model_loop)

---@param o Object
local function bhv_air_ballon(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 80
    o.hitboxHeight = 160
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_IGLOO_BARRIER
end

--bhvAirBalloon (TOTWC)
bhvAirBalloon = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_air_ballon, nil)

--[[[0021BA7C / 13001C7C] 00 04 0000 // Start Behavior (Object type = 4)
[0021BA80 / 13001C80] 23 00 00 00 0140 0500 // Set Collision sphere size (XZ radius = 320, Y radius = 1280)
[0021BA88 / 13001C88] 0E 45 2000 // (Set value) obj->_0x19C = (float)8192
[0021BA8C / 13001C8C] 04 00 00 00 13000288 // Jump to address 0x13000288 --probably koopa shell?
[0021A088 / 13000288] 0E 2A 0002 // (Set value) obj->_0x130 = (float)2
[0021A08C / 1300028C] 08 00 00 00 // Start of loop
[0021A090 / 13000290]    10 05 0000 // (Set value) obj->_0x9C = 0
[0021A094 / 13000294]    10 2B 0000 // (Set value) obj->_0x134 = 0
[0021A098 / 13000298]    09 00 00 00 // End of loop]]

---@param o Object
local function bhv_air_ballon2(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 320
    o.hitboxHeight = 1280
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_IGLOO_BARRIER
end

--bhvAirBalloon2 (SL)
hook_behavior(id_bhvClockMinuteHand, OBJ_LIST_LEVEL, true, bhv_air_ballon2, nil)

---@param o Object
local function bhv_sl_cloudy_platform(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("sl_cloudy_platform_collision")
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
end

---@param o Object
local function bhv_sl_cloudy_platform_loop(o)
    load_object_collision_model()
    o.oPosY = o.oPosY + approach_f32_asymptotic(o.oVelY, (o.oHomeY - o.oPosY) / 8, 0.4)
    if cur_obj_is_mario_on_platform() ~= 0 then
        o.oPosY = o.oPosY - 9 + (o.oBehParams2ndByte / 100)
    end
end

bhvSLCloudyPlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_sl_cloudy_platform, bhv_sl_cloudy_platform_loop)

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
local function bhv_static_tree(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 160
    o.hitboxHeight = 864
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_IGLOO_BARRIER
    o.header.gfx.skipInViewCheck = true
end

hook_behavior(id_bhvBetaChestBottom, OBJ_LIST_GENACTOR, true, bhv_static_tree, nil)

---@param o Object
local function bhv_totwc_cloudy_platform(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1600
    o.collisionData = smlua_collision_util_get("totwc_cloudy_platform_collision")
    cur_obj_set_home_once()
end

bhvTOTWCCloudyPlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_totwc_cloudy_platform,
    bhv_bob_cloud_platform_loop)

local StarSpawned = false

hook_event(HOOK_ON_LEVEL_INIT, function()
    StarSpawned = false
end)

local FLIPSWITCH_PANEL_ACT_IDLE = 0
local FLIPSWITCH_PANEL_ACT_MARIO_IS_ON = 1

E_MODEL_FLIPSWITCH_PANEL = smlua_model_util_get_id("Flipswitch_Panel_MOP")

---@param obj Object
function bhv_flipswitch_panel_init(obj)
    obj_set_model_extended(obj, E_MODEL_FLIPSWITCH_PANEL)
    obj.oPosY = obj.oPosY + 40
    load_object_collision_model()
    -- One of the only synced MOPs
    network_init_object(obj, false, {
        "oAction",
        "oAnimState"
    })
end

---@param obj Object
function bhv_flipswitch_panel_loop(obj)
    -- Always checks for the starspawn mop
    --[[local starspawn_obj = obj_get_nearest_object_with_behavior_id(obj, bhvFlipswitch_Panel_StarSpawn_MOP)
    if not starspawn_obj then return end
    if not is_current_area_sync_valid() then return end
    if obj.parentObj ~= starspawn_obj then
        obj.parentObj = starspawn_obj
    end]]

    -- Turn green and don't allow further change
    if StarSpawned then
        obj.oAnimState = 2
    else
        switch(obj.oAction, {
            [FLIPSWITCH_PANEL_ACT_IDLE] = function()
                if cur_obj_is_mario_on_platform() == 1 and not is_bubbled(gMarioStates[0]) then
                    -- Causes the panel to change colors upon being pressed multiple times
                    -- Doesn't sync properly, the starspawn itself now checks each panel
                    --obj.parentObj.oHiddenStarTriggerCounter = obj.parentObj.oHiddenStarTriggerCounter + 1 - (2 * obj.oAnimState)
                    obj.oAnimState = obj.oAnimState ~ 1

                    cur_obj_play_sound_1(SOUND_GENERAL_BIG_CLOCK)
                    obj.oAction = FLIPSWITCH_PANEL_ACT_MARIO_IS_ON
                    network_send_object(obj, true)
                end
            end,
            [FLIPSWITCH_PANEL_ACT_MARIO_IS_ON] = function()
                local closest_player = nearest_player_to_object(obj)
                if not closest_player or (cur_obj_is_mario_on_platform() == 0 and closest_player.platform ~= obj) then
                    obj.oAction = FLIPSWITCH_PANEL_ACT_IDLE
                end
            end
        })
    end
end

---@param obj Object
function bhv_flipswitch_panel_starspawn_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.oHealth = 0
end

---@param obj Object
function bhv_flipswitch_panel_starspawn_loop(obj)
    local amount_of_panels = obj_count_objects_with_behavior_id(bhvFlipswitch_Panel_MOP)
    -- Prevents the starspawn mop from prematurely assume all panels have been pressed
    if amount_of_panels > obj.oHealth or obj.oHealth == 0 then
        obj.oHealth = amount_of_panels
        return
    end

    -- Force check every panel
    obj.oHiddenStarTriggerCounter = 0
    local panel = obj_get_first_with_behavior_id(bhvFlipswitch_Panel_MOP)
    while panel do
        if panel.oAnimState == 1 then
            obj.oHiddenStarTriggerCounter = obj.oHiddenStarTriggerCounter + 1
        end
        panel = obj_get_next_with_same_behavior_id(panel)
    end

    if obj.oHiddenStarTriggerCounter == obj.oHealth and not StarSpawned then
        spawn_red_coin_cutscene_star(obj.oPosX, obj.oPosY, obj.oPosZ)
        StarSpawned = true
        obj_mark_for_deletion(obj)
    end
end

hook_event(HOOK_ON_OBJECT_UNLOAD,
    ---@param obj Object
    function(obj)
        -- Force spawn star for newly entering players
        if obj_has_behavior_id(obj, bhvFlipswitch_Panel_StarSpawn_MOP) == 1 and obj.oHiddenStarTriggerCounter ~= obj.oHealth and not StarSpawned then
            local starspawn_obj = obj_get_first_with_behavior_id(bhvFlipswitch_Panel_StarSpawn_MOP)
            spawn_red_coin_cutscene_star(starspawn_obj.oPosX, starspawn_obj.oPosY, starspawn_obj.oPosZ)
            StarSpawned = true
        end
    end)

---@param o Object
local function bhv_sl_windmill_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 4500
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("sl_windmill_collision")
    o.oAngleVelRoll = 67
end

---@param o Object
local function bhv_sl_windmill_loop(o)
    o.oFaceAngleRoll = o.oFaceAngleRoll + 67
    load_object_collision_model()
end

bhvSLWindmill = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_sl_windmill_init, bhv_sl_windmill_loop)

local function bhv_sl_explodeable_object_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("sl_explodeable_obj_collision")
    network_init_object(o, true, nil)
end

local function bhv_sl_explodeable_object_loop(o)
    load_object_collision_model()

    if (cur_obj_nearest_object_with_behavior(get_behavior_from_id(id_bhvExplosion))) then
        if dist_between_objects((cur_obj_nearest_object_with_behavior(get_behavior_from_id(id_bhvExplosion))), o) < 420 then
            obj_mark_for_deletion(o)
            --network_send_object(o, true)
        end
    end
end

---bhvSLExplodeableObj
hook_behavior(id_bhvLllRotatingHexagonalPlatform, OBJ_LIST_SURFACE, true, bhv_sl_explodeable_object_init,
    bhv_sl_explodeable_object_loop)

---@param o Object
---@param action integer
function obj_set_action(o, action)
    o.oAction = action
end

local function bhv_konami_code_gate(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 2000
    o.collisionData = smlua_collision_util_get("konami_code_gate_collision")
    network_init_object(o, true, { "oPosY", "oAction" })
end

KONAMI_CODE_GATE_ACT_CLOSED = 0
KONAMI_CODE_GATE_ACT_OPENED = 1

-- code is [A] [B] [Z]
local function bhv_konami_code_gate_loop(o)
    load_object_collision_model()

    local m = nearest_mario_state_to_object(o)
    if o.oAction == KONAMI_CODE_GATE_ACT_CLOSED then
        if is_button_down(m, Z_TRIG) and is_button_down(m, B_BUTTON) and is_button_down(m, A_BUTTON) then
            obj_set_action(o, KONAMI_CODE_GATE_ACT_OPENED)
            play_puzzle_jingle()
        end
    elseif o.oAction == KONAMI_CODE_GATE_ACT_OPENED then
        o.oPosY = o.oPosY - 5
        if o.oPosY < -300 then
            obj_mark_for_deletion(o)
        end
    end
end

bhvKonamiCodeGate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_konami_code_gate, bhv_konami_code_gate_loop)


local function bhv_ci_cloud_collision(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1500
    o.collisionData = smlua_collision_util_get("ci_cloud_collision_collision")
end

bhvCICloudCollision = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_ci_cloud_collision,
    function(o) load_object_collision_model() end)

local function bhv_rr_cart_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_MOVE_XZ_USING_FVEL | OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
    -- home yaw
    o.oFishYawVel = o.oMoveAngleYaw
end

local sRRkartTrajectory = {
    { timer = 30 + 10, moveangle = 20600 },
    { timer = 115,     moveangle = 26000 },
    { timer = 200,     moveangle = -32240 },
    { timer = 275,     moveangle = -27500 },
    { timer = 445,     moveangle = -22500 },
    { timer = 520,     moveangle = -16000 },
    { timer = 615,     moveangle = -6830 },
    { timer = 702,     moveangle = -750 },
    { timer = 830,     moveangle = 2350 },
    { timer = 985,     moveangle = 1380 },
    { timer = 1170,    moveangle = -5000 },
}

---@param o Object
---only moves for local player
local function bhv_rr_cart_loop(o)
    local mariostate = gMarioStates[0]
    local curP = mariostate.marioObj

    move_obj_with_physics(true, o)

    for i = 1, #sRRkartTrajectory do
        if o.oAnimState == sRRkartTrajectory[i].timer then
            o.oMoveAngleYaw = sRRkartTrajectory[i].moveangle
        end
    end

    if o.oAction == 0 then
        o.oMoveAngleYaw = o.oFishYawVel
        if obj_check_hitbox_overlap(o, curP) then
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        o.oAnimState = o.oAnimState + 1
        local object_pos_vec3f = { x = o.oPosX, y = o.oPosY, z = o.oPosZ }
        vec3f_copy(mariostate.pos, object_pos_vec3f)
        mariostate.faceAngle.y = o.oFaceAngleYaw
        set_mario_animation(mariostate, MARIO_ANIM_SLIDE)
        mariostate.marioObj.header.gfx.pos.y = mariostate.pos.y
        o.oVelY = o.oVelY - 3

        if o.oAnimState < 1275 then
            o.oForwardVel = 8
        else
            o.oForwardVel = approach_s16_symmetric(o.oForwardVel, 0, 1)
        end

        if mariostate.controller.buttonPressed & A_BUTTON ~= 0 then
            if o.oPosY < find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 72 then
                o.oVelY = 60
            end
        end

        if mariostate.controller.buttonPressed & B_BUTTON ~= 0 then
            mariostate.action = ACT_DIVE
            mariostate.vel.y = 30
            mariostate.forwardVel = 20
            o.oAction = 0
            cur_obj_set_pos_to_home()
            o.oVelY = 0
            o.oAnimState = 0
            o.oForwardVel = 0
        end
    end
end

bhvRRRideableCart = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_rr_cart_init, bhv_rr_cart_loop)

local function fake_rr_wind(o)
    o.hitboxRadius = 200
    o.hitboxHeight = 1100
    o.oIntangibleTimer = 0
    if obj_check_hitbox_overlap(o, gMarioStates[0].marioObj) then
        gMarioStates[0].action = ACT_DOUBLE_JUMP
        gMarioStates[0].vel.y = 15
    end
end

bhvFakeRRWind = hook_behavior(nil, OBJ_LIST_LEVEL, true, nil, fake_rr_wind)

--bhvRainbowSnakeBlock

MODEL_SNAKE_BLOCK_RAINBOW = smlua_model_util_get_id("rainbow_snake_block_geo")

local function bhv_rainbow_snake_block_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1500
    o.collisionData = smlua_collision_util_get("rainbow_snake_block_collision")
end

-----------@nope, not doing it. im not mentally insane
---@param o Object
local function bhv_rainbow_snake_block_loop(o)
    load_object_collision_model()

    if cur_obj_is_any_player_on_platform() == 1 then

    end
end

--bhvRainbowSnakeBlock = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rainbow_snake_block_init, bhv_rainbow_snake_block_loop)
---@param o Object
local function bhv_moving_chomp_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.header.gfx.skipInViewCheck = true
    o.oFriction = 1
    obj_scale(o, 2)
    obj_set_hitbox_radius_and_height(o, 350, 350)
    o.oForwardVel = 16
    o.oAnimations = gObjectAnimations.chain_chomp_seg6_anims_06025178
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_DAMAGE
    o.oDamageOrCoinValue = 2
    o.hitboxDownOffset = 60
    o.oGraphYOffset = 130
    cur_obj_init_animation(0)
    network_init_object(o, true, { "oMoveAngleYaw", "oPosX", "oPosY", "oPosZ" })
end

---@param o Object
local function bhv_moving_chomp_loop(o)
    object_step()
    o.oInteractStatus = 0
    o.oMoveAngleYaw = o.oMoveAngleYaw + 0x100
    o.oFaceAnglePitch = o.oFaceAnglePitch + 0x500

    if gPlayerSyncTable[network_local_index_from_global(nearest_player_to_object(o).globalPlayerIndex)].powerup == RAINBOW then
        o.oInteractType = 0
        if obj_check_hitbox_overlap(o, nearest_player_to_object(o)) then
            obj_mark_for_deletion(o)
            spawn_triangle_break_particles(20, 138, 3.0, 4);
            obj_spawn_yellow_coins(o, 3)
            play_sound(SOUND_OBJ_KING_WHOMP_DEATH, gGlobalSoundSource)
        end
    else
        o.oInteractType = INTERACT_DAMAGE
    end
end

bhvMovingChomp = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_moving_chomp_init, bhv_moving_chomp_loop)

---@param o Object
local function bhv_bitfs_cloudy_platform(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 900
    o.collisionData = smlua_collision_util_get("bitfs_cloudy_platform_collision")
    cur_obj_set_home_once()
end

---@param o Object
local function bhv_bitfs_cloudy_platform_loop(o)
    load_object_collision_model()
    o.oPosY = o.oPosY + approach_f32_asymptotic(o.oVelY, (o.oHomeY - o.oPosY) / 8, 0.5)
    if cur_obj_is_mario_on_platform() ~= 0 then
        o.oPosY = o.oPosY - 6
    end
end


bhvBITFSCloudyPlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bitfs_cloudy_platform,
    bhv_bitfs_cloudy_platform_loop)

local angleAdjust2 = {
    [248] = Ns50Time10 / 5,
    [8] = s50Time10 / 5,
}

---@param o Object
local function bhv_bitfs_gear_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bitfs_gear_collision")
    o.oAngleVelRoll = ((o.oBehParams >> 24) & 0xFF) == 248 and Ns50Time10 / 5 or s50Time10 / 5
end

---@param o Object
local function bhv_bitfs_gear_loop(o)
    load_object_collision_model()
    local beh1st = (o.oBehParams >> 24) & 0xFF

    if angleAdjust2[beh1st] then
        o.oFaceAngleRoll = o.oFaceAngleRoll + angleAdjust2[beh1st]
    end
end

---bhvBITFSGear
hook_behavior(id_bhvSLWalkingPenguin, OBJ_LIST_SURFACE, true, bhv_bitfs_gear_init, bhv_bitfs_gear_loop)

---@param o Object
local function bhv_bitfs_cloudy_rotating_platform(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1000
    o.collisionData = smlua_collision_util_get("bitfs_cloudy_rotating_platform_collision")
    cur_obj_set_home_once()
    o.oAngleVelYaw = 0x80
end

---@param o Object
local function bhv_bitfs_cloudy_rotating_platform_loop(o)
    load_object_collision_model()
    o.oPosY = o.oPosY + approach_f32_asymptotic(o.oVelY, (o.oHomeY - o.oPosY) / 8, 0.55)
    if cur_obj_is_mario_on_platform() ~= 0 then
        o.oPosY = o.oPosY - 8
    end

    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x80
end


bhvBITFSCloudyRotatingPlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bitfs_cloudy_rotating_platform,
    bhv_bitfs_cloudy_rotating_platform_loop)

---@param o Object
local function bhv_rotating_staircase_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1600
    o.collisionData = smlua_collision_util_get("rotating_staircase_collision")
end

---@param o Object
local function bhv_rotating_staircase_loop(o)
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x80
    load_object_collision_model()
end


bhvRotatingStaircase = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rotating_staircase_init,
    bhv_rotating_staircase_loop)

---@param o Object
local function bhv_ttc_static_tree(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 128
    o.hitboxHeight = 288
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_IGLOO_BARRIER
    o.header.gfx.skipInViewCheck = true
end

bhvTTCStaticTree = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_ttc_static_tree, nil)

---@param o Object
function bhv_ttc_cloud(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1500
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("ttc_cloud_collision")
end

---@param o Object
function bhv_ttc_cloud_loop(o)
    load_object_collision_model() -- not done yet
end

bhvTTCCloud = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_ttc_cloud, bhv_ttc_cloud_loop)

---@param o Object
function bhv_bitfs_slime_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bitfs_slime_collision")
    network_init_object(o, true, { "oAction", "oTimer" })
end

slimesize_amount = 0.015
slimesize_amount_fast = 0.045

---@param o Object
function bhv_bitfs_slime_loop(o)
    load_object_collision_model()

    if o.oAction == 0 then
        if cur_obj_is_any_player_on_platform() == 1 then
            o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 0, slimesize_amount)
            o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 2, slimesize_amount)
            o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 2, slimesize_amount)
        else
            o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 1, slimesize_amount)
            o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 1, slimesize_amount)
            o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 1, slimesize_amount)
        end

        if is_any_mario_groundpounding_obj(o) then
            o.oAction = 1
            o.oTimer = 0
        end
    elseif o.oAction == 1 then
        o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 0, slimesize_amount_fast)
        o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 2, slimesize_amount_fast)
        o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 2, slimesize_amount_fast)
        if o.oTimer > 40 then
            o.oAction = 0
        end
    end
end

bhvBITFSSlime = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bitfs_slime_init, bhv_bitfs_slime_loop)

bossShadowMarioAnims = {
    [0] = get_mario_vanilla_animation(MARIO_ANIM_FIRST_PERSON),
    get_mario_vanilla_animation(MARIO_ANIM_RUNNING),
    get_mario_vanilla_animation(MARIO_ANIM_FIRST_PUNCH),
    get_mario_vanilla_animation(MARIO_ANIM_DIVE),
    get_mario_vanilla_animation(MARIO_ANIM_FORWARD_SPINNING),
    get_mario_vanilla_animation(MARIO_ANIM_SLIDEFLIP),
    get_mario_vanilla_animation(MARIO_ANIM_GROUND_BONK),
}

MODEL_SHADOW_MARIO = smlua_model_util_get_id("shadow_mario_geo")

---@param o Object
function bhv_boss_shadow_mario_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW

    obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 0, true)

    o.oGraphYOffset = 40

    o.oFriction = 1
    o.oGravity = 3

    o.oInteractType = INTERACT_DAMAGE
    o.oIntangibleTimer = 0
    o.oDamageOrCoinValue = 1

    o.oHealth = 6

    obj_set_hitbox_radius_and_height(o, 85, 120)

    cur_obj_set_home_once()

    network_init_object(o, true,
        { "oAction", "oBirdSpeed", "oMoveAngleYaw", "oAnimState", "oInteractStatus", "oForwardVel", "oSubAction",
            "oHeldState", "oHealth" })
end

---@param o Object
function bhv_boss_shadow_mario_loop(o)
    local nearestP = nearest_player_to_object(o)
    local nearestMstate = nearest_mario_state_to_object(o)

    object_step()

    if o.oAction ~= 0 then
        -- check if this bigger than 260, set allow dive to true
        o.oBirdSpeed = o.oBirdSpeed + 9
        ---check if this bigger then 320 then allow jump
        o.oHeldState = o.oHeldState + 14
        if o.oBirdSpeed > 260 then
            o.oBirdSpeed = 0
            o.oAnimState = 1
        end

        if o.oHeldState > 360 then
            o.oHeldState = 0
            o.oAnimState = 2
        end
        if o.oAction ~= 2 then
            if o.oAction ~= 3 and o.oAction ~= 4 and o.oAction ~= 5 then
                o.oForwardVel = 30
                o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, obj_angle_to_object(o, nearestP), 0x530)
            end
        end
    end

    if nearestMstate.pos.z > -7221 and nearestMstate.pos.z < -3342
        and nearestMstate.pos.x > 11379 and nearestMstate.pos.x < 19254 and o.oAction == 0 then
        o.oAction = 1
    elseif nearestMstate.pos.x < 11379 and o.oAction ~= 0 then
        o.oAction = 0
        cur_obj_set_pos_to_home()
        o.oMoveAngleYaw = 16384
    end



    if o.oAction == 0 then
        o.oForwardVel = 0
        obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 0, true)
    elseif o.oAction == 1 then
        o.oInteractType = INTERACT_DAMAGE
        obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 1, true, 3.2)
        if o.oInteractStatus & INT_STATUS_ATTACKED_MARIO ~= 0 and o.oAnimState == 0 then
            o.oInteractStatus = 0
            o.oAction = 2
        end

        if dist_between_objects(o, nearestP) < 300 and o.oAnimState == 1 then
            o.oAction = 3
        end

        if dist_between_objects(o, nearestP) < 250 and o.oAnimState == 2 then
            o.oAction = 4
        end
    elseif o.oAction == 2 then
        o.oInteractStatus = 0
        o.oForwardVel = 0
        obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 2, true, 0.1)
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 20 then
            o.oAction = 1
        end
    elseif o.oAction == 3 then
        o.oInteractStatus = 0
        o.oForwardVel = 48
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction < 15 then
            obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 3, true, 1)
        else
            obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 4, true, 1)
            if o.oSubAction > 25 then
                o.oAnimState = 0
                o.oAction = 1
            end
        end
    elseif o.oAction == 4 then
        o.oInteractStatus = 0
        if o.oSubAction == 0 then
            o.oVelY = 40
        end

        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 20 then
            o.oAnimState = 0
            o.oAction = 1
            o.oSubAction = 0
        end
        obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 5, true, 1)
        o.oForwardVel = 29
    elseif o.oAction == 5 then
        o.oInteractType = 0
        o.oForwardVel = -4
        o.oSubAction = o.oSubAction + 1
        obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 6, true, 1)
        if o.oSubAction > 35 then
            o.oAction = 1
        end
    end

    if dist_between_objects(o, nearestP) < 130 and o.oAction ~= 5 then
        if nearestMstate.action == ACT_JUMP_KICK or nearestMstate.action == ACT_PUNCHING or nearestMstate.action == ACT_MOVE_PUNCHING or nearestMstate.action == ACT_GROUND_POUND then
            play_sound(SOUND_ACTION_HIT_2, gGlobalSoundSource)
            o.oAction = 5
            o.oHealth = o.oHealth - 1
        end
    end

    if o.oHealth <= 0 then
        spawn_triangle_break_particles(20, 138, 3.0, 4);
        obj_mark_for_deletion(o)
    end
end

bhvShadowMarioBoss = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_boss_shadow_mario_init, bhv_boss_shadow_mario_loop)

MODEL_GOOMBABROS_TRIANGLE = smlua_model_util_get_id("goomba_bros_triangle_geo")

function bhv_goomba_bros_triangle_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW|OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.oGravity = -3
    o.collisionData = smlua_collision_util_get("goomba_bros_triangle_collision")
    o.header.gfx.skipInViewCheck = true
end

function bhv_goomba_bros_triangle_loop(o)
    obj_mark_for_deletion(o) -- not done
    load_object_collision_model()
    if gGlobalSyncTable.goombabros1 then
        cur_obj_enable_rendering()
        cur_obj_become_tangible()
    else
        cur_obj_disable_rendering()
        cur_obj_become_intangible()
    end

    --[[if is_star_colected(COURSE_NONE, 1) then
        obj_mark_for_deletion(o)
    end]]

    if not gGlobalSyncTable.goombabros1 then return end
    if o.oAction == 1 then
        o.oMoveAngleYaw = o.oMoveAngleYaw + 0x220
        o.oForwardVel = 12
    end
end

bhvGoombaBrosTraingle = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_goomba_bros_triangle_init,
    bhv_goomba_bros_triangle_loop)

---gomba bros!!
MODEL_GOOMBA_BRO1 = smlua_model_util_get_id("goomba_bro_1_geo")
MODEL_GOOMBA_BRO2 = smlua_model_util_get_id("goomba_bro_2_geo")
MODEL_GOOMBA_BRO3 = smlua_model_util_get_id("goomba_bro_3_geo")

---@param o Object
function bhv_goomba_bros_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW|OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.oAnimations = gObjectAnimations.goomba_seg8_anims_0801DA4C
    cur_obj_init_animation(0)

    o.oGravity = -3

    cur_obj_scale(1.3)

    network_init_object(o, true, { "oAction" })
end

---@param o Object
function bhv_goomba_bros_loop(o)
    local nearestPlayer = nearest_player_to_object(o)
    local nearestMario = nearest_mario_state_to_object(o)

    --obj_mark_for_deletion(o) -- not done

    ---@type MarioState
    local gMarioState = nearestMario

    --[[if get_curr_star_count() >= 30 then
        gGlobalSyncTable.goombabros1 = true
    end

    if gGlobalSyncTable.goombabros1 then
        cur_obj_enable_rendering()
        cur_obj_become_tangible()
    else
        cur_obj_disable_rendering()
        cur_obj_become_intangible()
    end

    if is_star_colected(COURSE_NONE, 1) then
        obj_mark_for_deletion(o)
    end

    if not gGlobalSyncTable.goombabros1 then return end]]

    if o.oAction == 0 then
        o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, obj_angle_to_object(o, nearestPlayer),
            0x300)

        if dist_between_objects(o, gMarioState.marioObj) < 100 then
            if gMarioState.pos.y == gMarioState.floorHeight then
                gMarioState.action = ACT_READING_NPC_DIALOG
                if (gMarioState and should_start_or_continue_dialog(gMarioState, o) and cutscene_object_with_dialog(CUTSCENE_DIALOG, o, DIALOG_160) ~= 0) then
                    for_each_object_with_behavior(bhvGoombaBros, function(ggg) ggg.oAction = 1 end)
                end
            end
        end
    end
    --spawn_non_sync_object(id_bhvSparkleSpawn, E_MODEL_NONE, o.oPosX, o.oPosY, o.oPosZ, nil)
    if o.oAction == 1 then

    end
end

bhvGoombaBros = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_goomba_bros_init, bhv_goomba_bros_loop)

MODEL_FLOATING_PLATFORM_GENERATOR = smlua_model_util_get_id("floating_platform_generator_geo")

floating_platform_generators_distance = 260

---@param o Object
function bhv_floating_platform_generator_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1500
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("floating_platform_generator_collision")

    if o.oBehParams2ndByte == 18 then
        for i = 0, o.oBehParams2ndByte do
            spawn_non_sync_object(bhvFloatingPlatformGenerator, MODEL_FLOATING_PLATFORM_GENERATOR,
                i & 1 == 0 and o.oPosX + (i * floating_platform_generators_distance) or
                o.oPosX - (i * floating_platform_generators_distance), o.oPosY, o.oPosZ,
                function(obj)
                    obj.oFaceAngleYaw = 16384; obj_set_model_extended(o, MODEL_FLOATING_PLATFORM_GENERATOR)
                end)
        end
    end
end

---@param o Object
function bhv_floating_platform_generator_loop(o)
    load_object_collision_model()
end

bhvFloatingPlatformGenerator = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_floating_platform_generator_init,
    bhv_floating_platform_generator_loop)


-- the door in bitfs (shadow factory)

---@param o Object
function bitfs_general_use_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("bitfs_general_use_cage_collision")
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
end

---@param o Object
function bitfs_general_use_gate_loop(o)
    load_object_collision_model()
    if o.oBehParams == 0 then
        if is_star_colected(COURSE_BITFS, 2) and get_curr_star_count() >= 45 then
            obj_mark_for_deletion(o)
        end
    elseif (o.oBehParams >> 24) & 0xff == 1 and o.oBehParams2ndByte == 1 then
        if not obj_get_nearest_object_with_behavior_id(o, bhvShadowMarioBoss) then
            obj_mark_for_deletion(o)
        end
    elseif (o.oBehParams >> 24) & 0xff == 0 and o.oBehParams2ndByte == 1 then
        if obj_get_nearest_object_with_behavior_id(o, bhvShadowMarioBoss) and obj_get_nearest_object_with_behavior_id(o, bhvShadowMarioBoss).oAction ~= 0 then
            o.oPosY = -2128
        else
            o.oPosY = o.oHomeY
        end
    elseif not obj_get_nearest_object_with_behavior_id(o, bhvShadowMarioBoss) then
        obj_mark_for_deletion(o)
    end
end

bhvBitfsGeneralUseGate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bitfs_general_use_gate_init,
    bitfs_general_use_gate_loop)


---@param o Object
function bhv_sunken_thwomp(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("sunken_thwomp_collision")
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1600
end

bhvSunkenThwomp = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_sunken_thwomp,
    function(o) load_object_collision_model(); end)

---@param o Object
function bhv_quicksand_shadow_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.collisionData = smlua_collision_util_get("quicksand_shadow_collision")
    o.header.gfx.skipInViewCheck = true
    network_init_object(o, true, { "oMoveAngleYaw", "oPosX", "oPosZ", "oForwardVel" })
end

---@param o Object
function bhv_quicksand_shadow_loop(o)
    load_object_collision_model();
    if o.oBehParams2ndByte == 0 then
        o.oForwardVel = math_sin(o.oTimer * 0.07) * 28
    end

    if o.oBehParams2ndByte == 2 then
        o.oForwardVel = math_sin(o.oTimer * 0.07) * 25
    end

    if o.oBehParams2ndByte == 1 then
        o.oForwardVel = 9
        o.oMoveAngleYaw = o.oMoveAngleYaw + 0x84
    end
end

bhvQuicksandShadow = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_quicksand_shadow_init,
    bhv_quicksand_shadow_loop)

function bhv_pianta_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE| OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    o.oInteractType = INTERACT_IGLOO_BARRIER
    o.hitboxRadius = 130
    o.hitboxHeight = 150
    o.oIntangibleTimer = 0
    smlua_anim_util_set_animation(o, "anim_pianta_idle")
end

function bhv_pianta_loop(o) -- maybe not done
    ---o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, o.oAngleToMario, 0x170)
end

bhvPianta = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_pianta_init, bhv_pianta_loop)

---@param o Object
local function bhv_red_and_white_target_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxRadius = 270
    o.hitboxHeight = 1000
    o.oIntangibleTimer = 0
    o.oCollisionDistance = 2000
    o.oInteractType = INTERACT_BREAKABLE
    o.collisionData = smlua_collision_util_get("red_and_white_target_collision")
    network_init_object(o, true, { "oInteractStatus" })
end

---@param o Object
local function bhv_red_and_white_target_loop(o)
    load_object_collision_model()

    if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
        spawn_triangle_break_particles(20, 138, 3.0, 4);
        obj_mark_for_deletion(o)
    end
end

bhvRedAndWhiteTarget = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_red_and_white_target_init,
    bhv_red_and_white_target_loop)


---@param o Object
function bhv_rw_spawn_star(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
function bhv_rw_spawn_star_loop(o)
    if obj_count_objects_with_behavior_id(bhvRedAndWhiteTarget) == 0 then
        obj_mark_for_deletion(o)
        spawn_red_coin_cutscene_star(o.oPosX, o.oPosY + 230, o.oPosZ)
    end
end

bhvRedAndWhiteTargetSpawnStar = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rw_spawn_star,
    bhv_rw_spawn_star_loop)

---@param o Object
function bhv_swinging_ship_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 4000
    o.collisionData = smlua_collision_util_get("swinging_ship_collision")
end

---@param o Object
function bhv_swinging_ship_loop(o)
    load_object_collision_model()
    o.oFaceAnglePitch = math_sin(o.oTimer * 0.02) * 4300
end

bhvSwingingShip = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_swinging_ship_init,
    bhv_swinging_ship_loop)


---@param o Object
function bhv_up_and_down_ride_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1300
    o.collisionData = smlua_collision_util_get("up_and_down_ride_collision")
    cur_obj_set_home_once()
    network_init_object(o, true, { "oVelY", "oPosY", "oAnimState", "oHauntedChairUnkFC" })
end

---@param o Object
function bhv_up_and_down_ride_loop(o)
    load_object_collision_model()

    --djui_chat_message_create(tostring(o.oAction))

    if o.oAction == 0 then
        if cur_obj_is_any_player_on_platform() == 1 then
            o.oAnimState = o.oAnimState + 1
            if o.oAnimState > 10 then
                o.oAction = 1
                o.oAnimState = 0
            end
        end
    elseif o.oAction == 1 then
        -- pos is f32 (float) but idc lmao
        o.oPosY = approach_s16_symmetric(o.oPosY, 7450, 40)

        if o.oPosY == 7450 then
            o.oHauntedChairUnkFC = o.oHauntedChairUnkFC + 1
            if o.oHauntedChairUnkFC > 70 then
                o.oAction = 2
            end
        end
    elseif o.oAction == 2 then
        o.oPosY = approach_s16_symmetric(o.oPosY, o.oHomeY, 65)
        if o.oPosY == o.oHomeY then
            o.oAction = 0
            o.oHauntedChairUnkFC = 0
            o.oAnimState = 0
        end
    end
end

bhvUpAndDownRide = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_up_and_down_ride_init,
    bhv_up_and_down_ride_loop)

---@param o Object
function bhv_luna_park_ent_part1(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
end

MODEL_LP_ENT1 = smlua_model_util_get_id("luna_park_entrance_part1_geo")

---@param o Object
function bhv_luna_park_ent_part1_loop(o)
    obj_set_model_extended(o, MODEL_LP_ENT1)
end

bhvLPEntP1 = hook_behavior(nil, OBJ_LIST_DEFAULT, true, bhv_luna_park_ent_part1,
    bhv_luna_park_ent_part1_loop)

---blooping

---@param o Object
function bhv_blooper_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW|OBJ_FLAG_MOVE_XZ_USING_FVEL
    smlua_anim_util_set_animation(o, "anim_blooper")
    o.oForwardVel = 10
    o.oDamageOrCoinValue = 1
    o.oInteractType = INTERACT_BOUNCE_TOP
    o.oIntangibleTimer = 0
    o.oNumLootCoins = -1
    o.hitboxDownOffset = 30
    cur_obj_set_home_once();
    obj_scale(o, 1.75)
    o.hitboxRadius = 60
    o.hitboxHeight = 60
    network_init_object(o, true, { "oMoveAngleYaw", "oPosX", "oPosY", "oPosZ", "oHealth", "oInteractStatus" })
end

---@param o Object
function bhv_blooper_loop(o)
    local nearP = nearest_player_to_object(o)
    local nearMS = nearest_mario_state_to_object(o)

    if dist_between_objects(nearP, o) < 900 then
        o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, obj_angle_to_object(o, nearP), 0x90 * 4)
        o.oPosY = approach_s16_symmetric(o.oPosY, nearMS.pos.y + 65, 3)
    else
        o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, cur_obj_angle_to_home(), 0x90 * 4)
        o.oPosY = approach_s16_symmetric(o.oPosY, o.oHomeY, 3)
    end

    if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
        o.oHealth = 0
        spawn_mist_particles()
        obj_die_if_health_non_positive()
    elseif o.oInteractStatus & INT_STATUS_ATTACKED_MARIO ~= 0 then
        o.oInteractStatus = 0
    end
end

bhvBlooper = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_blooper_init,
    bhv_blooper_loop)

---@param o Object
function bhv_mouth_water_thing_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxHeight = 1000
    o.hitboxDownOffset = 1000
    o.hitboxRadius = 120
    o.oIntangibleTimer = 0

    o.header.gfx.skipInViewCheck = true

    o.oHeldState = get_water_level(0)
    o.oHealth = get_water_level(1)
    o.oVelY = get_water_level(2)

    o.oBobombBuddyPosXCopy = 0
    o.oBobombBuddyPosYCopy = 0
    o.oBobombBuddyPosZCopy = 0

    network_init_object(o, true,
        { "oAction", "oAnimState", "oBobombBuddyPosXCopy", "oBobombBuddyPosYCopy", "oBobombBuddyPosYCopy" })
end

---@param o Object
function bhv_mouth_water_thing_loop(o)
    if o.oAction == 0 then
        if obj_check_hitbox_overlap(o, nearest_player_to_object(o)) then
            cur_obj_shake_screen(SHAKE_POS_LARGE)
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        o.oBobombBuddyPosXCopy = approach_f32_symmetric(o.oBobombBuddyPosXCopy, 1500, 40)
        o.oBobombBuddyPosYCopy = approach_f32_symmetric(o.oBobombBuddyPosYCopy, 1130, 40)
        o.oBobombBuddyPosZCopy = approach_f32_symmetric(o.oBobombBuddyPosZCopy, 1500, 40)
        set_water_level(0, o.oBobombBuddyPosXCopy, true)
        set_water_level(1, o.oBobombBuddyPosYCopy, true)
        set_water_level(2, o.oBobombBuddyPosZCopy, true)
        o.oAnimState = o.oAnimState + 1
        if o.oAnimState > 200 then
            o.oAction = 0
            o.oAnimState = 0
            o.oBobombBuddyPosXCopy = 0
            o.oBobombBuddyPosYCopy = 0
            o.oBobombBuddyPosZCopy = 0
            set_water_level(0, o.oHeldState, true)
            set_water_level(1, o.oHeldState, true)
            set_water_level(2, o.oVelY, true)
        end
    end
end

bhvMouthWaterThing = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_mouth_water_thing_init,
    bhv_mouth_water_thing_loop)

MODEL_TOTWC_ENTRY_LIGHT = smlua_model_util_get_id("totwc_entry_light_geo")

--[[
const BehaviorScript bhvWarp[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvWarp),
    OR_INT(oFlags, (OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    SET_INT(oInteractType, INTERACT_WARP),
    SET_INT(oIntangibleTimer, 0),
    BEGIN_LOOP(),
        CALL_NATIVE(bhv_warp_loop),
    END_LOOP(),
};
]]

---@param o Object
function bhv_totwc_entry_light(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_WARP
    o.hitboxHeight = 10000
    o.hitboxRadius = 200

    o.hitboxDownOffset = 300
end

bhvTOTWCEntryLight = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_totwc_entry_light,
    function(o)
        bhv_warp_loop();
        if get_curr_star_count() < 12 then
            obj_mark_for_deletion(o)
        end
    end)


function bhv_bbh_spinning_meteor_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bbh_spinning_meteor_collision")
    o.oAnimState = math.random(1, 3)
end

function bhv_bbh_spinning_meteor_loop(o)
    load_object_collision_model()

    if o.oAnimState == 1 then
        o.oFaceAnglePitch = o.oFaceAnglePitch + 400
    elseif o.oAnimState == 2 then
        o.oFaceAngleYaw = o.oFaceAngleYaw + 500
    elseif o.oAnimState == 3 then
        o.oFaceAngleRoll = o.oFaceAngleRoll + 600
    end
end

bhvBBHSpinningMeteor = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bbh_spinning_meteor_init,
    bhv_bbh_spinning_meteor_loop)

function bhv_meteor_cage_blocker(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("meteor_cage_blocker_collision")
    o.oCollisionDistance = 3500
end

bhvMeteorCageBlocker = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_meteor_cage_blocker,
    function(o)
        load_object_collision_model()
    end)


function bhv_fi_breather_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    bhv_animstate_by_param2(o)
end

function bhv_fi_breather_loop(o) -- not done

end

bhvFIBreather = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_fi_breather_init, bhv_fi_breather_loop)

MODEL_PSS_CLOUDY_PLATFORM = smlua_model_util_get_id("pss_cloudy_platform_geo")

---@param o Object
function bhv_pss_cloudy_platform(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("pss_cloudy_platform_collision")
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
end

bhvPSSCloudyPlatform = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_pss_cloudy_platform, bhv_sl_cloudy_platform_loop)

function bhv_tnt_and_boulder_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("tnt_and_boulder_collision")
    o.oCollisionDistance = 1200
    o.hitboxRadius = 300
    o.hitboxHeight = 400
    o.oIntangibleTimer = 0
    network_init_object(o, true, { "oAction", "oAnimState" })
end

function bhv_tnt_and_boulder_loop(o)
    load_object_collision_model()
    local nfire = obj_get_nearest_object_with_behavior_id(o, bhvFireFlowerFire)
    if o.oAction == 0 then
        if nfire then
            if obj_check_hitbox_overlap(o, nfire) then
                obj_mark_for_deletion(nfire)
                o.oAction = 1
            end
        end
    elseif o.oAction == 1 then
        o.oAnimState = o.oAnimState + 1
        if o.oAnimState > 20 then
            spawn_triangle_break_particles(20, 138, 3.0, 4);
            play_sound(SOUND_GENERAL_BREAK_BOX, gGlobalSoundSource)
            obj_mark_for_deletion(o)
        end
    end
end

bhvTNTAndBoulder = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_tnt_and_boulder_init, bhv_tnt_and_boulder_loop)

function bhv_fire_opens_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    o.hitboxHeight = 140
    o.hitboxRadius = 120

    o.oIntangibleTimer = 0

    network_init_object(o, true, { "oAction" })
end

function bhv_fire_opens_gate_loop(o)
    o.oInteractStatus = 0

    local nreastfirel = obj_get_nearest_object_with_behavior_id(o, bhvFireFlowerFire)

    if o.oAction == 0 then
        obj_set_model_extended(o, 0)
        if nreastfirel then
            if obj_check_hitbox_overlap(o, nreastfirel) then
                obj_mark_for_deletion(nreastfirel)
                o.oAction = 1
            end
        end
    elseif o.oAction == 1 then
        o.oAnimState = o.oAnimState + 2

        o.oInteractType = INTERACT_FLAME

        obj_set_billboard(o)

        obj_scale(o, 6.3)

        obj_set_model_extended(o, E_MODEL_RED_FLAME)

        if obj_has_behavior_id(o, bhvInvFireOpensGate4) == 1 then
            o.oGraphYOffset = 64
        end
    end
end

bhvInvFireOpensGate1 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_opens_gate_init, bhv_fire_opens_gate_loop)
bhvInvFireOpensGate2 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_opens_gate_init, bhv_fire_opens_gate_loop)
bhvInvFireOpensGate3 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_opens_gate_init, bhv_fire_opens_gate_loop)
bhvInvFireOpensGate4 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_opens_gate_init, bhv_fire_opens_gate_loop)

bhvInvFireOpensGate5 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_opens_gate_init, bhv_fire_opens_gate_loop)
bhvInvFireOpensGate6 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_opens_gate_init, bhv_fire_opens_gate_loop)
bhvInvFireOpensGate7 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_opens_gate_init, bhv_fire_opens_gate_loop)

MODEL_FIRE_OPEN_GATE = smlua_model_util_get_id("fire_openable_gate_geo")

function bhv_fire_openable_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("fire_openable_gate_collision")
    o.oCollisionDistance = 1000
    network_init_object(o, true, { "oAction", "oPosY" })
end

function bhv_fire_openable_gate_loop(o)
    load_object_collision_model()

    if o.oAction == 0 then
        if obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate1) and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate2) then
            if obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate1).oAction == 1 and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate2).oAction == 1 then
                o.oAction = 1
                play_puzzle_jingle()
            end
        end
    elseif o.oAction == 1 then
        o.oPosY = o.oPosY - 5
        if o.oPosY < -3300 then
            obj_mark_for_deletion(o)
        end
    end
end

bhvFireOpenableGate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_fire_openable_gate_init, bhv_fire_openable_gate_loop)

MODEL_PSS_HIDEN_GEOMETRY = smlua_model_util_get_id("pss_secret_hidden_geometry_geo")

function bhv_pss_hidden_geometry_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("pss_secret_hidden_geometry_collision")
    o.oCollisionDistance = 5500
    cur_obj_set_home_once()
    network_init_object(o, true, { "oAction", "oPosY" })
end

function bhv_pss_hidden_geometry_loop(o)
    load_object_collision_model()

    if o.oAction == 0 then
        if obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate3) and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate4) then
            if obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate3).oAction == 1 and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate4).oAction == 1 then
                o.oAction = 1
                play_puzzle_jingle()
            end
        end
    elseif o.oAction == 1 then
        o.oPosY = approach_f32_symmetric(o.oPosY, o.oHomeY + 1400, 5.7)
    end
end

bhvPSSHiddenGeometry = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_pss_hidden_geometry_init,
    bhv_pss_hidden_geometry_loop)

function bhv_cloud2_aircruise_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("cloud2_aircruise_collision")
    o.oCollisionDistance = 3000
    smlua_anim_util_set_animation(o, "anim_cloud2_aircruise")
end

function bhv_cloud2_aircruise_loop(o)
    load_object_collision_model()
end

bhvCloud2AirCruise = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cloud2_aircruise_init, bhv_cloud2_aircruise_loop)

function bhv_cloud3_aircruise_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("cloud3_aircruise_collision")
    o.oCollisionDistance = 6500
end

function bhv_cloud3_aircruise_loop(o)
    load_object_collision_model()
end

bhvCloud3AirCruise = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cloud3_aircruise_init, bhv_cloud3_aircruise_loop)

function bhv_stone_arch(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("stone_arch_collision")
    o.oCollisionDistance = 3000
end

bhvStoneArch = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_stone_arch,
    function(o) load_object_collision_model() end)


function bhv_nep_enut_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oAnimState = o.oBehParams >> 24
end

function bhv_nep_enut_loop(o)
    smlua_anim_util_set_animation(o, "anim_nepenut")
end

bhvNepEnut = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_nep_enut_init,
    bhv_nep_enut_loop)


function bhv_bitfs_platform_moving_up_and_down_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bitfs_platform_moving_up_and_down_collision")
    o.oCollisionDistance = 900
end

---only moves for local player
function bhv_bitfs_platform_moving_up_and_down_loop(o)
    load_object_collision_model()

    o.oPosY = o.oPosY + math_sin(o.oTimer * 0.042) * 19
end

bhvBITFSPlatformMovingUpAndDown = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bitfs_platform_moving_up_and_down_init,
    bhv_bitfs_platform_moving_up_and_down_loop)


function bhv_breakable_sa_entry(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("breakable_sa_entry_collision")
    o.oCollisionDistance = 900
    network_init_object(o, true, nil)
end

function bhv_breakable_sa_entry_loop(o)
    load_object_collision_model()

    if is_any_mario_groundpounding_obj(o) then
        spawn_triangle_break_particles(20, 138, 3.0, 4);
        obj_mark_for_deletion(o)
    end
end

bhvBreakableSAEntry = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_breakable_sa_entry,
    bhv_breakable_sa_entry_loop)


function bhv_sa_static_flower(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("sa_static_flower_collision")
    o.oCollisionDistance = 1700
end

bhvStaticSAFlower = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_sa_static_flower,
    function(o) load_object_collision_model() end)

function bhv_sa_static_plant(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("sa_static_plant_collision")
    o.oCollisionDistance = 1800
end

bhvSAStaticPlant = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_sa_static_plant,
    function(o) load_object_collision_model() end)

--lll_haunted_static_tree
function bhv_lll_static_haunted_tree(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("lll_haunted_static_tree_collision")
    o.oCollisionDistance = 1000
end

bhvLLLHauntedStaticTree = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_lll_static_haunted_tree,
    function(o) load_object_collision_model() end)


function bhv_bitdw_gate_to_star(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bitdw_gate_to_star_collision")
    network_init_object(o, true, nil)
end

function bhv_bitdw_gate_to_star_loop(o)
    load_object_collision_model()

    if (cur_obj_nearest_object_with_behavior(get_behavior_from_id(id_bhvExplosion))) then
        if dist_between_objects((cur_obj_nearest_object_with_behavior(get_behavior_from_id(id_bhvExplosion))), o) < 420 then
            obj_mark_for_deletion(o)
            --network_send_object(o, true)
        end
    end
end

bhvBITDWGateToStar = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bitdw_gate_to_star,
    bhv_bitdw_gate_to_star_loop)

function bhv_wdw_cage_opener_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("wdw_cage_opener_collision")
    network_init_object(o, true, { "oAction" })
end

function bhv_wdw_cage_opener_loop(o)
    if o.oAction == 0 then
        load_object_collision_model()
        if is_any_mario_groundpounding_obj(o) then
            spawn_triangle_break_particles(20, 138, 3.0, 4);
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        cur_obj_hide()
    end
end

bhvWDWMouthCageOpener = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_wdw_cage_opener_init,
    bhv_wdw_cage_opener_loop)

function bhv_wdw_mouth_cage_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("wdw_mouth_cage_collision")
    network_init_object(o, true, nil)
end

function bhv_wdw_mouth_cage_loop(o)
    load_object_collision_model()

    if obj_get_nearest_object_with_behavior_id(o, bhvWDWMouthCageOpener) and obj_get_nearest_object_with_behavior_id(o, bhvWDWMouthCageOpener).oAction == 1 then
        obj_mark_for_deletion(o)
        play_puzzle_jingle()
    end
end

bhvWDWMouthCage = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_wdw_mouth_cage_init,
    bhv_wdw_mouth_cage_loop)


function bhv_air_rocks(o)
    local a
    if (o.oTimer > 30 * 4.2) then
        a = spawn_non_sync_object(
            id_bhvWaterAirBubble, E_MODEL_BUBBLE, o.oPosX, o.oPosY + 400, o.oPosZ, nil);
        a.oBehParams = o.oBehParams;
        o.oTimer = 0;
    end
end

function bhv_vcutm_fish(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    smlua_anim_util_set_animation(o, "anim_vcutm_fish")
end

function bhv_vcutm_fish_loop(o)

end

bhvVCUTMFish = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_vcutm_fish,
    bhv_vcutm_fish_loop)


---@param o Object
function bhv_bits_entry_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("bits_entry_gate_collision")
    o.header.gfx.skipInViewCheck = true
end

---@param o Object
function bhv_bits_entry_gate_loop(o)
    load_object_collision_model()
    if get_curr_star_count() >= 80 then
        obj_mark_for_deletion(o)
    end
end

bhvBITSEntryGate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bits_entry_gate_init, bhv_bits_entry_gate_loop)

function lighthouse_mech_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 9000
    o.collisionData = smlua_collision_util_get("lighthouse_mech_collision")
    --o.oFaceAnglePitch = o.oFaceAnglePitch- 16384
    obj_scale(o, 10)
    o.oAngleVelYaw = 230
end

function lighthouse_mech_loop(o)
    load_object_collision_model()
    o.oFaceAngleYaw = o.oFaceAngleYaw + 230
end

bhvLightHouseMech = hook_behavior(nil, OBJ_LIST_SURFACE, true, lighthouse_mech_init, lighthouse_mech_loop)


function bhv_thi_circuit(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 900
    o.collisionData = smlua_collision_util_get("thi_circuit_collision")
end

bhvTHICircuit = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_thi_circuit,
    function(o) load_object_collision_model() end)

function bhv_thigray_static_block(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1200
    o.collisionData = smlua_collision_util_get("thi_static_gray_block_collision")
end

bhvTHIStaticGrayBlock = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_thigray_static_block,
    function(o) load_object_collision_model() end)

function bits_ship_wings(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    smlua_anim_util_set_animation(o, "anim_bits_ship_wings")
end

bhvTHIStaticGrayBlock = hook_behavior(nil, OBJ_LIST_LEVEL, true, bits_ship_wings, nil)

function bhv_bits_secret_platforms_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bits_secret_platforms_collision")
    o.oCollisionDistance = 1000
    cur_obj_set_home_once()
    network_init_object(o, true, { "oAction", "oPosY", "oPosX", "oPosZ" })
end

function bhv_bits_secret_platforms_loop(o)
    load_object_collision_model()

    if o.oBehParams2ndByte ~= 8 then
        if o.oAction == 0 then
            if obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate5) and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate6) and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate7) then
                if obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate5).oAction == 1 and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate6).oAction == 1 and obj_get_nearest_object_with_behavior_id(o, bhvInvFireOpensGate7).oAction == 1 then
                    o.oAction = 1
                    play_puzzle_jingle()
                end
            end
        elseif o.oAction == 1 then
            o.oPosX = approach_f32_symmetric(o.oPosX, o.oHomeX + 320, 5.7)
            o.oPosZ = approach_f32_symmetric(o.oPosZ, o.oHomeZ + 510, 5.7)
        end
    end
end

bhvBITSSecretPlatforms = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_bits_secret_platforms_init,
    bhv_bits_secret_platforms_loop)

---@param o Object
function bhv_rashay_button_spawn_star(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
function bhv_rashay_button_spawn_star_loop(o)
    local near1 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton)
    local near2 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton2)
    local near3 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton3)
    local near4 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton4)

    local nearmariostatetg = nearest_mario_state_to_object(o)

    if near1 and near2 and near3 and near4 then
        if near1.oAction == 1 and near2.oAction == 1 and near3.oAction == 1 and near4.oAction == 1 then
            obj_mark_for_deletion(o)
            spawn_default_star(nearmariostatetg.pos.x, nearmariostatetg.pos.y + 200, nearmariostatetg.pos.z)
        end
    end
end

bhvRashayButtonStarSpawn = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_rashay_button_spawn_star,
    bhv_rashay_button_spawn_star_loop)

---@param o Object
function bhv_rashay_unlocker_button_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("rashay_unlocker_button_collision")
    network_init_object(o, true, { "oSubAction", "oAction", "oAnimState" })
end

---@param o Object
function bhv_rashay_unlocker_button_loop(o)
    load_object_collision_model()
    local currMs = nearest_mario_state_to_object(o)
    if currMs.marioObj.platform == o then
        o.oAction = 1
    end

    if o.oAction == 1 then
        o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, -0.1, 0.05)
        o.oAnimState = o.oAnimState + 1

        if o.oAnimState > 60 then
            obj_scale(o, 0)
        end
    end
end

bhvRashayUnlockerButton = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rashay_unlocker_button_init,
    bhv_rashay_unlocker_button_loop)
bhvRashayUnlockerButton2 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rashay_unlocker_button_init,
    bhv_rashay_unlocker_button_loop)
bhvRashayUnlockerButton3 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rashay_unlocker_button_init,
    bhv_rashay_unlocker_button_loop)
bhvRashayUnlockerButton4 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rashay_unlocker_button_init,
    bhv_rashay_unlocker_button_loop)


function bhv_rashay_elevator_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1200
    o.collisionData = smlua_collision_util_get("rashay_elevator_collision")
    network_init_object(o, true, nil)
end

function bhv_rashay_elevator_loop(o)
    load_object_collision_model()

    local near1 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton)
    local near2 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton2)
    local near3 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton3)
    local near4 = obj_get_nearest_object_with_behavior_id(o, bhvRashayUnlockerButton4)

    if near1 and near2 and near3 and near4 then
        if near1.oAction == 1 and near2.oAction == 1 and near3.oAction == 1 and near4.oAction == 1 then
            o.oInteractType = INTERACT_WARP
            o.hitboxRadius = 470
            o.hitboxHeight = 470
            o.oIntangibleTimer = 0
            o.oBehParams = 11 << 16
            o.oBehParams2ndByte = 11
        end
    end
end

bhvRashayElevator = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rashay_elevator_init,
    bhv_rashay_elevator_loop)


function bhv_green_floating_bubble(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 800
    o.collisionData = smlua_collision_util_get("green_floating_bubble_collision")
    cur_obj_scale(0.5)
    cur_obj_set_home_once()
    if math.random(1, 10) > 3 then
        o.oAction = 1
    end
end

bhvGreenFloatingBubble = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_green_floating_bubble,
    function(o)
        load_object_collision_model()
        if o.oPosY > 11755 then
            o.oPosY = o.oHomeY
            o.oSubAction = 0
        end
        if o.oAction == 0 then
            o.oPosY = o.oPosY + 5.2
        elseif o.oAction == 1 then
            o.oSubAction = o.oSubAction + 1
            if o.oSubAction > 15 * 30 then
                o.oPosY = o.oPosY + 5.2
            end
        end

        if o.oPosY > 6896 then
            cur_obj_unhide()
        else
            cur_obj_hide()
        end

        --o.header.gfx.scale.y = math_sin(o.oTimer * 0.002) + 0.2
        --o.header.gfx.scale.z = math_sin(o.oTimer * 0.002)+ 0.2
    end)

function bhv_rashay_block(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("rashay_block_collision")
    o.oCollisionDistance = 700
    o.oForwardVel = 10
end

bhvRashayBlock = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rashay_block,
    function(o)
        load_object_collision_model()
        o.oPosY = o.oPosY - 4
        o.oFaceAngleYaw = o.oFaceAngleYaw + 0x400
        o.oMoveAngleYaw = -20144
        o.oMoveAnglePitch = 0
        o.oMoveAngleRoll = 0
        o.oFaceAnglePitch = 0
        o.oFaceAngleRoll = 0

        if o.oPosY < 160 then
            spawn_triangle_break_particles(20, 138, 3.0, 4);
            obj_mark_for_deletion(o)
        end
    end)


---@param o Object
function bhv_rashay_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.header.gfx.skipInViewCheck = true

    o.oInteractType = INTERACT_DAMAGE
    obj_set_hitbox_radius_and_height(o, 460, 600)
    o.hitboxDownOffset = 200
    o.oIntangibleTimer = 0
    o.oHealth = 0
    --o.oDamageOrCoinValue = 2

    smlua_anim_util_set_animation(o, "anim_rashay_idle")
    network_init_object(o, true,
        { "oPosX", "oPosY", "oPosZ", "oMoveAngleYaw", "oAction", "oBobombBuddyPosXCopy", "oAnimState", "oSubAction" })
end

RASHAY_ACTION_IDLE_DIALOG = 0
RASHAY_ACTION_THROW_BLOCK_GOING = 1
RASHAY_ACTION_THROW_BLOCK = 2
RASHAY_ACTION_IDLE_DIALOG2 = 3 -- "Im going to hunt you"
RASHAY_ACTION_HUNTING = 4
RASHAY_ACTION_HIT_MARIO_AIR = 5
RASHAY_ACTION_DEAD = 6

MODEL_RASHAY_BLOCK = smlua_model_util_get_id("rashay_block_geo")

---@param o Object
function bhv_rashay_loop(o)
    --djui_chat_message_create("xpos " .. o.oPosX .. " ypos " .. o.oPosY .. " zpos " .. o.oPosZ)
    local marioState = nearest_mario_state_to_object(o)
    if o.oAction == RASHAY_ACTION_IDLE_DIALOG then
        if (marioState and should_start_or_continue_dialog(marioState, o) ~= 0 and cutscene_object_with_dialog(CUTSCENE_DIALOG, o, DIALOG_166) ~= 0) then
            o.oAction = RASHAY_ACTION_THROW_BLOCK_GOING
        end
    elseif o.oAction == RASHAY_ACTION_THROW_BLOCK_GOING then
        o.oPosX = approach_s16_symmetric(o.oPosX, 5150, 50)
        o.oPosY = approach_s16_symmetric(o.oPosY, 1700, 20)
        o.oPosZ = approach_s16_symmetric(o.oPosZ, 3090, 50)
        o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, -20144, 0x110)
        if o.oPosX == 5150 and o.oPosY == 1700 and o.oPosZ == 3090 then
            o.oAction = RASHAY_ACTION_THROW_BLOCK
        end
    elseif o.oAction == RASHAY_ACTION_THROW_BLOCK then
        smlua_anim_util_set_animation(o, "anim_rashay_throw_block")

        --handLeft after throw: 4775, 1591, 2725
        --handRight afte tthow: 4700, 1591, 3070

        if o.header.gfx.animInfo.animFrame == 27 then
            spawn_sync_object(bhvRashayBlock, MODEL_RASHAY_BLOCK, 4775, 1591, 2725, nil)
        elseif o.header.gfx.animInfo.animFrame == 56 then
            spawn_sync_object(bhvRashayBlock, MODEL_RASHAY_BLOCK, 4700, 1591, 3070, nil)
        end

        if o.oInteractStatus ~= 0 then
            o.oInteractStatus = 0
            marioState.vel.y = 65
            marioState.actionArg = 60
            marioState.action = ACT_BACKWARD_AIR_KB_MODIFIED
            o.oAnimState = 1
        end

        if o.oAnimState == 1 then
            o.oBobombBuddyPosXCopy = o.oBobombBuddyPosXCopy + 1
            if o.oBobombBuddyPosXCopy > 45 then
                o.oBobombBuddyPosXCopy = 0
                o.oAnimState = 0
                o.oAction = RASHAY_ACTION_IDLE_DIALOG2
            end
        end
    elseif o.oAction == RASHAY_ACTION_IDLE_DIALOG2 then
        if (marioState and should_start_or_continue_dialog(marioState, o) ~= 0 and cutscene_object_with_dialog(CUTSCENE_DIALOG, o, DIALOG_167) ~= 0) then
            o.oAction = RASHAY_ACTION_HUNTING
        end
    elseif o.oAction == RASHAY_ACTION_HUNTING then
        smlua_anim_util_set_animation(o, "anim_rashay_hurt_mario")
        o.oFriction = 1
        o.oForwardVel = 25
        object_step()
        o.oPosY = find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 250
        o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, obj_angle_to_object(o, marioState.marioObj), 0x260)
        o.oInteractStatus = 0
        o.oDamageOrCoinValue = 2
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 230 then
            o.oAction = RASHAY_ACTION_HIT_MARIO_AIR
            o.oSubAction = 0
        end
    elseif o.oAction == RASHAY_ACTION_HIT_MARIO_AIR then
        o.oPosX          = 270
        o.oPosY          = 67 + 180
        o.oPosZ          = -1970
        marioState.pos.x = o.oPosX
        marioState.pos.y = o.oPosY
        marioState.pos.z = o.oPosZ
        if o.header.gfx.animInfo.animFrame == 27 then
            --obj_mark_for_deletion(o)
            marioState.faceAngle.y = 784
            marioState.vel.y = 60 * 2
            marioState.actionArg = 70
            marioState.action = ACT_BACKWARD_AIR_KB_MODIFIED
            o.oAction = RASHAY_ACTION_DEAD
        end
    elseif o.oAction == RASHAY_ACTION_DEAD then

    end
end

bhvRashay = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_rashay_init,
    bhv_rashay_loop)

function bhv_rashay_locked_gate(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("rashay_locked_gate_collision")
    o.oCollisionDistance = 1000
    network_init_object(o, true, { "activeFlags" })
end

---only moves for local player
function bhv_rashay_locked_gate_loop(o)
    load_object_collision_model()

    --[[    if o.oBehParams2ndByte == 8 then
        if obj_get_nearest_object_with_behavior_id(o, bhvRashay) then
            if obj_get_nearest_object_with_behavior_id(o, bhvRashay).oAction == RASHAY_ACTION_DEAD then
                if nearest_mario_state_to_object(o).wall then
                    if nearest_mario_state_to_object(o).wall.object == o then
                        obj_mark_for_deletion(o)
                        spawn_triangle_break_particles(20, 138, 3.0, 4);
                        obj_mark_for_deletion(obj_get_nearest_object_with_behavior_id(o, bhvRashay))
                    end
                end
            end
        end
    end]]

    if o.oBehParams2ndByte == 40 then
        if obj_get_nearest_object_with_behavior_id(o, bhvRashay) then
            if obj_get_nearest_object_with_behavior_id(o, bhvRashay).oAction == RASHAY_ACTION_DEAD then
                if nearest_mario_state_to_object(o).wall then
                    if nearest_mario_state_to_object(o).wall.object == o then
                        obj_mark_for_deletion(o)
                        spawn_triangle_break_particles(20, 138, 3.0, 4);
                        obj_mark_for_deletion(obj_get_nearest_object_with_behavior_id(o, bhvRashay))
                    end
                end
            end
        end
    end
end

bhvRashayLockedGate = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rashay_locked_gate,
    bhv_rashay_locked_gate_loop)


function bhv_talking_peach2(o)
    o.oFlags = (OBJ_FLAG_PERSISTENT_RESPAWN | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oInteractType = INTERACT_TEXT
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oAnimations = gObjectAnimations.peach_seg5_anims_0501C41C
    cur_obj_init_animation(6)
    o.hitboxRadius = 110
    o.hitboxHeight = 70
    o.oIntangibleTimer = 0
    o.oOpacity = 255
    --bhv_toad_message_init()
end

bhvTalkingPeach2 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_talking_peach2,
    function(o)
        if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
            gMarioStates[0].action = ACT_READING_NPC_DIALOG
            if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, 146) ~= 0 then
                o.oInteractStatus = 0
                warp_special(SPECIAL_WARP_CAKE)
                set_background_music(0, 0, 0)
            end
        end
    end)


---@param o Object
function bhv_brown_hand_enemy_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW

    o.oFriction = 1

    o.hitboxHeight = 200
    o.hitboxDownOffset = 50
    o.hitboxRadius = 110
    o.oIntangibleTimer = 0
    o.oInteractType = INTERACT_BOUNCE_TOP
    o.oDamageOrCoinValue = 2
    o.oNumLootCoins = -1
    smlua_anim_util_set_animation(o, "anim_brown_hand_enemy_idle")
    cur_obj_set_home_once()
    network_init_object(o, true, { "oAction", "oInteractStatus", "oForwardVel", "oFriction", "oMoveAngleYaw" })
end

---@param o Object
function bhv_brown_hand_enemy_loop(o)
    object_step()

    local mnearest = nearest_mario_state_to_object(o)

    if o.oAction == 0 then
        o.oForwardVel = 15
        o.oFriction = 1
        smlua_anim_util_set_animation(o, "anim_brown_hand_enemy_idle")
        if dist_between_objects(o, mnearest.marioObj) < 1850 then
            o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, obj_angle_to_object(o, mnearest.marioObj), 0x255)
            o.oPosY = approach_s16_symmetric(o.oPosY, mnearest.pos.y + 65, 3)
        else
            o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, cur_obj_angle_to_home(), 0x255)
            o.oPosY = approach_s16_symmetric(o.oPosY, o.oHomeY, 3)
        end
    elseif o.oAction == 1 then
        o.oForwardVel = 0
        o.oFriction = 0
        smlua_anim_util_set_animation(o, "anim_brown_hand_enemy_attack")
        if o.header.gfx.animInfo.animFrame > 42 then
            o.oAction = 0
        end
    elseif o.oAction == 2 then
        o.oForwardVel = 0
        o.oFriction = 0
        smlua_anim_util_set_animation(o, "anim_brown_hand_enemy_dead")
        if o.header.gfx.animInfo.animFrame > 50 then
            obj_die_if_health_non_positive()
            spawn_mist_particles()
        end
    end

    if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
        o.oHealth = 0
        o.oAction = 2
    elseif o.oInteractStatus & INT_STATUS_ATTACKED_MARIO ~= 0 then
        o.oInteractStatus = 0
        o.oAction         = 1
    end
end

bhvBrownHandEnemy = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_brown_hand_enemy_init, bhv_brown_hand_enemy_loop)

function really_big_pole(o)
    o.oInteractType = INTERACT_POLE
    o.hitboxHeight = o.oBehParams2ndByte * 64.0
    o.hitboxRadius = 60
    o.oIntangibleTimer = 0
end

bhvReallyBigPole = hook_behavior(nil, OBJ_LIST_POLELIKE, true, really_big_pole, function(o) bhv_pole_base_loop() end)

---star_hexagon
function bhv_starhexagon_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1200
    o.collisionData = smlua_collision_util_get("star_hexagon_collision")
    network_init_object(o, true, { "oAnimState", "oAction" })
end

function bhv_starhexagon_loop(o)
    load_object_collision_model()

    ---@type MarioState
    local marioS = gMarioStates[0]

    if --[[marioS.wall.object == o or marioS.floor.object == o]] cur_obj_is_any_player_on_platform() == 1 then
        o.oAnimState = 1
        o.oAction = 1
        --network_send_object(o, true)
    end
end

bhvStarHexagon = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_starhexagon_init,
    bhv_starhexagon_loop)
bhvStarHexagon2 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_starhexagon_init,
    bhv_starhexagon_loop)
bhvStarHexagon3 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_starhexagon_init,
    bhv_starhexagon_loop)
bhvStarHexagon4 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_starhexagon_init,
    bhv_starhexagon_loop)
bhvStarHexagon5 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_starhexagon_init,
    bhv_starhexagon_loop)

---@param o Object
function bhv_star_hexagon_spawn_star(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
function bhv_star_hexagon_spawn_star_loop(o)
    local near1 = obj_get_nearest_object_with_behavior_id(o, bhvStarHexagon)
    local near2 = obj_get_nearest_object_with_behavior_id(o, bhvStarHexagon2)
    local near3 = obj_get_nearest_object_with_behavior_id(o, bhvStarHexagon3)
    local near4 = obj_get_nearest_object_with_behavior_id(o, bhvStarHexagon4)
    local near5 = obj_get_nearest_object_with_behavior_id(o, bhvStarHexagon5)

    if near1 and near2 and near3 and near4 and near5 then
        if near1.oAction == 1 and near2.oAction == 1 and near3.oAction == 1 and near4.oAction == 1 and near5.oAction == 1 then
            obj_mark_for_deletion(o)
            spawn_red_coin_cutscene_star(o.oPosX, o.oPosY, o.oPosZ)
        end
    end
end

bhvStarHexagonStarSpawn = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_star_hexagon_spawn_star,
    bhv_star_hexagon_spawn_star_loop)


---@param o Object
function bhv_blue_nabbit_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_MOVE_XZ_USING_FVEL

    o.hitboxRadius = 90
    o.hitboxHeight = 100

    o.oInteractType = INTERACT_BOUNCE_TOP

    o.oIntangibleTimer = 0

    smlua_anim_util_set_animation(o, "anim_blue_nabbit_idle")

    network_init_object(o, true, { "oAction", "oInteractStatus" })
end

---@param o Object
function bhv_blue_nabbit_loop(o)
    if o.oAction == 0 then
        if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
            o.oAction = 1
        else
            o.oInteractStatus = 0
        end
    elseif o.oAction == 1 then
        --smlua_anim_util_set_animation(o, "anim_blue_nabbit_dead")

        -- if cur_obj_check_if_near_animation_end() == 1 then
        spawn_mist_particles()
        obj_mark_for_deletion(o)
        spawn_red_coin_cutscene_star(o.oPosX, o.oPosY + 230, o.oPosZ)
        --end
    end
end

hook_behavior(id_bhvWfSlidingPlatform, OBJ_LIST_GENACTOR, true, bhv_blue_nabbit_init, bhv_blue_nabbit_loop)

function custom_metal_box(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = gGlobalObjectCollisionData.breakable_box_seg8_collision_08012D70
    o.oCollisionDistance = 1000
end

bhvCustomMetalBox = hook_behavior(nil, OBJ_LIST_SURFACE, true, custom_metal_box,
    function(o) load_object_collision_model() end)

--wdw_seashell
---@param o Object
function bhv_wdw_seashell_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("wdw_seashell_collision")
    o.oCollisionDistance = 900
end

---only works for local player
---@param o Object
function bhv_wdw_seashell_loop(o)
    load_object_collision_model()
    if cur_obj_is_mario_on_platform() == 1 then
        o.oAction = o.oAction + 1
        if o.oAction > 35 then
            gMarioStates[0].vel.y = ((o.oBehParams >> 24) & 0XFF) *
                (o.oBehParams2ndByte == 1 and 1.8 or o.oBehParams2ndByte)
            gMarioStates[0].faceAngle.y = o.oFaceAngleYaw
            gMarioStates[0].actionArg = 15
            gMarioStates[0].action = ACT_BACKWARD_AIR_KB_MODIFIED
            o.oAction = 0
        end
    end
end

bhvWDWSeaShell = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_wdw_seashell_init,
    bhv_wdw_seashell_loop)

---@param o Object
function bobomb_gaurd_stopper(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    o.hitboxRadius = 110
    o.hitboxHeight = 4000
    o.oIntangibleTimer = 0
    o.hitboxDownOffset = 200

    o.oFaceAngleYaw = 225
end

bhvBobombGaurdStopper = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bobomb_gaurd_stopper,
    nil)


---@param o Object
function bobomb_buddy_gaurd_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW

    o.oAnimations = gObjectAnimations.bobomb_seg8_anims_0802396C
    cur_obj_init_animation(0)

    o.oFriction = 1
    o.oForwardVel = 10
    o.oGravity = -3
    obj_set_model_extended(o, E_MODEL_BOBOMB_BUDDY)

    network_init_object(o, true, { "oPosX", "oPosY", "oPosZ", "oMoveFlags", "oMoveAngleYaw" })
end

function bobomb_buddy_gaurd_loop(o)
    ---SET_OBJ_PHYSICS(/*Wall hitbox radius*/ 0, /*Gravity*/ -400, /*Bounciness*/ -70, /*Drag strength*/ 1000, /*Friction*/ 1000, /*Buoyancy*/ 200, /*Unused*/ 0, 0),

    cur_obj_move_standard(-78)
    cur_obj_update_floor_and_walls()
    cur_obj_if_hit_wall_bounce_away()

    if (o.oMoveFlags & OBJ_MOVE_HIT_EDGE) ~= 0 then
        o.oMoveAngleYaw = o.oMoveAngleYaw + 32768
    end

    if obj_get_nearest_object_with_behavior_id(o, bhvBobombGaurdStopper) and obj_get_nearest_object_with_behavior_id(o, bhvBobombGaurdStopper).oBehParams == o.oBehParams and obj_check_hitbox_overlap(obj_get_nearest_object_with_behavior_id(o, bhvBobombGaurdStopper), o) then
        o.oMoveAngleYaw = o.oMoveAngleYaw + 32768
    end

    if dist_between_objects(o, nearest_player_to_object(o)) < 600 then
        nearest_mario_state_to_object(o).forwardVel = 0
        o.oPosX = approach_f32_symmetric(o.oPosX, nearest_mario_state_to_object(o).pos.x, 50)
        o.oPosZ = approach_f32_symmetric(o.oPosZ, nearest_mario_state_to_object(o).pos.z, 50)
        local ggm = nearest_mario_state_to_object(o)
        if o.oPosX == ggm.pos.x and o.oPosZ == ggm.pos.z then
            ggm.action = ACT_BOBOMB_GAURD_DEATH
        end
    end
end

bhvBobombBuddyGaurd = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bobomb_buddy_gaurd_init,
    bobomb_buddy_gaurd_loop)

function bhv_lll_fan_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
end

function bhv_lll_fan_loop(o)
    o.oFaceAngleRoll = o.oFaceAngleRoll + 256
end

bhvLLLFan = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_lll_fan_init,
    bhv_lll_fan_loop)

---@param o Object
function bhv_pink_ballon_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 2000
    o.collisionData = smlua_collision_util_get("pink_ballon_collision")
    o.oHealth = 0
    cur_obj_set_home_once()
    obj_scale(o, 4)
end

---@param o Object
function bhv_pink_ballon_loop(o)
    load_object_collision_model()
    --djui_chat_message_create("" .. o.oAnimState)
    obj_scale(o, 4 + o.oAnimState)

    if o.oAnimState > 4 then
        o.oAnimState = 4
    end

    if o.oAnimState == 4 then
        o.oFaceAngleRoll = -14384
        if o.oAction == 0 then
            o.oPosY = o.oPosY + 230
            o.oAction = 1
        end

        if o.oHealth == 0 then
            if cur_obj_is_mario_on_platform() == 1 then
                o.oHealth = 1
            end
        end
    end
    if o.oHealth == 1 then
        if cur_obj_is_mario_on_platform() == 1 then
            o.oMoveAngleYaw = gMarioStates[0].faceAngle.y
        end


        o.oForwardVel = 7
        o.oFriction = 1
        obj_move_xyz_using_fvel_and_yaw(o)
        o.oPosY = approach_f32_symmetric(o.oPosY, 5933, 4)

        o.oBehParams2ndByte = o.oBehParams2ndByte + 1

        if o.oBehParams2ndByte > (35 * 30) or cur_obj_is_mario_ground_pounding_platform() == 1 then -- 35 seconds
            o.oBehParams2ndByte = 0
            o.oHealth = 0
            cur_obj_set_pos_to_home()
            o.oForwardVel = 0
            o.oFriction = 0
            o.oAnimState = 0
            o.oFaceAngleRoll = 0
            o.oAction = 0
        end
    end
end

bhvPinkBallon = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_pink_ballon_init,
    bhv_pink_ballon_loop)


---@param o Object
function bhv_custom_ballon_trampoline_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = gGlobalObjectCollisionData.springboard_collision_05001A28
    o.oCollisionDistance = 500
    o.oHiddenBlueCoinSwitch = spawn_non_sync_object(id_bhvStaticObject, E_MODEL_TRAMPOLINE_CENTER, -553, 2784 + 30,
        -11602,
        nil)
end

tramp_hardcodedposy = 2784

---@param o Object
function bhv_custom_ballon_trampoline_loop(o)
    load_object_collision_model()

    if o.oAction == 0 then
        o.oHiddenBlueCoinSwitch.oPosY = approach_f32_symmetric(o.oHiddenBlueCoinSwitch.oPosY, tramp_hardcodedposy + 30, 5)
        o.oPosY = approach_f32_symmetric(o.oPosY, tramp_hardcodedposy + 100, 5)
        if cur_obj_is_mario_ground_pounding_platform() == 1 then
            obj_get_nearest_object_with_behavior_id(o, bhvPinkBallon).oAnimState =
                obj_get_nearest_object_with_behavior_id(o, bhvPinkBallon).oAnimState + 1
            o.oAction = 1
        end
    elseif o.oAction == 1 then
        o.oPosY = approach_f32_symmetric(o.oPosY, tramp_hardcodedposy + 30, 5)
        o.oHiddenBlueCoinSwitch.oPosY = approach_f32_symmetric(o.oHiddenBlueCoinSwitch.oPosY, tramp_hardcodedposy - 40, 5)
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 20 then
            o.oAction = 0
            o.oSubAction = 0
        end
    end
end

bhvCustomBallonTrampoline = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_custom_ballon_trampoline_init,
    bhv_custom_ballon_trampoline_loop)

MODEL_PINK_BALLON = smlua_model_util_get_id("pink_ballon_geo")

---@param o Object
function bhv_airballon_jrb_stand(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("jrb_airballon_stand_collision")
    o.oCollisionDistance = 1560
    o.oHiddenBlueCoinSwitch = spawn_non_sync_object(bhvCustomBallonTrampoline, E_MODEL_TRAMPOLINE, -553, 2784 + 100,
        -11602,
        nil)
    o.oHiddenBlueCoinSwitch.oHiddenObjectUnkF4 = o
    o.oHiddenObjectUnkF4 = spawn_non_sync_object(bhvPinkBallon, MODEL_PINK_BALLON, -14, 2768,
        -11172,
        nil)
end

bhvJRBAirballonStand = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_airballon_jrb_stand,
    function(o) load_object_collision_model() end)


---@param o Object
function bhv_koopa_npc_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractionSubtype = INT_SUBTYPE_NPC
    o.oInteractType = INTERACT_TEXT
    o.hitboxHeight = 340
    o.hitboxRadius = 210
    o.oIntangibleTimer = 0
    o.oAnimations = gObjectAnimations.koopa_seg6_anims_06011364
    cur_obj_init_animation(7)
    obj_scale(o, 3)
    obj_set_model_extended(o, E_MODEL_KOOPA_WITH_SHELL)
end

---@param o Object
function bhv_koopa_npc_loop(o)
    if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        gMarioStates[0].action = ACT_READING_NPC_DIALOG
        if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, gNetworkPlayers[0].currActNum == 5 and DIALOG_007 or DIALOG_006) ~= 0 then
            o.oInteractStatus = 0
        end
    end
end

bhvKoopaNPC = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_koopa_npc_init, bhv_koopa_npc_loop)


---@param o Object
function bhv_cork_drain_water_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oHealth = 1
    o.hitboxRadius = 220
    o.hitboxHeight = 300
    o.hurtboxHeight = 300
    o.oIntangibleTimer = 0
    o.hurtboxRadius = 220
    o.oCollisionDistance = 2000
    o.collisionData = smlua_collision_util_get("cork_drain_water_collision")
    cur_obj_set_home_once()
    o.header.gfx.skipInViewCheck = true
    network_init_object(o, true, { "oMoveAngleYaw", "oPosX", "oPosY", "oPosZ" })
end

---@param o Object
function bhv_cork_drain_water_loop(o)
    local marioState = nearest_mario_state_to_object(o);
    local player = marioState.marioObj;
    o.oPosY = find_floor_height(o.oPosX, o.oPosY, o.oPosZ)

    local sp1C;
    o.oForwardVel = 0.0;

    if o.oBehParams == 0 then
        load_object_collision_model()
        if (player) then
            if (obj_check_if_collided_with_object(o, player) ~= 0 and marioState and marioState.flags & MARIO_UNKNOWN_31 ~= 0) then
                sp1C = obj_angle_to_object(o, player);
                if (abs_angle_diff(sp1C, player.oMoveAngleYaw) > 0x4000) then
                    o.oMoveAngleYaw = s16((player.oMoveAngleYaw));
                    if (check_if_moving_over_floor(8.0, 150.0)) then
                        o.oForwardVel = 5.0;
                        cur_obj_play_sound_1(SOUND_ENV_METAL_BOX_PUSH);
                    end
                end
            end
        end
        cur_obj_move_using_fvel_and_gravity();
    end

    if o.oBehParams == (4 << 24) then
        o.oFlags                               = o.oFlags & ~OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
        o.header.gfx.disableAutomaticShadowPos = true
        o.header.gfx.pos.x                     = 0
        o.header.gfx.pos.y                     = -1000
        o.header.gfx.pos.z                     = 0

        o.hitboxRadius                         = 110
        o.hitboxHeight                         = 40

        if obj_check_hitbox_overlap(o, obj_get_nearest_object_with_behavior_id(o, bhvCorkDrainWaterREAL)) then
            obj_mark_for_deletion(o)
            spawn_red_coin_cutscene_star(-3200, 1390, 6540)
        end
    end

    if o.oBehParams == 2 then
        load_object_collision_model()
    end
end

bhvCorkDrainWater = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cork_drain_water_init, bhv_cork_drain_water_loop)
bhvCorkDrainWaterREAL = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_cork_drain_water_init, bhv_cork_drain_water_loop)

---@param o Object
function bhv_musical_fruit_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxHeight = 80
    o.hitboxRadius = 60
    o.oIntangibleTimer = 0
    network_init_object(o, true, { "oAction" })
end

---@param o Object
function bhv_musical_fruit_loop(o)
    if o.oAction == 0 then
        if obj_check_hitbox_overlap(o, nearest_player_to_object(o)) then
            play_sound(SOUND_MENU_STAR_SOUND, gGlobalSoundSource)
            o.oAction = 1
        end
    end
end

bhvMusicalFruit = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_musical_fruit_init, bhv_musical_fruit_loop)
bhvMusicalFruit2 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_musical_fruit_init, bhv_musical_fruit_loop)
bhvMusicalFruit3 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_musical_fruit_init, bhv_musical_fruit_loop)

---@param o Object
function bhv_musical_fruit_star_spawn(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
function bhv_musical_fruit_star_spawn_loop(o)
    local near1 = obj_get_nearest_object_with_behavior_id(o, bhvMusicalFruit)
    local near2 = obj_get_nearest_object_with_behavior_id(o, bhvMusicalFruit2)
    local near3 = obj_get_nearest_object_with_behavior_id(o, bhvMusicalFruit3)

    local nearmariostatetg = nearest_mario_state_to_object(o)

    if near1 and near2 and near3 then
        if near1.oAction == 1 and near2.oAction == 1 and near3.oAction == 1 then
            obj_mark_for_deletion(o)
            spawn_red_coin_cutscene_star(445, 7488, -3152)
        end
    end
end

bhvMusicalFruitStarSpawn = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_musical_fruit_star_spawn,
    bhv_musical_fruit_star_spawn_loop)


---@param o Object
function bhv_weird_floating_orb_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
end

---@param o Object
function bhv_weird_floating_orb_loop(o)
    o.oFaceAnglePitch = o.oFaceAnglePitch + 100
    o.oFaceAngleRoll = o.oFaceAngleRoll + 313
    o.header.gfx.scale.x = absf_2(math_sin(o.oTimer / 100) * 2)
    o.header.gfx.scale.y = absf_2(math_sin(o.oTimer / 120) * 2)
    o.oPosY = o.oPosY + math_sin(o.oTimer / 130)
end

bhvWeirdFloatingOrb = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_weird_floating_orb_init,
    bhv_weird_floating_orb_loop)


---@param o Object
function bhv_virus_boss_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW

    o.oGravity = 2

    o.hitboxHeight = 120
    o.hitboxRadius = 100

    o.oInteractType = INTERACT_BOUNCE_TOP

    o.oIntangibleTimer = 0

    o.oBounciness = 0
    o.oBuoyancy = 0

    o.oHealth = 0

    o.oDamageOrCoinValue = 2

    cur_obj_set_home_once()

    smlua_anim_util_set_animation(o, "anim_virus_boss_idle")
end

VIRUS_IDLE = 0
VIRUS_JUMP_TO_MARIO = 1
VIRUS_WIND_BEND = 2
VIRUS_WALK = 3
VIRUS_NORMAL_JUMP = 4
VIRUS_THROW_FIRE = 5
VIRUS_SCALE_BIG = 6
VIRUS_RETURN_HOME = 7
VIRUS_ATTACKED = 8

---@param o Object
function bhv_virus_boss_loop(o)
    local nearplayer = nearest_player_to_object(o)

    if o.oAction == VIRUS_IDLE then
        smlua_anim_util_set_animation(o, "anim_virus_boss_idle")
        if dist_between_objects(o, nearplayer) < 1900 then
            if obj_has_behavior_id(o, bhvVirusBossBlue) ~= 0 and o.oBehParams == 0 then
                o.oAction = VIRUS_JUMP_TO_MARIO
            end
        end
    elseif o.oAction == VIRUS_JUMP_TO_MARIO then
        smlua_anim_util_set_animation(o, "anim_virus_boss_jump")
        if o.oAnimState == 0 then
            o.oVelY = 50
            o.oAnimState = 1
        end
        o.oForwardVel = 20
        o.oFriction = 1
        local stepObjResult = object_step()
        if stepObjResult & OBJ_COL_FLAG_GROUNDED == 1 then
            o.oForwardVel = 0
            o.oAction = VIRUS_WALK
        end
    elseif o.oAction == VIRUS_WALK then
        smlua_anim_util_set_animation(o, "anim_virus_boss_walk")
        cur_obj_move_standard(-78)
        cur_obj_update_floor_and_walls()

        o.oGravity = -2

        if (o.oMoveFlags & OBJ_MOVE_HIT_EDGE) ~= 0 then
            o.oMoveAngleYaw = o.oMoveAngleYaw + 32768
        end
        o.oForwardVel = 12
        cur_obj_rotate_yaw_toward(obj_angle_to_object(o, nearplayer), 0x230)

        if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
            o.oInteractStatus = 0
            o.oAction = VIRUS_ATTACKED
        else
            o.oInteractStatus = 0
        end
    elseif o.oAction == VIRUS_ATTACKED then
        smlua_anim_util_set_animation(o, "anim_virus_boss_die")

        o.oHealth = o.oHealth + 1

        if o.oHealth > 30 then
            spawn_triangle_break_particles(20, 138, 3.0, 4);
            cur_obj_set_pos_to_home()
            o.oHealth = 0
            o.oInteractStatus = 0
            o.oMoveAngleYaw = 32768
            o.oForwardVel = 0
            o.oAction = 0
            o.oAnimState = 0
            o.oBehParams = 1
            if obj_has_behavior_id(o, bhvVirusBossBlue) ~= 0 then
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossRed).oAction = VIRUS_JUMP_TO_MARIO
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossRed).oPosX = o.oHomeX
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossRed).oPosY = o.oHomeY
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossRed).oPosZ = o.oHomeZ
                cur_obj_disable_rendering_and_become_intangible(o)
            end

            if obj_has_behavior_id(o, bhvVirusBossRed) ~= 0 then
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossYellow).oAction = VIRUS_JUMP_TO_MARIO
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossYellow).oPosX =
                    obj_get_nearest_object_with_behavior_id(o, bhvVirusBossBlue).oHomeX
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossYellow).oPosY =
                    obj_get_nearest_object_with_behavior_id(o, bhvVirusBossBlue).oHomeY
                obj_get_nearest_object_with_behavior_id(o, bhvVirusBossYellow).oPosZ =
                    obj_get_nearest_object_with_behavior_id(o, bhvVirusBossBlue).oHomeZ
                cur_obj_disable_rendering_and_become_intangible(o)
            end

            if obj_has_behavior_id(o, bhvVirusBossYellow) ~= 0 then
                obj_mark_for_deletion(o)
                obj_mark_for_deletion(obj_get_nearest_object_with_behavior_id(o, bhvVirusBossBlue))
                obj_mark_for_deletion(obj_get_nearest_object_with_behavior_id(o, bhvVirusBossRed))
                spawn_red_coin_cutscene_star(11440, 176, -5130)
            end
        end
    end
end

bhvVirusBossBlue = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_virus_boss_init,
    bhv_virus_boss_loop)

bhvVirusBossRed = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_virus_boss_init,
    bhv_virus_boss_loop)

bhvVirusBossYellow = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_virus_boss_init,
    bhv_virus_boss_loop)
