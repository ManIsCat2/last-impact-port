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
#include "levels/sl/header.h"
extern u8 _sl_segment_ESegmentRomStart[]; 
extern u8 _sl_segment_ESegmentRomEnd[];
const LevelScript level_sl_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _sl_segment_ESegmentRomStart, _sl_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_cloud_floor_skybox_mio0SegmentRomStart,_cloud_floor_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group1_mio0SegmentRomStart,_group1_mio0SegmentRomEnd),
LOAD_RAW(12,_group1_geoSegmentRomStart,_group1_geoSegmentRomEnd),
LOAD_MIO0(6,_group13_mio0SegmentRomStart,_group13_mio0SegmentRomEnd),
LOAD_RAW(13,_group13_geoSegmentRomStart,_group13_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
// LOAD_MODEL_FROM_DL(22,0x0e0acbb0,4),
// LOAD_MODEL_FROM_GEO(23,0x19001a00),
// LOAD_MODEL_FROM_GEO(24,0x19001ac0),
// LOAD_MODEL_FROM_GEO(25,0x19001b20),
LOAD_MODEL_FROM_GEO(27,sl_cloudy_platform_geo),
LOAD_MODEL_FROM_GEO(29, haunted_door_geo),
// LOAD_MODEL_FROM_GEO(31,0x19001b70),
// LOAD_MODEL_FROM_GEO(32,0x19001bc0),
// LOAD_MODEL_FROM_DL(34,0x0e0f7060,4),
LOAD_MODEL_FROM_GEO(35,fading_warp_stand_geo),
LOAD_MODEL_FROM_GEO(36, castle_door_3_stars_geo),
LOAD_MODEL_FROM_GEO(37, warp_pipe_geo),
// LOAD_MODEL_FROM_GEO(38,0x19001c00),
// LOAD_MODEL_FROM_GEO(39,0x030214f4),
// LOAD_MODEL_FROM_DL(40,0x03020fc4,4),
LOAD_MODEL_FROM_GEO(53,air_balloon2_geo),
LOAD_MODEL_FROM_GEO(54,sl_static_tree_geo),
LOAD_MODEL_FROM_GEO(55,sl_windmill_geo),
// LOAD_MODEL_FROM_GEO(56,0x19001e60),
LOAD_MODEL_FROM_GEO(57,konami_code_gate_geo),
LOAD_MODEL_FROM_GEO(58,sl_explodeable_obj_geo),
// LOAD_MODEL_FROM_GEO(59,0x19001f40),
// LOAD_MODEL_FROM_GEO(60,0x19001f90),
// LOAD_MODEL_FROM_DL(132,0x08025f08,4),
// LOAD_MODEL_FROM_GEO(133,0x007e0000),
// LOAD_MODEL_FROM_DL(158,0x0302c8a0,4),
// LOAD_MODEL_FROM_DL(159,0x0302bcd0,4),
// LOAD_MODEL_FROM_DL(161,0x0301cb00,4),
// LOAD_MODEL_FROM_DL(164,0x04032a18,4),
// LOAD_MODEL_FROM_DL(201,0x080048e0,4),
// LOAD_MODEL_FROM_DL(218,0x08024bb8,4),
// LOAD_MODEL_FROM_GEO(254,0x00309b40),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_2),
JUMP_LINK(script_func_global_14),
JUMP_LINK(local_area_sl_1_),
JUMP_LINK(local_area_sl_2_),
JUMP_LINK(local_area_sl_3_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_sl_1_[] = {
AREA(1,Geo_sl_1_0x1a41700),
TERRAIN(col_sl_1_0xe070398),
SET_BACKGROUND_MUSIC(0,43),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_sl_1_),
JUMP_LINK(local_warps_sl_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_sl_1_[] = {
OBJECT_WITH_ACTS(0,4478,-2900,7114,0,342,0,0xb0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,283,-1902,963,0,0,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,4,-2150,-22,0,-154,0,0xb0000, bhvHeaveHoThrowMario,63),
OBJECT_WITH_ACTS(53,3290,-2900,6307,0,-132,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,-4135,-3599,6749,0,57,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,7995,-2900,8452,0,-51,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,-1351,-689,-10744,0,27,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,290,-689,-11644,0,-95,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,3571,-689,-3570,0,41,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,3442,-689,-9972,0,183,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,-3764,189,2155,0,0,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,-1190,189,3442,0,256,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,9296,1766,901,0,-193,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,15376,2046,1319,0,0,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,18335,1745,-2702,0,180,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,10872,1870,-5983,0,-283,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,8042,1557,-10293,0,-279,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,5211,1470,-12513,0,169,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,6659,1604,-18367,0,-336,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,2445,235,-21134,0,0,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,17788,1802,-8492,0,138,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(53,16598,1956,-14539,0,-210,0,0x0, bhvClockMinuteHand,63),
OBJECT_WITH_ACTS(54,9457,1497,-2702,0,-167,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,9361,1630,-804,0,-356,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,11098,1918,-2734,0,-156,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,13028,2023,-1287,0,282,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,15022,2088,-643,0,219,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,12030,1984,-129,0,141,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,13960,2054,611,0,-215,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,12223,1989,1640,0,-190,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,10519,1681,-1222,0,-234,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(54,10615,1812,997,0,255,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(55,10541,10198,-12170,0,-250,0,0x0, bhvSLWindmill,63),
OBJECT_WITH_ACTS(122,12931,11849,-13037,0,0,0,0x2000000, bhvStar,63),
OBJECT_WITH_ACTS(0,9896,-2600,6146,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,-4792,-3599,6042,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,1198,-1902,-573,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,6250,-1580,2188,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,469,-3541,4848,0,7,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,-208,607,-8438,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,1875,-254,-10573,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,-416,-689,-8892,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,917,-1648,1510,0,0,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(35,-2013,607,-8976,0,0,0,0x0, bhvBowserKeyCourseExit,63),
OBJECT_WITH_ACTS(35,12485,1999,-16617,0,0,0,0x0, bhvBowserKeyCourseExit,63),
OBJECT_WITH_ACTS(0,-2013,607,-8976,0,0,0,0x10000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(0,12485,1999,-16617,0,0,0,0x20000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(124,-2713,189,1476,0,-9,0,0x490000, bhvMessagePanel,63),
/*OBJECT_WITH_ACTS(56,-3251,189,479,0,180,0,0x0, Bhv_Custom_0x13001cc4,63),
OBJECT_WITH_ACTS(56,-2285,189,796,0,180,0,0x10000, Bhv_Custom_0x13001cc4,63),
OBJECT_WITH_ACTS(56,-2463,189,488,0,180,0,0x20000, Bhv_Custom_0x13001cc4,63),
OBJECT_WITH_ACTS(56,-2853,189,480,0,180,0,0x30000, Bhv_Custom_0x13001cc4,63),
OBJECT_WITH_ACTS(56,-2821,189,1100,0,180,0,0x40000, Bhv_Custom_0x13001cc4,63),
OBJECT_WITH_ACTS(56,-2469,189,1098,0,180,0,0x50000, Bhv_Custom_0x13001cc4,63),
OBJECT_WITH_ACTS(56,-2632,189,800,0,180,0,0x60000, Bhv_Custom_0x13001cc4,63),
OBJECT_WITH_ACTS(56,-3040,189,796,0,180,0,0x70000, Bhv_Custom_0x13001cc4,63),*/
OBJECT_WITH_ACTS(57,50,561,-2832,0,0,0,0x0, bhvKonamiCodeGate,63),
OBJECT_WITH_ACTS(122,33,854,-3105,0,0,0,0x5000000, bhvStar,63),
OBJECT_WITH_ACTS(188,9275,-1580,4418,0,-26,0,0x0, bhvBobomb,63),
OBJECT_WITH_ACTS(58,9771,-1820,2389,0,0,0,0x0, bhvLllRotatingHexagonalPlatform,63),
OBJECT_WITH_ACTS(0,-2939,-1909,2947,0,89,0,0x110000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-3425,-1909,2963,0,0,0,0x10110000, bhvWarp,63),
OBJECT_WITH_ACTS(0,9158,-1580,3167,0,-36,0,0x40000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,10160,-2065,1804,0,0,0,0x40040000, bhvWarp,63),
OBJECT_WITH_ACTS(23,11853,-7227,14620,-30,250,0,0x0, bhvLllRotatingBlockWithFireBars,63),
OBJECT_WITH_ACTS(188,-3051,189,2174,0,190,0,0x0, bhvBobomb,63),
OBJECT_WITH_ACTS(188,2488,-331,-8300,0,0,0,0x0, bhvBobomb,63),
OBJECT_WITH_ACTS(188,3916,235,-20352,0,0,0,0x0, bhvBobomb,63),
OBJECT_WITH_ACTS(188,8030,1580,-11975,0,0,0,0x0, bhvBobomb,63),
OBJECT_WITH_ACTS(188,17284,1790,-4142,0,0,0,0x0, bhvBobomb,63),
OBJECT_WITH_ACTS(188,14198,2065,-671,0,0,0,0x0, bhvBobomb,63),
OBJECT_WITH_ACTS(24,760,-3244,4838,0,-82,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,-1992,-1867,1938,0,110,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,3565,-1371,1320,0,68,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,14,368,-1360,0,0,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,8894,-2117,-4113,0,-106,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(0,16949,-11936,-17899,0,0,0,0x1000000, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,10608,2802,-12009,0,0,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,15261,4679,-11429,0,-57,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,15490,5123,-12772,0,9,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,14944,5873,-14065,0,20,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,14227,6826,-15839,0,13,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(24,10974,7494,-14640,0,105,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(192,5191,-2900,6981,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-1473,607,-6555,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(192,12519,2001,-4294,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(192,6694,-2103,-6490,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(25,4745,-324,-8369,0,-74,0,0x2980000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(212,15147,2070,-15781,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(24,10171,4486,-13502,0,0,0,0x0, bhvLllRotatingHexFlame,63),
OBJECT_WITH_ACTS(25,6201,-378,-8841,0,-102,0,0x82450000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(25,4998,-2025,-3496,0,0,0,0x17a0000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(27,-23,208,1247,0,178,0,0x450000, bhvSLCloudyPlatform,63),
OBJECT_WITH_ACTS(27,4481,-2240,-4133,-13,-87,-10,0x100000, bhvSLCloudyPlatform,63),
OBJECT_WITH_ACTS(27,6044,-2240,-3473,-20,88,2,0x980000, bhvSLCloudyPlatform,63),
OBJECT_WITH_ACTS(27,4557,-2240,-2610,0,-142,0,0x60000, bhvSLCloudyPlatform,63),
OBJECT_WITH_ACTS(27,5254,-2240,-1288,-17,94,-16,0x570000, bhvSLCloudyPlatform,63),
OBJECT_WITH_ACTS(27,4158,-2101,-582,0,281,0,0xc00000, bhvSLCloudyPlatform,63),
OBJECT_WITH_ACTS(25,5358,-2112,-1838,0,108,0,0x1e80000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(25,5410,-2147,-2984,0,0,0,0x2000000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(0,6012,-2115,-3469,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-1606,607,-7054,0,0,0,0x20000, bhvCoinFormation,63),
/*OBJECT_WITH_ACTS(31,5004,-2900,7707,0,0,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,10767,-2900,8003,0,-77,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,8621,-2605,5165,0,41,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,-3650,189,777,0,64,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,-2951,-3599,5903,0,49,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,11495,1931,-7689,0,31,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,-777,-689,-9953,0,25,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,3573,-689,-5243,0,-44,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,5514,-2103,-6058,0,54,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,8349,-2103,-6136,0,-51,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,7340,235,-22290,0,0,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,15805,1998,-3650,0,0,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,9204,1735,-18291,0,0,0,0x0, Bhv_Custom_0x13001e48,63),
OBJECT_WITH_ACTS(31,621,1360,-16776,0,0,0,0x0, Bhv_Custom_0x13001e48,63),*/
OBJECT_WITH_ACTS(192,14808,2687,-6891,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(27,8518,-2572,-4300,0,79,0,0x0, bhvSLCloudyPlatform,63),
OBJECT_WITH_ACTS(0,8011,-2322,-2726,0,41,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,7499,2,-8593,0,-11,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(116,2965,235,-21243,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,3140,235,-21149,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,2972,235,-20962,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(34,-842,1688,-4034,0,0,0,0x4a0000, bhvLllSinkingRectangularPlatform,63),
OBJECT_WITH_ACTS(0,7482,-2900,6893,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,1637,1360,-16926,0,-7,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,12669,-1547,-7911,0,-11,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,12905,-470,-13619,0,14,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,13834,1032,3097,0,96,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(212,19981,334,-3225,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,17481,-1387,1604,0,211,0,0xd0000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(124,15234,2686,-6661,0,-159,0,0x560000, bhvMessagePanel,63),
//OBJECT_WITH_ACTS(40,15348,2688,-6406,0,0,0,0x2010000, Bhv_Custom_0x13001eb0,63),
OBJECT_WITH_ACTS(192,10602,1722,-458,0,0,0,0x10000, bhvGoomba,63),
/*OBJECT_WITH_ACTS(0,3285,-7566,11850,0,0,0,0x0, Bhv_Custom_0x13000bec,63),
OBJECT_WITH_ACTS(0,-8125,-7176,-3177,0,0,0,0x0, Bhv_Custom_0x13000bec,63),
OBJECT_WITH_ACTS(0,-833,-6893,-1615,0,0,0,0x0, Bhv_Custom_0x13000bec,63),
OBJECT_WITH_ACTS(0,13177,-7512,7500,0,0,0,0x0, Bhv_Custom_0x13000bec,63),
OBJECT_WITH_ACTS(0,-9635,-6713,9583,0,0,0,0x0, Bhv_Custom_0x13000bec,63),*/
OBJECT_WITH_ACTS(195,15868,1976,-105,0,0,0,0x510000, bhvBobombBuddy,63),
//OBJECT_WITH_ACTS(0,2031,-6267,-12865,0,0,0,0x0, Bhv_Custom_0x13000bec,63),
OBJECT_WITH_ACTS(0,-32,-1580,16886,0,0,0,0x9090000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(37,17296,-1197,1284,120,30,0,0xe0000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(0,1,4,6,3,0,0,2,editor_Scroll_Texture,63),
RETURN()
};
const LevelScript local_warps_sl_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(14,29,2,10,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(18,9,1,13,0),
WARP_NODE(240,6,1,218,0),
WARP_NODE(241,6,1,202,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,10,1,2,0),
WARP_NODE(2,10,1,1,0),
WARP_NODE(17,10,2,10,0),
WARP_NODE(4,10,3,10,0),
WARP_NODE(153,20,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_sl_2_[] = {
AREA(2,Geo_sl_2_0x1a41600),
TERRAIN(col_sl_2_0x7037448),
SET_BACKGROUND_MUSIC(0,45),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_sl_2_),
JUMP_LINK(local_warps_sl_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_sl_2_[] = {
OBJECT_WITH_ACTS(0,-60,822,98,0,180,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-64,822,450,0,0,0,0xa0000, bhvWarp,63),
OBJECT_WITH_ACTS(59,-683,780,-3223,0,283,0,0x0, bhvFlipswitch_Panel_MOP,63),
OBJECT_WITH_ACTS(59,-1642,1100,-752,0,12,0,0x0, bhvFlipswitch_Panel_MOP,63),
OBJECT_WITH_ACTS(59,-1635,213,-863,0,12,0,0x0, bhvFlipswitch_Panel_MOP,63),
OBJECT_WITH_ACTS(59,3019,90,-4944,0,-107,0,0x0, bhvFlipswitch_Panel_MOP,63),
OBJECT_WITH_ACTS(59,1565,1519,-352,0,133,0,0x1000000, bhvFlipswitch_Panel_MOP,63),
OBJECT_WITH_ACTS(0,-373,760,-1449,0,0,0,0x0, bhvFlipswitch_Panel_StarSpawn_MOP,63),
OBJECT_WITH_ACTS(0,411,1182,-1682,0,45,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-408,560,-1456,0,0,0,0x20000, bhvCoinFormation,63),
/*OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x50000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x30000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x10000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x0, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x60000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x20000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x70000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x50000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x30000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x10000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x0, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x60000, Bhv_Custom_0x13001f58,63),
OBJECT_WITH_ACTS(38,676,0,-2541,0,0,0,0x20000, Bhv_Custom_0x13001f58,63),*/
RETURN()
};
const LevelScript local_warps_sl_2_[] = {
WARP_NODE(240,6,1,218,0),
WARP_NODE(241,6,1,202,0),
WARP_NODE(10,10,1,17,0),
WARP_NODE(1,10,1,2,0),
WARP_NODE(2,10,1,1,0),
WARP_NODE(17,10,2,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(5,9,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_sl_3_[] = {
AREA(3,Geo_sl_3_0x1a41500),
TERRAIN(col_sl_3_0xe09eb30),
SET_BACKGROUND_MUSIC(0,45),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_sl_3_),
JUMP_LINK(local_warps_sl_3_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_sl_3_[] = {
OBJECT_WITH_ACTS(0,639,426,7819,0,189,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,780,426,8850,0,0,0,0x180a0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,1384,-59,5693,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-948,426,7576,0,93,0,0x0, bhvCoinFormation,63),
//OBJECT_WITH_ACTS(60,0,0,0,0,0,0,0x0, Bhv_Custom_0x13001d5c,63),
OBJECT_WITH_ACTS(122,-2319,2475,4800,0,0,0,0x3000000, bhvStar,63),
OBJECT_WITH_ACTS(22,-567,-1179,-5980,0,0,0,0x0, bhvLllMovingOctagonalMeshPlatform,63),
OBJECT_WITH_ACTS(25,2284,492,3820,0,0,0,0x1000000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(25,1990,879,-609,0,127,0,0x1970000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(25,3222,491,4003,0,180,0,0x1e40000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(25,1896,800,-1432,0,-107,0,0x1610000, bhvLllWoodPiece,63),
OBJECT_WITH_ACTS(0,1273,16,8179,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,116,16,8348,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(32,1423,426,7226,0,180,0,0x4b0000, bhvLllSinkingRectangularPlatform,63),
OBJECT_WITH_ACTS(32,1510,426,7279,0,300,0,0x4c0000, bhvLllSinkingRectangularPlatform,63),
OBJECT_WITH_ACTS(32,1509,426,7169,0,60,0,0x4d0000, bhvLllSinkingRectangularPlatform,63),
RETURN()
};
const LevelScript local_warps_sl_3_[] = {
WARP_NODE(240,6,1,218,0),
WARP_NODE(241,6,1,202,0),
WARP_NODE(10,10,1,4,0),
WARP_NODE(1,10,1,2,0),
WARP_NODE(2,10,1,1,0),
WARP_NODE(17,10,2,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(5,9,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
