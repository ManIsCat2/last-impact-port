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
#include "levels/hmc/header.h"
extern u8 _hmc_segment_ESegmentRomStart[]; 
extern u8 _hmc_segment_ESegmentRomEnd[];
const LevelScript level_hmc_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _hmc_segment_ESegmentRomStart, _hmc_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom24510144_skybox_mio0SegmentRomStart,_SkyboxCustom24510144_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group10_mio0SegmentRomStart,_group10_mio0SegmentRomEnd),
LOAD_RAW(12,_group10_geoSegmentRomStart,_group10_geoSegmentRomEnd),
LOAD_MIO0(6,_group14_mio0SegmentRomStart,_group14_mio0SegmentRomEnd),
LOAD_RAW(13,_group14_geoSegmentRomStart,_group14_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(56, gummy_bear_geo),
LOAD_MODEL_FROM_GEO(61, donut_geo),
LOAD_MODEL_FROM_GEO(62, candy_cane_geo),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_11),
JUMP_LINK(script_func_global_15),
JUMP_LINK(local_area_hmc_1_),
JUMP_LINK(local_area_hmc_2_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_hmc_1_[] = {
AREA(1,Geo_hmc_1_0x1621700),
TERRAIN(col_hmc_1_0xe0a1ff8),
SET_BACKGROUND_MUSIC(0,40),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_hmc_1_),
JUMP_LINK(local_warps_hmc_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_hmc_1_[] = {
OBJECT_WITH_ACTS(0,5050,-1528,8141,0,177,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,10078,-1654,-4973,0,0,0,0x250b0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,9506,-1654,-4959,0,-88,0,0x20000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(53,3539,-1405,9784,0,75,0,0x5800000,Bhv_Custom_0x1300024c,63),
OBJECT_WITH_ACTS(53,8905,-723,-7382,0,0,0,0x5800000,Bhv_Custom_0x1300024c,63),
OBJECT_WITH_ACTS(53,8386,-529,-7892,0,45,0,0x5800000,Bhv_Custom_0x1300024c,63),
OBJECT_WITH_ACTS(53,7377,-323,-8135,0,90,0,0x5800000,Bhv_Custom_0x1300024c,63),
OBJECT_WITH_ACTS(53,9249,314,-6430,0,99,0,0x5800000,Bhv_Custom_0x1300024c,63),
OBJECT_WITH_ACTS(53,8484,-145,-6466,0,91,0,0x5800000,Bhv_Custom_0x1300024c,63),
OBJECT_WITH_ACTS(53,7309,-268,-6722,0,78,0,0x5800000,Bhv_Custom_0x1300024c,63),
OBJECT_WITH_ACTS(54,2613,-346,-7785,0,0,0,0x0,Bhv_Custom_0x130018b4,63),
OBJECT_WITH_ACTS(54,2613,-346,-7785,0,90,0,0x0,Bhv_Custom_0x130018b4,63),
OBJECT_WITH_ACTS(54,2613,-346,-7785,0,180,0,0x0,Bhv_Custom_0x130018b4,63),
OBJECT_WITH_ACTS(54,2613,-346,-7785,0,270,0,0x0,Bhv_Custom_0x130018b4,63),
OBJECT_WITH_ACTS(55,3628,-1635,-3364,-10,31,3,0x0,Bhv_Custom_0x130018e0,63),
OBJECT_WITH_ACTS(55,4674,-2187,2325,3,0,-9,0x0,Bhv_Custom_0x130018e0,63),
OBJECT_WITH_ACTS(102,2085,-1159,-1199,0,-88,0,0x0, bhvChainChomp,63),
OBJECT_WITH_ACTS(56,-6659,-977,9847,-2,95,11,0x0,bhvGummyBear,63),
OBJECT_WITH_ACTS(56,-5523,-1038,6224,-4,-141,4,0x10000,bhvGummyBear,63),
OBJECT_WITH_ACTS(56,-12540,-426,-8937,-90,-246,0,0x20000,bhvGummyBear,63),
OBJECT_WITH_ACTS(56,-18242,-519,-1985,2,0,1,0x30000,bhvGummyBear,63),
OBJECT_WITH_ACTS(56,-13947,-633,-9044,0,0,-8,0x0,bhvGummyBear,63),
OBJECT_WITH_ACTS(56,-13217,-536,-1888,0,133,0,0x20000,bhvGummyBear,63),
OBJECT_WITH_ACTS(56,-13245,-656,1364,0,-86,0,0x10000,bhvGummyBear,63),
OBJECT_WITH_ACTS(57,-3658,-2178,-189,0,0,0,0x0, Bhv_Custom_0x13001934,63),
OBJECT_WITH_ACTS(56,-16285,56,-5066,-90,-98,0,0x0,bhvGummyBear,63),
OBJECT_WITH_ACTS(85,-16078,-298,-9239,0,0,0,0x0, bhvFallingBowserPlatform,63),
OBJECT_WITH_ACTS(192,-6216,-828,7955,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-994,-1129,-479,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-3130,-1140,8139,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-2210,-1154,5303,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-4530,-1046,5119,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(0,-11517,-965,5443,0,0,0,0x0,Bhv_Custom_0x13001bbc,63),
OBJECT_WITH_ACTS(192,-8065,-962,2762,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(0,-17778,-335,-5906,0,0,0,0x0,Bhv_Custom_0x13001bbc,63),
OBJECT_WITH_ACTS(192,-13781,-264,-5330,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-15073,-503,-1437,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(0,-17153,26,-7414,0,66,0,0x0,Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,-10445,340,-10450,0,-18,0,0x0,Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,-4500,340,-9050,0,71,0,0x0,Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,-7150,442,-10795,0,-28,0,0x0,Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,-3394,476,-11575,0,-64,0,0x0,Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,-2385,398,-13599,0,146,0,0x0,Bhv_Custom_0x13001a24,63),
OBJECT_WITH_ACTS(0,-3639,-1102,-381,90,0,0,0x130000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,2206,-1127,92,0,-101,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,8951,-1058,-5804,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,10537,205,-3630,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,10520,205,-6283,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,6815,-1406,9455,0,0,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(0,816,-146,-5448,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,4072,-146,-6015,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,1387,-146,-9725,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,4443,-146,-10282,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,10492,-657,-4942,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,1058,-1283,8670,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,2085,-971,-1199,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,4674,-1066,2325,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(23,-4761,98,-14037,0,0,0,0x0,Bhv_Custom_0x13001a38,63),
OBJECT_WITH_ACTS(23,-3581,1300,-16727,0,-126,0,0x0,Bhv_Custom_0x13001a38,63),
OBJECT_WITH_ACTS(122,-2223,3840,-16585,0,0,0,0x1000000, bhvStar,63),
OBJECT_WITH_ACTS(23,-2498,2053,-17103,0,-191,0,0x0,Bhv_Custom_0x13001a38,63),
OBJECT_WITH_ACTS(103,-2530,-1154,9953,0,-151,0,0x0,Bhv_Custom_0x13001af0,63),
OBJECT_WITH_ACTS(212,-17473,-392,-11184,0,276,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,-21132,-269,-8797,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(34,-10466,412,12402,0,-233,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,-20469,2788,7843,0,138,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,-24411,3802,-899,0,-77,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,-27536,4583,-10899,0,26,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,-18786,3881,-19232,0,33,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,-7675,3703,-23396,0,0,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,3720,1370,-20222,0,-43,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,4600,452,-13086,0,0,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,5792,358,-1826,0,0,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,-3442,1972,-18997,0,180,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(34,-28051,4465,-3047,0,91,0,0x0,Bhv_Custom_0x13001b90,63),
OBJECT_WITH_ACTS(116,-26302,4127,-7500,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,-12396,3764,-21563,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,1510,1330,-19844,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,7448,-1161,-10938,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,3073,1159,-521,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,10400,-1481,-1009,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,7458,-1526,631,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,8015,-1589,8052,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,6642,-1594,6345,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,6159,-1592,3117,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(133,-5892,131,-7407,0,0,0,0x0,Bhv_Custom_0x130000c0,63),
OBJECT_WITH_ACTS(133,-2894,158,-12727,0,0,0,0x0,Bhv_Custom_0x130000c0,63),
OBJECT_WITH_ACTS(0,-16606,1049,-9926,0,38,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,4499,-1613,11818,0,0,0,0x0,Bhv_Custom_0x13001bbc,63),
OBJECT_WITH_ACTS(0,6697,-1613,10695,0,0,0,0x0,Bhv_Custom_0x13001bbc,63),
OBJECT_WITH_ACTS(0,-16959,1332,-9661,0,38,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-16313,803,-10145,0,38,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(35,-16921,-304,-8079,0,0,0,0x50000, bhvBowserKeyCourseExit,63),
OBJECT_WITH_ACTS(35,-2159,-1156,4225,0,0,0,0x60000, bhvBowserKeyCourseExit,63),
OBJECT_WITH_ACTS(0,-16921,-176,-8079,0,0,0,0x50000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(0,-2159,-1028,4225,0,0,0,0x60000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(0,9066,-1406,-4912,0,0,0,0x5000000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(0,8704,10688,8448,0,0,0,0xac4a0000,editor_Scroll_Texture,63),
OBJECT_WITH_ACTS(37,11387,-1178,4007,0,0,0,0x0,Bhv_Custom_0x13001c30,63),
OBJECT_WITH_ACTS(36,11387,-1178,4007,0,0,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(40,-5337,-978,4678,0,0,0,0x1000000,Bhv_Custom_0x13001eb0,63),
OBJECT_WITH_ACTS(124,-4984,-1013,4727,0,69,0,0x560000, bhvMessagePanel,63),
OBJECT_WITH_ACTS(61,-8547,-929,3584,0,44,0,0x0,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(61,-14513,-213,-5562,0,11,0,0x0,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(61,-9589,133,-9014,0,238,0,0x0,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(61,-730,-1095,1420,253,-44,5,0x0,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(61,7979,-1568,17,0,-48,0,0x0,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(62,-6827,163,-7332,0,-68,0,0x10000,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(62,-3781,-1130,6522,0,-88,0,0x10000,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(62,-2194,213,-11648,0,-136,0,0x10000,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(62,-16191,-475,-3350,0,-1,0,0x10000,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(62,-6208,173,-11165,0,12,0,0x10000,bhvCollisionHmcStaticObject,63),
OBJECT_WITH_ACTS(62,-10791,126,-8962,0,-89,0,0x10000,bhvCollisionHmcStaticObject,63),
RETURN()
};
const LevelScript local_warps_hmc_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(240,6,1,214,0),
WARP_NODE(241,6,1,198,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(11,7,2,10,0),
WARP_NODE(2,7,1,3,0),
WARP_NODE(3,7,1,2,0),
WARP_NODE(153,22,1,10,0),
WARP_NODE(5,7,1,6,0),
WARP_NODE(6,7,1,5,0),
RETURN()
};
const LevelScript local_area_hmc_2_[] = {
AREA(2,Geo_hmc_2_0x1621600),
TERRAIN(col_hmc_2_0xe0d9fc0),
SET_BACKGROUND_MUSIC(0,41),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_hmc_2_),
JUMP_LINK(local_warps_hmc_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_hmc_2_[] = {
OBJECT_WITH_ACTS(0,-166,0,-1289,0,-270,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-864,0,-1230,0,0,0,0x20020000, bhvWarp,63),
OBJECT_WITH_ACTS(24,2983,573,-2314,0,90,0,0x10320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,2983,502,-2014,0,90,0,0xf0320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,2983,715,-1114,0,90,0,0x10320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,2983,573,-1714,0,90,0,0x10320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,2983,644,-1414,0,90,0,0xf0320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,2812,670,5245,0,0,0,0xc640000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,2212,528,5245,0,0,5,0xf4640000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,1612,386,5245,0,0,0,0xc640000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,3398,411,11747,0,90,22,0x18190000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,3317,411,11837,0,0,0,0xe8190000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,3166,377,11837,0,0,0,0x18190000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,3016,340,11837,0,0,0,0xe8190000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,67,759,7364,26,90,0,0xf0320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,67,759,7664,26,90,23,0x10320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,67,759,7064,26,90,0,0x10320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,67,759,6764,26,90,23,0xf0320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,67,759,6464,26,90,0,0x10320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(24,67,759,6164,26,90,23,0xf0320000,Bhv_Custom_0x13001a58,63),
OBJECT_WITH_ACTS(25,1609,-42,10160,0,0,0,0x0, bhvFlameMovingForwardGrowing,63),
OBJECT_WITH_ACTS(25,1609,-42,9460,0,0,0,0x0, bhvFlameMovingForwardGrowing,63),
OBJECT_WITH_ACTS(25,1609,-42,8760,0,0,0,0x0, bhvFlameMovingForwardGrowing,63),
OBJECT_WITH_ACTS(25,1609,-42,8060,0,0,0,0x0, bhvFlameMovingForwardGrowing,63),
OBJECT_WITH_ACTS(25,1609,-42,7360,0,0,0,0x0, bhvFlameMovingForwardGrowing,63),
OBJECT_WITH_ACTS(25,1609,-42,6660,0,0,0,0x0, bhvFlameMovingForwardGrowing,63),
OBJECT_WITH_ACTS(25,1609,-42,5960,0,0,0,0x0, bhvFlameMovingForwardGrowing,63),
OBJECT_WITH_ACTS(140,2779,0,10646,0,0,0,0x0, bhvBlueCoinSwitch,63),
OBJECT_WITH_ACTS(118,561,185,6062,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(0,2155,185,6446,0,0,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(118,1324,185,7288,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,2261,185,8823,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(118,1296,185,9690,0,0,0,0x0, bhvHiddenBlueCoin,63),
OBJECT_WITH_ACTS(27,6810,331,7000,0,180,0,0x0,Bhv_Custom_0x13001a98,63),
OBJECT_WITH_ACTS(27,6810,331,11500,0,180,0,0x0,Bhv_Custom_0x13001a98,63),
OBJECT_WITH_ACTS(27,6810,331,8500,0,180,0,0x0,Bhv_Custom_0x13001a98,63),
OBJECT_WITH_ACTS(27,6810,331,10000,0,180,0,0x0,Bhv_Custom_0x13001a98,63),
OBJECT_WITH_ACTS(31,5296,228,5965,0,0,0,0x0,Bhv_Custom_0x13001ab0,63),
OBJECT_WITH_ACTS(122,5629,4702,7849,0,0,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(0,4625,3785,8527,0,0,0,0x20200000, bhvIgloo,63),
OBJECT_WITH_ACTS(0,4625,4278,8527,0,0,0,0x20200000, bhvIgloo,63),
OBJECT_WITH_ACTS(0,4625,3274,8527,0,0,0,0x20200000, bhvIgloo,63),
OBJECT_WITH_ACTS(0,4625,3785,8527,0,0,0,0x60200000, bhvIgloo,63),
OBJECT_WITH_ACTS(0,4625,4278,8527,0,0,0,0x60200000, bhvIgloo,63),
OBJECT_WITH_ACTS(0,4625,3274,8527,0,0,0,0x60200000, bhvIgloo,63),
OBJECT_WITH_ACTS(212,1811,-384,3523,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,1323,-59,12532,0,0,0,0x0, bhvGoombaTripletSpawner,63),
OBJECT_WITH_ACTS(0,5001,-131,8755,0,200,0,0x10400000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,4951,-131,11309,0,200,0,0x40200000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,5652,-131,11259,0,200,0,0x30300000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,5001,-131,10257,0,200,0,0x60500000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,5627,-131,10032,0,200,0,0x28300000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,5001,-131,9206,0,200,0,0x18200000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,5627,-131,8730,0,200,0,0x40480000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,5477,-131,9431,0,200,0,0x28380000, bhvGrandStar,63),
OBJECT_WITH_ACTS(0,5300,88,9873,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(116,5325,2921,8827,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,4302,3421,9242,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(116,3917,3921,8281,0,0,0,0x0, bhvOneCoin,63),
OBJECT_WITH_ACTS(32,2338,-69,661,0,0,0,0x0,Bhv_Custom_0x13001ad0,63),
OBJECT_WITH_ACTS(122,2344,185,-15802,0,0,0,0x2000000, bhvStar,63),
OBJECT_WITH_ACTS(212,2753,144,-10487,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(0,863,-969,1243,0,0,0,0x130000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,529,-719,-200,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(53,2045,-1319,2374,90,90,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(27,2604,-1506,3269,0,90,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(23,2559,-1506,2816,0,92,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(23,2278,-1506,2458,0,90,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(27,2678,-1506,2040,0,270,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(22,2820,-1546,2975,90,82,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(53,2892,-1312,2655,90,270,0,0x0, bhvStaticObject,63),
OBJECT_WITH_ACTS(0,-864,190,-1230,0,0,0,0x20020000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-864,356,-1230,0,0,0,0x20020000, bhvWarp,63),
RETURN()
};
const LevelScript local_warps_hmc_2_[] = {
WARP_NODE(10,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,6,1,214,0),
WARP_NODE(241,6,1,198,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,7,1,2,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(5,9,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
