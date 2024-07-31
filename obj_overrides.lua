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