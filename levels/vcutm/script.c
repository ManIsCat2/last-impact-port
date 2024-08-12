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
#include "levels/vcutm/header.h"
extern u8 _vcutm_segment_ESegmentRomStart[]; 
extern u8 _vcutm_segment_ESegmentRomEnd[];
const LevelScript level_vcutm_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _vcutm_segment_ESegmentRomStart, _vcutm_segment_ESegmentRomEnd),
LOAD_MIO0(        /*seg*/ 0x0B, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom40369856_skybox_mio0SegmentRomStart,_SkyboxCustom40369856_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group11_mio0SegmentRomStart,_group11_mio0SegmentRomEnd),
LOAD_RAW(12,_group11_geoSegmentRomStart,_group11_geoSegmentRomEnd),
LOAD_MIO0(6,_group13_mio0SegmentRomStart,_group13_mio0SegmentRomEnd),
LOAD_RAW(13,_group13_geoSegmentRomStart,_group13_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_12),
JUMP_LINK(script_func_global_14),
JUMP_LINK(local_area_vcutm_1_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,0,1280,0),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_vcutm_1_[] = {
AREA(1,Geo_vcutm_1_0x2541700),
TERRAIN(col_vcutm_1_0xe0423c0),
SET_BACKGROUND_MUSIC(0, 63),
TERRAIN_TYPE(5),
JUMP_LINK(local_objects_vcutm_1_),
JUMP_LINK(local_warps_vcutm_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_vcutm_1_[] = {
OBJECT(0,-110,-1581,-110,0,0,0,0xa0000, bhvSwimmingWarp),
OBJECT(0,209,-1693,-207,0,-154,0,0x4000000, bhvHiddenRedCoinStar),
OBJECT(215,-2173,-1442,-1990,0,-153,0,0x0, bhvRedCoin),
OBJECT(215,436,-901,-2836,0,107,0,0x0, bhvRedCoin),
OBJECT(215,-2643,-1848,2496,0,-151,0,0x0, bhvRedCoin),
OBJECT(215,2019,-1990,1842,0,0,0,0x0, bhvRedCoin),
OBJECT(215,2515,-1532,-2515,0,0,0,0x0, bhvRedCoin),
OBJECT(215,-1683,-1815,101,0,0,0,0x0, bhvRedCoin),
OBJECT(215,2788,-1879,-323,0,0,0,0x0, bhvRedCoin),
OBJECT(215,289,-1825,2169,0,0,0,0x0, bhvRedCoin),
OBJECT(168,2856,-2167,-1481,0,0,0,0x10000000, Bhv_Custom_0x13003830),
OBJECT(168,2896,-2167,-1459,0,0,0,0x90000000, Bhv_Custom_0x13003830),
OBJECT(168,-682,-2221,-837,0,0,0,0x20000000, Bhv_Custom_0x13003830),
OBJECT(168,-720,-2221,-848,0,0,0,0xa0000000, Bhv_Custom_0x13003830),
OBJECT(168,2867,-2143,2613,0,0,0,0xc0000000, Bhv_Custom_0x13003830),
OBJECT(168,2801,-2143,2600,0,0,0,0x40000000, Bhv_Custom_0x13003830),
OBJECT(168,-1430,-2148,2049,0,0,0,0xe0000000, Bhv_Custom_0x13003830),
OBJECT(168,-1442,-2148,2116,0,0,0,0x70000000, Bhv_Custom_0x13003830),
OBJECT(0,2717,-2020,689,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,-704,-1565,-2663,0,0,0,0x130000, bhvCoinFormation),
OBJECT(0,-2081,-1895,1469,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,182,-1062,-2829,0,0,0,0x0, bhvLargeFishGroup),
OBJECT(0,-2188,-1108,-2701,0,0,0,0x0, bhvFish2),
OBJECT(0,2290,-1339,2714,0,0,0,0x0, bhvFish3),
OBJECT(0,-624,-646,-644,0,0,0,0x0, bhvFish3),
OBJECT(53,0,1108,0,0,0,0,0x770000, Bhv_Custom_0x13003844),
OBJECT(53,250,753,-1666,0,0,0,0x890000, Bhv_Custom_0x13003844),
OBJECT(53,-3232,-2,970,0,0,0,0x120000, Bhv_Custom_0x13003844),
OBJECT(53,474,92,-2953,0,0,0,0x440000, Bhv_Custom_0x13003844),
OBJECT(53,2733,0,2344,0,0,0,0xe20000, Bhv_Custom_0x13003844),
OBJECT(53,-657,0,2304,0,0,0,0xf50000, Bhv_Custom_0x13003844),
OBJECT(0,-1146,-1940,-2188,0,0,0,0x0, bhvSeaweedBundle),
OBJECT(0,2240,-1989,-990,0,0,0,0x0, bhvSeaweedBundle),
OBJECT(0,-2604,-1932,1458,0,0,0,0x0, bhvSeaweedBundle),
OBJECT(0,1563,-1941,2448,0,0,0,0x0, bhvSeaweedBundle),
OBJECT(0,2708,-2043,1563,0,0,0,0x0, bhvSeaweedBundle),
OBJECT(0,-2396,-1994,-417,0,0,0,0x0, bhvSeaweedBundle),
OBJECT(0,365,-1930,573,0,0,0,0x0, bhvSeaweedBundle),
OBJECT(0,156,-1986,-1042,0,0,0,0x0, bhvSeaweedBundle),
RETURN()
};
const LevelScript local_warps_vcutm_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,6,2,218,0),
WARP_NODE(241,6,2,234,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,19,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
