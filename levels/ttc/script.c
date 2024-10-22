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
#include "levels/ttc/header.h"
extern u8 _ttc_segment_ESegmentRomStart[]; 
extern u8 _ttc_segment_ESegmentRomEnd[];
const LevelScript level_ttc_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _ttc_segment_ESegmentRomStart, _ttc_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom34602688_skybox_mio0SegmentRomStart,_SkyboxCustom34602688_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group2_mio0SegmentRomStart,_group2_mio0SegmentRomEnd),
LOAD_RAW(12,_group2_geoSegmentRomStart,_group2_geoSegmentRomEnd),
LOAD_MIO0(6,_group17_mio0SegmentRomStart,_group17_mio0SegmentRomEnd),
LOAD_RAW(13,_group17_geoSegmentRomStart,_group17_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(22, warp_pipe_geo),
LOAD_MODEL_FROM_GEO(23, bubbly_tree_geo),
LOAD_MODEL_FROM_GEO(24,green_floating_bubble_geo),
LOAD_MODEL_FROM_GEO(25,animated_hand_geo),
// LOAD_MODEL_FROM_GEO(27,0x19001c60),
LOAD_MODEL_FROM_GEO(29, haunted_door_geo),
// LOAD_MODEL_FROM_GEO(31,0x19001d20),
LOAD_MODEL_FROM_GEO(32, hazy_maze_door_geo),
LOAD_MODEL_FROM_GEO(34, castle_door_0_star_geo),
LOAD_MODEL_FROM_GEO(35, castle_door_1_star_geo),
LOAD_MODEL_FROM_GEO(36, castle_door_3_stars_geo),
LOAD_MODEL_FROM_GEO(37, key_door_geo),
LOAD_MODEL_FROM_GEO(38, castle_door_geo),
LOAD_MODEL_FROM_GEO(53,ttc_cloud_geo),
// LOAD_MODEL_FROM_DL(54,0x0e0a04d0,4),
// LOAD_MODEL_FROM_GEO(55,0x19001920),
LOAD_MODEL_FROM_GEO(56,star_hexagon_geo),
LOAD_MODEL_FROM_GEO(57,ttc_static_tree_geo),
LOAD_MODEL_FROM_GEO(58,musical_fruit_geo),
// LOAD_MODEL_FROM_GEO(59,0x19001a00),
LOAD_MODEL_FROM_GEO(60,brown_hand_enemy_geo),
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
JUMP_LINK(local_area_ttc_1_),
JUMP_LINK(local_area_ttc_2_),
FREE_LEVEL_POOL(),
MARIO_POS(1,0,0,8192,0),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_ttc_1_[] = {
AREA(1,Geo_ttc_1_0x1fc1700),
TERRAIN(col_ttc_1_0xe07eba8),
SET_BACKGROUND_MUSIC(0,66),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ttc_1_),
JUMP_LINK(local_warps_ttc_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ttc_1_[] = {
OBJECT_WITH_ACTS(0,2891,7150,305,0,148,0,0xa0000, bhvSpinAirborneWarp,63),
//OBJECT_WITH_ACTS(0,0,13854,0,0,0,0,0x0,Bhv_Custom_0x13003a18,63),
OBJECT_WITH_ACTS(0,3555,7390,310,0,-153,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(215,-39,7057,12698,0,107,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-2213,4804,6470,0,-151,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-1818,5303,10352,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,3525,10772,-4415,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,5471,9389,-2432,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,7525,8860,-5154,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,3118,9089,-1700,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-5708,7065,11673,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(53,4214,10379,7310,0,0,0,0x6c0000,bhvTTCCloud,63),
OBJECT_WITH_ACTS(53,3115,8594,-1725,0,0,0,0x380000,bhvTTCCloud,63),
OBJECT_WITH_ACTS(53,8768,8125,-3714,0,0,0,0x500000,bhvTTCCloud,63),
OBJECT_WITH_ACTS(53,7544,8649,-5203,0,0,0,0x500000,bhvTTCCloud,63),
OBJECT_WITH_ACTS(53,-2845,9215,-5490,0,0,0,0x5a0000,bhvTTCCloud,63),
OBJECT_WITH_ACTS(53,-1550,8735,-7923,0,0,0,0x400000,bhvTTCCloud,63),
OBJECT_WITH_ACTS(53,-75,8140,-7991,0,0,0,0x2c0000,bhvTTCCloud,63),
//Bhv_Custom_0x13003a74
OBJECT_WITH_ACTS(MODEL_NOTEBLOCKS,591,7009,1244,0,-61,0,(30 << 16),bhvNoteblock_MOP,63),
OBJECT_WITH_ACTS(MODEL_NOTEBLOCKS,2434,7923,6107,0,32,0,(90 << 16),bhvNoteblock_MOP,63),
//OBJECT_WITH_ACTS(55,337,9741,6366,0,32,0,0x2010000,Bhv_Custom_0x13003a74,63),*/
OBJECT_WITH_ACTS(122,4250,10853,7349,0,0,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(0,-9319,1849,-4537,0,0,0,0x830000, bhvReallyBigPole,63),
OBJECT_WITH_ACTS(192,-10541,1014,-4685,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(56,-10794,5398,-5374,0,30,0,0x10000,bhvStarHexagon,63),
OBJECT_WITH_ACTS(56,-9762,3782,-5395,0,-30,0,0x20000,bhvStarHexagon2,63),
OBJECT_WITH_ACTS(56,-11237,3215,-4574,0,90,0,0x40000,bhvStarHexagon3,63),
OBJECT_WITH_ACTS(56,-10911,3923,-3787,0,150,0,0x80000,bhvStarHexagon4,63),
OBJECT_WITH_ACTS(56,-9721,1869,-3712,0,210,0,0x100000,bhvStarHexagon5,63),
//OBJECT_WITH_ACTS(0,-6295,335,-4571,0,0,0,0x0,Bhv_Custom_0x13003aac,63),
OBJECT_WITH_ACTS(129,-9802,1014,-5270,0,60,0,0x10000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(129,-1151,6351,-11555,0,0,0,0x0, bhvBreakableBox,63),
OBJECT_WITH_ACTS(129,-3346,8289,-8338,0,0,0,0x30000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(0,-10248,1014,-4558,0,0,0,0x20000, bhvCoinFormation,63),
//start
OBJECT_WITH_ACTS(0,-10248,1434,-4558,0,0,0,(1 << 24), bhvStarHexagonStarSpawn,63),
//end
OBJECT_WITH_ACTS(129,-11428,1014,-4558,0,0,0,0x20000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(57,9772,7000,-801,0,0,0,0x0,bhvTTCStaticTree,63),
OBJECT_WITH_ACTS(57,1684,7092,-1270,0,-28,0,0x0,bhvTTCStaticTree,63),
OBJECT_WITH_ACTS(57,1187,7101,-7398,0,126,0,0x0,bhvTTCStaticTree,63),
OBJECT_WITH_ACTS(0,-3193,7888,3032,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,8392,7860,-1104,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(57,5880,7093,1270,0,-102,0,0x0,bhvTTCStaticTree,63),
OBJECT_WITH_ACTS(58,2789,7554,-6775,0,141,0,0x40000,bhvMusicalFruit,63),
OBJECT_WITH_ACTS(58,6466,8110,-5838,0,-71,0,0x70000,bhvMusicalFruit2,63),
OBJECT_WITH_ACTS(0,5528,7775,-7109,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(58,166,7488,-4332,0,95,0,0x0,bhvMusicalFruit3,63),
OBJECT_WITH_ACTS(0,2087,6352,10985,0,2,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,2087,6540,10985,0,2,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,2087,6722,10985,0,2,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,2394,6352,10969,0,2,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,2394,6540,10969,0,2,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,2394,6722,10969,0,2,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,2174,6315,10399,0,180,0,0xc0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(60,847,7204,-1289,0,0,0,0x0,bhvBrownHandEnemy,63),
OBJECT_WITH_ACTS(60,1256,7239,-8190,0,-135,0,0x0,bhvBrownHandEnemy,63),
OBJECT_WITH_ACTS(60,5207,7351,3297,0,58,0,0x0,bhvBrownHandEnemy,63),
OBJECT_WITH_ACTS(60,11304,7285,602,0,78,0,0x0,bhvBrownHandEnemy,63),
OBJECT_WITH_ACTS(60,1622,6885,-11042,0,-48,0,0x0,bhvBrownHandEnemy,63),
OBJECT_WITH_ACTS(0,3480,6896,-4422,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-6228,7040,8871,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-5861,7007,3873,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(140,-4004,6966,12246,0,0,0,0x0, bhvBlueCoinSwitch,63),
OBJECT_WITH_ACTS(0,-2983,7388,-11461,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(118,-2436,6315,12559,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,-740,6855,12392,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,-5410,6872,10935,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,-3723,6315,11633,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(60,-1798,8040,4522,0,0,0,0x0,bhvBrownHandEnemy,63),
OBJECT_WITH_ACTS(0,1948,7923,5612,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,3064,7067,9917,0,10,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,2187,7168,10987,0,92,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(24,2983,6500,-5175,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,2081,6500,-4106,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,4917,6500,-3536,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,4125,6500,-2596,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,5635,6500,-460,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,6004,6500,-2320,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,3738,6500,-2357,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,4186,6500,-4434,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,2923,6500,-2923,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,5772,6500,-2774,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,5128,6500,-2229,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,1561,6500,-3319,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(24,4781,6500,-1090,0,0,0,0x0,bhvGreenFloatingBubble,63),
OBJECT_WITH_ACTS(25,-748,5307,5314,0,157,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-3958,5303,5521,0,-92,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-4635,5415,7656,0,-25,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,208,5275,7604,0,-74,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-1406,4730,8125,0,24,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-3021,4868,8854,0,71,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-208,5175,9323,0,-57,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-3542,5253,9688,0,140,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-781,5493,10729,0,-139,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-2135,5331,10417,0,103,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-2135,4730,6927,0,0,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-2500,4845,6302,0,92,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-3646,4895,7083,0,74,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-2292,5405,4792,0,0,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-1510,4861,9167,0,-135,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-677,4928,6771,0,-68,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-1510,5109,9896,0,-33,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,573,5485,6458,0,-214,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-2708,4730,7813,0,109,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,573,5445,8854,0,-110,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-4427,5436,8906,0,74,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,365,5550,10104,0,73,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-1771,4940,5885,0,-36,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-2448,4976,9583,0,44,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-2917,5640,10885,0,186,0,0x0, bhvPyramidElevator,63),
OBJECT_WITH_ACTS(25,-469,4959,8438,0,-224,0,0x0, bhvPyramidElevator,63),
//OBJECT_WITH_ACTS(27,-50,7028,-7960,0,36,0,0x0,Bhv_Custom_0x13003c88,63),
OBJECT_WITH_ACTS(0,2542,11140,6941,0,0,0,0xd0d0000, bhvBetaChestLid,63),
/*OBJECT_WITH_ACTS(31,-12016,7887,14925,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,-9120,7423,16670,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,-3563,9162,-18239,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,6405,6829,16755,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,4030,7465,-20954,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,-18409,14337,-11071,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,-12725,12428,2587,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,14888,12089,2757,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,6744,12980,9120,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,2545,13064,-8399,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,12004,10053,-16839,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,11537,9120,-20233,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,-8144,9968,8526,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,23244,12301,85,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,-9501,14676,339,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,-4199,11325,-11198,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,9629,11622,-11877,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,4539,9459,-15525,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,2206,12767,-2757,0,90,0,0x0,Bhv_Custom_0x130041d8,63),
OBJECT_WITH_ACTS(31,11834,12555,-7041,0,90,0,0x0,Bhv_Custom_0x130041d8,63),*/
OBJECT_WITH_ACTS(0,-7205,-4481,-4533,0,0,0,(80 << 16), bhvReallyBigPole,63),
/////start
OBJECT_WITH_ACTS(0,0,0,0,0,0,0,(2 << 24), bhvMusicalFruitStarSpawn,63),
RETURN()
};
const LevelScript local_warps_ttc_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,14,2,10,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,228,0),
WARP_NODE(241,26,1,212,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,15,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_ttc_2_[] = {
AREA(2,Geo_ttc_2_0x1fc1600),
TERRAIN(col_ttc_2_0xe0d9530),
SET_BACKGROUND_MUSIC(0,6),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ttc_2_),
JUMP_LINK(local_warps_ttc_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ttc_2_[] = {
OBJECT_WITH_ACTS(0,-12111,0,-2306,0,0,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(22,-12786,0,-1446,0,71,0,0x200000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,-190,0,-1364,0,71,0,0x210000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,-13533,0,-576,0,29,0,0x220000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,-937,0,-494,0,29,0,0x230000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,-10625,971,-536,0,0,0,0x240000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,1971,971,-454,0,0,0,0x250000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,-14833,250,6796,0,0,0,0x260000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,-2237,250,6877,0,0,0,0x270000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,-12261,1502,8751,0,-37,0,0x280000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,335,1502,8833,0,-37,0,0x290000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(122,-2075,3914,9627,0,0,0,0x3000000, bhvStar,63),
OBJECT_WITH_ACTS(122,-14702,3914,9621,0,0,0,0x3000000, bhvStar,63),
/////OBJECT_WITH_ACTS(59,-2134,1756,8914,0,0,0,0x8c500000,Bhv_Custom_0x13003ae8,63),
//OBJECT_WITH_ACTS(59,-14699,1756,8820,0,0,0,0x40200000,Bhv_Custom_0x13003ae8,63),
OBJECT_WITH_ACTS(212,-10966,1190,-3004,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(192,974,0,177,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-1771,250,6862,0,0,0,0x10000, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-11333,0,0,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-14078,250,6685,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(0,-10049,975,974,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-12263,0,-2942,0,0,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-12263,217,-2942,0,0,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-12263,408,-2942,0,0,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-11931,0,-2942,0,0,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-11931,217,-2942,0,0,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-11931,408,-2942,0,0,0,0x180b0000, bhvWarp,63),
RETURN()
};
const LevelScript local_warps_ttc_2_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,14,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,228,0),
WARP_NODE(241,26,1,212,0),
WARP_NODE(32,14,2,33,0),
WARP_NODE(33,14,2,32,0),
WARP_NODE(34,14,2,35,0),
WARP_NODE(35,14,2,34,0),
WARP_NODE(36,14,2,37,0),
WARP_NODE(37,14,2,36,0),
WARP_NODE(38,14,2,39,0),
WARP_NODE(39,14,2,38,0),
WARP_NODE(40,14,2,41,0),
WARP_NODE(41,14,2,40,0),
RETURN()
};
