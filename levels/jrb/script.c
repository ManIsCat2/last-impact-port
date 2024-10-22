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
#include "levels/jrb/header.h"
extern u8 _jrb_segment_ESegmentRomStart[]; 
extern u8 _jrb_segment_ESegmentRomEnd[];
const LevelScript level_jrb_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _jrb_segment_ESegmentRomStart, _jrb_segment_ESegmentRomEnd),
LOAD_MIO0(        /*seg*/ 0x0B, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom31456960_skybox_mio0SegmentRomStart,_SkyboxCustom31456960_skybox_mio0SegmentRomEnd),
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
LOAD_MODEL_FROM_GEO(23, jrb_airballon_stand_geo),
LOAD_MODEL_FROM_GEO(24, star_2d_geo),
LOAD_MODEL_FROM_GEO(27, lighthouse_mech_geo),
LOAD_MODEL_FROM_GEO(57, tnt_and_boulder_geo),
LOAD_MODEL_FROM_GEO(60, cork_drain_water_geo),
LOAD_MODEL_FROM_GEO(MODEL_TRAMPOLINE_CENTER,       springboard_spring_geo),
JUMP_LINK(local_area_jrb_1_),
JUMP_LINK(local_area_jrb_2_),
JUMP_LINK(local_area_jrb_3_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_jrb_1_[] = {
AREA(1,Geo_jrb_1_0x1d01700),
TERRAIN(col_jrb_1_0xe0a8ec0),
SET_BACKGROUND_MUSIC(0,37),
TERRAIN_TYPE(5),
JUMP_LINK(local_objects_jrb_1_),
JUMP_LINK(local_warps_jrb_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_jrb_1_[] = {
OBJECT_WITH_ACTS(0,-6114,1428,-3609,0,103,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-8419,50,580,0,-154,0,0x0, bhvMrIParticle,16),
OBJECT_WITH_ACTS(24,-3529,3481,6741,0,0,0,0x0,bhv2DStar,63),
OBJECT_WITH_ACTS(0,-7471,1024,-3065,0,107,0,0x0, bhvMrIParticle,47),
OBJECT_WITH_ACTS(0,4551,-19,6782,0,-151,0,0x50000, bhvWarp,63),
//OBJECT_WITH_ACTS(0,-4007,5360,-7035,0,83,0,0xa0000, bhvUkikiCage,63),
//OBJECT_WITH_ACTS(100,11476,365,997,0,0,0,0x0, Bhv_Custom_0x13002210,47),
OBJECT_WITH_ACTS(89,8930,0,-114,0,0,0,0x0, bhvBubba,47),
OBJECT_WITH_ACTS(0,-9849,-461,-4373,0,0,0,0x0, bhvSeaweedBundle,47),
OBJECT_WITH_ACTS(0,497,504,-16377,0,0,0,0x0, bhvSeaweedBundle,47),
OBJECT_WITH_ACTS(0,5489,-250,-13425,0,0,0,0x0, bhvSeaweedBundle,63),
OBJECT_WITH_ACTS(0,1585,-116,3746,0,0,0,0x0, bhvSeaweedBundle,47),
OBJECT_WITH_ACTS(0,-6118,-611,-16234,0,0,0,0x0, bhvSeaweedBundle,63),
OBJECT_WITH_ACTS(0,7761,-355,-8836,0,0,0,0x0, bhvSeaweedBundle,63),
OBJECT_WITH_ACTS(0,-2043,63,-19407,0,0,0,0x0, bhvSeaweedBundle,63),
OBJECT_WITH_ACTS(122,-3978,5373,-7036,0,0,0,0x5000000, bhvStar,63),
OBJECT_WITH_ACTS(122,-5730,3235,7636,0,0,0,0x2000000, bhvStar,63),
OBJECT_WITH_ACTS(86,-2984,1234,-14032,0,0,0,0x0, bhvSpiny,63),
OBJECT_WITH_ACTS(86,-1792,1473,-13675,0,0,0,0x30000, bhvSpiny,63),
OBJECT_WITH_ACTS(86,160,1626,-13473,0,0,0,0x30000, bhvSpiny,63),
OBJECT_WITH_ACTS(86,-436,1635,-14369,0,0,0,0x0, bhvSpiny,63),
OBJECT_WITH_ACTS(23,-10,2780,-11167,0,51,0,0x0,bhvJRBAirballonStand,63),
/*OBJECT_WITH_ACTS(0,-9516,950,-3684,0,0,0,0x0,Bhv_Custom_0x13000bec,47),
OBJECT_WITH_ACTS(0,-5625,950,-18906,0,-53,0,0x0,Bhv_Custom_0x13000bec,47),
OBJECT_WITH_ACTS(0,1771,950,6302,0,-134,0,0x0,Bhv_Custom_0x13000bec,47),
OBJECT_WITH_ACTS(0,8438,950,-8177,0,7,0,0x0,Bhv_Custom_0x13000bec,47),
OBJECT_WITH_ACTS(0,6823,950,-12344,0,31,0,0x0,Bhv_Custom_0x13000bec,47),
OBJECT_WITH_ACTS(0,4948,950,-14219,0,41,0,0x0,Bhv_Custom_0x13000bec,47),
OBJECT_WITH_ACTS(0,-10313,950,-10938,0,-11,0,0x0,Bhv_Custom_0x13000bec,47),*/
OBJECT_WITH_ACTS(84,-1973,1794,-2659,0,0,0,0x0, bhvEnemyLakitu,63),
//OBJECT_WITH_ACTS(53,-978,2181,-9876,-31,0,0,0x60000,Bhv_Custom_0x13000c18,47),
//OBJECT_WITH_ACTS(53,-978,2181,-9876,-31,0,0,0x1070000,Bhv_Custom_0x13000c18,16),
OBJECT_WITH_ACTS(0,-418,1760,-1630,0,41,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(118,294,2589,-10140,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(0,1235,1423,-14596,0,-28,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(57,-5595,1659,5810,0,0,0,0x0,bhvTNTAndBoulder,63),
OBJECT_WITH_ACTS(192,1282,2591,-8699,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,1942,2572,-8233,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(129,-5149,3008,7967,0,0,0,0x0, bhvBreakableBox,63),
OBJECT_WITH_ACTS(129,-6072,3024,8238,0,0,0,0x10000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(84,-6587,3374,7540,0,0,0,0x0, bhvEnemyLakitu,63),
/*OBJECT_WITH_ACTS(58,-6320,765,1886,0,55,0,0x0,Bhv_Custom_0x13000cb8,47),
OBJECT_WITH_ACTS(59,-7745,-537,-14804,0,26,0,0x0,Bhv_Custom_0x13000ce4,47),
OBJECT_WITH_ACTS(59,-2993,1106,-3982,0,168,0,0x0,Bhv_Custom_0x13000ce4,47),
OBJECT_WITH_ACTS(59,-8991,621,3873,0,157,0,0x0,Bhv_Custom_0x13000ce4,47),
OBJECT_WITH_ACTS(59,-10130,-267,-8855,0,82,0,0x0,Bhv_Custom_0x13000ce4,47),
OBJECT_WITH_ACTS(59,-819,-103,-18426,0,-7,0,0x0,Bhv_Custom_0x13000ce4,47),
OBJECT_WITH_ACTS(59,-8310,-257,-228,0,124,0,0x0,Bhv_Custom_0x13000ce4,47),
OBJECT_WITH_ACTS(59,-9500,-466,-5514,0,90,0,0x0,Bhv_Custom_0x13000ce4,47),*/
OBJECT_WITH_ACTS(60,-9704,532,4280,0,0,0,0x0,bhvCorkDrainWaterREAL,16),
OBJECT_WITH_ACTS(60,444,160,5800,0,0,0,2, bhvCorkDrainWater,47),
OBJECT_WITH_ACTS(60,444,160,5800,0,0,0,(4 << 24), bhvCorkDrainWater,16),
/*OBJECT_WITH_ACTS(59,-9139,655,4488,0,174,0,0x0,Bhv_Custom_0x13000ce4,16),
OBJECT_WITH_ACTS(59,-8234,616,3618,0,179,0,0x0,Bhv_Custom_0x13000ce4,16),
OBJECT_WITH_ACTS(59,-6869,535,2344,0,198,0,0x0,Bhv_Custom_0x13000ce4,16),
OBJECT_WITH_ACTS(59,-5885,305,1765,0,193,0,0x0,Bhv_Custom_0x13000ce4,16),
OBJECT_WITH_ACTS(59,-3760,684,3741,0,151,0,0x0,Bhv_Custom_0x13000ce4,16),
OBJECT_WITH_ACTS(59,-1457,565,3865,0,-114,0,0x0,Bhv_Custom_0x13000ce4,16),
OBJECT_WITH_ACTS(59,-1963,831,5287,0,-185,0,0x0,Bhv_Custom_0x13000ce4,16),*/
OBJECT_WITH_ACTS(137,-3735,2800,-6078,0,0,0,0x10000, bhvExclamationBox,63),
OBJECT_WITH_ACTS(215,7587,11,-2357,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,10128,-125,1731,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,9907,-285,-2541,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,7844,-234,700,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,10312,-283,-737,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,8802,164,1289,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,7808,-223,-1399,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(215,10545,-280,-1816,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,9496,35,-1348,0,0,0,0x3000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(140,-2266,2640,-11064,0,34,0,0x0, bhvBlueCoinSwitch,63),
OBJECT_WITH_ACTS(118,-1783,2679,-11177,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,-1105,2669,-11145,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,-523,2678,-10833,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(0,-4191,2668,-10292,0,62,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,1561,2506,-6090,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-459,2152,-1591,0,-51,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-5015,1428,-4004,0,-75,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-3182,1304,6542,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-465,1641,-14368,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(116,-4249,1099,-13617,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-6245,1247,-10870,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-6634,1306,-9183,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-6413,1287,-7183,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(0,1604,1671,-6207,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-2807,2518,-7830,0,90,0,0x10000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-3840,2621,-7810,0,0,0,0x25010000, bhvWarp,63),
OBJECT_WITH_ACTS(0,3895,-156,6576,0,-89,0,0x30000, bhvSwimmingWarp,63),
OBJECT_WITH_ACTS(0,4556,-114,6791,0,0,0,0x18030000, bhvWarp,63),
OBJECT_WITH_ACTS(124,-3571,2518,-6434,0,124,0,0x230000, bhvMessagePanel,63),
OBJECT_WITH_ACTS(0,-5444,2518,-7866,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(118,-191,2342,-9706,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(0,-6194,1556,-3585,0,0,0,0x2000000, bhvBetaChestLid,63),
//START
OBJECT_WITH_ACTS(0,-1886,2292,-10344,0,16,0,0x00000000, bhvKoopaNPC,63),
RETURN()
};
const LevelScript local_warps_jrb_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,16,1,227,0),
WARP_NODE(241,16,1,211,0),
WARP_NODE(0,12,2,10,0),
WARP_NODE(1,12,2,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,12,3,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(5,12,3,10,0),
WARP_NODE(153,5,1,10,0),
RETURN()
};
const LevelScript local_area_jrb_2_[] = {
AREA(2,Geo_jrb_2_0x1d01600),
TERRAIN(col_jrb_2_0xe0d2b08),
SET_BACKGROUND_MUSIC(0,37),
TERRAIN_TYPE(5),
JUMP_LINK(local_objects_jrb_2_),
JUMP_LINK(local_warps_jrb_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_jrb_2_[] = {
OBJECT_WITH_ACTS(0,862,23,19,0,-90,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,1783,0,-1,0,0,0,0x400a0000, bhvWarp,63),
OBJECT_WITH_ACTS(122,1058,2567,80,0,0,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(27,33,0,-2,0,0,0,0x0,bhvLightHouseMech,63),
OBJECT_WITH_ACTS(0,33,127,-2,0,0,0,0x20000, bhvCoinFormation,63),
RETURN()
};
const LevelScript local_warps_jrb_2_[] = {
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,16,1,227,0),
WARP_NODE(241,16,1,211,0),
WARP_NODE(0,12,1,10,0),
WARP_NODE(10,12,1,1,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,5,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_jrb_3_[] = {
AREA(3,Geo_jrb_3_0x1d01500),
TERRAIN(col_jrb_3_0xe0e13d0),
SET_BACKGROUND_MUSIC(0,37),
TERRAIN_TYPE(5),
JUMP_LINK(local_objects_jrb_3_),
JUMP_LINK(local_warps_jrb_3_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_jrb_3_[] = {
OBJECT_WITH_ACTS(0,-320,-104,101,0,-61,0,0xa0000, bhvSwimmingWarp,63),
OBJECT_WITH_ACTS(0,377,-289,-348,0,0,0,0x400a0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-2094,-3594,-1174,0,0,0,0x0, bhvMrIParticle,16),
OBJECT_WITH_ACTS(0,378,67,-327,0,0,0,0x400a0000, bhvWarp,63),
//OBJECT_WITH_ACTS(59,-1240,-308,1277,0,154,0,0x0,Bhv_Custom_0x13000ce4,63),
OBJECT_WITH_ACTS(122,93,-234,1462,0,0,0,0x1000000, bhvStar,63),
//OBJECT_WITH_ACTS(59,1043,-281,2988,0,-62,0,0x0,Bhv_Custom_0x13000ce4,63),
//OBJECT_WITH_ACTS(59,1079,-265,990,0,32,0,0x0,Bhv_Custom_0x13000ce4,63),
OBJECT_WITH_ACTS(116,748,-340,1610,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,942,-340,2010,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,713,-340,2356,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,385,-340,2494,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-50,-340,2469,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-388,-340,2215,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,363,-340,1504,0,0,0,0x0, bhvOneCoin,63),
RETURN()
};
const LevelScript local_warps_jrb_3_[] = {
WARP_NODE(10,12,1,3,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,16,1,227,0),
WARP_NODE(241,16,1,211,0),
WARP_NODE(0,12,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(5,9,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
