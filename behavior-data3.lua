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

    if o.oTimer > 300 then
        obj_mark_for_deletion(o)
    end
end

bhvIntroMeteor0 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_intro_meteor0_init, bhv_intro_meteor_loop)
bhvIntroMeteor1 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_intro_meteor1_init, bhv_intro_meteor_loop)
bhvIntroMeteor2 = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_intro_meteor2_init, bhv_intro_meteor_loop)

local function bhv_spiky_piranha_plant_hitbox_init(o)
    o.oFlags = 0x0041
    o.oInteractType = 0x08
    o.oDamageOrCoinValue = 2

    o.hitboxRadius = 0x60
    o.hitboxHeight = 0x60
end

local function bhv_spiky_piranha_plant_hitbox_loop(o)
    local parent = o.parentObj
    local idx = o.oBehParams2ndByte

    obj_copy_pos(o, parent)
    o.oMoveAngleYaw = parent.oMoveAngleYaw

    if idx == 2 then
        o.hitboxRadius = 30
        o.hitboxHeight = 30
    elseif idx == 3 then
        o.oInteractType = 0x8000
    end

    if parent.oAction == 0 then
        local f = idx * 140

        o.oForwardVel = f

        if idx == 2 then
            f = f + 68
        elseif idx == 1 then
            f = f + 58
        end

        o.oPosY = o.oPosY + f

    elseif parent.oAction == 1 then
        local timer = parent.oTimer

        if timer < 14 then
            o.oForwardVel = idx * 10
            o.oPosY = o.oPosY + idx * 150

        elseif timer < 35 then
            timer = timer - 14

            o.oForwardVel = idx * (10 + timer * 7)
            o.oPosY = o.oPosY + (4 - idx) * 50 + timer * 7

        else
            o.oForwardVel = idx * 150
            o.oPosY = o.oPosY + 100
        end

    elseif parent.oAction == 2 then
        local timer = parent.oTimer

        o.oForwardVel = idx * (150 - timer * 1.25)
        o.oPosY = o.oPosY + (idx - 2) * timer * 30 + 200

    else
        obj_mark_for_deletion(o)
    end

    cur_obj_compute_vel_xz()
    cur_obj_move_using_fvel_and_gravity()

    if idx == 3 and obj_check_if_collided_with_object(o, gMarioStates[0].marioObj) ~= 0 then
        if gMarioStates[0].marioObj.oPosY - 100 >= o.oPosY then
            parent.oAction = 3
        end
    end

    o.oInteractStatus = 0
    o.oIntangibleTimer = 0
end

bhvSpikyPiranhaPlantHurtbox = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_spiky_piranha_plant_hitbox_init, bhv_spiky_piranha_plant_hitbox_loop)

---@param o Object
local function bhv_spiky_piranha_plant_init(o)
    o.oFlags =
        OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE |
        OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO

    smlua_anim_util_set_animation(o, "anim_spiky_piranha_plant_idle")

    o.oInteractType = INTERACT_DAMAGE
    o.oDamageOrCoinValue = 2
    o.hitboxRadius = 80
    o.hitboxHeight = 160

    for i = 1, 3 do
        local child = spawn_object(o, E_MODEL_NONE, bhvSpikyPiranhaPlantHurtbox)

        child.parentObj = o
        child.oBehParams2ndByte = i
    end
end

-- the attack condition is not quite right,
-- it's supposed to be  (o->oTimer < 0xA0) && (*(u8*)0x8039EEE0 < 2)
-- but that doesnt really make sense. i also have no idea what 0x8039EEE0 is
-- everything else seems fine though, i might fix it later
local function bhv_spiky_piranha_plant_loop(o)
    if o.oAction == 0 then
        if o.oDistanceToMario < 1200 then
            o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, o.oAngleToMario, 0x400)

           if o.oDistanceToMario < 792 then
                if o.oTimer > 0xA0 then
                    o.oTimer = 0
                    o.oAction = 1

                    smlua_anim_util_set_animation(o, "anim_spiky_piranha_plant_attack")

                    o.header.gfx.animInfo.animFrame = 0
                    o.header.gfx.animInfo.animAccel = 0

                    cur_obj_extend_animation_if_at_end()

                    random_u16() -- ?
                    return
                end
            end
        end
    elseif o.oAction == 1 then
        if o.oTimer == 0 then
            create_sound_spawner(0x504A0081)
        end

        if o.oTimer == 0x20 then
            create_sound_spawner(0x50100081);
        end

        if o.oTimer == 0x4F then
            o.oAction = 2
            smlua_anim_util_set_animation(o, "anim_spiky_piranha_plant_reset")

            o.header.gfx.animInfo.animFrame = 0
            o.header.gfx.animInfo.animAccel = 0

            cur_obj_extend_animation_if_at_end()
        end

    elseif o.oAction == 2 then
        if o.oTimer == 7 then
            o.oAction = 0
            smlua_anim_util_set_animation(o, "anim_spiky_piranha_plant_idle")

            o.header.gfx.animInfo.animFrame = 0
            o.header.gfx.animInfo.animAccel = 0

            cur_obj_extend_animation_if_at_end()
        end
    elseif o.oAction == 3 then
        o.header.gfx.scale.y = 0.5
        o.header.gfx.animInfo.animFrame = o.header.gfx.animInfo.animFrame - 1 -- ?

        if o.oTimer == 0 then
            create_sound_spawner(0x50590081)
        end

        if o.oTimer == 24 then
            create_sound_spawner(0x50610081)
            obj_mark_for_deletion(o)
            spawn_object(o, E_MODEL_BLUE_COIN, id_bhvBlueCoinJumping)
            spawn_object(o, E_MODEL_NONE, id_bhvMistCircParticleSpawner)
        end
    end

    o.oIntangibleTimer = 0
    o.oInteractStatus = 0
end

bhvSpikyPiranhaPlant = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_spiky_piranha_plant_init, bhv_spiky_piranha_plant_loop)
E_MODEL_SPIKY_PIRANHA_PLANT = smlua_model_util_get_id("spiky_piranha_plant_geo")

local function bhv_cg_moon_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    local count = save_file_get_total_star_count(get_current_save_file_num() - 1, 0, 24)

    o.oPosY = 23946 - (count * 144);

    local color = 255 - ((count >> 1) + (count >> 3))

    set_lighting_color(0, color)
    set_lighting_color(1, color)
    set_lighting_color(2, color)

    set_skybox_color(0, color)
    set_skybox_color(1, color)
    set_skybox_color(2, color)
end

bhvCGMoon = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_cg_moon_init, nil)

local function reset_lights()
    if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS then
        local color = 0xFF

        set_lighting_color(0, color)
        set_lighting_color(1, color)
        set_lighting_color(2, color)

        set_skybox_color(0, color)
        set_skybox_color(1, color)
        set_skybox_color(2, color)
    end
end

hook_event(HOOK_BEFORE_WARP, reset_lights)

