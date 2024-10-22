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
#include "levels/lll/header.h"
extern u8 _lll_segment_ESegmentRomStart[]; 
extern u8 _lll_segment_ESegmentRomEnd[];
const LevelScript level_lll_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _lll_segment_ESegmentRomStart, _lll_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_water_skybox_mio0SegmentRomStart,_water_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group6_mio0SegmentRomStart,_group6_mio0SegmentRomEnd),
LOAD_RAW(12,_group6_geoSegmentRomStart,_group6_geoSegmentRomEnd),
LOAD_MIO0(6,_group15_mio0SegmentRomStart,_group15_mio0SegmentRomEnd),
LOAD_RAW(13,_group15_geoSegmentRomStart,_group15_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(22,magikoopa_wand_geo),
LOAD_MODEL_FROM_GEO(23,lll_haunted_static_tree_geo),
// LOAD_MODEL_FROM_GEO(24,0x19001430),
LOAD_MODEL_FROM_GEO(25, snow_tree_geo),
LOAD_MODEL_FROM_GEO(27, palm_tree_geo),
LOAD_MODEL_FROM_GEO(29, haunted_door_geo),
LOAD_MODEL_FROM_GEO(31, metal_door_geo),
LOAD_MODEL_FROM_GEO(32, hazy_maze_door_geo),
LOAD_MODEL_FROM_GEO(34, castle_door_0_star_geo),
LOAD_MODEL_FROM_GEO(35, castle_door_1_star_geo),
LOAD_MODEL_FROM_GEO(36, castle_door_3_stars_geo),
LOAD_MODEL_FROM_GEO(37, key_door_geo),
LOAD_MODEL_FROM_GEO(38, castle_door_geo),
// LOAD_MODEL_FROM_GEO(53,0x19001470),
// LOAD_MODEL_FROM_GEO(54,0x19001490),
// LOAD_MODEL_FROM_DL(55,0x070222e0,4),
// LOAD_MODEL_FROM_GEO(56,0x19001580),
LOAD_MODEL_FROM_GEO(57,lll_custom_metal_box_geo),
LOAD_MODEL_FROM_GEO(58,lll_fan_geo),
// LOAD_MODEL_FROM_GEO(60,0x19001400),
// LOAD_MODEL_FROM_DL(84,0x05000840,4),
// LOAD_MODEL_FROM_DL(132,0x08025f08,4),
// LOAD_MODEL_FROM_GEO(133,0x007e0000),
// LOAD_MODEL_FROM_DL(158,0x0302c8a0,4),
// LOAD_MODEL_FROM_DL(159,0x0302bcd0,4),
// LOAD_MODEL_FROM_DL(161,0x0301cb00,4),
// LOAD_MODEL_FROM_DL(164,0x04032a18,4),
LOAD_MODEL_FROM_GEO(195,bobomb_buddy_gaurd_geo),
// LOAD_MODEL_FROM_DL(201,0x080048e0,4),
// LOAD_MODEL_FROM_DL(218,0x08024bb8,4),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_7),
JUMP_LINK(script_func_global_16),
JUMP_LINK(local_area_lll_1_),
JUMP_LINK(local_area_lll_2_),
JUMP_LINK(local_area_lll_3_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_lll_1_[] = {
AREA(1,Geo_lll_1_0x2ac1700),
TERRAIN(col_lll_1_0xe08b778),
SET_BACKGROUND_MUSIC(0,49),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_lll_1_),
JUMP_LINK(local_warps_lll_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_lll_1_[] = {
OBJECT_WITH_ACTS(0,-4400,-509,-3296,0,-31,0,0xa0000, bhvSpinAirborneWarp,39),
OBJECT_WITH_ACTS(0,6002,740,-4521,0,-202,0,0xb0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-6695,203,6685,0,-98,0,0xc0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-9737,-259,1045,0,88,0,0xd0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-7770,-257,3035,0,120,0,0xe0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-7807,13,-1571,0,-2,0,0x10000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(122,-7807,-154,-1571,0,0,0,0x4000000, bhvStar,63),
OBJECT_WITH_ACTS(0,5330,809,-2165,0,0,0,0x500b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-6089,203,6752,0,0,0,0x100c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-10064,-259,1069,0,7,0,0x80d0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-7997,-257,3222,0,0,0,0x80e0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,0,11875,0,0,0,0,0x0, bhvSunkenShipPart,63),
OBJECT_WITH_ACTS(23,9531,-695,-6198,0,48,0,0x0, bhvLLLHauntedStaticTree,63),
OBJECT_WITH_ACTS(23,-4740,-1108,-11302,0,83,0,0x0, bhvLLLHauntedStaticTree,63),
OBJECT_WITH_ACTS(23,469,-678,-5833,0,0,0,0x0, bhvLLLHauntedStaticTree,63),
OBJECT_WITH_ACTS(23,-2396,-830,9792,0,190,0,0x0, bhvLLLHauntedStaticTree,63),
OBJECT_WITH_ACTS(23,5781,1672,-1823,0,99,0,0x0, bhvLLLHauntedStaticTree,63),
OBJECT_WITH_ACTS(23,4740,1672,2188,0,80,0,0x0, bhvLLLHauntedStaticTree,63),
OBJECT_WITH_ACTS(23,3438,-1116,-11406,0,-115,0,0x0, bhvLLLHauntedStaticTree,63),
OBJECT_WITH_ACTS(221,-9206,-272,-2096,0,9,0,DIALOG_091 <<24, bhvToadMessage,7),
//OBJECT_WITH_ACTS(24,4163,1672,-600,0,70,0,0x2010000, Bhv_Custom_0x13002490,7),
///OBJECT_WITH_ACTS(24,-3093,2698,5984,0,0,0,0x1000000, Bhv_Custom_0x13002490,7),
OBJECT_WITH_ACTS(221,-6533,203,6329,0,-171,0,0x5f5f0000, bhvBulletBillCannon,7),
OBJECT_WITH_ACTS(221,6321,743,-4334,0,-151,0,0x63630000, bhvOpenableCageDoor,7),
OBJECT_WITH_ACTS(221,276,-30,3064,0,-157,0,0x61610000, bhvBulletBillCannon,7),
OBJECT_WITH_ACTS(0,4744,1672,2208,0,0,0,0x20000, bhvCoinFormation,31),
OBJECT_WITH_ACTS(0,4740,1672,-1722,0,0,0,0x20000, bhvCoinFormation,31),
OBJECT_WITH_ACTS(0,5991,1082,4886,0,-23,0,0x0, bhvCoinFormation,31),
/*OBJECT_WITH_ACTS(86,-118,432,9016,0,-191,0,0x180000, Bhv_Custom_0x13002608,31),
OBJECT_WITH_ACTS(86,6861,1132,1568,0,-5,0,0x0, Bhv_Custom_0x13002608,31),
OBJECT_WITH_ACTS(86,3905,963,7978,0,-58,0,0x80000, Bhv_Custom_0x13002608,31),*/
OBJECT_WITH_ACTS(0,-56,-640,-12231,0,0,0,0x20000, bhvCoinFormation,15),
OBJECT_WITH_ACTS(221,-6423,-480,1616,0,-128,0,0x60600000, bhvBulletBillCannon,7),
OBJECT_WITH_ACTS(221,-2120,-340,-5876,0,0,0,(3 << 24), bhvUnderCoverMagikoopa,8),
OBJECT_WITH_ACTS(0,-7113,-480,856,0,0,0,0x20000, bhvCoinFormation,31),
OBJECT_WITH_ACTS(0,-3521,-502,-2884,0,148,0,0xa0000, bhvSpinAirborneWarp,8),
OBJECT_WITH_ACTS(221,-3408,-688,-6268,0,72,0,0x6d6d0000, bhvBulletBillCannon,8),
OBJECT_WITH_ACTS(221,-3413,-673,-5423,0,124,0,0x6e6e0000, bhvBulletBillCannon,8),
OBJECT_WITH_ACTS(221,-2913,-640,-4783,0,143,0,0x6f6f0000, bhvBulletBillCannon,8),
OBJECT_WITH_ACTS(188,-1962,-652,-6380,0,0,0,0x0, bhvBobomb,31),
OBJECT_WITH_ACTS(188,-2611,-652,-5568,0,0,0,0x0, bhvBobomb,31),
OBJECT_WITH_ACTS(188,-1759,-652,-5406,0,0,0,0x0, bhvBobomb,31),
/*OBJECT_WITH_ACTS(144,-4239,540,-302,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-7290,528,-1784,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-8992,360,3108,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-10426,316,534,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-9983,244,2282,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-9775,302,-999,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-9101,218,-2148,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-4590,1045,4789,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-6025,1419,6332,0,0,0,0x0, Bhv_Custom_0x13002364,48),
OBJECT_WITH_ACTS(144,-3707,388,-1480,0,0,0,0x0, Bhv_Custom_0x13002364,48),*/
OBJECT_WITH_ACTS(0,-4849,403,-2134,0,72,0,0x0, bhvCoinFormation,31),
OBJECT_WITH_ACTS(0,7030,-1608,-8549,0,0,0,0x0, bhvLargeFishGroup,31),
OBJECT_WITH_ACTS(0,1046,-1608,-11161,0,0,0,0x0, bhvFish2,31),
OBJECT_WITH_ACTS(0,-6181,-1608,-7377,0,0,0,0x0, bhvFish3,31),
OBJECT_WITH_ACTS(0,4551,-1116,-10601,0,0,0,0x0, bhvGoombaTripletSpawner,31),
OBJECT_WITH_ACTS(0,-6296,-1108,-9632,0,0,0,0x0, bhvGoombaTripletSpawner,31),
OBJECT_WITH_ACTS(118,-4767,-643,-11229,0,0,0,0x0, bhvHiddenBlueCoin,31),
OBJECT_WITH_ACTS(118,-4725,-837,-11087,0,0,0,0x0, bhvHiddenBlueCoin,31),
OBJECT_WITH_ACTS(118,-4989,-702,-11399,0,0,0,0x0, bhvHiddenBlueCoin,31),
OBJECT_WITH_ACTS(140,-8060,-1108,-7908,0,0,0,0x0, bhvBlueCoinSwitch,31),
OBJECT_WITH_ACTS(0,-6835,-1108,-8854,0,0,0,0x20000, bhvCoinFormation,31),
OBJECT_WITH_ACTS(0,-3615,-2312,2956,90,0,0,0x130000, bhvCoinFormation,31),
OBJECT_WITH_ACTS(0,3790,565,-4802,0,-67,0,0x0, bhvCoinFormation,31),
//OBJECT_WITH_ACTS(54,-7180,385,588,0,0,0,0x1000000, bhvUnderCoverMagikoopa,32), //lol.
OBJECT_WITH_ACTS(195,-309,-640,-11952,0,153,0,0x0, bhvBobombBuddy,16),
OBJECT_WITH_ACTS(195,134,-640,-11969,0,206,0,0x0, bhvBobombBuddy,16),
OBJECT_WITH_ACTS(195,-94,-640,-11874,0,180,0,0x0, bhvBobombBuddy,16),
OBJECT_WITH_ACTS(0,-55,-640,-12231,0,0,0,0xa0000, bhvSpinAirborneWarp,16),
/*OBJECT_WITH_ACTS(0,-97,-550,-11848,0,0,0,0x10000, Bhv_Custom_0x130026ec,16),
OBJECT_WITH_ACTS(54,19729,7448,14271,0,-32,0,0x0, Bhv_Custom_0x13000cb8,7),
OBJECT_WITH_ACTS(55,19729,7448,14271,0,-32,0,0x0, Bhv_Custom_0x13000cb8,7),*/
OBJECT_WITH_ACTS(0,-5531,1077,-1803,0,0,0,0x6000000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(57,-2709,42,4489,0,0,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-2709,242,4489,0,0,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(212,-4762,758,1339,0,-98,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(130,-3045,43,4574,0,0,0,0x10000, bhvBreakableBox,63),
RETURN()
};
const LevelScript local_warps_lll_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,22,2,10,0),
WARP_NODE(12,22,3,10,0),
WARP_NODE(13,22,3,11,0),
WARP_NODE(14,22,3,12,0),
WARP_NODE(240,6,1,199,0),
WARP_NODE(241,6,1,215,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,22,2,11,0),
WARP_NODE(2,22,2,12,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,8,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_lll_2_[] = {
AREA(2,Geo_lll_2_0x2ac1600),
TERRAIN(col_lll_2_0xe0d5870),
SET_BACKGROUND_MUSIC(0,45),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_lll_2_),
JUMP_LINK(local_warps_lll_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_lll_2_[] = {
//START
OBJECT_WITH_ACTS(0,-14854,-906,222,0,0,0,(1 << 24), bhvBobombGaurdStopper,63),
OBJECT_WITH_ACTS(0,-14629,-906,-27,0,0,0,(1 << 24), bhvBobombGaurdStopper,63),

OBJECT_WITH_ACTS(0,-12192,-906,2448,0,0,0,(1 << 24), bhvBobombGaurdStopper,63),
OBJECT_WITH_ACTS(0,-12426,-906,2675,0,0,0,(1 << 24), bhvBobombGaurdStopper,63),

OBJECT_WITH_ACTS(0,-15117,-906,51,0,0,0,0, bhvBobombGaurdStopper,63),
OBJECT_WITH_ACTS(0,-14962,-906,-181,0,0,0,(3 << 16), bhvBobombGaurdStopper,63),
OBJECT_WITH_ACTS(0,-17644,-906,-2460,0,0,0,0, bhvBobombGaurdStopper,63),
OBJECT_WITH_ACTS(0,-17426,-906,-2650,0,0,0,(3 << 16), bhvBobombGaurdStopper,63),
//END
OBJECT_WITH_ACTS(0,-1462,-9,-986,0,26,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-21027,-906,-7603,0,-47,0,0xb0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(130,-21776,-906,-8594,0,45,0,0x30000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(0,-11576,-283,8075,0,0,0,0x100d0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-2031,-3,-1940,0,0,0,0x480c0000, bhvWarp,63),
////OBJECT_WITH_ACTS(1,612,-248,6345,0,0,0,0x0, Bhv_Custom_0x130023cc,63),
OBJECT_WITH_ACTS(0,-1015,-1350,10793,0,0,0,0x20000, bhvCoinFormation,63),
//OBJECT_WITH_ACTS(101,2020,-995,8329,0,-89,0,0x0, Bhv_Custom_0x130023e4,63),
////OBJECT_WITH_ACTS(0,0,2508,0,0,0,0,0x10000, bhvSunkenShipPart,63),
//OBJECT_WITH_ACTS(24,1227,-43,-1409,0,0,0,0x4020000, Bhv_Custom_0x13002490,7),
OBJECT_WITH_ACTS(0,715,-44,-226,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-833,-1337,4896,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(195,-20318,-906,-5400,0,-159,0,0x10000, bhvBobombBuddyGaurd,63),
//that
OBJECT_WITH_ACTS(195,-12379,-840,2260,0,225,0,0x1000000, bhvBobombBuddyGaurd,63),
OBJECT_WITH_ACTS(195,-16234,482,-2598,0,49,0,0x1020000, bhvBobombBuddyGaurd,63),
OBJECT_WITH_ACTS(195,-7495,-283,2927,0,-45,0,0x1030000, bhvBobombBuddyGaurd,63),
OBJECT_WITH_ACTS(195,-7238,-283,2766,0,-45,0,0x0, bhvBobombBuddyGaurd,63),
OBJECT_WITH_ACTS(195,-14217,-906,315,0,225,0,0x0, bhvBobombBuddyGaurd,63),
OBJECT_WITH_ACTS(195,-22853,-906,-7492,0,-320,0,0x20000, bhvBobombBuddyGaurd,63),
OBJECT_WITH_ACTS(195,-16341,-906,-1527,0,225,0,0x30000, bhvBobombBuddyGaurd,63),
OBJECT_WITH_ACTS(195,-15386,-906,-215,0,225,0,0x0, bhvBobombBuddyGaurd,63),
//this
OBJECT_WITH_ACTS(195,-12672,-847,2440,0,225,0,0x1000000, bhvBobombBuddyGaurd,63),
//OBJECT_WITH_ACTS(85,-22025,-906,-8150,0,70,0,0xc710000, Bhv_Custom_0x13002714,63),
//OBJECT_WITH_ACTS(85,-11556,-906,235,0,43,0,0x20720000, Bhv_Custom_0x13002714,63),
OBJECT_WITH_ACTS(58,-23725,786,-7424,90,0,246,0x20720000, bhvLLLFan,63),
OBJECT_WITH_ACTS(57,-16542,-491,-3167,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-16542,-691,-3167,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-16542,-916,-3167,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-16542,-291,-3167,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-16542,-91,-3167,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-16390,-691,-3317,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-23715,-999,-7148,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-23567,-999,-7292,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-23715,-799,-7148,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-23715,-599,-7148,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-23871,-999,-7294,0,44,0,0x0, bhvCustomMetalBox,63),
OBJECT_WITH_ACTS(57,-23871,-799,-7294,0,44,0,0x0, bhvCustomMetalBox,63),
//OBJECT_WITH_ACTS(0,-21031,-906,-7600,0,0,0,0x0, bhvSlidingSnowMound,63),
RETURN()
};
const LevelScript local_warps_lll_2_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,22,2,10,0),
WARP_NODE(12,22,1,11,0),
WARP_NODE(13,22,1,1,0),
WARP_NODE(14,22,3,12,0),
WARP_NODE(240,6,1,199,0),
WARP_NODE(241,6,1,215,0),
RETURN()
};
const LevelScript local_area_lll_3_[] = {
AREA(3,Geo_lll_3_0x2ac1900),
TERRAIN(col_lll_3_0xe11cf08),
SET_BACKGROUND_MUSIC(0,52),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_lll_3_),
JUMP_LINK(local_warps_lll_3_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_lll_3_[] = {
OBJECT_WITH_ACTS(0,23385,0,4896,0,180,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,1815,0,-1100,0,28,0,0xb0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,24440,0,21065,0,0,0,0xc0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,23353,7,5633,0,0,0,0x300a0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,1632,0,-1457,0,28,0,0x100b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,24435,0,20652,0,0,0,0x100c0000, bhvWarp,63),
OBJECT_WITH_ACTS(101,23889,2534,-449,0,0,0,0x10000, bhvGhostHuntBoo,63),
OBJECT_WITH_ACTS(101,21680,2534,-228,0,0,3,0x10000, bhvGhostHuntBoo,63),
OBJECT_WITH_ACTS(101,24362,631,3736,0,-31,0,0x10000, bhvGhostHuntBoo,63),
OBJECT_WITH_ACTS(101,23453,1664,-1307,0,94,0,0x10000, bhvGhostHuntBoo,63),
OBJECT_WITH_ACTS(101,23909,407,-1741,0,0,0,0x10000, bhvGhostHuntBoo,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,24938,2832,4341,0,-152,0,0x10000, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(101,18787,1561,2060,0,103,0,0x10000, bhvGhostHuntBoo,63),
OBJECT_WITH_ACTS(101,20159,1584,-304,0,0,0,0x10000, bhvGhostHuntBoo,63),
OBJECT_WITH_ACTS(0,22762,9,22639,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,19098,1718,587,0,0,0,0x2000000, bhvHiddenRedCoinStar,63),
/*OBJECT_WITH_ACTS(101,18523,1769,602,0,0,0,0x0, Bhv_Custom_0x1300266c,63),
OBJECT_WITH_ACTS(101,18055,1770,484,0,65,0,0x10000, Bhv_Custom_0x1300266c,63),
OBJECT_WITH_ACTS(101,20205,1770,291,0,-72,0,0x54010000, Bhv_Custom_0x1300266c,63),
OBJECT_WITH_ACTS(101,19011,1770,-718,0,0,0,0x20000, Bhv_Custom_0x1300266c,63),
OBJECT_WITH_ACTS(101,17939,1586,1739,0,55,0,0x98030000, Bhv_Custom_0x1300266c,63),
OBJECT_WITH_ACTS(101,18175,1586,2439,0,-198,0,0x30000, Bhv_Custom_0x1300266c,63),
OBJECT_WITH_ACTS(144,21007,154,21456,0,0,0,0x0, Bhv_Custom_0x13002364,63),
OBJECT_WITH_ACTS(0,16276,1695,6634,0,0,0,0x0, Bhv_Custom_0x13002680,63),*/
OBJECT_WITH_ACTS(101,89,1056,130,0,180,0,0x62620000, bhvBulletBillCannon,63),
OBJECT_WITH_ACTS(0,-1696,9,227,0,87,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,567,9,238,0,104,0,0x0, bhvCoinFormation,63),
//OBJECT_WITH_ACTS(22,22921,160,21864,5,5,83,0x0, Bhv_Custom_0x130026b4,8),
OBJECT_WITH_ACTS(MODEL_MAGIKOOPA_WAND,22921,160,21864,5,5,83,0x0, id_bhvStaticObject,8),
RETURN()
};
const LevelScript local_warps_lll_3_[] = {
WARP_NODE(10,22,1,12,0),
WARP_NODE(11,22,1,13,0),
WARP_NODE(12,22,1,14,0),
WARP_NODE(13,22,1,1,0),
WARP_NODE(14,22,3,12,0),
WARP_NODE(240,6,1,199,0),
WARP_NODE(241,6,1,215,0),
RETURN()
};
