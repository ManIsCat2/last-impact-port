#include <ultra64.h>
#include "sm64.h"
#include "behavior_data.h"
#include "model_ids.h"
#include "seq_ids.h"
#include "dialog_ids.h"
#include "segment_symbols.h"
#include "level_commands.h"
#include "game/level_update.h"
#include "levels/scripts.h"
#include "actors/common1.h"
#include "make_const_nonconst.h"

#include "areas/1/custom.model.inc.h"
#include "areas/2/custom.model.inc.h"
#include "levels/wdw/header.h"
extern u8 _wdw_segment_ESegmentRomStart[]; 
extern u8 _wdw_segment_ESegmentRomEnd[];
const LevelScript level_wdw_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _wdw_segment_ESegmentRomStart, _wdw_segment_ESegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group4_mio0SegmentRomStart,_group4_mio0SegmentRomEnd),
LOAD_RAW(12,_group4_geoSegmentRomStart,_group4_geoSegmentRomEnd),
LOAD_MIO0(6,_group15_mio0SegmentRomStart,_group15_mio0SegmentRomEnd),
LOAD_RAW(13,_group15_geoSegmentRomStart,_group15_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(22,wdw_mouth_cage_geo),
LOAD_MODEL_FROM_GEO(23,wdw_cage_opener_geo),
// LOAD_MODEL_FROM_GEO(24,0x19001a40),
// LOAD_MODEL_FROM_GEO(25,0x19001b60),
// LOAD_MODEL_FROM_GEO(27,0x19001b80),
LOAD_MODEL_FROM_GEO(29, haunted_door_geo),
LOAD_MODEL_FROM_GEO(31,mouth_water_thing_geo),
// LOAD_MODEL_FROM_GEO(32,0x19001bc0),
// LOAD_MODEL_FROM_GEO(34,0x19001be0),
LOAD_MODEL_FROM_GEO(35,blooper_geo),
// LOAD_MODEL_FROM_GEO(36,0x19001d00),
// LOAD_MODEL_FROM_GEO(37,0x19001f00),
// LOAD_MODEL_FROM_GEO(38,0x19001f80),
// LOAD_MODEL_FROM_GEO(84,0x05008d14),
// LOAD_MODEL_FROM_DL(87,0x05013cb8,4),
// LOAD_MODEL_FROM_DL(132,0x08025f08,4),
// LOAD_MODEL_FROM_GEO(133,0x007e0000),
// LOAD_MODEL_FROM_DL(158,0x0302c8a0,4),
// LOAD_MODEL_FROM_DL(159,0x0302bcd0,4),
// LOAD_MODEL_FROM_DL(161,0x0301cb00,4),
// LOAD_MODEL_FROM_DL(164,0x04032a18,4),
// LOAD_MODEL_FROM_DL(201,0x080048e0,4),
// LOAD_MODEL_FROM_DL(218,0x08024bb8,4),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_5),
JUMP_LINK(script_func_global_16),
JUMP_LINK(local_area_wdw_1_),
JUMP_LINK(local_area_wdw_2_),
FREE_LEVEL_POOL(),
MARIO_POS(1,0,0,0,0),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_wdw_1_[] = {
AREA(1,Geo_wdw_1_0x1ba1700),
TERRAIN(col_wdw_1_0xe08e608),
SET_BACKGROUND_MUSIC(0,58),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_wdw_1_),
JUMP_LINK(local_warps_wdw_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_wdw_1_[] = {
OBJECT_WITH_ACTS(0,-1823,-54,-11354,0,0,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,0,2683,0,0,0,0,0x0, Bhv_Custom_0x130030fc,63),
OBJECT_WITH_ACTS(100,4398,-1856,605,0,-98,0,148 << 16, id_bhvParentAndChildRabbit,63),
//start
OBJECT_WITH_ACTS(22,4000,-1900,605,0,0,0,0x000000000, bhvWDWMouthCage,63),
OBJECT_WITH_ACTS(23,-5420,-1804,-1407,0,0,0,0x000000000, bhvWDWMouthCageOpener,63),
//emd
OBJECT_WITH_ACTS(0,-4177,-2887,6093,0,70,0,0x10000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-4903,-2809,5783,0,-14,0,0x20010000, bhvWarp,63),
OBJECT_WITH_ACTS(86,-2585,-3787,-389,0,-265,-127,0x0, bhvWhirlpool,63),
OBJECT_WITH_ACTS(122,-2019,1467,-11763,0,-72,0,0x2000000, bhvStar,63),
OBJECT_WITH_ACTS(0,2558,-3198,-1215,0,0,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(216,-992,-3779,1703,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(216,-1508,-3332,-3827,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(216,-178,-3654,-537,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(216,-3037,-3658,-5089,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(31,-1681,1321,-9363,0,0,0,0x0, bhvMouthWaterThing,63),
OBJECT_WITH_ACTS(216,-571,-3114,-5305,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(216,-3055,-2241,1040,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(216,563,-2387,2182,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(216,2681,-2058,-5456,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(32,-4177,-3723,-89,0,85,0,0x60010000, Bhv_Custom_0x13003368,63),
OBJECT_WITH_ACTS(32,2317,-3038,-5699,0,-85,0,0x25000000, Bhv_Custom_0x13003368,63),
OBJECT_WITH_ACTS(32,-3125,-3700,781,0,180,0,0x20020000, Bhv_Custom_0x13003368,63),
OBJECT_WITH_ACTS(32,850,-3787,2223,0,90,0,0x28030000, Bhv_Custom_0x13003368,63),
OBJECT_WITH_ACTS(32,-1983,-3740,-6315,0,19,0,0x30040000, Bhv_Custom_0x13003368,63),
OBJECT_WITH_ACTS(32,3183,-3723,-927,0,180,0,0x28050000, Bhv_Custom_0x13003368,63),
OBJECT_WITH_ACTS(0,-1707,-129,-10204,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-2041,-3872,1002,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-891,-3304,4007,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,2968,-2465,631,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-4479,-2882,7753,0,-21,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-1583,-2955,9688,0,72,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-4479,-2868,12125,0,-19,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-2854,-2783,15250,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,146,-3932,-3563,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-4958,-3067,-3833,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(35,-250,-3476,1809,0,0,0,0x0, bhvBlooper,63),
OBJECT_WITH_ACTS(35,-1709,-3587,-223,0,0,0,0x0, bhvBlooper,63),
OBJECT_WITH_ACTS(35,-3946,-1586,-769,0,0,0,0x0, bhvBlooper,63),
OBJECT_WITH_ACTS(35,1798,-3231,-4699,0,0,0,0x0, bhvBlooper,63),
OBJECT_WITH_ACTS(35,-531,-3331,-3010,0,0,0,0x0, bhvBlooper,63),
OBJECT_WITH_ACTS(35,-1543,80,-9558,0,0,0,0x0, bhvBlooper,63),
OBJECT_WITH_ACTS(36,-3191,-2780,16070,0,159,0,0x950000, Bhv_Custom_0x130033a4,63),
OBJECT_WITH_ACTS(144,-2986,-2774,15809,0,0,0,0x0, Bhv_Custom_0x13002364,63),
OBJECT_WITH_ACTS(37,2853,-1497,-6599,0,-238,0,0x0, Bhv_Custom_0x130033c0,63),
OBJECT_WITH_ACTS(37,3042,-1754,-6227,0,-250,0,0x0, Bhv_Custom_0x130033c0,63),
OBJECT_WITH_ACTS(37,3396,-1815,-5207,0,-249,0,0x0, Bhv_Custom_0x130033c0,63),
OBJECT_WITH_ACTS(37,3553,-1865,-4580,0,-256,0,0x0, Bhv_Custom_0x130033c0,63),
OBJECT_WITH_ACTS(37,3659,-1888,-3946,0,-259,0,0x0, Bhv_Custom_0x130033c0,63),
OBJECT_WITH_ACTS(38,2692,-3424,-3871,0,-38,0,0x10000, Bhv_Custom_0x130033dc,63),
OBJECT_WITH_ACTS(0,0,0,0,0,0,0,0xa000000, bhvBetaChestLid,63),
RETURN()
};
const LevelScript local_warps_wdw_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,225,0),
WARP_NODE(241,26,1,209,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,11,2,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,36,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_wdw_2_[] = {
AREA(2,Geo_wdw_2_0x1ba1600),
TERRAIN(col_wdw_2_0x7018350),
SET_BACKGROUND_MUSIC(0,0),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_wdw_2_),
JUMP_LINK(local_warps_wdw_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_wdw_2_[] = {
OBJECT_WITH_ACTS(0,0,0,-6,0,180,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,3,88,485,0,0,0,0x180a0000, bhvWarp,63),
OBJECT_WITH_ACTS(24,580,109,-1670,0,0,0,0x50000, bhvSignOnWall,63),
OBJECT_WITH_ACTS(24,90,109,-1670,0,0,0,0x40000, bhvSignOnWall,63),
OBJECT_WITH_ACTS(24,580,250,-2170,0,0,0,0x20000, bhvSignOnWall,63),
OBJECT_WITH_ACTS(24,90,250,-2170,0,0,0,0x10000, bhvSignOnWall,63),
OBJECT_WITH_ACTS(24,-400,109,-1670,0,0,0,0x30000, bhvSignOnWall,63),
OBJECT_WITH_ACTS(24,-400,250,-2170,0,0,0,0x0, bhvSignOnWall,63),
OBJECT_WITH_ACTS(25,-31,0,-482,0,0,0,0x0, Bhv_Custom_0x13003338,63),
RETURN()
};
const LevelScript local_warps_wdw_2_[] = {
WARP_NODE(240,26,1,225,0),
WARP_NODE(241,26,1,209,0),
WARP_NODE(10,11,1,1,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(5,9,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
