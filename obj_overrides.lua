-- rianobow thwomp

function bhv_thwomp_custom(o)
    o.collisionData = smlua_collision_util_get("rainbow_thwomp_collision")
    if o.oAction >= 2 then
        o.oAnimState = 1
    else
        o.oAnimState = 0
    end
end

hook_behavior(id_bhvThwomp, OBJ_LIST_SURFACE, false, nil, bhv_thwomp_custom)

-- toad that has a expire date when you get 15 stars

---@param o Object
function bhv_toad_custom_loop(o)
    if ((o.oBehParams >> 24) & 0xFF) == DIALOG_054 then
        if get_curr_star_count() >= 15 then
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