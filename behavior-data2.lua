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


---@param o Object
local function bhv_ttc_cloud(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1500
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("ttc_cloud_collision")
end

---@param o Object
local function bhv_ttc_cloud_loop(o)
    load_object_collision_model() -- not done yet
end

bhvTTCCloud = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_ttc_cloud, bhv_ttc_cloud_loop)

---@param o Object
local function bhv_bitfs_slime_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("bitfs_slime_collision")
    network_init_object(o, true, { "oAction", "oTimer" })
end

slimesize_amount = 0.015
slimesize_amount_fast = 0.045

---@param o Object
local function bhv_bitfs_slime_loop(o)
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

local bossShadowMarioAnims = {
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
local function bhv_boss_shadow_mario_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW

    obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 0, true)

    o.oGraphYOffset = 40

    o.oFriction = 1
    o.oGravity = 3

    o.oInteractType = INTERACT_BOUNCE_TOP2
    o.oIntangibleTimer = 0
    o.oDamageOrCoinValue = 1

    o.oHealth = 6

    obj_set_hitbox_radius_and_height(o, 85, 120)

    cur_obj_set_home_once()

    network_init_object(o, true,
        { "oAction", "oBirdSpeed", "oMoveAngleYaw", "oAnimState", "oInteractStatus", "oForwardVel", "oSubAction",
            "oHeldState", "oHealth" })
end

function do_boss_mario_shadow_attacks(o)
    if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 and o.oAction ~= 5 then
        o.oAction = 5
        o.oInteractStatus = 0
        o.oHealth = o.oHealth - 1
    end
end

---@param o Object
local function bhv_boss_shadow_mario_loop(o)
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
        o.oInteractType = INTERACT_BOUNCE_TOP2
        obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 1, true, 3.2)
        if o.oInteractStatus & INT_STATUS_ATTACKED_MARIO ~= 0 and o.oAnimState == 0 then
            o.oInteractStatus = 0
            o.oAction = 2
        end

        do_boss_mario_shadow_attacks(o)
        if dist_between_objects(o, nearestP) < 300 and o.oAnimState == 1 then
            o.oAction = 3
        end

        if dist_between_objects(o, nearestP) < 250 and o.oAnimState == 2 then
            o.oAction = 4
        end
    elseif o.oAction == 2 then
        --o.oInteractStatus = 0
        do_boss_mario_shadow_attacks(o)
        o.oForwardVel = 0
        obj_init_animation_from_custom_table(o, bossShadowMarioAnims, 2, true, 0.1)
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 20 then
            o.oAction = 1
        end
    elseif o.oAction == 3 then
        do_boss_mario_shadow_attacks(o)
        --o.oInteractStatus = 0
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
        --o.oInteractStatus = 0
        do_boss_mario_shadow_attacks(o)
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
            o.oInteractStatus = 0
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
local function bhv_goomba_bros_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW|OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.oAnimations = gObjectAnimations.goomba_seg8_anims_0801DA4C
    cur_obj_init_animation(0)

    o.oGravity = -3

    cur_obj_scale(1.3)

    network_init_object(o, true, { "oAction" })
end

---@param o Object
local function bhv_goomba_bros_loop(o)
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
local function bhv_floating_platform_generator_init(o)
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
local function bhv_floating_platform_generator_loop(o)
    load_object_collision_model()
end

bhvFloatingPlatformGenerator = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_floating_platform_generator_init,
    bhv_floating_platform_generator_loop)


-- the door in bitfs (shadow factory)

---@param o Object
local function bitfs_general_use_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("bitfs_general_use_cage_collision")
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
end

---@param o Object
local function bitfs_general_use_gate_loop(o)
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
local function bhv_sunken_thwomp(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("sunken_thwomp_collision")
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1600
end

bhvSunkenThwomp = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_sunken_thwomp,
    function(o) load_object_collision_model(); end)

---@param o Object
local function bhv_quicksand_shadow_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_MOVE_XZ_USING_FVEL
    o.collisionData = smlua_collision_util_get("quicksand_shadow_collision")
    o.header.gfx.skipInViewCheck = true
    network_init_object(o, true, { "oMoveAngleYaw", "oPosX", "oPosZ", "oForwardVel" })
end

---@param o Object
local function bhv_quicksand_shadow_loop(o)
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
local function bhv_rw_spawn_star(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
local function bhv_rw_spawn_star_loop(o)
    if obj_count_objects_with_behavior_id(bhvRedAndWhiteTarget) == 0 then
        obj_mark_for_deletion(o)
        spawn_red_coin_cutscene_star(o.oPosX, o.oPosY + 230, o.oPosZ)
    end
end

bhvRedAndWhiteTargetSpawnStar = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_rw_spawn_star,
    bhv_rw_spawn_star_loop)

---@param o Object
local function bhv_swinging_ship_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 4000
    o.collisionData = smlua_collision_util_get("swinging_ship_collision")
end

---@param o Object
local function bhv_swinging_ship_loop(o)
    load_object_collision_model()
    o.oFaceAnglePitch = math_sin(o.oTimer * 0.02) * 4300
end

bhvSwingingShip = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_swinging_ship_init,
    bhv_swinging_ship_loop)


---@param o Object
local function bhv_up_and_down_ride_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 1300
    o.collisionData = smlua_collision_util_get("up_and_down_ride_collision")
    cur_obj_set_home_once()
    network_init_object(o, true, { "oVelY", "oPosY", "oAnimState", "oHauntedChairUnkFC" })
end

---@param o Object
local function bhv_up_and_down_ride_loop(o)
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
local function bhv_luna_park_ent_part1(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
end

MODEL_LP_ENT1 = smlua_model_util_get_id("luna_park_entrance_part1_geo")

---@param o Object
local function bhv_luna_park_ent_part1_loop(o)
    obj_set_model_extended(o, MODEL_LP_ENT1)
end

bhvLPEntP1 = hook_behavior(nil, OBJ_LIST_DEFAULT, true, bhv_luna_park_ent_part1,
    bhv_luna_park_ent_part1_loop)

---blooping

---@param o Object
local function bhv_blooper_init(o)
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
local function bhv_blooper_loop(o)
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
local function bhv_mouth_water_thing_init(o)
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
local function bhv_mouth_water_thing_loop(o)
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
local function bhv_totwc_entry_light(o)
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
local function bhv_pss_cloudy_platform(o)
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
                spawn_triangle_break_particles(20, 138, 3.0, 4);
                play_sound(SOUND_GENERAL_BREAK_BOX, gGlobalSoundSource)
                obj_mark_for_deletion(o)
            end
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
local function bhv_bits_entry_gate_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("bits_entry_gate_collision")
    o.header.gfx.skipInViewCheck = true
end

---@param o Object
local function bhv_bits_entry_gate_loop(o)
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
local function bhv_rashay_button_spawn_star(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
local function bhv_rashay_button_spawn_star_loop(o)
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
local function bhv_rashay_unlocker_button_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("rashay_unlocker_button_collision")
    network_init_object(o, true, { "oSubAction", "oAction", "oAnimState" })
end

---@param o Object
local function bhv_rashay_unlocker_button_loop(o)
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
local function bhv_rashay_init(o)
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
local function bhv_rashay_loop(o)
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
local function bhv_brown_hand_enemy_init(o)
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
local function bhv_brown_hand_enemy_loop(o)
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
local function bhv_star_hexagon_spawn_star(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
local function bhv_star_hexagon_spawn_star_loop(o)
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
local function bhv_blue_nabbit_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_MOVE_XZ_USING_FVEL

    o.hitboxRadius = 90
    o.hitboxHeight = 100

    o.oInteractType = INTERACT_BOUNCE_TOP

    o.oIntangibleTimer = 0

    smlua_anim_util_set_animation(o, "anim_blue_nabbit_idle")

    network_init_object(o, true, { "oAction", "oInteractStatus" })
end

---@param o Object
local function bhv_blue_nabbit_loop(o)
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
local function bhv_wdw_seashell_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("wdw_seashell_collision")
    o.oCollisionDistance = 900
end

---only works for local player
---@param o Object
local function bhv_wdw_seashell_loop(o)
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
local function bobomb_gaurd_stopper(o)
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
local function bobomb_buddy_gaurd_init(o)
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
local function bhv_pink_ballon_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oCollisionDistance = 2000
    o.collisionData = smlua_collision_util_get("pink_ballon_collision")
    o.oHealth = 0
    cur_obj_set_home_once()
    obj_scale(o, 4)
end

---@param o Object
local function bhv_pink_ballon_loop(o)
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
local function bhv_custom_ballon_trampoline_init(o)
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
local function bhv_custom_ballon_trampoline_loop(o)
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
local function bhv_airballon_jrb_stand(o)
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
local function bhv_koopa_npc_init(o)
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
local function bhv_koopa_npc_loop(o)
    if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        gMarioStates[0].action = ACT_READING_NPC_DIALOG
        if cutscene_object_with_dialog(CUTSCENE_DIALOG, o, gNetworkPlayers[0].currActNum == 5 and DIALOG_007 or DIALOG_006) ~= 0 then
            o.oInteractStatus = 0
        end
    end
end

bhvKoopaNPC = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_koopa_npc_init, bhv_koopa_npc_loop)


---@param o Object
local function bhv_cork_drain_water_init(o)
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
local function bhv_cork_drain_water_loop(o)
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
local function bhv_musical_fruit_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.hitboxHeight = 80
    o.hitboxRadius = 60
    o.oIntangibleTimer = 0
    network_init_object(o, true, { "oAction" })
end

---@param o Object
local function bhv_musical_fruit_loop(o)
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
local function bhv_musical_fruit_star_spawn(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    network_init_object(o, true, nil)
end

---@param o Object
local function bhv_musical_fruit_star_spawn_loop(o)
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
local function bhv_weird_floating_orb_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
end

---@param o Object
local function bhv_weird_floating_orb_loop(o)
    o.oFaceAnglePitch = o.oFaceAnglePitch + 100
    o.oFaceAngleRoll = o.oFaceAngleRoll + 313
    o.header.gfx.scale.x = absf_2(math_sin(o.oTimer / 100) * 2)
    o.header.gfx.scale.y = absf_2(math_sin(o.oTimer / 120) * 2)
    o.oPosY = o.oPosY + math_sin(o.oTimer / 130)
end

bhvWeirdFloatingOrb = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_weird_floating_orb_init,
    bhv_weird_floating_orb_loop)


---@param o Object
local function bhv_virus_boss_init(o)
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

    network_init_object(o, true, { "oAction", "oAnimState", "oSubAction", "oInteractStatus", "oHealth", "oCapUnkF4" })
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
local function bhv_virus_boss_loop(o)
    local nearplayer = nearest_player_to_object(o)

    obj_delete_if_flood(o)

    if o.oAction == VIRUS_IDLE then
        smlua_anim_util_set_animation(o, "anim_virus_boss_idle")
        if dist_between_objects(o, nearplayer) < 2100 then
            if obj_has_behavior_id(o, bhvVirusBossBlue) ~= 0 then
                o.oAction = VIRUS_JUMP_TO_MARIO
                set_background_music(0, 0x3d, 0)
                audio_stop_all()
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
            o.oVelY = 0
            o.oForwardVel = 0
            o.oAction = VIRUS_WALK
            o.oSubAction = 0
        end
    elseif o.oAction == VIRUS_WALK then
        smlua_anim_util_set_animation(o, "anim_virus_boss_walk")
        cur_obj_move_standard(-78)
        cur_obj_update_floor_and_walls()

        o.oSubAction = o.oSubAction + 1

        o.oGravity = -2

        if o.oSubAction > 45 then
            o.oSubAction = 0
            if obj_has_behavior_id(o, bhvVirusBossBlue) ~= 0 then
                o.oAction = VIRUS_WIND_BEND
            end

            if obj_has_behavior_id(o, bhvVirusBossRed) ~= 0 then
                o.oAction = VIRUS_THROW_FIRE
                spawn_object2(o, E_MODEL_RED_FLAME, bhvFireFlowerFire)
            end

            if obj_has_behavior_id(o, bhvVirusBossYellow) ~= 0 then
                o.oAction = VIRUS_SCALE_BIG
            end
        end

        if (o.oMoveFlags & OBJ_MOVE_HIT_EDGE) ~= 0 then
            o.oMoveAngleYaw = o.oMoveAngleYaw + 32768
        end
        if dist_between_objects(o, gMarioStates[0].marioObj) < 2300 then
            --[[if currentAudio == streamed_collosal_circuits then
                set_background_music(0, 0x3d, 0)
                audio_stop_all()
            end]]
        end
        o.oForwardVel = 12
        cur_obj_rotate_yaw_toward(obj_angle_to_object(o, nearplayer), 0x230)
    elseif o.oAction == VIRUS_WIND_BEND then
        smlua_anim_util_set_animation(o, "anim_virus_boss_wind_bend")
        spawn_object(o, E_MODEL_WHITE_PARTICLE, id_bhvStrongWindParticle)
        cur_obj_rotate_yaw_toward(obj_angle_to_object(o, nearplayer), 0x230)

        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 15 then
            o.oSubAction = 0
            o.oAction = VIRUS_WALK
        end
    elseif o.oAction == VIRUS_THROW_FIRE then
        smlua_anim_util_set_animation(o, "anim_virus_boss_throw_fire")


        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 5 then
            o.oSubAction = 0
            o.oAction = VIRUS_WALK
        end
    elseif o.oAction == VIRUS_SCALE_BIG then
        smlua_anim_util_set_animation(o, "anim_virus_boss_idle")
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 70 then
            o.oSubAction = 0
            o.oAction = VIRUS_WALK
            obj_scale(o, 1)
            o.oCapUnkF4 = 0
        else
            o.oCapUnkF4 = o.oCapUnkF4 + 1
            if o.oCapUnkF4 < 40 then
                o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 6, 0.1)
                o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 6, 0.1)
                o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 6, 0.1)
            else
                o.header.gfx.scale.y = approach_f32_symmetric(o.header.gfx.scale.y, 1, 0.1)
                o.header.gfx.scale.x = approach_f32_symmetric(o.header.gfx.scale.x, 1, 0.1)
                o.header.gfx.scale.z = approach_f32_symmetric(o.header.gfx.scale.z, 1, 0.1)
            end
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
                set_background_music(0, 0, 0)
                play_seq_streamed(streamed_collosal_circuits)
                obj_mark_for_deletion(obj_get_nearest_object_with_behavior_id(o, bhvVirusBossBlue))
                obj_mark_for_deletion(obj_get_nearest_object_with_behavior_id(o, bhvVirusBossRed))
                spawn_red_coin_cutscene_star(11440, 176, -5130)
                network_send_object(o, true)
            end
        end
    end

    if o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
        o.oInteractStatus = 0
        o.oAction = VIRUS_ATTACKED
        if obj_has_behavior_id(o, bhvVirusBossYellow) ~= 0 then
            obj_scale(o, 1)
            o.oCapUnkF4 = 0
        end
    else
        o.oInteractStatus = 0
    end
end

bhvVirusBossBlue = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_virus_boss_init,
    bhv_virus_boss_loop)

bhvVirusBossRed = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_virus_boss_init,
    bhv_virus_boss_loop)

bhvVirusBossYellow = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_virus_boss_init,
    bhv_virus_boss_loop)

---@param o Object
local function bhv_spider_boss_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    o.oGravity = 2

    o.oHealth = 3

    o.hitboxRadius = 180
    o.hitboxHeight = 300

    o.oInteractType = INTERACT_DAMAGE

    o.oIntangibleTimer = 0

    o.oDamageOrCoinValue = 2

    cur_obj_set_home_once()

    o.collisionData = smlua_collision_util_get("spider_boss_collision")

    o.header.gfx.skipInViewCheck = true

    smlua_anim_util_set_animation(o, "anim_spider_boss_idle")

    network_init_object(o, true, { "oAction", "oAnimState", "oSubAction", "oInteractStatus", "oHealth", "oPosY" })
end

SPIDER_IDLE = 0
SPIDER_ATTACK_MOUTH = 1
SPIDER_DEFEND = 2
SPIDER_DIE = 3
SPIDER_JUMP = 4

function do_air_kb(o)
    nearest_mario_state_to_object(o).action = ACT_BACKWARD_AIR_KB_MODIFIED; nearest_mario_state_to_object(o).vel.y = 40; nearest_mario_state_to_object(o).actionArg = 35
end

---@param o Object
local function bhv_spider_boss_loop(o)
    o.oInteractStatus = 0
    obj_delete_if_flood(o)
    load_object_collision_model()
    if o.oAction == SPIDER_IDLE then
        if nearest_mario_state_to_object(o).floor.object ~= o then
            o.oFaceAngleYaw = approach_s16_symmetric(o.oFaceAngleYaw, obj_angle_to_object(o, nearest_player_to_object(o)),
                0x340)
        else
            if nearest_mario_state_to_object(o).marioObj.platform == o then
                o.oAnimState = o.oAnimState + 1
                if o.oAnimState > 30 then
                    o.oAction = SPIDER_JUMP
                    do_air_kb(o)
                    cur_obj_play_sound_1(SOUND_OBJ2_BOWSER_ROAR)
                    o.oAnimState = 0
                    o.oSubAction = 0
                end
            end
        end
        cur_obj_become_intangible()
        smlua_anim_util_set_animation(o, "anim_spider_boss_idle")
        if is_any_mario_groundpounding_obj(o) then
            if nearest_mario_state_to_object(o).floor.type == SURFACE_NOT_SLIPPERY then
                o.oHealth = o.oHealth - 1
                --[[o.oAction = SPIDER_DEFEND
                do_air_kb(o)
                cur_obj_play_sound_1(SOUND_OBJ2_BOWSER_ROAR)
                smlua_anim_util_set_animation(o, "anim_spider_boss_jump")
                o.oSubAction = 0
                o.header.gfx.animInfo.animFrame = 0
                o.header.gfx.animInfo.prevAnimFrame = 0]]
                o.oAction = SPIDER_JUMP
                do_air_kb(o)
                cur_obj_play_sound_1(SOUND_OBJ2_BOWSER_ROAR)
                o.oSubAction = 0
            end
        end

        if dist_between_objects(o, nearest_player_to_object(o)) < 300 and nearest_mario_state_to_object(o).floor.object ~= o then
            o.oAction = SPIDER_ATTACK_MOUTH
        end
    elseif o.oAction == SPIDER_DEFEND then
        smlua_anim_util_set_animation(o, "anim_spider_boss_defend")
        cur_obj_become_tangible()

        o.oSubAction = o.oSubAction + 1

        if o.oSubAction > 50 then
            o.oAction = SPIDER_IDLE
        end
    elseif o.oAction == SPIDER_ATTACK_MOUTH then
        smlua_anim_util_set_animation(o, "anim_spider_boss_attack_mouth")
        cur_obj_become_tangible()

        o.oSubAction = o.oSubAction + 1

        if o.oSubAction > 70 then
            o.oAction = SPIDER_IDLE
        end
    elseif o.oAction == SPIDER_DIE then
        smlua_anim_util_set_animation(o, "anim_spider_boss_die")

        if cur_obj_check_if_near_animation_end() == 1 then
            spawn_mist_particles()
            spawn_red_coin_cutscene_star(o.oPosX, o.oPosY + 200, o.oPosZ)
            obj_mark_for_deletion(o)
        end
    elseif o.oAction == SPIDER_JUMP then
        smlua_anim_util_set_animation(o, "anim_spider_boss_jump")
        o.oSubAction = o.oSubAction + 1

        o.oPosY = o.oHomeY + 100

        if o.oSubAction > 50 then
            o.oAction = SPIDER_IDLE
            o.oSubAction = 0
            o.oGraphYOffset = 0
            o.oPosY = o.oHomeY
        end
    end

    if o.oHealth <= 0 and o.oAction ~= SPIDER_DIE then
        o.oAction = SPIDER_DIE
    end
end

bhvSpiderBoss = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_spider_boss_init, bhv_spider_boss_loop)

MODEL_FLUDD_BOX = smlua_model_util_get_id("fludd_box_geo")

---@param o Object
local function fludd_box_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("fludd_box_collision")

    network_init_object(o, true, { "oAnimState", "oAction" })
end

---@param o Object
local function fludd_box_loop(o)
    obj_delete_if_flood(o)
    if o.oAction == 0 then
        load_object_collision_model()
        cur_obj_unhide()
        if nearest_player_to_object(o).platform == o then
            spawn_triangle_break_particles(20, 138, 3.0, 4);
            play_sound(SOUND_GENERAL_BREAK_BOX, gGlobalSoundSource)
            o.oAction = 1
            spawn_object2(o, MODEL_FLUDD, bhvFLUDD)
        end
    elseif o.oAction == 1 then
        cur_obj_hide()
        o.oAnimState = o.oAnimState + 1
        if o.oAnimState > (5 * 30) then -- 5 seconds
            o.oAction = 0
            o.oAnimState = 0
        end
    end
end

bhvFLUDDBox = hook_behavior(nil, OBJ_LIST_SURFACE, true, fludd_box_init, fludd_box_loop)

local function bhv_do_not_consume(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.collisionData = smlua_collision_util_get("do_not_consume_collision")
    o.oCollisionDistance = 2000
end

local function bhv_do_not_consume_loop(o)
    load_object_collision_model()
end

bhvDoNotConsume = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_do_not_consume, bhv_do_not_consume_loop)

local function bhv_ball_spike(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true

    o.oPosX = o.parentObj.oPosX
    o.oPosY = o.parentObj.oPosY
    o.oPosZ = o.parentObj.oPosZ
    o.oGraphYOffset = 64
end

-- at 0x13002A48
bhvWFBallSpike = hook_behavior(nil, OBJ_LIST_GENACTOR, true, nil, bhv_ball_spike)

--[[

[0021A4F4 / 130006F4] 00 04 0000 // Start Behavior (Object type = 4)
[0021A4F8 / 130006F8] 11 01 0049 // (Set bits) obj._0x8C |= 0x0049
[0021A4FC / 130006FC] 2D 00 00 00 // Set inital position. (Used in Dorrie, Fly guys, etc. to determine in which range they can move)
[0021A500 / 13000700] 23 00 00 00 0070 0070 // Set Collision sphere size (XZ radius = 112, Y radius = 112)
[0021A508 / 13000708] 2C 00 00 00 00000039 13002A48 // (Spawn child object) obj._0x6C = (Model ID = 0x0039, Behavior = 0x13002A48
[0021A514 / 13000714] 10 3E 0002 // (Set value) obj._0x180 = 2
[0021A518 / 13000718] 08 00 00 00 // Start of loop
[0021A51C / 1300071C]    0C 00 00 00 802A73F0 // Call ASM function 0x802A73F0
[0021A524 / 13000724]    10 05 0000 // (Set value) obj._0x9C = 0
[0021A528 / 13000728]    10 2B 0000 // (Set value) obj._0x134 = 0
[0021A52C / 1300072C]    09 00 00 00 // End of loop

]]
MODEL_WF_BALL_SPIKE = smlua_model_util_get_id("wf_ball_spike_geo")
local function bhv_wf_balls(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.header.gfx.skipInViewCheck = true
    cur_obj_set_home_once()
    o.hitboxRadius = 112
    o.hitboxHeight = 112
    --spawn child
    o.oHiddenBlueCoinSwitch = spawn_object(o, MODEL_WF_BALL_SPIKE, bhvWFBallSpike)
    o.oHiddenBlueCoinSwitch.parentObj = o
    o.oDamageOrCoinValue = 2
    o.oGravity = 3
    o.oFriction = 1
    o.oGraphYOffset = 64
    network_init_object(o, true, { "oPosX", "oPosY", "oPosZ", "oMoveAngleYaw" })
end

---@param o Object
local function bhv_wf_balls_loop(o)
    local pr = nearest_player_to_object(o)
    if o.oAction == 0 then
        obj_scale(o.oHiddenBlueCoinSwitch, 0)
        o.oInteractType = INTERACT_IGLOO_BARRIER
        o.oMoveAngleYaw = o.oMoveAngleYaw + 0x70
        o.oForwardVel = 5
        o.oFaceAnglePitch = o.oFaceAnglePitch + 0x100
        o.oPosY = find_floor_height(o.oPosX, o.oPosY, o.oPosZ)
        cur_obj_move_xz_using_fvel_and_yaw()
        if dist_between_objects(o, pr) < 340 then
            o.oAction = 1;
        end
    elseif o.oAction == 1 then
        o.oSubAction = o.oSubAction + 1
        if o.oSubAction > 35 and o.oSubAction < 35 * 2 then
            obj_scale(o.oHiddenBlueCoinSwitch, 1)
            o.oInteractType = INTERACT_DAMAGE
        elseif o.oSubAction > 35 * 2 then
            o.oInteractType = INTERACT_IGLOO_BARRIER
            obj_scale(o.oHiddenBlueCoinSwitch, 0)
            o.oSubAction = 0
        end
        if dist_between_objects(o, pr) > 340 then
            o.oAction = 0;
            o.oSubAction = 0
        end
    end

    o.oInteractStatus = 0
    o.oIntangibleTimer = 0
end

bhvWFBalls = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_wf_balls, bhv_wf_balls_loop)


---taken from Behavior Ball example from examples in docs/lua and edited to work with last impact
local function bhv_ball_init(obj)
    obj.oFlags            = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.oGraphYOffset     = 35

    -- physics
    obj.oWallHitboxRadius = 40.00
    obj.oGravity          = 2.50
    obj.oBounciness       = -0.75
    obj.oDragStrength     = 0.00
    obj.oFriction         = 0.99
    obj.oBuoyancy         = -2.00

    -- hitbox
    obj.hitboxRadius      = 100
    obj.hitboxHeight      = 100

    network_init_object(obj, true, nil)
end

local function bhv_ball_loop(obj)
    local m = nearest_mario_state_to_object(obj)
    local player = m.marioObj
    local distanceToPlayer = dist_between_objects(obj, player)
    local angleToPlayer = obj_angle_to_object(obj, player)
    local localPlayerTouch = false

    -- figure out player-to-ball radius
    local radius = 100
    if (m.action & ACT_FLAG_ATTACKING) ~= 0 and distanceToPlayer < 130 then
        radius = 150
        obj.oAction = 1
    end

    if obj.oAction == 0 then
        obj.oFriction = 0
    else
        obj.oFriction = 1
    end
    -- check if player should affect ball
    if distanceToPlayer < radius then
        local xdiff = player.oPosX - obj.oPosX
        local zdiff = player.oPosZ - obj.oPosZ

        obj.oPosX = obj.oPosX - (radius - distanceToPlayer) / radius * xdiff;
        obj.oPosZ = obj.oPosZ - (radius - distanceToPlayer) / radius * zdiff;

        obj.oMoveAngleYaw = angleToPlayer + 0x8000
        obj.oForwardVel = obj.oForwardVel + 10

        if (m.action & ACT_FLAG_ATTACKING) ~= 0 then
            obj.oVelY = obj.oVelY + 20.0
        end
        if m.playerIndex == 0 then
            localPlayerTouch = true
        end
    end

    -- do physics

    local stepRc = 0
    stepRc = object_step_without_floor_orient()
    if obj.oForwardVel > 0 then
        obj.oForwardVel = obj.oForwardVel - 0.2
    end
    -- play sounds
    if stepRc == 1 then
        cur_obj_play_sound_2(SOUND_GENERAL_BOX_LANDING_2)
    elseif (stepRc & 1) ~= 0 then
        if obj.oForwardVel > 20.0 then
            cur_obj_play_sound_2(SOUND_ENV_SLIDING)
        end
    end

    -- check for floor death
    local floor = cur_obj_update_floor_height_and_get_floor()
    if floor ~= nil then
        obj_check_floor_death(stepRc, floor)
    end

    -- update visual rotation
    if obj.oForwardVel > 0 then
        obj.oFaceAngleYaw = obj.oMoveAngleYaw
        obj.oFaceAnglePitch = obj.oFaceAnglePitch + obj.oForwardVel * 100
    end

    -- if we touched it, send an immediate update instead of waiting
    if localPlayerTouch then
        network_send_object(obj, false)
    end
end

bhvCGCoconut = hook_behavior(nil, OBJ_LIST_DEFAULT, true, bhv_ball_init, bhv_ball_loop)

local function bhv_fludd_blackspot(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true

    o.hitboxRadius = 120
    o.hitboxHeight = 2000
    o.oIntangibleTimer = 0
    ---doesnt work???
    o.oOpacity = 80
    network_init_object(o, true, {"activeFlags"})
end

MODEL_BLACKSPOT = smlua_model_util_get_id("fludd_blackspot_geo")

local function bhv_fludd_blackspot_loop(o)
    local pm = nearest_mario_state_to_object(o)
    obj_set_model_extended(o, MODEL_BLACKSPOT)
    if pm.action == ACT_FLUDD_FLOAT then
        if obj_check_hitbox_overlap(o, pm.marioObj) then
            o.oOpacity = o.oOpacity - 1
            if o.oOpacity <= 0 then
                obj_mark_for_deletion(o)
            end
        end
    end
end

bhvFluddBlackSpot = hook_behavior(id_bhvWfRotatingWoodenPlatform, OBJ_LIST_LEVEL, true, bhv_fludd_blackspot,
    bhv_fludd_blackspot_loop)

local function fludd_blackspot_starspawn(o)
    if obj_count_objects_with_behavior_id(bhvFluddBlackSpot) == 0 then
        spawn_red_coin_cutscene_star(o.oPosX, o.oPosY, o.oPosZ)
    end
end

bhvFluddBlackSpotStarSpawn = hook_behavior(nil, OBJ_LIST_LEVEL, true, nil,
    fludd_blackspot_starspawn)

local function bhv_intro_meteor0_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.oVelY = -272
end

local function bhv_intro_meteor1_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.oForwardVel = 80
    o.oMoveAngleYaw = -18528
    o.oVelY = -272

    obj_scale(o, 0.16)
end

local function bhv_intro_meteor2_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    o.oForwardVel = 80
    o.oMoveAngleYaw = -15616
    o.oVelY = -272

    obj_scale(o, 0.16)
end

local function bhv_intro_meteor_loop(o)
    local angle = o.oMoveAngleYaw

    o.oVelX = o.oForwardVel * sins(angle)
    o.oVelZ = o.oForwardVel * coss(angle)

    -- 0x8029F070 inlined
    o.oPosX = o.oPosX + o.oVelX
    o.oPosY = o.oPosY + o.oVelY
    o.oPosZ = o.oPosZ + o.oVelZ
end

bhvIntroMeteor0 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_intro_meteor0_init, bhv_intro_meteor_loop)
bhvIntroMeteor1 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_intro_meteor1_init, bhv_intro_meteor_loop)
bhvIntroMeteor2 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_intro_meteor2_init, bhv_intro_meteor_loop)
