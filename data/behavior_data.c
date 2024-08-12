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