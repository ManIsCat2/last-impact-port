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
#include "areas/3/custom.model.inc.h"
#include "levels/ddd/header.h"
extern u8 _ddd_segment_ESegmentRomStart[]; 
extern u8 _ddd_segment_ESegmentRomEnd[];
const LevelScript level_ddd_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _ddd_segment_ESegmentRomStart, _ddd_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom27025408_skybox_mio0SegmentRomStart,_SkyboxCustom27025408_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group1_mio0SegmentRomStart,_group1_mio0SegmentRomEnd),
LOAD_RAW(12,_group1_geoSegmentRomStart,_group1_geoSegmentRomEnd),
LOAD_MIO0(6,_group17_mio0SegmentRomStart,_group17_mio0SegmentRomEnd),
LOAD_RAW(13,_group17_geoSegmentRomStart,_group17_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(53, bee_shroom_geo),
LOAD_MODEL_FROM_GEO(54, bee_npc_geo),
LOAD_MODEL_FROM_GEO(56, queen_bee_geo),
LOAD_MODEL_FROM_GEO(57, lilypad_geo),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_2),
JUMP_LINK(script_func_global_18),
JUMP_LINK(local_area_ddd_1_),
JUMP_LINK(local_area_ddd_2_),
JUMP_LINK(local_area_ddd_3_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_ddd_1_[] = {
AREA(1,Geo_ddd_1_0x2c21700),
TERRAIN(col_ddd_1_0xe053158),
SET_BACKGROUND_MUSIC(0,54),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ddd_1_),
JUMP_LINK(local_warps_ddd_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ddd_1_[] = {
OBJECT_WITH_ACTS(0,6798,150,-2616,0,-90,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,1674,-70,5447,0,-186,0,0x10000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,1599,147,6252,0,-153,0,0x20010000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-6612,1024,-3351,0,107,0,0xd0000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(0,1980,768,6618,0,-151,0,0xe0000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(0,-1550,1049,-4211,0,102,0,0x20000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-1778,2054,-4232,0,0,0,0x20000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-1704,1282,-4265,0,0,0,(160 << 16), bhvPoleGrabbing,63),
OBJECT_WITH_ACTS(0,-856,1861,3242,0,0,0,(160 << 16), bhvPoleGrabbing,63),
OBJECT_WITH_ACTS(0,-1017,1918,2681,0,0,0,(160 << 16), bhvPoleGrabbing,63),
OBJECT_WITH_ACTS(0,-1141,1984,2084,0,0,0,(160 << 16), bhvPoleGrabbing,63),
OBJECT_WITH_ACTS(53,-2684,-132,-1942,0,0,0,0x0,bhvBeeShroom,63),
OBJECT_WITH_ACTS(122,-12292,161,-7500,0,0,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(54,6129,524,-1175,0,-163,0,0x7d0000,bhvBeeNPC,63),
OBJECT_WITH_ACTS(101,-4058,934,1933,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,-5000,864,1146,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,-5104,869,2292,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,-3906,967,3177,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(54,-1678,2116,2037,0,87,0,0x2000000,bhvBeeNPC,63),
OBJECT_WITH_ACTS(54,-1493,299,-3085,0,134,0,0x3000000,bhvBeeNPC,63),
OBJECT_WITH_ACTS(54,3299,480,-5581,0,0,0,0x810000,bhvBeeNPC,63),
OBJECT_WITH_ACTS(56,3088,2431,49,0,-56,0,0x850000, bhvBetaBowserAnchor,63),
OBJECT_WITH_ACTS(54,2456,2402,-269,0,0,0,0x890000,bhvBeeNPC,63),
OBJECT_WITH_ACTS(57,-4213,44,-5675,0,61,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-5481,44,-7461,0,-200,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-2651,44,-7913,0,-99,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-4060,44,-7213,0,134,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-1621,44,-8341,0,-165,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-2904,44,-6518,0,9,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-203,44,-8206,0,0,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,574,44,-7058,0,-74,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-574,44,-6585,0,66,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(57,-1418,44,-7126,0,124,0,0x0,bhvLilyPad,63),
OBJECT_WITH_ACTS(0,-236,569,-2161,0,0,0,0x3000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-2660,415,-7908,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-4051,416,-7191,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,576,416,-7048,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-4211,415,-5667,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,1867,933,2418,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,1897,949,-2540,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,3162,1238,5381,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,3083,1296,-6282,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(0,1367,-151,814,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,5437,-4,-4271,0,55,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,1737,1398,4934,0,82,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(192,2865,-60,1010,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(0,5323,1261,3366,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,2546,1858,1861,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,5484,319,-5439,0,61,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-2694,-81,-1941,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,4390,285,-1216,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-3951,659,-12191,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-6988,722,-11478,0,16,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(212,461,2646,4521,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,1435,145,-2064,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,0,0,0,0,0,0x8000000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(0,5322,-63,3358,0,0,0,0x20000, bhvCoinFormation,63),
RETURN()
};
const LevelScript local_warps_ddd_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,6,1,201,0),
WARP_NODE(241,6,1,217,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,23,2,10,0),
WARP_NODE(2,23,3,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,10,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_ddd_2_[] = {
AREA(2,Geo_ddd_2_0x2c21600),
TERRAIN(col_ddd_2_0xe09d9e0),
SET_BACKGROUND_MUSIC(0,9),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ddd_2_),
JUMP_LINK(local_warps_ddd_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ddd_2_[] = {
OBJECT_WITH_ACTS(0,16473,414,-17284,0,180,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,16489,678,-16537,0,0,0,0x200a0000, bhvWarp,63),
OBJECT_WITH_ACTS(53,15040,488,-17607,0,0,0,0x0,bhvBeeShroom,63),
OBJECT_WITH_ACTS(212,-14045,8470,19543,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,-11,-267,1503,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(54,15044,576,-17919,0,0,0,0x1000000,bhvBeeNPC,63),
OBJECT_WITH_ACTS(0,5659,528,8853,0,0,0,0x0,Bhv_Custom_0x130029d4,63),
OBJECT_WITH_ACTS(0,5659,768,8853,0,0,0,0x0,Bhv_Custom_0x130029d4,63),
OBJECT_WITH_ACTS(0,5659,1034,8853,0,0,0,0x0,Bhv_Custom_0x130029d4,63),
OBJECT_WITH_ACTS(0,5923,518,8671,0,0,0,0x0,Bhv_Custom_0x130029d4,63),
OBJECT_WITH_ACTS(0,5923,779,8671,0,0,0,0x0,Bhv_Custom_0x130029d4,63),
OBJECT_WITH_ACTS(0,5923,1015,8671,0,0,0,0x0,Bhv_Custom_0x130029d4,63),
RETURN()
};
const LevelScript local_warps_ddd_2_[] = {
WARP_NODE(240,6,1,201,0),
WARP_NODE(241,6,1,217,0),
WARP_NODE(10,23,1,1,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
RETURN()
};
const LevelScript local_area_ddd_3_[] = {
AREA(3,Geo_ddd_3_0x2c21500),
TERRAIN(col_ddd_3_0xe0c4ee8),
SET_BACKGROUND_MUSIC(0,45),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ddd_3_),
JUMP_LINK(local_warps_ddd_3_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ddd_3_[] = {
OBJECT_WITH_ACTS(0,743,-72,-2570,0,0,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,938,-738,-2967,0,0,0,0x200a0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,888,-2131,-3027,0,0,0,0x0, bhvHeaveHoThrowMario,63),
OBJECT_WITH_ACTS(MODEL_SILVER_STAR,-5949,1549,5509,0,0,0,0x4000000, id_bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(MODEL_SILVER_STAR,-6572,560,1475,0,0,0,0x4000000, id_bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(MODEL_SILVER_STAR,-2968,1504,4832,0,0,0,0x4000000, id_bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(MODEL_SILVER_STAR,-7336,1504,5061,0,0,0,0x4000000, id_bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(MODEL_SILVER_STAR,-4459,767,3740,0,0,0,0x4000000, id_bhvHiddenStarTrigger,63),

OBJECT_WITH_ACTS(0,-800,0,-424,0,0,0,0x4000000, bhvHiddenStar,63),
OBJECT_WITH_ACTS(58,-1017,376,-2865,0,0,0,0x0, bhvUnusedFakeStar,63),
OBJECT_WITH_ACTS(0,-828,-174,-433,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(124,-962,378,-2555,0,0,0,0x220000, bhvMessagePanel,63),
OBJECT_WITH_ACTS(101,1134,-257,-1745,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,-4712,614,3694,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,-6166,313,1105,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,-1658,-173,-349,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,-6518,1056,4424,0,0,0,0x0, bhvScuttlebug,63),
//OBJECT_WITH_ACTS(60,4112,-191,-1081,0,-26,0,0x0, bhvCastleFloorTrap,63),
OBJECT_WITH_ACTS(0,4897,-128,-2112,0,0,0,0x20000, bhvCoinFormation,63),
RETURN()
};
const LevelScript local_warps_ddd_3_[] = {
WARP_NODE(240,6,1,201,0),
WARP_NODE(241,6,1,217,0),
WARP_NODE(10,23,1,2,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
RETURN()
};
