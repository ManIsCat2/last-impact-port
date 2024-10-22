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
#include "levels/bits/header.h"
extern u8 _bits_segment_ESegmentRomStart[]; 
extern u8 _bits_segment_ESegmentRomEnd[];
const LevelScript level_bits_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _bits_segment_ESegmentRomStart, _bits_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom36044480_skybox_mio0SegmentRomStart,_SkyboxCustom36044480_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group2_mio0SegmentRomStart,_group2_mio0SegmentRomEnd),
LOAD_RAW(12,_group2_geoSegmentRomStart,_group2_geoSegmentRomEnd),
LOAD_MIO0(6,_group17_mio0SegmentRomStart,_group17_mio0SegmentRomEnd),
LOAD_RAW(13,_group17_geoSegmentRomStart,_group17_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
// LOAD_MODEL_FROM_GEO(22,0x190018c0),
// LOAD_MODEL_FROM_GEO(23,0x19001c00),
LOAD_MODEL_FROM_GEO(24,rashay_locked_gate_geo),
// LOAD_MODEL_FROM_GEO(25,0x19001c40),
// LOAD_MODEL_FROM_GEO(29,0x19001ae0),
// LOAD_MODEL_FROM_DL(30,0x0703f070,4),
// LOAD_MODEL_FROM_GEO(31,0x19001c60),
// LOAD_MODEL_FROM_GEO(32,0x19001940),
// LOAD_MODEL_FROM_GEO(34,0x19001d00),
// LOAD_MODEL_FROM_GEO(35,0x19001e00),
// LOAD_MODEL_FROM_GEO(36,0x19001f00),
// LOAD_MODEL_FROM_GEO(37,0x19001900),
// LOAD_MODEL_FROM_GEO(38,0x19001970),
// LOAD_MODEL_FROM_GEO(53,0x19001a80),
LOAD_MODEL_FROM_GEO(54,bits_secret_platforms_geo),
LOAD_MODEL_FROM_GEO(55,bits_ship_wings_geo),
// LOAD_MODEL_FROM_GEO(56,0x007f0670),
// LOAD_MODEL_FROM_GEO(57,0x19001b00),
LOAD_MODEL_FROM_GEO(58,rashay_geo),
LOAD_MODEL_FROM_GEO(59,rashay_elevator_geo),
LOAD_MODEL_FROM_GEO(60,rashay_unlocker_button_geo),
// LOAD_MODEL_FROM_DL(132,0x08025f08,4),
// LOAD_MODEL_FROM_GEO(133,0x007e0000),
// LOAD_MODEL_FROM_DL(158,0x0302c8a0,4),
// LOAD_MODEL_FROM_DL(159,0x0302bcd0,4),
// LOAD_MODEL_FROM_DL(161,0x0301cb00,4),
// LOAD_MODEL_FROM_DL(164,0x04032a18,4),
// LOAD_MODEL_FROM_DL(201,0x080048e0,4),
// LOAD_MODEL_FROM_DL(218,0x08024bb8,4),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_3),
JUMP_LINK(script_func_global_18),
JUMP_LINK(local_area_bits_1_),
JUMP_LINK(local_area_bits_2_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_bits_1_[] = {
AREA(1,Geo_bits_1_0x2961700),
TERRAIN(col_bits_1_0xe0a3160),
SET_BACKGROUND_MUSIC(0,26),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_bits_1_),
JUMP_LINK(local_warps_bits_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_bits_1_[] = {
OBJECT(0,629,0,262,0,-22,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(60,6495,4130,1631,0,45,0,0x1000000, bhvRashayUnlockerButton),
OBJECT(60,2401,4369,-6856,0,0,0,0x2010000, bhvRashayUnlockerButton2),
OBJECT(60,-3209,3817,6611,0,0,0,0x4020000, bhvRashayUnlockerButton3),
OBJECT(60,-6453,3813,-2104,0,22,0,0x8030000, bhvRashayUnlockerButton4),
OBJECT(120,-1499,2283,6605,0,0,0,0x0, bhvRecoveryHeart),
OBJECT(59,0,0,0,0,0,0,0x0, bhvRashayElevator),
OBJECT(120,-1569,3298,6604,0,-49,0,0x0, bhvRecoveryHeart),
OBJECT(120,-1579,3995,6600,0,90,0,0x0, bhvRecoveryHeart),
OBJECT(0,-242,302,-627,0,0,0,0x1010000, bhvBowserCourseRedCoinStar),
OBJECT(215,-1572,982,4974,0,0,0,0x0, bhvRedCoin),
OBJECT(215,-3209,3176,6596,0,0,0,0x0, bhvRedCoin),
OBJECT(215,5635,2096,1811,0,0,0,0x0, bhvRedCoin),
OBJECT(215,5945,3838,2939,0,0,0,0x0, bhvRedCoin),
OBJECT(215,3288,3089,-6657,0,0,0,0x0, bhvRedCoin),
OBJECT(215,1269,2840,-5527,0,0,0,0x0, bhvRedCoin),
OBJECT(215,-8083,1348,-1063,0,0,0,0x0, bhvRedCoin),
OBJECT(215,-5291,3441,-1935,0,0,0,0x0, bhvRedCoin),
OBJECT(MODEL_FIRE_BULLY,-1260,1334,5757,0,0,0,0x0, id_bhvSmallBully),
OBJECT(54,-1645,1961,5089,0,115,0,0x80000, bhvBITSSecretPlatforms),
OBJECT(0,-3025,2283,4638,0,0,0,0x10100000, bhvLllRotatingBlockWithFireBars),
OBJECT(0,-2877,2283,6639,0,0,0,0x10100000, bhvLllRotatingBlockWithFireBars),
OBJECT(0,-3326,2283,6085,0,0,0,0x10100000, bhvLllRotatingBlockWithFireBars),
OBJECT(101,3506,4079,-5631,0,0,0,0x0, bhvScuttlebug),
OBJECT(101,1204,1565,-6021,0,0,0,0x0, bhvScuttlebug),
OBJECT(101,3159,1521,-4930,0,0,0,0x0, bhvScuttlebug),
OBJECT(101,3467,166,-5174,0,0,0,0x0, bhvScuttlebug),
/*OBJECT(0,3749,557,-5811,0,0,0,0x10000, Bhv_Custom_0x130042f0),
OBJECT(0,3749,1651,-5811,0,0,0,0x10000, Bhv_Custom_0x130042f0),
OBJECT(0,3749,4105,-5811,0,0,0,0x10000, Bhv_Custom_0x130042f0),
OBJECT(0,2468,177,-4405,0,0,0,0x0, Bhv_Custom_0x130042f0),
OBJECT(0,2468,1619,-4405,0,0,0,0x0, Bhv_Custom_0x130042f0),
OBJECT(0,2468,3846,-4405,0,0,0,0x0, Bhv_Custom_0x130042f0),
OBJECT(0,1031,1596,-5909,0,0,0,0x10000, Bhv_Custom_0x130042f0),
OBJECT(0,2382,497,-7165,0,0,0,0x0, Bhv_Custom_0x130042f0),
OBJECT(0,2382,2110,-7165,0,0,0,0x0, Bhv_Custom_0x130042f0),
OBJECT(0,2382,4413,-7165,0,0,0,0x0, Bhv_Custom_0x130042f0),
OBJECT(53,6621,4130,1783,0,45,0,0x0, Bhv_Custom_0x13004304),
OBJECT(53,5090,1594,1640,0,135,0,0x7f0000, Bhv_Custom_0x13004304),*/
OBJECT(137,-7412,2012,-3075,0,18,0,0x10000, bhvExclamationBox),
OBJECT(0,-4723,2686,-2545,0,0,0,0x1000000, bhvInvFireOpensGate5),
OBJECT(0,-3650,2686,-2764,0,0,0,0x2000000, bhvInvFireOpensGate6),
OBJECT(0,-4011,2686,-1735,0,0,0,0x4000000, bhvInvFireOpensGate7),
OBJECT(54,-5331,2647,-2030,0,22,0,0x1000000, bhvBITSSecretPlatforms),
OBJECT(54,-5831,2982,-1814,0,22,0,0x2000000, bhvBITSSecretPlatforms),
OBJECT(54,-5331,3291,-2030,0,22,0,0x4000000, bhvBITSSecretPlatforms),
OBJECT(55,-7055,1705,-2991,180,108,0,0xf0ff0000, bhvTHIStaticGrayBlock),
OBJECT(55,-7200,1705,-3379,0,-72,0,0x10010000, bhvTHIStaticGrayBlock),
OBJECT(55,-5251,1910,-3497,180,108,0,0xf0ff0000, bhvTHIStaticGrayBlock),
OBJECT(55,-5447,1910,-4108,0,-72,0,0x10010000, bhvTHIStaticGrayBlock),
//OBJECT(29,-7936,1515,-1046,0,-97,0,0x7f000000, Bhv_Custom_0x13002f30),
OBJECT(0,0,-804,0,0,0,0,0x0, bhvRashayButtonStarSpawn),
OBJECT(124,-1461,2220,6225,0,-15,0,0x5c0000, bhvMessagePanel),
OBJECT(212,-2428,164,6449,0,0,0,0x0, bhv1Up),
OBJECT(0,32,5,108,9,0,0,5,editor_Scroll_Texture),
OBJECT(0,32,5,96,3,0,0,6,editor_Scroll_Texture),
OBJECT(0,64,4,120,6,0,0,7,editor_Scroll_Texture),
OBJECT(0,64,4,120,6,0,0,8,editor_Scroll_Texture),
OBJECT(0,64,4,120,6,0,0,9,editor_Scroll_Texture),
RETURN()
};
const LevelScript local_warps_bits_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,21,2,10,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,237,0),
WARP_NODE(241,26,1,237,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,16,1,153,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_bits_2_[] = {
AREA(2,Geo_bits_2_0x2961600),
TERRAIN(col_bits_2_0xe0d4498),
SET_BACKGROUND_MUSIC(0,0x46),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_bits_2_),
JUMP_LINK(local_warps_bits_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_bits_2_[] = {
OBJECT(0,0,270,0,0,180,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(E_MODEL_PEACH,38,-27,-5309,0,-3,0,0x0, bhvTalkingPeach2),
OBJECT(MODEL_GOOMBA_BRO1,-4545,-263,2438,0,94,0,0x0, bhvGoombaBros),
OBJECT(MODEL_GOOMBA_BRO2,-4605,-263,2680,0,118,0,0x0, bhvGoombaBros),
OBJECT(MODEL_GOOMBA_BRO3,-4409,-263,2797,0,140,0,0x0, bhvGoombaBros),
OBJECT(58,54,538,-2606,0,0,0,0x0, bhvRashay),
OBJECT(0,-1535,368,-2092,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,2915,238,2191,0,0,0,0x20000, bhvCoinFormation),
OBJECT(24,-4424,-263,2556,0,113,0,0x80000, bhvRashayLockedGate),
OBJECT(24,91,-7,-5110,0,-2,0,0x280000, bhvRashayLockedGate),
RETURN()
};
const LevelScript local_warps_bits_2_[] = {
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,237,0),
WARP_NODE(241,26,1,237,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(10,9,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
