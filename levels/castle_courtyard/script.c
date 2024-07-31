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
#include "levels/castle_courtyard/header.h"
extern u8 _castle_courtyard_segment_ESegmentRomStart[]; 
extern u8 _castle_courtyard_segment_ESegmentRomEnd[];
const LevelScript level_castle_courtyard_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _castle_courtyard_segment_ESegmentRomStart, _castle_courtyard_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom19949824_skybox_mio0SegmentRomStart,_SkyboxCustom19949824_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group4_mio0SegmentRomStart,_group4_mio0SegmentRomEnd),
LOAD_RAW(12,_group4_geoSegmentRomStart,_group4_geoSegmentRomEnd),
LOAD_MIO0(6,_group15_mio0SegmentRomStart,_group15_mio0SegmentRomEnd),
LOAD_RAW(13,_group15_geoSegmentRomStart,_group15_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_5),
JUMP_LINK(script_func_global_16),
JUMP_LINK(local_area_castle_courtyard_1_),
FREE_LEVEL_POOL(),
MARIO_POS(1,0,0,0,0),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_castle_courtyard_1_[] = {
AREA(1,Geo_castle_courtyard_1_0x3041700),
TERRAIN(col_castle_courtyard_1_0xe073bf8),
SET_BACKGROUND_MUSIC(0,16),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_castle_courtyard_1_),
JUMP_LINK(local_warps_castle_courtyard_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_castle_courtyard_1_[] = {
OBJECT_WITH_ACTS(0,313,-9,-2083,0,-14,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-1449,237,285,0,96,0,0xf10000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(23,3196,-12,5195,0,0,0,0x0,Bhv_Custom_0x130030e8,63),
OBJECT_WITH_ACTS(0,1144,421,2072,0,36,0,0xe10000, bhvAirborneStarCollectWarp,63),
OBJECT_WITH_ACTS(0,1144,421,2072,0,-144,0,0xd10000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(0,-1182,-182,5208,0,0,0,0xb0000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(0,-1932,342,4930,0,-5,0,0xea0000, bhvAirborneStarCollectWarp,63),
OBJECT_WITH_ACTS(0,-1959,199,5295,0,-13,0,0xda0000, bhvLaunchDeathWarp,63),
OBJECT_WITH_ACTS(0,5914,29,1294,0,0,0,0x20030000, bhvWarp,63),
OBJECT_WITH_ACTS(0,5745,254,2239,0,-23,0,0xe30000, bhvAirborneStarCollectWarp,63),
OBJECT_WITH_ACTS(0,5745,254,2239,0,-203,0,0xd30000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(195,-3750,75,1406,0,64,0,0x9a0000, bhvBobombBuddy,63),
OBJECT_WITH_ACTS(24,-6444,91,158,0,-22,0,0x0, Bhv_Custom_0x13003794,63),
OBJECT_WITH_ACTS(25,-6400,91,159,0,-45,0,0x720000, bhvStaticObject,63),
OBJECT_WITH_ACTS(0,-5063,313,-538,0,68,0,0xd70000, bhvAirborneStarCollectWarp,63),
OBJECT_WITH_ACTS(0,-5063,313,-538,0,68,0,0xe70000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(0,621,140,-3154,0,-18,0,0x18060000, bhvWarp,63),
OBJECT_WITH_ACTS(0,621,246,-3154,0,-18,0,0x18060000, bhvWarp,63),
OBJECT_WITH_ACTS(0,621,397,-3154,0,-18,0,0x60000, bhvWarp,63),
OBJECT_WITH_ACTS(0,621,496,-3154,0,-18,0,0x60000, bhvWarp,63),
OBJECT_WITH_ACTS(0,621,571,-3154,0,-18,0,0x60000, bhvWarp,63),
OBJECT_WITH_ACTS(0,621,660,-3154,0,-18,0,0x60000, bhvWarp,63),
OBJECT_WITH_ACTS(0,621,733,-3154,0,-18,0,0x60000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-807,70,3161,0,0,0,0x10020000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-611,242,2570,0,165,0,0xe20000, bhvAirborneStarCollectWarp,63),
OBJECT_WITH_ACTS(0,-611,242,2570,0,-15,0,0xd20000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(0,-2448,-174,-3200,0,0,0,0x20040000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-2176,91,-3194,0,90,0,0xe40000, bhvAirborneStarCollectWarp,63),
OBJECT_WITH_ACTS(0,-2441,-71,-3220,0,259,0,0xd40000, bhvLaunchDeathWarp,63),
OBJECT_WITH_ACTS(0,0,2917,0,0,0,0,0x0,Bhv_Custom_0x13003a60,63),
OBJECT_WITH_ACTS(0,-4148,39,1206,0,0,0,0x50000,Bhv_Custom_0x13003ca8,63),
OBJECT_WITH_ACTS(0,-3965,297,758,0,158,0,0xd50000, bhvAirborneStarCollectWarp,63),
OBJECT_WITH_ACTS(0,-3965,297,758,0,159,0,0xe50000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(22,4037,3,-439,0,0,0,0xd0000, bhvWarpPipe,63),
OBJECT_WITH_ACTS(0,3469,231,-290,0,104,0,0xed0000, bhvDeathWarp,63),
OBJECT_WITH_ACTS(53,3709,14,-570,0,104,0,0x0,Bhv_Custom_0x130042a4,63),
OBJECT_WITH_ACTS(53,3819,14,-129,0,-76,0,0x10000,Bhv_Custom_0x130042a4,63),
OBJECT_WITH_ACTS(221,-650,1590,3723,0,0,0,0x0, bhvMantaRay,63),
OBJECT_WITH_ACTS(0,8512,8704,8256,0,0,0,0xb8780000,editor_Scroll_Texture,191),
OBJECT_WITH_ACTS(0,8512,8704,12288,0,0,0,0xb87a0000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8704,12416,9216,0,0,0,0x269a0000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8640,11264,12288,0,0,0,0xe88a0000,editor_Scroll_Texture,63),
RETURN()
};
const LevelScript local_warps_castle_courtyard_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,27,2,10,0),
WARP_NODE(12,28,1,10,0),
WARP_NODE(225,25,1,10,0),
WARP_NODE(209,25,1,10,0),
WARP_NODE(226,25,1,10,0),
WARP_NODE(210,25,1,10,0),
WARP_NODE(227,25,1,10,0),
WARP_NODE(211,25,1,10,0),
WARP_NODE(228,25,1,10,0),
WARP_NODE(212,25,1,10,0),
WARP_NODE(229,25,1,10,0),
WARP_NODE(213,25,1,10,0),
WARP_NODE(231,25,1,10,0),
WARP_NODE(215,25,1,10,0),
WARP_NODE(234,25,1,10,0),
WARP_NODE(218,25,1,10,0),
WARP_NODE(240,26,1,10,0),
WARP_NODE(241,26,1,241,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,11,1,10,0),
WARP_NODE(2,36,1,10,0),
WARP_NODE(3,13,1,10,0),
WARP_NODE(4,14,1,10,0),
WARP_NODE(5,15,1,10,0),
WARP_NODE(6,6,1,88,0),
WARP_NODE(13,21,1,10,0),
WARP_NODE(237,25,1,10,0),
WARP_NODE(221,25,1,10,0),
RETURN()
};
