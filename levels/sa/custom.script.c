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
#include "levels/sa/header.h"
extern u8 _sa_segment_ESegmentRomStart[]; 
extern u8 _sa_segment_ESegmentRomEnd[];
#include "levels/bbh/header.h"
const LevelScript level_sa_entry[] = {
INIT_LEVEL(),
LOAD_MIO0(0x07, _bbh_segment_7SegmentRomStart, _bbh_segment_7SegmentRomEnd),
LOAD_RAW(0x1A, _bbhSegmentRomStart, _bbhSegmentRomEnd),
LOAD_RAW(0x0E, _sa_segment_ESegmentRomStart, _sa_segment_ESegmentRomEnd),
LOAD_MIO0(        /*seg*/ 0x0B, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd),
LOAD_MIO0(0xA,_bbh_skybox_mio0SegmentRomStart,_bbh_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group2_mio0SegmentRomStart,_group2_mio0SegmentRomEnd),
LOAD_RAW(12,_group2_geoSegmentRomStart,_group2_geoSegmentRomEnd),
LOAD_MIO0(6,_group15_mio0SegmentRomStart,_group15_mio0SegmentRomEnd),
LOAD_RAW(13,_group15_geoSegmentRomStart,_group15_geoSegmentRomEnd),
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
// LOAD_MODEL_FROM_GEO(53,0x19001900),
// LOAD_MODEL_FROM_GEO(54,0x190014c0),
// LOAD_MODEL_FROM_GEO(55,0x19001480),
// LOAD_MODEL_FROM_GEO(56,0x190014a0),
LOAD_MODEL_FROM_GEO(57,sa_static_flower_geo),
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
JUMP_LINK(script_func_global_16),
JUMP_LINK(local_area_sa_1_),
JUMP_LINK(local_area_sa_2_),
JUMP_LINK(local_area_sa_3_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_sa_1_[] = {
AREA(1,Geo_sa_1_0x2801700),
TERRAIN(col_sa_1_0xe054e50),
SET_BACKGROUND_MUSIC(0,56),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_sa_1_),
JUMP_LINK(local_warps_sa_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_sa_1_[] = {
OBJECT(0,-1929,123,2850,0,-270,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(0,775,383,242,0,-154,0,0x0, bhvHiddenRedCoinStar),
OBJECT(215,3617,2374,-4328,0,-153,0,0x0, bhvRedCoin),
OBJECT(215,530,16,4845,0,107,0,0x0, bhvRedCoin),
OBJECT(215,3713,343,4440,0,-151,0,0x0, bhvRedCoin),
OBJECT(215,2607,459,-2165,0,0,0,0x0, bhvRedCoin),
OBJECT(215,3046,813,-4923,0,0,0,0x0, bhvRedCoin),
OBJECT(215,-2302,147,-4108,0,0,0,0x0, bhvRedCoin),
OBJECT(215,-2109,842,4402,0,0,0,0x0, bhvRedCoin),
OBJECT(215,4304,148,325,0,0,0,0x0, bhvRedCoin),
OBJECT(0,94,78,-2143,0,-59,0,0x0, bhvCoinFormation),
OBJECT(0,794,148,251,0,0,0,0x20000, bhvCoinFormation),
OBJECT(192,1847,153,-369,0,0,0,0x10000, bhvGoomba),
OBJECT(192,-2124,43,1708,0,0,0,0x10000, bhvGoomba),
OBJECT(192,3555,1405,-3786,0,0,0,0x10000, bhvGoomba),
OBJECT(212,4217,2334,-4724,0,0,0,0x0, bhv1Up),
OBJECT(212,-1823,1723,5081,0,0,0,0x0, bhv1Up),
OBJECT(0,4539,1895,-3983,0,0,0,0x30000, bhvFadingWarp),
OBJECT(0,1161,1006,-4831,0,0,0,0x40000, bhvFadingWarp),
OBJECT(0,1345,1013,-4924,0,0,0,0x40000, bhvFadingWarp),
OBJECT(0,4381,1895,-3903,0,0,0,0x30000, bhvFadingWarp),
OBJECT(0,958,1020,-4809,0,0,0,0x40000, bhvFadingWarp),
/*OBJECT(53,-1327,88,-3547,0,0,0,0x0, Bhv_Custom_0x13002758),
OBJECT(53,-1568,88,-3695,0,0,0,0x10000, Bhv_Custom_0x13002758),
OBJECT(53,-1318,88,-4087,0,0,0,0x20000, Bhv_Custom_0x13002758),
OBJECT(53,-1087,88,-4455,0,0,0,0x30000, Bhv_Custom_0x13002758),
OBJECT(53,-1775,88,-3837,0,0,0,0x40000, Bhv_Custom_0x13002758),
OBJECT(53,-1533,88,-4222,0,0,0,0x50000, Bhv_Custom_0x13002758),
OBJECT(53,-1295,88,-4591,0,0,0,0x60000, Bhv_Custom_0x13002758),
OBJECT(53,-1995,88,-3982,0,0,0,0x70000, Bhv_Custom_0x13002758),
OBJECT(53,-1760,88,-4362,0,0,0,0x80000, Bhv_Custom_0x13002758),
OBJECT(53,-1527,88,-4732,0,0,0,0x90000, Bhv_Custom_0x13002758),
OBJECT(53,-989,88,-4087,0,0,0,0x10a0000, Bhv_Custom_0x13002758),
OBJECT(53,-1327,88,-5045,0,0,0,0xb0000, Bhv_Custom_0x13002758),
OBJECT(53,-1098,88,-4901,0,0,0,0xc0000, Bhv_Custom_0x13002758),
OBJECT(53,-875,88,-4772,0,0,0,0xd0000, Bhv_Custom_0x13002758),
OBJECT(53,-650,88,-4626,0,0,0,0xe0000, Bhv_Custom_0x13002758),*/
RETURN()
};
const LevelScript local_warps_sa_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,6,1,206,0),
WARP_NODE(241,6,1,222,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,20,1,4,0),
WARP_NODE(4,20,1,3,0),
WARP_NODE(153,18,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_sa_2_[] = {
AREA(2,Geo_sa_2_0x2801600),
TERRAIN(col_sa_2_0xe0a9380),
SET_BACKGROUND_MUSIC(0,0),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_sa_2_),
JUMP_LINK(local_warps_sa_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_sa_2_[] = {
OBJECT(0,173,10,319,0,-180,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(0,171,44,-417,0,0,0,0x10b0000, bhvBooCage),
RETURN()
};
const LevelScript local_warps_sa_2_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,20,1,10,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,6,1,206,0),
WARP_NODE(241,6,1,222,0),
RETURN()
};
const LevelScript local_area_sa_3_[] = {
AREA(3,Geo_sa_3_0x2801500),
TERRAIN(col_sa_3_0xe0f0c68),
SET_BACKGROUND_MUSIC(0,50),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_sa_3_),
JUMP_LINK(local_warps_sa_3_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_sa_3_[] = {
OBJECT(0,-1017,-71,720,0,90,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(0,11183,3313,993,0,0,0,0x1000000, bhvHiddenRedCoinStar),
OBJECT(215,10047,3700,-284,0,0,0,0x1010000, bhvRedCoin),
OBJECT(101,6216,2306,1394,0,0,0,0x1010000, bhvGhostHuntBoo),
OBJECT(101,12918,2900,-3837,0,-19,0,0x1010000, bhvGhostHuntBoo),
OBJECT(101,11540,2900,3898,0,-201,0,0x1010000, bhvGhostHuntBoo),
OBJECT(215,8066,4650,2263,0,0,0,0x0, bhvRedCoin),
OBJECT(215,11805,3000,1773,0,0,0,0x0, bhvRedCoin),
OBJECT(215,8207,3000,461,0,0,0,0x0, bhvRedCoin),
OBJECT(215,14373,2938,-272,0,0,0,0x0, bhvRedCoin),
OBJECT(54,3757,-1332,2955,0,0,0,0x0, Bhv_Custom_0x13002780),
OBJECT(130,2967,1013,2510,0,-24,0,0x0, bhvBreakableBox),
OBJECT(130,2967,1213,2510,0,-24,0,0x0, bhvBreakableBox),
OBJECT(130,2967,1413,2510,0,-24,0,0x0, bhvBreakableBox),
OBJECT(130,2741,1213,2415,0,-24,0,0x0, bhvBreakableBox),
OBJECT(130,2741,1013,2415,0,-24,0,0x0, bhvBreakableBox),
OBJECT(137,766,278,-940,0,0,0,0x70000, bhvExclamationBox),
OBJECT(55,10006,2900,-241,0,0,0,0x0, Bhv_Custom_0x1300279c),
OBJECT(57,14371,2925,-252,0,0,0,0x0, bhvStaticSAFlower),
OBJECT(101,11861,3058,1272,0,90,0,0x6b6b0000, bhvBulletBillCannon),
OBJECT(124,8962,3000,934,0,-55,0,0x7a0000, bhvMessagePanel),
OBJECT(124,-844,-76,903,0,-143,0,0x550000, bhvMessagePanel),
RETURN()
};
const LevelScript local_warps_sa_3_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,20,1,10,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,6,1,47,0),
WARP_NODE(241,6,1,46,0),
RETURN()
};
