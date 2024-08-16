-- rianobow thwomp

local function bhv_thwomp_custom(o)
    o.collisionData = smlua_collision_util_get("rainbow_thwomp_collision")
    o.oCollisionDistance = 1500
    if o.oAction >= 2 then
        o.oAnimState = 1
    else
        o.oAnimState = 0
    end
end

hook_behavior(id_bhvThwomp, OBJ_LIST_SURFACE, false, nil, bhv_thwomp_custom)

-- toad that has a expire date when you get the amount of stars needed

local sDisappearToadsInfo = {
    [DIALOG_054] = 15,
    [DIALOG_019] = 20,
    [DIALOG_053] = 4,
}

---@param o Object
local function bhv_toad_custom_loop(o)
    local oBehParams1stByte = ((o.oBehParams >> 24) & 0xFF)
    if sDisappearToadsInfo[oBehParams1stByte] then
        if get_curr_star_count() >= sDisappearToadsInfo[oBehParams1stByte] then
            obj_mark_for_deletion(o)
        end
    end
end

hook_behavior(id_bhvToadMessage, OBJ_LIST_GENACTOR, false, nil, bhv_toad_custom_loop)

--STRAsleect 
local MODEL_STARSELECT = smlua_model_util_get_id("starselect_geo")

local function act_selector_init(o)
    obj_set_model_extended(o, MODEL_STARSELECT)
end

hook_behavior(id_bhvActSelector, OBJ_LIST_DEFAULT, false, act_selector_init, nil)