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
#include "levels/cotmc/header.h"
extern u8 _cotmc_segment_ESegmentRomStart[]; 
extern u8 _cotmc_segment_ESegmentRomEnd[];
const LevelScript level_cotmc_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _cotmc_segment_ESegmentRomStart, _cotmc_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom19949824_skybox_mio0SegmentRomStart,_SkyboxCustom19949824_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group10_mio0SegmentRomStart,_group10_mio0SegmentRomEnd),
LOAD_RAW(12,_group10_geoSegmentRomStart,_group10_geoSegmentRomEnd),
LOAD_MIO0(6,_group14_mio0SegmentRomStart,_group14_mio0SegmentRomEnd),
LOAD_RAW(13,_group14_geoSegmentRomStart,_group14_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
// LOAD_MODEL_FROM_DL(22,0x07010db0,4),
// LOAD_MODEL_FROM_GEO(23,0x19001900),
// LOAD_MODEL_FROM_GEO(24,0x19001920),
// LOAD_MODEL_FROM_GEO(25,0x19001940),
// LOAD_MODEL_FROM_GEO(27,0x19001960),
LOAD_MODEL_FROM_GEO(29, haunted_door_geo),
LOAD_MODEL_FROM_GEO(31, metal_door_geo),
LOAD_MODEL_FROM_GEO(32, hazy_maze_door_geo),
LOAD_MODEL_FROM_GEO(34, castle_door_0_star_geo),
LOAD_MODEL_FROM_GEO(35, castle_door_1_star_geo),
LOAD_MODEL_FROM_GEO(36, castle_door_3_stars_geo),
LOAD_MODEL_FROM_GEO(37, key_door_geo),
LOAD_MODEL_FROM_GEO(38, castle_door_geo),
// LOAD_MODEL_FROM_GEO(39,0x030214f4),
// LOAD_MODEL_FROM_DL(40,0x03020fc4,4),
// LOAD_MODEL_FROM_DL(58,0x007fe670,4),
// LOAD_MODEL_FROM_DL(59,0x007fc2e0,4),
// LOAD_MODEL_FROM_DL(60,0x007fdf18,4),
// LOAD_MODEL_FROM_DL(132,0x08025f08,4),
// LOAD_MODEL_FROM_GEO(133,0x007e0000),
// LOAD_MODEL_FROM_DL(158,0x0302c8a0,4),
// LOAD_MODEL_FROM_DL(159,0x0302bcd0,4),
// LOAD_MODEL_FROM_DL(161,0x0301cb00,4),
// LOAD_MODEL_FROM_DL(164,0x04032a18,4),
// LOAD_MODEL_FROM_DL(201,0x080048e0,4),
// LOAD_MODEL_FROM_DL(218,0x08024bb8,4),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_11),
JUMP_LINK(script_func_global_15),
JUMP_LINK(local_area_cotmc_1_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_cotmc_1_[] = {
AREA(1,Geo_cotmc_1_0x3301700),
TERRAIN(col_cotmc_1_0xe0b7768),
SET_BACKGROUND_MUSIC(0,62),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_cotmc_1_),
JUMP_LINK(local_warps_cotmc_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_cotmc_1_[] = {
OBJECT_WITH_ACTS(0,-10547,0,2920,0,110,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,1961,-464,3836,0,-154,0,0x1000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(215,-1972,7816,-3318,0,-153,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-7612,349,-2312,0,107,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-2666,960,7677,0,-151,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,3417,1779,-646,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-5491,833,4119,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-6196,833,6642,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-5781,1685,1281,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,-1686,392,1157,0,0,0,0x0, bhvRedCoin,63),
/*OBJECT_WITH_ACTS(23,-4375,-379,-1351,0,84,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,-4310,-379,-290,0,-33,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,8589,-25,3852,0,96,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,-7981,5,1987,0,68,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,-10260,5,-1563,0,84,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,-7158,5,-5833,0,13,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,-4323,-394,-3844,0,48,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,4885,5,-7021,0,-44,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,7659,5,-3123,0,-54,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,5361,-394,6704,0,-67,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,2172,-394,-3506,0,-50,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,-7508,5,6729,0,-66,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(23,8754,0,2392,0,-70,0,0x0, bhvBetaChestBottom,63),*/
OBJECT_WITH_ACTS(0,2019,-754,3790,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,781,482,7908,0,-12,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,7096,-25,5875,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-1047,150,-7474,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-9182,109,5090,0,31,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(212,-6305,4962,881,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(212,-5831,2020,5374,0,0,0,0x0, bhv1Up,63),
//OBJECT_WITH_ACTS(24,-1978,-50,-3314,0,0,0,0x0, Bhv_Custom_0x130037b0,63),
//OBJECT_WITH_ACTS(25,-5832,1968,5377,0,-18,0,0x0, Bhv_Custom_0x130037cc,63),
OBJECT_WITH_ACTS(124,4556,-400,3020,0,29,0,0x560000, bhvMessagePanel,63),
/*OBJECT_WITH_ACTS(85,6322,-50,6797,0,-108,0,0x0, bhvFallingBowserPlatform,63),
OBJECT_WITH_ACTS(0,1923,25,-4511,0,0,0,0x0, Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,1896,25,-4488,0,0,0,0x0, Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,1919,6,-4478,0,0,0,0x0, Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,1852,25,-6522,0,0,0,0x0, Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,1882,25,-6545,0,0,0,0x0, Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,1898,6,-6503,0,0,0,0x0, Bhv_Custom_0x13001a24,63),*/
OBJECT_WITH_ACTS(124,1880,25,-6218,0,53,0,0x9c0000, bhvMessagePanel,63),
/*OBJECT_WITH_ACTS(27,-6,-394,-3338,0,51,0,0x0, bhvBowserBomb,63),
OBJECT_WITH_ACTS(27,-2219,444,-4706,0,190,0,0x0, bhvBowserBomb,63),
OBJECT_WITH_ACTS(27,-1901,5,-5887,0,174,0,0x0, bhvBowserBomb,63),
OBJECT_WITH_ACTS(27,-531,5,-6665,0,154,0,0x0, bhvBowserBomb,63),
OBJECT_WITH_ACTS(0,2004,25,-5529,0,0,0,0x0, Bhv_Custom_0x13003800,63),*/
OBJECT_WITH_ACTS(192,4650,0,-3743,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,5417,0,-3490,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-4063,-379,-781,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-7188,0,4375,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,729,-800,2552,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,7552,0,208,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-7829,-300,-1881,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-4583,-379,313,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,2813,-400,8698,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-7604,0,-4427,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,365,785,7083,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,4896,-400,3021,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-7183,-300,-2431,0,0,0,0x0, bhvGoomba,63),
/*OBJECT_WITH_ACTS(217,6375,479,-1217,0,8,0,0x0, Bhv_Custom_0x13003814,63),
OBJECT_WITH_ACTS(40,4321,-400,2836,0,0,0,0x4020000, Bhv_Custom_0x13001eb0,63),*/
RETURN()
};
const LevelScript local_warps_cotmc_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,215,0),
WARP_NODE(241,26,1,231,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,18,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(5,9,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
