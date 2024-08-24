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
#include "levels/pss/header.h"
extern u8 _pss_segment_ESegmentRomStart[]; 
extern u8 _pss_segment_ESegmentRomEnd[];
const LevelScript level_pss_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _pss_segment_ESegmentRomStart, _pss_segment_ESegmentRomEnd),
LOAD_MIO0(        /*seg*/ 0x0B, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group2_mio0SegmentRomStart,_group2_mio0SegmentRomEnd),
LOAD_RAW(12,_group2_geoSegmentRomStart,_group2_geoSegmentRomEnd),
LOAD_MIO0(6,_group17_mio0SegmentRomStart,_group17_mio0SegmentRomEnd),
LOAD_RAW(13,_group17_geoSegmentRomStart,_group17_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_3),
JUMP_LINK(script_func_global_18),
JUMP_LINK(local_area_pss_1_),
JUMP_LINK(local_area_pss_2_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_pss_1_[] = {
AREA(1,Geo_pss_1_0x31a1700),
TERRAIN(col_pss_1_0xe04d668),
SET_BACKGROUND_MUSIC(0,47),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_pss_1_),
JUMP_LINK(local_warps_pss_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_pss_1_[] = {
OBJECT(0,117,938,9241,0,180,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(137,-6733,-1620,-5731,0,-154,0,0x10000, bhvExclamationBox),
OBJECT(87,144,-3052,-67,0,-153,0,0x0, bhvBigBully),
OBJECT(0,0,10625,0,0,107,0,0x0, Bhv_Custom_0x130022f0),
OBJECT(192,480,0,43,0,-151,0,0x0, bhvGoomba),
OBJECT(53,0,208,0,0,0,0,0x0, Bhv_Custom_0x13002324),
OBJECT(53,0,208,0,0,0,0,0x10000, Bhv_Custom_0x13002324),
OBJECT(53,0,208,0,0,0,0,0x20000, Bhv_Custom_0x13002324),
OBJECT(54,0,0,0,0,0,0,0x1010000, Bhv_Custom_0x13002324),
OBJECT(0,-4909,-1787,-6585,0,0,0,0x1000000, Bhv_Custom_0x13002344),
OBJECT(0,-5321,-1787,-7462,0,0,0,0x2000000, Bhv_Custom_0x13002344),
OBJECT(0,7783,-3204,-5849,0,0,0,0x4000000, Bhv_Custom_0x13002344),
OBJECT(0,8039,-3275,-5437,0,0,0,0x8000000, Bhv_Custom_0x13002344),
OBJECT(55,-4575,-2042,-7362,0,0,0,0x10000, Bhv_Custom_0x13002344),
OBJECT(57,6735,-3743,-3751,0,0,0,0x20000, Bhv_Custom_0x13002344),
OBJECT(122,9168,-3119,215,0,0,0,0x1000000, bhvStar),
OBJECT(192,3406,-2387,-8688,0,0,0,0x0, bhvGoomba),
OBJECT(192,-1289,-2387,-9440,0,0,0,0x0, bhvGoomba),
OBJECT(192,-1714,-2387,-7560,0,0,0,0x0, bhvGoomba),
OBJECT(192,2561,-2387,-7482,0,0,0,0x0, bhvGoomba),
OBJECT(192,3909,-2387,-6735,0,0,0,0x0, bhvGoomba),
OBJECT(58,6725,-3649,-6028,0,-11,0,0x540000, Bhv_Custom_0x13002398),
OBJECT(58,6014,-3649,-6835,0,46,0,0x470000, Bhv_Custom_0x13002398),
OBJECT(58,7651,-3649,-5290,0,35,0,0xa0000, Bhv_Custom_0x13002398),
OBJECT(58,7280,-3649,-5732,0,0,0,0xcf0000, Bhv_Custom_0x13002398),
OBJECT(58,6163,-3649,-7431,0,7,0,0x640000, Bhv_Custom_0x13002398),
OBJECT(58,5646,-3649,-7067,0,23,0,0x140000, Bhv_Custom_0x13002398),
OBJECT(58,5615,-3649,-7554,0,-30,0,0xec0000, Bhv_Custom_0x13002398),
OBJECT(58,5291,-3649,-6837,0,11,0,0x0, Bhv_Custom_0x13002398),
OBJECT(212,-8650,-2057,-2759,0,0,0,0x0, bhv1Up),
OBJECT(0,-708,-3059,-3513,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,2363,-2920,-1289,0,38,0,0x0, bhvCoinFormation),
OBJECT(192,2427,-3074,337,0,0,0,0x0, bhvGoomba),
OBJECT(192,876,-2944,-2697,0,0,0,0x0, bhvGoomba),
OBJECT(59,0,0,0,0,0,0,0x10000, Bhv_Custom_0x130023ac),
OBJECT(59,0,0,0,0,0,0,0x20000, Bhv_Custom_0x130023ac),
OBJECT(59,0,0,0,0,0,0,0x30000, Bhv_Custom_0x130023ac),
OBJECT(59,0,0,0,0,0,0,0x40000, Bhv_Custom_0x130023ac),
OBJECT(59,0,0,0,0,0,0,0x50000, Bhv_Custom_0x130023ac),
OBJECT(59,0,0,0,0,0,0,0x60000, Bhv_Custom_0x130023ac),
OBJECT(59,0,0,0,0,0,0,0x70000, Bhv_Custom_0x130023ac),
OBJECT(59,0,0,0,0,0,0,0x80000, Bhv_Custom_0x130023ac),
RETURN()
};
const LevelScript local_warps_pss_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(153,7,1,10,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,16,2,36,0),
WARP_NODE(241,16,2,37,0),
RETURN()
};
const LevelScript local_area_pss_2_[] = {
AREA(2,Geo_pss_2_0x31a1600),
TERRAIN(col_pss_2_0x703b148),
SET_BACKGROUND_MUSIC(0,47),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_pss_2_),
JUMP_LINK(local_warps_pss_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_pss_2_[] = {
OBJECT(0,-654,-3587,13441,0,180,0,0xa0000, bhvSpinAirborneWarp),
OBJECT(0,-531,-2968,8766,0,0,0,0x10000, Bhv_Custom_0x13003404),
OBJECT(0,277,137,4088,0,0,0,0x0, Bhv_Custom_0x13003404),
OBJECT(24,-562,-3723,8861,0,0,0,0x0, Bhv_Custom_0x13003438),
OBJECT(0,1297,-1865,5260,0,0,0,0x110000, bhvCoinFormation),
OBJECT(0,-927,-759,7609,0,50,0,0x0, bhvCoinFormation),
OBJECT(0,247,46,4504,0,0,0,0x20000, bhvCoinFormation),
OBJECT(0,342,1326,2079,0,0,0,0x130000, bhvCoinFormation),
OBJECT(0,311,2251,-11116,0,0,0,0x0, bhvCoinFormation),
OBJECT(0,303,2251,-686,0,0,0,0x0, bhvCoinFormation),
OBJECT(0,-173,2531,-4364,0,0,0,0x110000, bhvCoinFormation),
OBJECT(0,306,2251,-7904,0,0,0,0x0, bhvCoinFormation),
OBJECT(25,-1315,0,5345,0,90,0,0x0, bhvSmallBully),
OBJECT(25,-1347,-165,5902,0,90,0,0x0, bhvSmallBully),
OBJECT(25,-1357,-363,6362,0,90,0,0x0, bhvSmallBully),
OBJECT(25,-1342,-515,6825,0,90,0,0x0, bhvSmallBully),
OBJECT(25,-315,1505,1633,0,0,0,0xb8010000, bhvSmallBully),
OBJECT(25,-315,842,1833,0,0,0,0x78010000, bhvSmallBully),
OBJECT(25,-315,176,2033,0,0,0,0x38010000, bhvSmallBully),
OBJECT(25,-315,2175,1433,0,0,0,0xf8010000, bhvSmallBully),
OBJECT(25,113,1505,1633,0,0,0,0xb8010000, bhvSmallBully),
OBJECT(25,113,842,1833,0,0,0,0x78010000, bhvSmallBully),
OBJECT(25,113,176,2033,0,0,0,0x38010000, bhvSmallBully),
OBJECT(25,113,2175,1433,0,0,0,0xf8010000, bhvSmallBully),
OBJECT(25,503,1505,1633,0,0,0,0xb8010000, bhvSmallBully),
OBJECT(25,503,842,1833,0,0,0,0x78010000, bhvSmallBully),
OBJECT(25,503,176,2033,0,0,0,0x38010000, bhvSmallBully),
OBJECT(25,503,2175,1433,0,0,0,0xf8010000, bhvSmallBully),
OBJECT(25,893,1505,1633,0,0,0,0xb8010000, bhvSmallBully),
OBJECT(25,893,842,1833,0,0,0,0x78010000, bhvSmallBully),
OBJECT(25,893,176,2033,0,0,0,0x38010000, bhvSmallBully),
OBJECT(25,893,2175,1433,0,0,0,0xf8010000, bhvSmallBully),
OBJECT(122,289,2550,-13583,0,0,0,0x7000000, bhvStar),
RETURN()
};
const LevelScript local_warps_pss_2_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,234,0),
WARP_NODE(241,26,1,218,0),
RETURN()
};
