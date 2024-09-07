--- @file powerups.lua
--- This file contains the code for every powerup in the game.

-- Placed here to remove the need of setting models for every powerup
-- Uses the definitive model check

-- Models

E_MODEL_BEE_MARIO = smlua_model_util_get_id("bee_mario_geo")
E_MODEL_CLOUD_MARIO = smlua_model_util_get_id("cloud_mario_geo")
E_MODEL_SPRING_MARIO = smlua_model_util_get_id("spring_mario_geo")

-- Sounds

local audio_rainbowmario = audio_stream_load("RainbowMario.mp3")

-- Powerups enum

NORMAL = 0
BEE = 1
CLOUD = 2
RAINBOW = 3
FIRE = 4
ICE = 5
SPRING = 6

-- Powerup Relatives
local cloudcount = 0        -- for cloud flower
local rainbow_timer = 0     -- for rainbow star
local savedBGM = 0          -- for rainbow star
local rainbow_music = false -- for rainbow star

characterPowerupModels = {
    [CT_MARIO] = { bee = E_MODEL_BEE_MARIO, cloud = E_MODEL_CLOUD_MARIO, rainbow = nil, fire = nil, ice = nil, spring = E_MODEL_SPRING_MARIO, },
    [CT_LUIGI] = { bee = E_MODEL_BEE_MARIO, cloud = E_MODEL_CLOUD_MARIO, rainbow = nil, fire = nil, ice = nil, spring = E_MODEL_SPRING_MARIO, },
    [CT_TOAD] = { bee = E_MODEL_BEE_MARIO, cloud = E_MODEL_CLOUD_MARIO, rainbow = nil, fire = nil, ice = nil, spring = E_MODEL_SPRING_MARIO, },
    [CT_WARIO] = { bee = E_MODEL_BEE_MARIO, cloud = E_MODEL_CLOUD_MARIO, rainbow = nil, fire = nil, ice = nil, spring = E_MODEL_SPRING_MARIO, },
    [CT_WALUIGI] = { bee = E_MODEL_BEE_MARIO, cloud = E_MODEL_CLOUD_MARIO, rainbow = nil, fire = nil, ice = nil, spring = E_MODEL_SPRING_MARIO, },
}

-- Powerups are a PlayerSyncTable by the way.

-- Powerup States, to add more powerups here, you must first add them to the enum and assign a number

-- To fix script errors on startup
local powerupStates = {
    [NORMAL] = { modelId = nil },
    [BEE] = { modelId = nil },
    [CLOUD] = { modelId = nil },
    [RAINBOW] = { modelId = nil },
    [FIRE] = { modelId = nil },
    [ICE] = { modelId = nil },
    [SPRING] = { modelId = nil },
}
function get_character_model(m)
    if m.playerIndex ~= 0 then return end
    CPM = characterPowerupModels[m.character.type] -- To get the model easily
    CPMM = characterPowerupModels[CT_MARIO]        -- To get Mario's model easily

    powerupStates = {
        [NORMAL] = { modelId = nil },
        [BEE] = { modelId = CPM.bee and CPM.bee or CPMM.bee },
        [CLOUD] = { modelId = CPM.cloud and CPM.cloud or CPMM.cloud },
        [RAINBOW] = { modelId = CPM.rainbow and CPM.rainbow or CPMM.rainbow },
        [FIRE] = { modelId = CPM.fire and CPM.fire or CPMM.fire },
        [ICE] = { modelId = CPM.ice and CPM.ice or CPMM.ice },
        [SPRING] = { modelId = CPM.spring and CPM.spring or CPMM.spring },
    }
end

--- Charselect Model fix. By OneCalledRPG
function cs_model_set(m)
    if _G.charSelectExists then
        if _G.charSelect.character_get_current_number() == 1 then
            get_character_model(m)
        else
            powerupStates = {
                [NORMAL] = { modelId = nil },
                [BEE] = { modelId = nil },
                [CLOUD] = { modelId = nil },
                [RAINBOW] = { modelId = nil },
                [FIRE] = { modelId = nil },
                [ICE] = { modelId = nil },
                [SPRING] = { modelId = nil },
            }
        end
    else
        get_character_model(m)
    end
end

hook_event(HOOK_MARIO_UPDATE, cs_model_set)

-- Powerup Model Functions --

function powerups()
    gPlayerSyncTable[0].modelId = powerupStates[gPlayerSyncTable[0].powerup].modelId
end

hook_event(HOOK_OBJECT_SET_MODEL, function(o)
    if obj_has_behavior_id(o, id_bhvMario) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)

        if gPlayerSyncTable[i].powerup == nil then gPlayerSyncTable[i].powerup = NORMAL end

        if gPlayerSyncTable[i].modelId ~= nil and obj_has_model_extended(o, gPlayerSyncTable[i].modelId) == 0 then
            obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        end
        return
    end
end)

-- Resets the player stats when leaving a level or dying

function on_death_warp()
    gPlayerSyncTable[0].powerup = NORMAL
    network_player_reset_override_palette(gNetworkPlayers[0])
    cloudcount = 0
    audio_stream_stop(audio_rainbowmario)
    rainbow_timer = 0
    rainbow_music = false
end

-- Removes the player's powerup on damage

function damage_check(m)
    --djui_chat_message_create(tostring(cloudcount))
    if m.playerIndex ~= 0 then return end
    if m.hurtCounter > 0 or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_JUMP then
        if gPlayerSyncTable[0].powerup == RAINBOW then
            set_background_music(0, savedBGM, 0)
        end
        gPlayerSyncTable[0].powerup = NORMAL
        network_player_reset_override_palette(gNetworkPlayers[0])
        cloudcount = 0
        rainbow_timer = 0
        rainbow_music = false
        audio_stream_stop(audio_rainbowmario)
    end
end

hook_event(HOOK_UPDATE, powerups)
hook_event(HOOK_MARIO_UPDATE, damage_check)
hook_event(HOOK_ON_DEATH, on_death_warp)
hook_event(HOOK_ON_WARP, on_death_warp)

-- Actual powerups

E_MODEL_BEE_SHROOM = smlua_model_util_get_id("bee_shroom_geo")

ACT_FLY = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)

if gPlayerSyncTable[0].energyBar == nil then
    gPlayerSyncTable[0].energyBar = 2.4 * 30 -- 2.4 Seconds
end

-- Energy Meter Textures --

local EMPTY_ENERGY = get_texture_info("bee_meter_empty")
local TWO_ENERGY = get_texture_info("bee_meter_2")
local THREE_ENERGY = get_texture_info("bee_meter_3")
local FOUR_ENERGY = get_texture_info("bee_meter_4")
local FIVE_ENERGY = get_texture_info("bee_meter_5")
local SIX_ENERGY = get_texture_info("bee_meter_6")
local SEVEN_ENERGY = get_texture_info("bee_meter_7")
local EIGHT_ENERGY = get_texture_info("bee_meter_8")
local NINE_ENERGY = get_texture_info("bee_meter_9")
local TEN_ENERGY = get_texture_info("bee_meter_10")
local ELEVEN_ENERGY = get_texture_info("bee_meter_11")
local FULL_ENERGY = get_texture_info("bee_meter_full")

energyMeter = {
    { energy = EMPTY_ENERGY },
    { energy = TWO_ENERGY },
    { energy = THREE_ENERGY },
    { energy = FOUR_ENERGY },
    { energy = FIVE_ENERGY },
    { energy = SIX_ENERGY },
    { energy = SEVEN_ENERGY },
    { energy = EIGHT_ENERGY },
    { energy = NINE_ENERGY },
    { energy = TEN_ENERGY },
    { energy = ELEVEN_ENERGY },
    { energy = FULL_ENERGY }
}

local common_blacklisted_actions = {
    [ACT_BACKWARD_AIR_KB] = true,
    [ACT_FORWARD_AIR_KB] = true,
    [ACT_BACKWARD_GROUND_KB] = true,
    [ACT_SOFT_BONK] = true,
    [ACT_HARD_FORWARD_AIR_KB] = true,
    [ACT_THROWN_BACKWARD] = true,
    [ACT_HARD_FORWARD_GROUND_KB] = true,
    [ACT_SOFT_FORWARD_GROUND_KB] = true,
    [ACT_HARD_BACKWARD_GROUND_KB] = true,
    [ACT_SOFT_BACKWARD_GROUND_KB] = true
}

function energy_meter()
    if math.ceil((gPlayerSyncTable[0].energyBar / 12) * 2) ~= 0 then
        gPlayerSyncTable[0].curEnergy = math.ceil((gPlayerSyncTable[0].energyBar / 12) * 2)
    else
        gPlayerSyncTable[0].curEnergy = 1
    end
end

hook_event(HOOK_UPDATE, energy_meter)

---@param powerup integer
---@param obj Object
function general_powerup_handler(obj, powerup)
    local nreaetsplayertopwoerup = nearest_player_to_object(obj)
    local nearestmariotopowerup = nearest_mario_state_to_object(obj)
    if obj.oAction == 0 then
        if obj_check_hitbox_overlap(nreaetsplayertopwoerup, obj) then
            obj.oAction = 1
            cur_obj_hide()
            obj.oTimer = 0
            cur_obj_play_sound_2(SOUND_MENU_EXIT_PIPE)
            gPlayerSyncTable[network_local_index_from_global(nreaetsplayertopwoerup.globalPlayerIndex)].powerup = powerup
            if powerup == RAINBOW then
                if nearestmariotopowerup.playerIndex == 0 then
                    rainbow_timer = 0
                end
            end
        end

        if powerup == SPRING then
            spawn_non_sync_object(id_bhvSparkleSpawn, E_MODEL_NONE, obj.oPosX, obj.oPosY, obj.oPosZ, nil);
        end
    end


    if obj.oAction == 1 then
        obj.hitboxRadius = 0
        obj.hitboxHeight = 0
        if obj.oTimer > 200 then
            obj.oTimer = 0
            obj.oAction = 0
            cur_obj_unhide()
            obj.hitboxRadius = 65
            obj.hitboxHeight = 65
        end
    end
end

---@param powerup integer
---@param obj Object
function general_powerup_handler2(obj, powerup)
    local nreaetsplayertopwoerup = nearest_player_to_object(obj)
    local nearestmariotopowerup = nearest_mario_state_to_object(obj)
    if obj_check_hitbox_overlap(nreaetsplayertopwoerup, obj) then
        cur_obj_play_sound_2(SOUND_MENU_EXIT_PIPE)
        gPlayerSyncTable[network_local_index_from_global(nreaetsplayertopwoerup.globalPlayerIndex)].powerup = powerup
        obj_mark_for_deletion(obj)
    end


    if obj.oTimer > 500 then
        obj_flicker_and_disappear(obj, 500)
    end
end

---@param obj Object
function bhv_beesuit_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj_set_model_extended(obj, E_MODEL_BEE_SHROOM)
    obj_scale(obj, 0.5)
    obj.hitboxRadius = 30
    obj.hitboxHeight = 30
    obj.oIntangibleTimer = 0
    obj.oGravity = 3
    obj.oFaceAngleYaw = obj.oFaceAngleYaw + 32768
    network_init_object(obj, true, nil)
end

---@param obj Object
function bhv_cloudflower_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.hitboxRadius = 80
    obj.hitboxHeight = 80
    obj.oIntangibleTimer = 0
    obj.oGravity = 3
    obj.oFaceAnglePitch = obj.oFaceAnglePitch + -16384
    obj.oGraphYOffset = 0
    network_init_object(obj, true, nil)
end

---@param obj Object
function bhv_rainbow_star_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.hitboxRadius = 60
    obj.hitboxHeight = 60
    obj.oIntangibleTimer = 0
    network_init_object(obj, true, nil)
end

---@param obj Object
function bhv_spring_mushroom_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.hitboxRadius = 65
    obj.hitboxHeight = 65
    obj.oIntangibleTimer = 0
    network_init_object(obj, true, nil)
end

MODEL_FIRE_FLOWER = smlua_model_util_get_id("fire_flower_geo")
MODEL_ICE_FLOWER = smlua_model_util_get_id("ice_flower_geo")

---@param obj Object
function bhv_fire_flower_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.hitboxRadius = 65
    obj.hitboxHeight = 65
    obj.oIntangibleTimer = 0
    obj.oGravity = 3
    obj_scale(obj, 0.7)
    --obj.oFaceAngleYaw = obj.oFaceAngleYaw + 32768
    obj_set_model_extended(obj, MODEL_FIRE_FLOWER)
    network_init_object(obj, true, nil)
end

---@param obj Object
function bhv_ice_flower_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.hitboxRadius = 65
    obj.hitboxHeight = 65
    obj.oIntangibleTimer = 0
    obj.oGravity = 3
    obj_scale(obj, 0.7)
    --obj.oFaceAngleYaw = obj.oFaceAngleYaw + 32768
    obj_set_model_extended(obj, MODEL_ICE_FLOWER)
    network_init_object(obj, true, nil)
end

---@param obj Object
function bhv_beesuit_loop(obj)
    object_step()
    general_powerup_handler(obj, BEE)
end

---@param obj Object
function bhv_cloudflower_loop(obj)
    general_powerup_handler(obj, CLOUD)
end

---@param obj Object
function bhv_rainbow_star_loop(obj)
    obj.oFaceAngleYaw = obj.oFaceAngleYaw + 0x860
    general_powerup_handler(obj, RAINBOW)
end

---@param obj Object
function bhv_fire_flower_loop(obj)
    object_step()
    general_powerup_handler2(obj, FIRE)
end

---@param obj Object
function bhv_ice_flower_loop(obj)
    object_step()
    general_powerup_handler2(obj, ICE)
end

---@param obj Object
function bhv_spring_mushroom_loop(obj)
    object_step()
    obj.oFaceAngleYaw = obj.oFaceAngleYaw + ((65536 / 360) * 2.2)
    general_powerup_handler(obj, SPRING)
end

---only deletes for local player
---@param obj Object
function bhv_add_cloud_count_loop(obj)
    obj.oFaceAngleYaw = obj.oFaceAngleYaw + 0x110
    local m = gMarioStates[0]
    if obj.oAction == 0 then
        if obj_check_hitbox_overlap(m.marioObj, obj) then
            obj.oAction = 1
            cur_obj_hide()
            obj.oTimer = 0
            play_sound(SOUND_MENU_STAR_SOUND, gGlobalSoundSource);
            if cloudcount ~= 3 then
                cloudcount = cloudcount + 1
            end
        end
    end


    if obj.oAction == 1 then
        obj.hitboxRadius = 0
        obj.hitboxHeight = 0
        if obj.oTimer > 200 then
            obj.oTimer = 0
            obj.oAction = 0
            cur_obj_unhide()
            obj.hitboxRadius = 65
            obj.hitboxHeight = 65
        end
    end
end

bhvAddCloudCount = hook_behavior(nil, OBJ_LIST_GENACTOR, true,
    function(obj) obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE end,
    bhv_add_cloud_count_loop)

---@param o Object
function bhv_fire_flower_fire_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    o.oInteractType = INTERACT_FLAME

    o.hurtboxRadius = 210
    o.hurtboxHeight = 210

    o.oIntangibleTimer = 0

    o.oGravity = 2.16

    o.oBounciness = 30

    o.oBuoyancy = 2

    o.oFriction = 1

    o.oHealth = 0
    obj_set_billboard(o)

    network_init_object(o, true, { "oVelY", "oHealth" })
end

local fireBouncyness = 20

---@param o Object
function bhv_fire_flower_fire_loop(o)
    o.oAnimState = o.oAnimState + 2

    o.oInteractStatus = 0

    o.oForwardVel = 27

    local objStep = object_step()

    if objStep & OBJ_COL_FLAG_GROUNDED == 1 then
        o.oVelY = fireBouncyness
        o.oHealth = o.oHealth + 1
    end

    if o.oHealth >= 4 then
        obj_mark_for_deletion(o)
    end
end

bhvFireFlowerFire = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_fire_flower_fire_init, bhv_fire_flower_fire_loop)

function cloudbox(o)
    o.oCollisionDistance = 1400
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    --o.globalPlayerIndex = (o.parentObj.globalPlayerIndex)
    --djui_chat_message_create(tostring(o.oTimer))
    if o.oTimer < 15 then
        o.header.gfx.scale.x = o.header.gfx.scale.x + 0.097;
        o.header.gfx.scale.y = o.header.gfx.scale.x;
        o.header.gfx.scale.z = o.header.gfx.scale.x;
        o.oFaceAngleYaw = o.oFaceAngleYaw + 0x0800;
    else
        if cur_obj_wait_then_blink(360, 20) ~= 0 or cur_obj_is_mario_ground_pounding_platform() == 1 then
            spawn_mist_particles_variable(0, -40.0, 46.0)
            mark_obj_for_deletion(o)
        else
            load_object_collision_model()
        end
    end
end

-- Function to check the cloud count
function checkCloudCount()
    local gMarioState = gMarioStates[0]
    local gMarioObject = gMarioState.marioObj
    local o

    if cloudcount > obj_count_objects_with_behavior_id(bhvCloudFollow) then
        o = spawn_object(gMarioObject, MODEL_CLOUDSPAWN, bhvCloudFollow)
        o.oHiddenBlueCoinSwitch = gMarioObject.oHiddenBlueCoinSwitch
        gMarioObject.oHiddenBlueCoinSwitch = o
        obj_scale(o, 0.3)
    end
end

-- Function for cloud following
local gapclose = 0.1
function cloudfollowing(o)
    local gMarioState = gMarioStates[0]
    local gMarioObject = gMarioState.marioObj
    --o.globalPlayerIndex = (o.parentObj.globalPlayerIndex)
    --obj_set_billboard(o)
    local x, y, z
    if gMarioObject.oHiddenBlueCoinSwitch == o then
        y = gMarioState.pos.y + 150
        x = gMarioState.pos.x + sins(gMarioState.faceAngle.y) * 50
        z = gMarioState.pos.z + coss(gMarioState.faceAngle.y) * 50
    elseif gMarioObject.oHiddenBlueCoinSwitch and (gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch == o) then
        y = gMarioObject.oHiddenBlueCoinSwitch.oPosY + 10
        x = gMarioObject.oHiddenBlueCoinSwitch.oPosX + sins(gMarioObject.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
        z = gMarioObject.oHiddenBlueCoinSwitch.oPosZ + coss(gMarioObject.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
    elseif gMarioObject.oHiddenBlueCoinSwitch and (gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch) then
        y = gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oPosY + 10
        x = gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oPosX +
            sins(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
        z = gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oPosZ +
            coss(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
    end
    o.oPosX = o.oPosX + (x - o.oPosX) * gapclose
    o.oPosY = o.oPosY + (y - o.oPosY) * gapclose
    o.oPosZ = o.oPosZ + (z - o.oPosZ) * gapclose
end

bhvBeeShroom = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_beesuit_init, bhv_beesuit_loop)
bhvCloudFlower = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_cloudflower_init, bhv_cloudflower_loop)
bhvRainbowStar = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_rainbow_star_init, bhv_rainbow_star_loop)
bhvSpringShroom = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_spring_mushroom_init, bhv_spring_mushroom_loop)
---bhvFireFlower
hook_behavior(id_bhvMetalCap, OBJ_LIST_GENACTOR, true, bhv_fire_flower_init, bhv_fire_flower_loop)
---bhvIceFlower
hook_behavior(id_bhvWingCap, OBJ_LIST_GENACTOR, true, bhv_ice_flower_init, bhv_ice_flower_loop)


---@param m MarioState
function bee_update(m)
    if m.playerIndex ~= 0 then return end
    if gPlayerSyncTable[0].powerup ~= BEE then return end
    if m.vel.y <= 0 and m.action & ACT_FLAG_AIR ~= 0 and gPlayerSyncTable[0].energyBar > 0 and ( --[[m.action ~= ACT_FAKE_FREEFALL and m.action ~= ACT_WALL_SLIDE and]] not common_blacklisted_actions[m.action]) then
        if m.controller.buttonDown & A_BUTTON ~= 0 then
            if m.action == ACT_GROUND_POUND then
                if m.vel.y < -50 then
                    set_mario_action(m, ACT_FLY, 0)
                end
            else
                set_mario_action(m, ACT_FLY, 0)
            end
        end
    end
    if m.action & ACT_FLAG_AIR == 0 then
        gPlayerSyncTable[0].energyBar = 72
    end
end

MODEL_CLOUDSPAWN = smlua_model_util_get_id("cloudspawn")

function cloud_powerup(m)
    checkCloudCount()
    --djui_chat_message_create(tostring(cloudcount))
    if m.playerIndex ~= 0 then return end
    local gMarioObject = m.marioObj
    --djui_chat_message_create(tostring(gMarioObject.oHiddenBlueCoinSwitch))
    if gPlayerSyncTable[0].powerup == CLOUD then
        local a
        if (m.action & ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION) ~= 0 then
            if (m.action & ACT_FLAG_INVULNERABLE) == 0 then
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    if m.pos.y > m.floorHeight + 72 then
                        if (m.action ~= ACT_WALL_KICK_AIR) or (m.actionTimer > 1) then
                            if (m.action ~= ACT_FORWARD_ROLLOUT) and (m.action ~= ACT_FLYING_TRIPLE_JUMP) then
                                if cloudcount > 0 then
                                    spawn_sync_object(bhvCloudSpawn, MODEL_CLOUDSPAWN, m.pos.x,
                                        m.pos.y - 130, m.pos.z, nil)

                                    spawn_mist_particles_variable(0, -40.0, 46.0)
                                    m.vel.y = 30
                                    m.forwardVel = 0
                                    --[[gMarioState.inertia[1] = 0
                                    gMarioState.inertia[2] = 0
                                    gMarioState.inertia[3] = 0]]
                                    set_mario_action(m, ACT_FORWARD_ROLLOUT, 0)
                                    cloudcount = cloudcount - 1
                                    if cloudcount == 0 then
                                        --gPlayerSyncTable[0].powerup = NORMAL not in last impacT!!!!
                                        obj_mark_for_deletion(gMarioObject.oHiddenBlueCoinSwitch)
                                    elseif cloudcount == 1 then
                                        obj_mark_for_deletion(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch)
                                    elseif cloudcount == 2 then
                                        obj_mark_for_deletion(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch
                                            .oHiddenBlueCoinSwitch)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function act_fly(m)
    if m.controller.buttonPressed & B_BUTTON ~= 0 then
        m.marioObj.header.gfx.angle.y = m.faceAngle.y
        return set_mario_action(m, ACT_DIVE, 0)
    end

    if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
        m.vel.y = 0
        m.marioObj.header.gfx.angle.y = m.faceAngle.y
        return set_mario_action(m, ACT_GROUND_POUND, 0)
    end

    if m.controller.buttonDown & A_BUTTON ~= 0 and gPlayerSyncTable[0].energyBar > 0 then
        m.vel.y = 10
        gPlayerSyncTable[0].energyBar = gPlayerSyncTable[0].energyBar - 1
    end

    common_air_action_step(m, ACT_JUMP_LAND, MARIO_ANIM_SLIDEFLIP,
        AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG)
    set_anim_to_frame(m, m.marioObj.header.gfx.animInfo.curAnim.loopEnd)
    m.marioObj.header.gfx.angle.y = m.faceAngle.y - 0x8000
end

--best one yet
--[[            i = i + 20
                j = gt / 50
                local r = math.sin(0.00 + i / 15 + gMarioObject.oTimer / 2) * 127 + 127
                local g = math.sin(0.33 + i / 33 + j) * 127 + 127
                local b = math.sin(0.66 + i / 77 + j) * 127 + 127]]

local rainbow_acts = {
    [ACT_JUMP] = true,
    [ACT_HOLD_JUMP] = true,
    [ACT_DOUBLE_JUMP] = true,
    [ACT_TRIPLE_JUMP] = true,
}

---@param m MarioState
function rainbow_powerup(m)
    if m.playerIndex ~= 0 then return end
    local gMarioObject = m.marioObj

    local gt = get_global_timer()
    --djui_chat_message_create(tostring(gMarioObject.oHiddenBlueCoinSwitch))
    if gPlayerSyncTable[0].powerup == RAINBOW then
        if not rainbow_music then
            audio_stream_set_looping(audio_rainbowmario, true)
            audio_stream_play(audio_rainbowmario, true, 1.2)
            rainbow_music = true
        end

        rainbow_timer = rainbow_timer + 1
        set_background_music(0, 0, 0)

        m.particleFlags = PARTICLE_SPARKLES

        if rainbow_acts[m.action] then
            m.action = ACT_SPECIAL_TRIPLE_JUMP
        end


        if m.action == ACT_WALKING then
            m.forwardVel = 45
        end
        ---@type PlayerPart
        for part = PANTS, PLAYER_PART_MAX - 1 do
            for i = 0, 255 do
                i = i + 20
                j = gt / 50
                local r = math.sin(0.00 + i / 15 + gMarioObject.oTimer / 2) * 127 + 127
                local g = math.sin(0.33 + i / 33 + j) * 127 + 127
                local b = math.sin(0.66 + i / 77 + j) * 127 + 127
                network_player_set_override_palette_color(gNetworkPlayers[0], part, { r = r, g = g, b = b })
            end
        end

        if rainbow_timer > (20 * 30) then
            gPlayerSyncTable[0].powerup = NORMAL
            network_player_reset_override_palette(gNetworkPlayers[0])
            rainbow_timer = 0
            rainbow_music = false
            audio_stream_stop(audio_rainbowmario)
            set_background_music(0, savedBGM, 0)
        end
    else
        savedBGM = get_current_background_music()
    end
end

local numFlamesThrown = 0
local flameTimer = 0

---@param m MarioState
function ice_fire_flower_powerup(m)
    if m.playerIndex == 0 then
        local gMarioObject = m.marioObj
        if gPlayerSyncTable[0].powerup == FIRE or gPlayerSyncTable[0].powerup == ICE then
            network_player_set_override_palette_color(gNetworkPlayers[0], SHIRT,
                gPlayerSyncTable[0].powerup == FIRE and { r = 255, g = 255, b = 255 } or { r = 0, g = 255, b = 255 })
            network_player_set_override_palette_color(gNetworkPlayers[0], CAP,
                gPlayerSyncTable[0].powerup == FIRE and { r = 255, g = 255, b = 255 } or { r = 0, g = 255, b = 255 })
            network_player_set_override_palette_color(gNetworkPlayers[0], PANTS,
                network_player_get_palette_color(gNetworkPlayers[0], SHIRT))
            if m.controller.buttonPressed & B_BUTTON ~= 0 and numFlamesThrown ~= 3 then
                if m.action & ACT_FLAG_STATIONARY ~= 0 or m.action & ACT_FLAG_MOVING ~= 0 or rainbow_acts[m.action] or m.action == ACT_JUMP_KICK or m.action == ACT_MOVE_PUNCHING then
                    spawn_sync_object(bhvFireFlowerFire,
                        gPlayerSyncTable[0].powerup == FIRE and E_MODEL_RED_FLAME or E_MODEL_BLUE_FLAME,
                        m.pos.x + (sins(m.faceAngle.y) * 170),
                        m.pos.y,
                        m.pos.z + (coss(m.faceAngle.y) * 170),

                        ---@param f Object
                        function(f)
                            f.oMoveAngleYaw = m.faceAngle.y
                            f.oGraphYOffset = 64
                            f.oVelY = fireBouncyness
                            obj_scale(f, 5)
                        end)

                    numFlamesThrown = numFlamesThrown + 1
                end
            end
        end

        if numFlamesThrown > 0 then
            flameTimer = flameTimer + 1
            if flameTimer > 100 then
                numFlamesThrown = 0
                flameTimer = 0
            end
        end
    end

    if gPlayerSyncTable[m.playerIndex].powerup == FIRE or gPlayerSyncTable[m.playerIndex].powerup == ICE then
        network_player_set_override_palette_color(gNetworkPlayers[m.playerIndex], SHIRT,
            gPlayerSyncTable[m.playerIndex].powerup == FIRE and { r = 255, g = 255, b = 255 } or
            { r = 0, g = 255, b = 255 })
        network_player_set_override_palette_color(gNetworkPlayers[m.playerIndex], CAP,
        gPlayerSyncTable[m.playerIndex].powerup == FIRE and { r = 255, g = 255, b = 255 } or
            { r = 0, g = 255, b = 255 })
        network_player_set_override_palette_color(gNetworkPlayers[m.playerIndex], PANTS,
            network_player_get_palette_color(gNetworkPlayers[m.playerIndex], SHIRT))
    end
end

local bigBonucer = false
local bigBouncerTime = 0

---@param m MarioState
function spring_powerup(m)
    if m.playerIndex ~= 0 then return end
    local gMarioObject = m.marioObj
    if gPlayerSyncTable[0].powerup == SPRING then
        if m.action == ACT_GROUND_POUND_LAND then
            m.action = ACT_DOUBLE_JUMP
            m.faceAngle.y = approach_s32(m.faceAngle.y, m.intendedYaw, 0x700, 0x700)
            bigBonucer = true
        else
            if m.pos.y == m.floorHeight then
                m.action = ACT_DOUBLE_JUMP
                m.faceAngle.y = approach_s32(m.faceAngle.y, m.intendedYaw, 0x700, 0x700)

                m.vel.y = 80
            end
        end
        --[[if m.pos.y == m.floorHeight then
            m.action = ACT_DOUBLE_JUMP
            m.faceAngle.y = approach_s32(m.faceAngle.y, m.intendedYaw, 0x700, 0x700)

            m.vel.y = 40
        end]]

        if bigBonucer then
            m.vel.y = m.vel.y + 20
            bigBouncerTime = bigBouncerTime + 1
            if bigBouncerTime > 45 then
                bigBonucer = false
                bigBouncerTime = 0
            end
        end
        if m.action == ACT_STAR_DANCE_EXIT or m.action == ACT_STAR_DANCE_NO_EXIT or m.action == ACT_STAR_DANCE_WATER or m.action == ACT_FALL_AFTER_STAR_GRAB then
            gPlayerSyncTable[0].powerup = NORMAL
        end
    end
end

hook_mario_action(ACT_FLY, { every_frame = act_fly })

hook_event(HOOK_MARIO_UPDATE, bee_update)
hook_event(HOOK_MARIO_UPDATE, spring_powerup)
hook_event(HOOK_MARIO_UPDATE, rainbow_powerup)
hook_event(HOOK_MARIO_UPDATE, ice_fire_flower_powerup)
hook_event(HOOK_MARIO_UPDATE, cloud_powerup)
