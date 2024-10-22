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
#include "levels/totwc/header.h"
extern u8 _totwc_segment_ESegmentRomStart[]; 
extern u8 _totwc_segment_ESegmentRomEnd[];
#include "levels/bbh/header.h"
const LevelScript level_totwc_entry[] = {
INIT_LEVEL(),
LOAD_MIO0(0x07, _bbh_segment_7SegmentRomStart, _bbh_segment_7SegmentRomEnd),
LOAD_RAW(0x1A, _bbhSegmentRomStart, _bbhSegmentRomEnd),
LOAD_RAW(0x0E, _totwc_segment_ESegmentRomStart, _totwc_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_cloud_floor_skybox_mio0SegmentRomStart,_cloud_floor_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group6_mio0SegmentRomStart,_group6_mio0SegmentRomEnd),
LOAD_RAW(12,_group6_geoSegmentRomStart,_group6_geoSegmentRomEnd),
LOAD_MIO0(4,_group0_mio0SegmentRomStart,_group0_mio0SegmentRomEnd),
LOAD_RAW(17,_group0_geoSegmentRomStart,_group0_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(MODEL_BBH_HAUNTED_DOOR,           haunted_door_geo),
LOAD_MODEL_FROM_GEO(MODEL_BBH_STAIRCASE_STEP,         geo_bbh_0005B0),
LOAD_MODEL_FROM_GEO(MODEL_BBH_TILTING_FLOOR_PLATFORM, geo_bbh_0005C8),
LOAD_MODEL_FROM_GEO(MODEL_BBH_TUMBLING_PLATFORM,      geo_bbh_0005E0),
LOAD_MODEL_FROM_GEO(MODEL_BBH_TUMBLING_PLATFORM_PART, geo_bbh_0005F8),
LOAD_MODEL_FROM_GEO(MODEL_BBH_MOVING_BOOKSHELF,       geo_bbh_000610),
LOAD_MODEL_FROM_GEO(MODEL_BBH_MESH_ELEVATOR,          geo_bbh_000628),
LOAD_MODEL_FROM_GEO(MODEL_BBH_MERRY_GO_ROUND,         geo_bbh_000640),
LOAD_MODEL_FROM_GEO(MODEL_BBH_WOODEN_TOMB,            geo_bbh_000658),
LOAD_MODEL_FROM_GEO(23,air_balloon_geo),
LOAD_MODEL_FROM_GEO(24,totwc_cloudy_platform_geo),
LOAD_MODEL_FROM_GEO(25,cloud2_aircruise_geo),
LOAD_MODEL_FROM_GEO(27,cloud3_aircruise_geo),
// LOAD_MODEL_FROM_GEO(28,0x190014a0),
// LOAD_MODEL_FROM_GEO(29,0x190014c0),
LOAD_MODEL_FROM_GEO(53,totwc_static_cloud_geo),
// LOAD_MODEL_FROM_GEO(54,0x06003be0),
// LOAD_MODEL_FROM_GEO(55,0x060096c0),
LOAD_MODEL_FROM_GEO(56,add_cloud_count_geo),
LOAD_MODEL_FROM_GEO(57,cloud_flower_geo),
// LOAD_MODEL_FROM_DL(84,0x05000840,4),
// LOAD_MODEL_FROM_DL(132,0x08025f08,4),
// LOAD_MODEL_FROM_GEO(133,0x007e0000),
// LOAD_MODEL_FROM_DL(158,0x0302c8a0,4),
// LOAD_MODEL_FROM_DL(159,0x0302bcd0,4),
// LOAD_MODEL_FROM_DL(161,0x0301cb00,4),
// LOAD_MODEL_FROM_DL(164,0x04032a18,4),
// LOAD_MODEL_FROM_DL(201,0x080048e0,4),
// LOAD_MODEL_FROM_DL(218,0x08024bb8,4),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_7),
JUMP_LINK(script_func_global_2),
JUMP_LINK(local_area_totwc_1_),
JUMP_LINK(local_area_totwc_2_),
JUMP_LINK(local_area_totwc_3_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_totwc_1_[] = {
AREA(1,Geo_totwc_1_0x3461700),
TERRAIN(col_totwc_1_0xe08ee80),
SET_BACKGROUND_MUSIC(0,9),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_totwc_1_),
JUMP_LINK(local_warps_totwc_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_totwc_1_[] = {
OBJECT(0,473,4787,323,0,0,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(122,-701,9064,7999,0,-154,0,0x0, bhvStar),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,3400,488,488,0,-196,0,0xc0000, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-6133,1024,2357,0,151,0,0xd0000, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,698,768,9310,0,-107,0,0xe0000, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-19114,6719,9023,0,-26,0,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-20084,10677,16952,-20,-26,17,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-21435,1719,6371,0,-48,0,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-16017,5521,18356,0,8,0,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-17998,7760,20635,0,23,0,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-13433,4896,27672,-22,52,-20,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-6603,3802,28534,0,95,0,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-13974,2292,25495,10,46,-8,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-21269,8021,3218,-4,-26,-17,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-20089,5208,2453,0,-55,0,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-17530,3906,11845,0,-7,0,0x0, id_bhvStaticObject),
OBJECT(57,454,4780,558,0,184,0,0x0,bhvCloudFlower),
OBJECT(56,511,4835,1477,0,0,0,0x0, bhvAddCloudCount),
OBJECT(56,2727,7743,2480,0,0,0,0x0, bhvAddCloudCount),
OBJECT(56,3919,5410,4834,0,0,0,0x0, bhvAddCloudCount),
OBJECT(56,352,6053,7978,0,0,0,0x0, bhvAddCloudCount),
OBJECT(0,-647,7387,1407,0,0,0,0x0, bhvCloud),
OBJECT(0,2090,8800,6253,0,-132,0,0x0, bhvCloud),
RETURN()
};
const LevelScript local_warps_totwc_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,16,1,239,0),
WARP_NODE(241,16,1,223,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,17,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_totwc_2_[] = {
AREA(2,Geo_totwc_2_0x3461600),
TERRAIN(col_totwc_2_0xe0fcce0),
SET_BACKGROUND_MUSIC(0,46),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_totwc_2_),
JUMP_LINK(local_warps_totwc_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_totwc_2_[] = {
OBJECT(0,4584,280,-4202,0,0,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(0,-2129,2570,-58,0,10,0,0x1000000, bhvHiddenRedCoinStar),
OBJECT(216,2600,1243,757,0,0,0,0x0, bhvRedCoin),
OBJECT(216,3290,938,3668,0,0,0,0x0, bhvRedCoin),
OBJECT(216,-666,1223,5535,0,0,0,0x0, bhvRedCoin),
OBJECT(216,-3924,526,3808,0,0,0,0x0, bhvRedCoin),
OBJECT(216,-5216,1935,766,0,0,0,0x0, bhvRedCoin),
OBJECT(216,1489,2740,-6370,0,0,0,0x0, bhvRedCoin),
OBJECT(216,3342,2740,-5217,0,0,0,0x0, bhvRedCoin),
OBJECT(216,336,2730,3134,0,0,0,0x0, bhvRedCoin),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-12169,645,4729,-10,0,-17,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-12963,2878,-2781,-1,-50,-4,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,12812,1594,-3537,-16,141,-31,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,129,1948,10401,-16,31,-14,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-6863,0,-7592,8,-81,-9,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,5352,2922,-13322,0,-119,-23,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,8226,-1328,6028,0,-56,0,0x0, id_bhvStaticObject),
OBJECT(MODEL_TOTWC_STATIC_CLOUD,-8499,0,12065,0,16,0,0x0, id_bhvStaticObject),
OBJECT(57,5151,280,-1733,0,180,0,0x0,bhvCloudFlower),
//start
OBJECT(56,5151,370,-2372,0,0,0,0x0, bhvAddCloudCount),
//end
OBJECT(56,-3298,1464,-2072,0,0,0,0x0, bhvAddCloudCount),
OBJECT(56,1835,804,3795,0,0,0,0x0, bhvAddCloudCount),
OBJECT(25,4590,139,-4214,0,0,0,0x0,bhvCloud2AirCruise),
OBJECT(212,1222,646,1595,0,0,0,0x0, bhv1Up),
OBJECT(124,-2,3992,-62,0,-86,0,0x570000, bhvMessagePanel),
OBJECT(24,2729,434,-404,0,43,0,0xd00000,bhvTOTWCCloudyPlatform),
OBJECT(24,2531,634,-18,0,73,0,0x780000,bhvTOTWCCloudyPlatform),
OBJECT(24,2506,834,387,0,90,0,0x300000,bhvTOTWCCloudyPlatform),
OBJECT(24,2590,1034,752,0,26,0,0x200000,bhvTOTWCCloudyPlatform),
OBJECT(24,-4484,1314,-396,0,15,0,0x100000,bhvTOTWCCloudyPlatform),
OBJECT(24,-4899,1514,-128,0,42,0,0x450000,bhvTOTWCCloudyPlatform),
OBJECT(0,-672,1172,5536,0,0,0,0x30300000, bhvIgloo),
OBJECT(0,518,2412,1173,0,0,0,0x18180000, bhvIgloo),
OBJECT(0,833,2412,2682,0,0,0,0x18180000, bhvIgloo),
OBJECT(23,5283,319,-2386,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,5021,319,-3266,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,5281,319,-3259,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,5017,319,-1525,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,5284,319,-1520,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,5021,319,-2388,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-2148,2408,608,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-1741,2408,1427,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-2009,2408,1471,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-2032,2408,-281,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-2294,2408,-239,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-1887,2408,573,0,0,0,0x0, bhvAirBalloon),
RETURN()
};
const LevelScript local_warps_totwc_2_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(240,6,1,218,0),
WARP_NODE(241,10,1,13,0),
RETURN()
};
const LevelScript local_area_totwc_3_[] = {
AREA(3,Geo_totwc_3_0x3461300),
TERRAIN(col_totwc_3_0xe1447f0),
SET_BACKGROUND_MUSIC(0,46),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_totwc_3_),
JUMP_LINK(local_warps_totwc_3_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_totwc_3_[] = {
OBJECT(0,-4571,537,3488,0,0,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(27,-4596,-159,0,0,0,0,0x0, bhvCloud3AirCruise),
OBJECT(0,-5762,415,3458,0,0,0,0x2000000, bhvHiddenRedCoinStar),
OBJECT(216,-87,1227,-814,0,0,0,0x0, bhvRedCoin),
OBJECT(216,-3374,456,5555,0,0,0,0x0, bhvRedCoin),
OBJECT(216,-4682,-188,-5293,0,0,0,0x0, bhvRedCoin),
OBJECT(216,-233,407,-6311,0,0,0,0x0, bhvRedCoin),
OBJECT(216,5208,240,-4808,0,0,0,0x0, bhvRedCoin),
OBJECT(216,-44,439,-805,0,0,0,0x0, bhvRedCoin),
OBJECT(216,6052,1199,624,0,0,0,0x0, bhvRedCoin),
OBJECT(216,1489,140,6985,0,0,0,0x0, bhvRedCoin),
OBJECT(24,6071,554,2062,0,-20,0,0x170000,bhvTOTWCCloudyPlatform),
OBJECT(24,6305,803,1380,0,0,0,0xc40000,bhvTOTWCCloudyPlatform),
OBJECT(24,6046,990,616,0,26,0,0x480000,bhvTOTWCCloudyPlatform),
OBJECT(24,-1301,-594,-6286,0,0,0,0x730000,bhvTOTWCCloudyPlatform),
OBJECT(24,-600,-400,-6238,0,0,0,0x0,bhvTOTWCCloudyPlatform),
OBJECT(195,-3082,-540,-7784,0,0,0,0x520000, bhvBobombBuddy),
/*OBJECT(29,4960,404,-4656,0,22,0,0x78000000,Bhv_Custom_0x13002f30),
OBJECT(29,4960,404,-4656,0,22,0,0x0,Bhv_Custom_0x13002f30),
OBJECT(29,4923,404,-4794,0,-159,0,0x10000000,Bhv_Custom_0x13002f30),*/
OBJECT(23,-4337,195,5826,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-4812,195,5214,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-5290,195,4581,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-5782,195,3962,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-6247,195,3335,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-3805,195,5415,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-4284,195,4798,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-4764,195,4177,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-5243,195,3554,0,0,0,0x0, bhvAirBalloon),
OBJECT(23,-5720,195,2933,0,0,0,0x0, bhvAirBalloon),
OBJECT(57,516,140,7218,0,-140,0,0x0,bhvCloudFlower),
OBJECT(24,-143,-54,-6043,0,83,0,0x30000000,bhvTOTWCCloudyPlatform),
OBJECT(56,865,915,-131,0,0,0,0x0, bhvAddCloudCount),
OBJECT(56,2178,248,6533,0,0,0,0x0, bhvAddCloudCount),
OBJECT(56,6060,819,2045,0,0,0,0x0, bhvAddCloudCount),
OBJECT(56,5274,348,-4067,0,0,0,0x0, bhvAddCloudCount),
OBJECT(0,853,807,-37,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,3744,527,3816,0,-52,0,0x130000, bhvCoinFormation),
OBJECT(0,-2818,-679,-6317,0,90,0,0x0, bhvCoinFormation),
OBJECT(0,5195,538,-1558,0,19,0,0x130000, bhvCoinFormation),
RETURN()
};
const LevelScript local_warps_totwc_3_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(240,6,2,230,0),
WARP_NODE(241,6,2,214,0),
RETURN()
};
