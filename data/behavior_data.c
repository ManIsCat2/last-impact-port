const BehaviorScript bhvCloudSpawn[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    ADD_FLOAT(oPosY, -80),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    LOAD_COLLISION_DATA(cloudspawn_collision),
    BEGIN_LOOP(),
    CALL_NATIVE(cloudbox),
    END_LOOP(),
};

const BehaviorScript bhvCloudFollow[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    BILLBOARD(),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    BEGIN_LOOP(),
    CALL_NATIVE(cloudfollowing),
    END_LOOP(),
};

const BehaviorScript bhvFlipswitch_Panel_StarSpawn_MOP[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    CALL_NATIVE(bhv_flipswitch_panel_starspawn_init),
    BEGIN_LOOP(),
    CALL_NATIVE(bhv_flipswitch_panel_starspawn_loop),
    END_LOOP(),
};

const BehaviorScript bhvFlipswitch_Panel_MOP[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    LOAD_COLLISION_DATA(col_Flipswitch_Panel_MOP_0x7daf78),
    SET_FLOAT(oCollisionDistance, 1024),
    CALL_NATIVE(bhv_flipswitch_panel_init),
    BEGIN_LOOP(),
    CALL_NATIVE(bhv_flipswitch_panel_loop),
    CALL_NATIVE(load_object_collision_model),
    END_LOOP(),
};

const BehaviorScript bhvAirrocks[] = {
    BEGIN(OBJ_LIST_DEFAULT),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    BEGIN_LOOP(),
    CALL_NATIVE(bhv_air_rocks),
    END_LOOP(),
};
