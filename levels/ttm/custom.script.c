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
#include "levels/ttm/header.h"
extern u8 _ttm_segment_ESegmentRomStart[]; 
extern u8 _ttm_segment_ESegmentRomEnd[];
const LevelScript level_ttm_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _ttm_segment_ESegmentRomStart, _ttm_segment_ESegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group5_mio0SegmentRomStart,_group5_mio0SegmentRomEnd),
LOAD_RAW(12,_group5_geoSegmentRomStart,_group5_geoSegmentRomEnd),
LOAD_MIO0(6,_group14_mio0SegmentRomStart,_group14_mio0SegmentRomEnd),
LOAD_RAW(13,_group14_geoSegmentRomStart,_group14_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(22, warp_pipe_geo),
LOAD_MODEL_FROM_GEO(23, bubbly_tree_geo),
LOAD_MODEL_FROM_GEO(24, spiky_tree_geo),
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
// LOAD_MODEL_FROM_GEO(53,0x19001a00),
// LOAD_MODEL_FROM_GEO(54,0x19001a40),
// LOAD_MODEL_FROM_GEO(55,0x19001b40),
// LOAD_MODEL_FROM_GEO(56,0x19001b80),
// LOAD_MODEL_FROM_DL(57,0x0703ded0,4),
// LOAD_MODEL_FROM_GEO(58,0x19001c00),
// LOAD_MODEL_FROM_GEO(59,0x19001c20),
// LOAD_MODEL_FROM_GEO(60,0x19001c40),
// LOAD_MODEL_FROM_GEO(86,0x05014630),
// LOAD_MODEL_FROM_DL(132,0x08025f08,4),
// LOAD_MODEL_FROM_GEO(133,0x007e0000),
// LOAD_MODEL_FROM_DL(158,0x0302c8a0,4),
// LOAD_MODEL_FROM_DL(159,0x0302bcd0,4),
// LOAD_MODEL_FROM_DL(161,0x0301cb00,4),
// LOAD_MODEL_FROM_DL(164,0x04032a18,4),
// LOAD_MODEL_FROM_DL(201,0x080048e0,4),
// LOAD_MODEL_FROM_DL(218,0x08024bb8,4),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_6),
JUMP_LINK(script_func_global_15),
JUMP_LINK(local_area_ttm_1_),
JUMP_LINK(local_area_ttm_2_),
JUMP_LINK(local_area_ttm_3_),
FREE_LEVEL_POOL(),
MARIO_POS(1,0,0,0,0),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_ttm_1_[] = {
AREA(1,Geo_ttm_1_0x3b41700),
TERRAIN(col_ttm_1_0xe0abe90),
SET_BACKGROUND_MUSIC(0,64),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ttm_1_),
JUMP_LINK(local_warps_ttm_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ttm_1_[] = {
OBJECT_WITH_ACTS(0,-5369,-147,-1490,0,75,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(122,-5,6745,-9,0,-154,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(0,0,2920,0,0,-153,0,0x200000, bhvLllDrawbridgeSpawner,63),
OBJECT_WITH_ACTS(0,-275,4190,67,0,107,0,0xd0000, bhvLllDrawbridgeSpawner,63),
OBJECT_WITH_ACTS(0,5606,-172,5142,0,-45,0,0x10000, bhvWarp,63),
OBJECT_WITH_ACTS(54,5082,-144,-2209,0,37,0,0x13040000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,393,-397,-1672,0,0,0,0x23020000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-1693,-392,-222,0,0,0,0x10000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,1043,-144,-3172,0,0,0,0x2050000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,1477,-144,-3167,0,-93,0,0x60000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,1007,-144,-3601,0,5,0,0x70000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,506,-144,-3275,0,86,0,0x80000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-464,-397,-1218,0,0,0,0x90000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-984,-397,-2119,0,0,0,0xa0000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-962,-397,-1063,0,0,0,0xb0000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-4419,-144,3189,0,119,0,0xc0000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-3429,-144,4184,0,140,0,0xc0000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,5338,-144,-937,0,178,0,0xd0000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,4853,-144,-1056,0,118,0,0xe0000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-2221,-144,-4811,0,-144,0,0xf0000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,3361,-144,2922,0,0,0,0x2100000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(54,-5069,-144,1464,0,105,0,0x43030000, Bhv_Custom_0x13003914,63),
OBJECT_WITH_ACTS(0,-1316,-144,5037,0,165,0,0x2a0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,5022,-144,1376,0,-104,0,0x2b0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,1341,-144,-5028,0,-15,0,0x2c0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-1563,-144,5979,0,0,0,0x202a0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,5995,-144,1592,0,0,0,0x202b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,1618,-144,-5953,0,0,0,0x202c0000, bhvWarp,63),
OBJECT_WITH_ACTS(55,5569,-144,1476,0,255,0,0x10000, Bhv_Custom_0x1300393c,63),
OBJECT_WITH_ACTS(55,1479,-145,-5571,0,-15,0,0x1020000, Bhv_Custom_0x1300393c,63),
OBJECT_WITH_ACTS(55,-1499,-145,5555,0,165,0,0x2040000, Bhv_Custom_0x1300393c,63),
OBJECT_WITH_ACTS(212,-3196,863,4885,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(212,1087,250,5628,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(56,-745,1507,-3972,0,-72,0,0x10000, bhvWfSlidingPlatform,63),
OBJECT_WITH_ACTS(56,-4644,1762,500,0,0,0,0x0, bhvWfSlidingPlatform,63),
OBJECT_WITH_ACTS(56,-2437,1645,3709,0,0,0,0x0, bhvWfSlidingPlatform,63),
OBJECT_WITH_ACTS(0,0,-235,0,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(116,5386,-102,4906,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,5171,-102,4698,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(0,4110,-144,-1101,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-4122,-144,1096,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,1342,-144,-5027,0,0,0,0x0, Bhv_Custom_0x130039bc,63),
OBJECT_WITH_ACTS(0,-2404,151,68,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-3745,187,-3258,0,-45,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,3512,0,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-2579,200,-5121,0,15,0,0x0, Bhv_Custom_0x130039d0,63),
OBJECT_WITH_ACTS(0,-2023,200,-5271,0,15,0,0x0, Bhv_Custom_0x130039d0,63),
OBJECT_WITH_ACTS(0,-1452,200,-5430,0,15,0,0x0, Bhv_Custom_0x130039d0,63),
OBJECT_WITH_ACTS(0,-888,200,-5584,0,15,0,0x0, Bhv_Custom_0x130039d0,63),
OBJECT_WITH_ACTS(0,-323,200,-5732,0,15,0,0x0, Bhv_Custom_0x130039d0,63),
OBJECT_WITH_ACTS(116,2415,396,-5094,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,443,396,-5599,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-2428,396,5089,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-440,396,5608,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,5590,396,454,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,5085,396,2412,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(0,3407,-208,2942,0,0,0,0xb0b0000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(140,3473,-144,-4260,0,45,0,0x20000, bhvBlueCoinSwitch,63),
OBJECT_WITH_ACTS(118,3243,144,-4301,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,3923,144,-3312,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,3395,144,-3512,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(0,3773,98,3815,0,225,0,0xd0000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(0,64,5,81,9,0,0,4,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,32,4,144,3,0,0,5,editor_Scroll_Texture,63),
RETURN()
};
const LevelScript local_warps_ttm_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,25,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(153,13,1,10,0),
WARP_NODE(240,26,1,226,0),
WARP_NODE(241,26,1,210,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,36,2,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(42,36,3,10,0),
WARP_NODE(43,36,3,11,0),
WARP_NODE(44,36,3,12,0),
RETURN()
};
const LevelScript local_area_ttm_2_[] = {
AREA(2,Geo_ttm_2_0x3b41600),
TERRAIN(col_ttm_2_0x7020890),
SET_BACKGROUND_MUSIC(0,65),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ttm_2_),
JUMP_LINK(local_warps_ttm_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ttm_2_[] = {
OBJECT_WITH_ACTS(22,7333,-200,2804,0,-90,0,0xa0000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(122,-8913,1052,-3429,0,0,0,0x1000000, bhvStar,63),
OBJECT_WITH_ACTS(53,5929,0,2402,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,5449,0,3136,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,4184,0,3424,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,4161,0,5670,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,5110,0,6740,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,3200,0,7458,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,414,0,4988,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,1533,0,-365,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,1022,0,572,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,1180,0,6375,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,-2190,0,5390,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,2677,0,1521,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,-3005,0,-475,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,-2068,0,-2969,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,-572,0,3991,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,3121,0,8389,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,-4249,0,-2964,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(53,3291,0,-349,0,0,0,0x0, Bhv_Custom_0x130038e4,63),
OBJECT_WITH_ACTS(0,-1758,-107,7213,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,-79,0,0,0,0,0x0, Bhv_Custom_0x13003900,63),
RETURN()
};
const LevelScript local_warps_ttm_2_[] = {
WARP_NODE(10,36,1,1,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,226,0),
WARP_NODE(241,36,1,13,0),
RETURN()
};
const LevelScript local_area_ttm_3_[] = {
AREA(3,Geo_ttm_3_0x3b41500),
TERRAIN(col_ttm_3_0xe0df070),
SET_BACKGROUND_MUSIC(0,64),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ttm_3_),
JUMP_LINK(local_warps_ttm_3_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ttm_3_[] = {
OBJECT_WITH_ACTS(0,-9266,1143,4486,0,180,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,3375,4769,8500,0,180,0,0xb0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-173,100,-3257,0,140,0,0xc0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-9262,2563,7814,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(22,-6274,164,1974,0,0,0,0xa0000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(22,3629,269,7338,0,0,0,0xb0000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-4075,1468,4418,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-6444,1319,4810,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-6491,2874,8544,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-7836,3431,9848,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-3766,2829,8437,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-8731,590,3190,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-6525,3403,9784,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-4847,3632,10321,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(0,-6718,364,1974,0,0,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(0,8979,1604,11968,0,0,0,0x0, Bhv_Custom_0x1300395c,63),
OBJECT_WITH_ACTS(0,12063,2573,7492,0,0,0,0x10000, Bhv_Custom_0x1300395c,63),
OBJECT_WITH_ACTS(0,5376,1045,11412,0,0,0,0x20000, Bhv_Custom_0x1300395c,63),
OBJECT_WITH_ACTS(0,7600,0,7833,0,0,0,0x1000000, Bhv_Custom_0x1300395c,63),
OBJECT_WITH_ACTS(0,-191,100,-3258,0,0,0,0x0, Bhv_Custom_0x1300399c,63),
OBJECT_WITH_ACTS(180,1144,-144,-4445,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(180,494,0,-7490,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(180,4717,349,-2983,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(180,4067,725,-7734,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(180,-602,0,-5622,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(180,1306,0,-2496,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(180,4595,725,-5785,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(180,2727,0,-2536,0,0,0,0x0, bhvFireSpitter,63),
OBJECT_WITH_ACTS(0,-6451,1455,4801,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(58,-9273,447,2751,0,0,0,0xcea10000, Bhv_Custom_0x130039e4,63),
OBJECT_WITH_ACTS(58,-8741,475,2851,0,0,0,0x74210000, Bhv_Custom_0x130039e4,63),
OBJECT_WITH_ACTS(58,-3674,533,2884,0,0,0,0x74210000, Bhv_Custom_0x130039e4,63),
OBJECT_WITH_ACTS(59,-4354,3645,10316,-23,0,0,0x38000000, Bhv_Custom_0x130039e4,63),
OBJECT_WITH_ACTS(59,-6470,2621,7916,-23,0,0,0x38000000, Bhv_Custom_0x130039e4,63),
OBJECT_WITH_ACTS(59,-7128,2903,8577,-23,0,0,0x38000000, Bhv_Custom_0x130039e4,63),
OBJECT_WITH_ACTS(59,-5970,3040,8898,-23,0,0,0x38000000, Bhv_Custom_0x130039e4,63),
OBJECT_WITH_ACTS(60,-5550,413,2854,-23,0,2,0x0, Bhv_Custom_0x130039f8,63),
OBJECT_WITH_ACTS(60,-7379,413,2855,23,180,2,0x10000, Bhv_Custom_0x130039f8,63),
OBJECT_WITH_ACTS(0,0,-1,0,0,0,0,0x0, Bhv_Custom_0x13003b04,63),
RETURN()
};
const LevelScript local_warps_ttm_3_[] = {
WARP_NODE(10,36,1,42,0),
WARP_NODE(11,36,1,43,0),
WARP_NODE(0,36,1,44,0),
WARP_NODE(12,25,1,10,0),
WARP_NODE(243,36,1,10,0),
WARP_NODE(240,26,1,226,0),
WARP_NODE(241,26,1,210,0),
RETURN()
};
