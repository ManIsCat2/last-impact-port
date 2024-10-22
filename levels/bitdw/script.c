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
#include "levels/bitdw/header.h"
extern u8 _bitdw_segment_ESegmentRomStart[]; 
extern u8 _bitdw_segment_ESegmentRomEnd[];
const LevelScript level_bitdw_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _bitdw_segment_ESegmentRomStart, _bitdw_segment_ESegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group2_mio0SegmentRomStart,_group2_mio0SegmentRomEnd),
LOAD_RAW(12,_group2_geoSegmentRomStart,_group2_geoSegmentRomEnd),
LOAD_MIO0(6,_group12_mio0SegmentRomStart,_group12_mio0SegmentRomEnd),
LOAD_RAW(13,_group12_geoSegmentRomStart,_group12_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(23, custom_thwomp_geo),   
LOAD_MODEL_FROM_GEO(25, bitdw_floating_boat_geo),
LOAD_MODEL_FROM_GEO(31, bitdw_gate_to_star_geo),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_3),
JUMP_LINK(script_func_global_13),
JUMP_LINK(local_area_bitdw_1_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_bitdw_1_[] = {
AREA(1,Geo_bitdw_1_0x23e1700),
TERRAIN(col_bitdw_1_0xe0b8fe0),
SET_BACKGROUND_MUSIC(0,17),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_bitdw_1_),
JUMP_LINK(local_warps_bitdw_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_bitdw_1_[] = {
OBJECT(0,-12114,0,-47,0,180,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(0,5726,8755,7565,0,-154,0,0xb0000, bhvBowserCourseRedCoinStar),
OBJECT(23,-7539,2893,-1794,0,0,0,0xc0000, bhvThwomp),
OBJECT(E_MODEL_RED_COIN,-2113,1660,-6301,0,107,0,0x0, id_bhvRedCoin),
OBJECT(E_MODEL_RED_COIN,1245,1578,-6025,0,-151,0,0x0, id_bhvRedCoin),
OBJECT(E_MODEL_RED_COIN,-7191,2258,-3017,0,0,0,0x0, id_bhvRedCoin),
OBJECT(E_MODEL_RED_COIN,-4013,4090,4180,0,0,0,0x0, id_bhvRedCoin),
OBJECT(E_MODEL_RED_COIN,11337,5400,859,0,0,0,0x0, id_bhvRedCoin),
OBJECT(E_MODEL_RED_COIN,1001,8836,-404,0,0,0,0x0, id_bhvRedCoin),
OBJECT(E_MODEL_RED_COIN,1658,8900,6488,0,0,0,0x0, id_bhvRedCoin),
OBJECT(E_MODEL_RED_COIN,-7602,4222,-2791,0,0,0,0x0, id_bhvRedCoin),
OBJECT(122,-7262,2413,-667,0,0,0,0x1010000, bhvStar),
OBJECT(212,9182,9321,19769,0,0,0,0x0, bhv1Up),
OBJECT(24,-9175,7135,25029,0,0,0,0x0, bhvBooCage),
OBJECT(212,-9723,827,-6871,0,0,0,0x0, bhv1Up),
OBJECT(23,-11638,332,-3253,0,0,0,0x0, bhvThwomp),
OBJECT(23,-12630,332,-3253,0,0,0,0x0, bhvThwomp),
OBJECT(0,-2113,1557,-6301,0,0,0,0x20200000, bhvLllRotatingBlockWithFireBars),
OBJECT(0,-2113,1372,-6301,0,0,0,0x20200000, bhvLllRotatingBlockWithFireBars),
OBJECT(0,-2113,1557,-6301,0,0,0,0x60200000, bhvLllRotatingBlockWithFireBars),
OBJECT(0,-2113,1228,-6301,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,-3645,3839,2953,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,-7041,1237,-9650,0,-103,0,0x0, bhvCoinFormation),
/*OBJECT(0,-12115,-500,-5170,0,251,0,0x20700000, bhvGrandStar),
OBJECT(0,-12615,-500,-5170,0,251,0,0x20700000, bhvGrandStar),
OBJECT(0,-11615,-500,-5170,0,251,0,0x20700000, bhvGrandStar),
OBJECT(0,-8210,0,-10272,0,359,0,0x20700000, bhvGrandStar),
OBJECT(0,-8212,0,-9297,0,359,0,0x20700000, bhvGrandStar),
OBJECT(0,-8210,0,-9770,0,359,0,0x20700000, bhvGrandStar),
OBJECT(0,-5402,0,-9767,0,359,0,0x20700000, bhvGrandStar),
OBJECT(0,-5906,0,-8619,0,359,0,0x20700000, bhvGrandStar),
OBJECT(0,-5683,0,-9275,0,359,0,0x20700000, bhvGrandStar),
OBJECT(0,10694,5281,1905,0,138,0,0x20b00000, bhvGrandStar),
OBJECT(0,11694,5281,1905,0,138,0,0x20b00000, bhvGrandStar),
OBJECT(0,11694,5281,-200,0,138,0,0x20b00000, bhvGrandStar),
OBJECT(0,10694,5281,-200,0,138,0,0x20b00000, bhvGrandStar),
OBJECT(0,-3757,0,-7345,0,359,0,0x20700000, bhvGrandStar), not for now */
OBJECT(116,-2944,1418,-5000,0,0,0,0x0, bhvOneCoin),
OBJECT(116,-3485,1558,-4358,0,0,0,0x0, bhvOneCoin),
OBJECT(116,-4265,1698,-4019,0,0,0,0x0, bhvOneCoin),
OBJECT(116,-5075,1838,-3856,0,0,0,0x0, bhvOneCoin),
OBJECT(116,-5899,1978,-4030,0,0,0,0x0, bhvOneCoin),
OBJECT(116,-8710,3108,-5127,0,0,0,0x0, bhvOneCoin),
OBJECT(23,-640,3849,2322,0,90,0,0x0, bhvThwomp),
OBJECT(23,-640,3849,3573,0,90,0,0x0, bhvThwomp),
OBJECT(23,3210,5349,2322,0,90,0,0x0, bhvThwomp),
OBJECT(23,3210,5349,3573,0,90,0,0x0, bhvThwomp),
OBJECT(25,11938,5112,-4035,0,270,0,0x0, bhvBITDWBoat),
/*OBJECT(0,6282,6010,-4195,0,182,0,0x20700000, bhvGrandStar),
OBJECT(0,2503,7604,-2857,0,182,0,0x20700000, bhvGrandStar),
OBJECT(0,1519,8333,494,0,182,0,0x20700000, bhvGrandStar),
OBJECT(0,704,8333,1550,0,182,0,0x20700000, bhvGrandStar),
OBJECT(0,1413,8333,3361,0,177,0,0x20700000, bhvGrandStar),
OBJECT(0,1025,8333,4983,0,177,0,0x20700000, bhvGrandStar),
OBJECT(0,2207,8333,7046,0,177,0,0x20700000, bhvGrandStar),
OBJECT(0,3717,8333,7020,0,177,0,0x20700000, bhvGrandStar),*/
/*OBJECT(27,-11464,-1021,-5150,0,-90,0,0x1c0000, Bhv_Custom_0x13001750),
OBJECT(27,-12875,-1021,-5150,0,90,0,0x1c0000, Bhv_Custom_0x13001750),
OBJECT(27,-2730,-677,2481,0,0,0,0xd0630000, Bhv_Custom_0x13001750),
OBJECT(27,-4278,-677,3009,0,96,0,0xd0630000, Bhv_Custom_0x13001750),
OBJECT(27,-2909,-677,3697,0,-158,0,0xd0630000, Bhv_Custom_0x13001750),
OBJECT(27,-3727,-677,3601,0,-190,0,0xd0630000, Bhv_Custom_0x13001750),
OBJECT(27,-4278,-677,3009,0,79,0,0xd0630000, Bhv_Custom_0x13001750),
OBJECT(27,9727,4861,-3526,0,180,0,0x30000000, Bhv_Custom_0x13001750),
OBJECT(27,4165,6952,-4198,0,83,0,0x30000000, Bhv_Custom_0x13001750),
OBJECT(27,2910,7477,-2528,0,141,0,0x30000000, Bhv_Custom_0x13001750),
OBJECT(27,375,8294,-146,0,0,0,0x30000000, Bhv_Custom_0x13001750),
OBJECT(27,757,8231,3339,0,79,0,0x30000000, Bhv_Custom_0x13001750),
OBJECT(27,1007,8294,4790,0,182,0,0x30000000, Bhv_Custom_0x13001750),*/
OBJECT(23,139,1378,-6572,0,90,0,0x0, bhvThwomp),
//OBJECT(100,9597,8305,17149,0,180,0,0x0, bhvAlphaBooKey),
OBJECT(MODEL_STAR,9226,8606,18958,0,0,0,(5<<24), bhvStar),
OBJECT(188,9156,8281,7848,0,0,0,0x0, bhvBobomb),
OBJECT(188,8830,8281,17708,0,0,0,0x0, bhvBobomb),
OBJECT(31,9194,8354,18163,0,0,0,0x0, bhvBITDWGateToStar),
OBJECT(212,-642,5105,3604,0,0,0,0x0, bhv1Up),
//OBJECT(0,-7549,3740,2078,0,0,0,0x0, Bhv_Custom_0x13001bbc),
//OBJECT(53,11933,5400,-1620,0,0,0,0x10000, Bhv_Custom_0x13001bf0),
OBJECT(MODEL_FIRE_BULLY,6832,5054,2867,0,0,0,0x0, id_bhvSmallBully),
OBJECT(MODEL_FIRE_BULLY,6910,5054,3507,0,0,0,0x0, id_bhvSmallBully),
OBJECT(MODEL_FIRE_BULLY,10791,5400,1329,0,0,0,0x0, id_bhvSmallBully),
OBJECT(MODEL_FIRE_BULLY,6750,4969,2245,0,0,0,0x0, id_bhvSmallBully),
OBJECT(MODEL_FIRE_BULLY,10490,5400,745,0,0,0,0x0, id_bhvSmallBully),
OBJECT(MODEL_FIRE_BULLY,12008,5400,856,0,0,0,0x0, id_bhvSmallBully),
OBJECT(MODEL_FIRE_BULLY,10407,5400,2484,0,0,0,0x0, id_bhvSmallBully),
OBJECT(MODEL_FIRE_BULLY,11759,5400,2898,0,0,0,0x0, id_bhvSmallBully),
//start
OBJECT(137,12080,5372,-4115,0,0,0,(3 << 16), bhvExclamationBox),
//end
OBJECT(0,8704,15936,12288,0,0,0,0xcc6a0000,editor_Scroll_Texture),
RETURN()
};
const LevelScript local_warps_bitdw_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,16,2,207,0),
WARP_NODE(241,16,2,191,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,27,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
