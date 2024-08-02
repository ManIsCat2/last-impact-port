-- Placed here to remove the need of setting models for every powerup
-- Uses the definitive model check

-- Models

E_MODEL_BEE_MARIO = smlua_model_util_get_id("bee_mario_geo")

-- Powerups enum

NORMAL = 0
BEE = 1

characterPowerupModels = {
    [CT_MARIO] = { bee = E_MODEL_BEE_MARIO, cat = nil, },
    [CT_LUIGI] = { bee = E_MODEL_BEE_MARIO, cat = nil, },
    [CT_TOAD] = { bee = E_MODEL_BEE_MARIO, cat = nil, },
    [CT_WARIO] = { bee = E_MODEL_BEE_MARIO, cat = nil, },
    [CT_WALUIGI] = { bee = E_MODEL_BEE_MARIO, cat = nil, },
}

-- Powerups are a PlayerSyncTable by the way.

-- Powerup States, to add more powerups here, you must first add them to the enum and assign a number
function get_character_model(m)
    if m.playerIndex ~= 0 then return end
    CPM = characterPowerupModels[m.character.type] -- To get the model easily
    CPMM = characterPowerupModels[CT_MARIO]        -- To get Mario's model easily
    powerupStates = {
        [NORMAL] = { modelId = nil },
        [BEE] = { modelId = CPM.bee and CPM.bee or CPMM.bee },
    }
end

hook_event(HOOK_MARIO_UPDATE, get_character_model)

-- Powerup Model Functions --

function powerups()
    gPlayerSyncTable[0].modelId = powerupStates[gPlayerSyncTable[0].powerup].modelId
end

hook_event(HOOK_OBJECT_SET_MODEL, function(o)
    if obj_has_behavior_id(o, id_bhvMario) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        if gPlayerSyncTable[i].modelId ~= nil and obj_has_model_extended(o, gPlayerSyncTable[i].modelId) == 0 then
            obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        end

        if gPlayerSyncTable[i].powerup == nil then gPlayerSyncTable[0].powerup = NORMAL end
    end
end)

-- Resets the player stats when leaving a level or dying

function on_death_warp()
    gPlayerSyncTable[0].powerup = NORMAL
end

-- Removes the player's powerup on damage

function damage_check(m)
    --djui_chat_message_create(tostring(cloudcount))
    if m.playerIndex ~= 0 then return end
    if m.hurtCounter > 0 or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_JUMP then
        gPlayerSyncTable[0].powerup = NORMAL
    end
end

hook_event(HOOK_UPDATE, powerups)
hook_event(HOOK_MARIO_UPDATE, damage_check)
hook_event(HOOK_ON_DEATH, on_death_warp)
hook_event(HOOK_ON_WARP, on_death_warp)

-- Actual powerups

-- Bee Powerup --

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
function bhv_beesuit_loop(obj)
    object_step()
    for i = 0, 15 do
        local m = gMarioStates[i]
        if obj.oAction == 0 then
            if obj_check_hitbox_overlap(m.marioObj, obj) then
                obj.oAction = 1
                cur_obj_hide()
                obj.oTimer = 0
                cur_obj_play_sound_2(SOUND_MENU_EXIT_PIPE)
                gPlayerSyncTable[i].powerup = BEE
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
            obj.hitboxRadius = 30
            obj.hitboxHeight = 30
        end
    end
end

bhvBeeShroom = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_beesuit_init, bhv_beesuit_loop)

xMid = djui_hud_get_screen_width() / 2

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

hook_mario_action(ACT_FLY, { every_frame = act_fly })

hook_event(HOOK_MARIO_UPDATE, bee_update)