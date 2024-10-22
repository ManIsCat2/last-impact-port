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
#include "levels/thi/header.h"
extern u8 _thi_segment_ESegmentRomStart[]; 
extern u8 _thi_segment_ESegmentRomEnd[];
const LevelScript level_thi_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _thi_segment_ESegmentRomStart, _thi_segment_ESegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group1_mio0SegmentRomStart,_group1_mio0SegmentRomEnd),
LOAD_RAW(12,_group1_geoSegmentRomStart,_group1_geoSegmentRomEnd),
LOAD_MIO0(6,_group17_mio0SegmentRomStart,_group17_mio0SegmentRomEnd),
LOAD_RAW(13,_group17_geoSegmentRomStart,_group17_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(22, spring_mushroom_geo),
LOAD_MODEL_FROM_GEO(23, thi_flying_train_geo),
LOAD_MODEL_FROM_GEO(24, thi_fan_geo),
LOAD_MODEL_FROM_GEO(25, thi2_platform_geo),
LOAD_MODEL_FROM_GEO(31, thi_circuit_geo),

LOAD_MODEL_FROM_GEO(54, blue_virus_boss_geo),
LOAD_MODEL_FROM_GEO(55, red_virus_boss_geo),
LOAD_MODEL_FROM_GEO(56, yellow_virus_boss_geo),
LOAD_MODEL_FROM_GEO(217, thi_static_gray_block_geo),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_2),
JUMP_LINK(script_func_global_18),
JUMP_LINK(local_area_thi_1_),
JUMP_LINK(local_area_thi_2_),
FREE_LEVEL_POOL(),
MARIO_POS(1,0,0,4096,0),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_thi_1_[] = {
AREA(1,Geo_thi_1_0x1e61700),
TERRAIN(col_thi_1_0xe094020),
SET_BACKGROUND_MUSIC(0,0),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_thi_1_),
JUMP_LINK(local_warps_thi_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_thi_1_[] = {
OBJECT_WITH_ACTS(0,-448,-395,5821,0,-162,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(122,905,3403,-24761,0,-154,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(122,-6562,9365,4594,0,-153,0,0x1000000, bhvStar,63),
OBJECT_WITH_ACTS(122,11134,4456,-1786,0,107,0,0x3000000, bhvStar,63),
OBJECT_WITH_ACTS(0,165,91,-4777,0,-151,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-619,485,-10674,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-3106,994,-13946,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,2030,-300,-13034,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-107,-349,-17475,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,9477,-336,-3688,0,0,0,0x1000000, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,12066,555,-4240,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,9326,425,-8678,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,13945,-354,-8837,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(212,-7324,5962,-3748,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,-3478,3177,-1148,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-6255,1555,5016,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-6747,2668,2850,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-4474,1443,4852,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(22,13740,1639,-8286,0,0,0,0x0, bhvSpringShroom,63),
OBJECT_WITH_ACTS(23,6115,-644,-8540,0,-90,0,0x0, bhvBigBullyWithMinions,63),
OBJECT_WITH_ACTS(24,1750,4415,-23638,0,-180,90,0x16f00000,bhvTHIFan,63),
OBJECT_WITH_ACTS(24,1124,-245,1,0,0,0,0xff0000,bhvTHIFan,63),
OBJECT_WITH_ACTS(24,5140,-615,-14784,0,0,0,43,bhvTHIFan,63),
OBJECT_WITH_ACTS(24,13641,500,-8784,0,-180,90,0x4930000,bhvTHIFan,63),
OBJECT_WITH_ACTS(24,-7004,6286,383,0,0,90,0x4930000,bhvTHIFan,63),
OBJECT_WITH_ACTS(0,11698,484,-10441,0,0,0,0x10000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,11723,1567,-11162,0,0,0,0x10000, bhvWarp,63),
OBJECT_WITH_ACTS(0,12002,1491,-11129,0,90,0,0x20000, bhvSpinAirborneWarp,63),
//OBJECT_WITH_ACTS(27,6260,2541,-21085,0,0,0,0x0,Bhv_Custom_0x130036e4,63),
OBJECT_WITH_ACTS(31,9469,13,-4793,0,0,0,0x0, bhvTHICircuit,63),
/*OBJECT_WITH_ACTS(0,10452,-254,-9642,0,0,0,0x0,Bhv_Custom_0x1300371c,63),
OBJECT_WITH_ACTS(0,12264,-254,-9658,0,0,0,0x0,Bhv_Custom_0x1300371c,63),
OBJECT_WITH_ACTS(0,12990,-254,-8726,0,0,0,0x10000,Bhv_Custom_0x1300371c,63),
OBJECT_WITH_ACTS(0,12991,-254,-6183,0,0,0,0x10000,Bhv_Custom_0x1300371c,63),
OBJECT_WITH_ACTS(0,12993,-254,-3602,0,0,0,0x10000,Bhv_Custom_0x1300371c,63),
OBJECT_WITH_ACTS(0,12266,-254,-2898,0,0,0,0x0,Bhv_Custom_0x1300371c,63),
OBJECT_WITH_ACTS(0,9645,-254,-2910,0,0,0,0x0,Bhv_Custom_0x1300371c,63),
OBJECT_WITH_ACTS(32,9474,-35,-3684,0,0,0,0x0, Bhv_Custom_0x13003730,63),*/
OBJECT_WITH_ACTS(0,1121,-485,21,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,5134,-100,-14823,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-4064,578,-7977,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,11438,-88,-5125,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,6208,2220,-18979,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,833,-324,-6556,0,37,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(101,1733,64,-12758,0,36,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(0,2496,64,-13230,0,36,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(212,9485,2981,-1836,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,12298,1932,-10739,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(212,11523,708,-11066,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(101,-555,-409,4207,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,1041,-300,-11232,0,0,0,0x0, bhvScuttlebug,63),
//OBJECT_WITH_ACTS(34,11296,-300,-8723,0,-29,0,0x0, Bhv_Custom_0x13003748,63),
OBJECT_WITH_ACTS(101,-3305,3177,-1132,0,0,0,0x0, bhvScuttlebug,63),
//OBJECT_WITH_ACTS(34,3374,2069,-17503,0,78,0,0x0, Bhv_Custom_0x13003748,63),
OBJECT_WITH_ACTS(101,14476,675,-2387,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,11140,-254,-7161,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(0,-6580,6733,-1909,0,90,0,0x0, bhvCoinFormation,63),
//OBJECT_WITH_ACTS(34,1088,-349,-15183,0,-55,0,0x0, Bhv_Custom_0x13003748,63),
//OBJECT_WITH_ACTS(0,4988,-8021,-30165,0,0,0,0x10000, Bhv_Custom_0x13003748,63),
//OBJECT_WITH_ACTS(34,-1463,-349,-15998,0,14,0,0x0, Bhv_Custom_0x13003748,63),
//OBJECT_WITH_ACTS(53,0,0,0,0,0,0,0x0, Bhv_Custom_0x13003764,63),
OBJECT_WITH_ACTS(54,10386,1170,-1997,0,180,0,(5 << 24), bhvVirusBossBlue,32),
OBJECT_WITH_ACTS(55,10058,1170,-1997,0,180,0,(5 << 24), bhvVirusBossRed,32),
OBJECT_WITH_ACTS(56,9739,1170,-1997,0,180,0,(5 << 24), bhvVirusBossYellow,32),
OBJECT_WITH_ACTS(129,9183,-254,-8097,0,0,0,0x30000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(129,9613,-254,-8148,0,0,0,0x10000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(129,-2928,-300,-12349,0,37,0,0x30000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(129,-3649,-300,-12434,0,37,0,0x0, bhvBreakableBox,63),
OBJECT_WITH_ACTS(0,12830,2121,-9546,0,146,0,0xc000000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(217,-7491,3660,-1295,0,0,0,0x0, bhvTHIStaticGrayBlock,63),
OBJECT_WITH_ACTS(124,13544,1639,-8578,0,-194,0,0x3a0000, bhvMessagePanel,63),
OBJECT_WITH_ACTS(0,8768,8448,9216,0,0,0,0x6aea0000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8640,9984,12288,0,0,0,0xea280000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8640,9984,12288,0,0,0,0xea280000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8640,9984,12288,0,0,0,0xea280000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8768,9088,9216,0,0,0,0x882a0000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8768,9088,10240,0,0,0,0x858a0000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8768,8960,12288,0,0,0,0x834a0000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(0,8768,9344,10240,0,0,0,0x8aca0000,editor_Scroll_Texture,63),
RETURN()
};
const LevelScript local_warps_thi_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,227,0),
WARP_NODE(241,26,1,211,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,13,2,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,14,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_thi_2_[] = {
AREA(2,Geo_thi_2_0x1e61600),
TERRAIN(col_thi_2_0x7012d00),
SET_BACKGROUND_MUSIC(0,0),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_thi_2_),
JUMP_LINK(local_warps_thi_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_thi_2_[] = {
OBJECT_WITH_ACTS(0,16,141,-1015,0,0,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,3,141,4242,0,0,0,0x180a0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,6,141,-1681,0,0,0,0x180b0000, bhvWarp,63),
OBJECT_WITH_ACTS(25,-313,-8,677,0,0,0,0x0,bhvTHI2Platform,63),
OBJECT_WITH_ACTS(25,313,-8,1979,0,0,0,0x0,bhvTHI2Platform,63),
OBJECT_WITH_ACTS(148,684,144,-483,0,0,0,0x0, bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(148,-715,229,545,0,0,0,0x0, bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(148,54,213,1300,0,0,0,0x0, bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(148,-447,154,3116,0,0,0,0x0, bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(148,-23,185,-790,0,0,0,0x0, bhvHiddenStarTrigger,63),
OBJECT_WITH_ACTS(0,344,341,3116,0,0,0,0x2000000, bhvHiddenStar,63),
RETURN()
};
const LevelScript local_warps_thi_2_[] = {
WARP_NODE(10,13,1,1,0),
WARP_NODE(11,13,1,2,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,26,1,227,0),
WARP_NODE(241,26,1,211,0),
RETURN()
};
