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
#include "levels/ssl/header.h"
extern u8 _ssl_segment_ESegmentRomStart[]; 
extern u8 _ssl_segment_ESegmentRomEnd[];
const LevelScript level_ssl_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _ssl_segment_ESegmentRomStart, _ssl_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom25951936_skybox_mio0SegmentRomStart,_SkyboxCustom25951936_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group7_mio0SegmentRomStart,_group7_mio0SegmentRomEnd),
LOAD_RAW(12,_group7_geoSegmentRomStart,_group7_geoSegmentRomEnd),
LOAD_MIO0(6,_group17_mio0SegmentRomStart,_group17_mio0SegmentRomEnd),
LOAD_RAW(13,_group17_geoSegmentRomStart,_group17_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
LOAD_MODEL_FROM_GEO(53, ssl_rotating_platform_geo),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_8),
JUMP_LINK(script_func_global_18),
JUMP_LINK(local_area_ssl_1_),
JUMP_LINK(local_area_ssl_2_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,0,0,0),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_ssl_1_[] = {
AREA(1,Geo_ssl_1_0x1781700),
TERRAIN(col_ssl_1_0xe0bfd80),
SET_BACKGROUND_MUSIC(0,0),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ssl_1_),
JUMP_LINK(local_warps_ssl_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ssl_1_[] = {
OBJECT_WITH_ACTS(0,1896,-165,7062,0,-136,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(122,12688,1957,-1661,0,-154,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(53,6306,1948,3938,0,-153,0,0x0,bhvSSLRotatingPlatform,63),
OBJECT_WITH_ACTS(0,-7410,86,20515,0,-145,0,0xc0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,-6906,181,21221,0,-145,0,0x400c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-6628,390,21103,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-7122,390,21421,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(128,-4709,411,8559,0,130,0,0x280000, bhvCannon,63),
OBJECT_WITH_ACTS(128,8933,3791,-210,0,131,0,0x800000, bhvCannon,63),
OBJECT_WITH_ACTS(212,6304,4122,3936,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(137,1273,2143,1526,0,-50,0,0x10000, bhvExclamationBox,63),
OBJECT_WITH_ACTS(137,-3537,545,9985,0,38,0,0x0, bhvExclamationBox,63),
OBJECT_WITH_ACTS(57,-5233,1967,12199,0,0,0,0x0,Bhv_Custom_0x13001ffc,63),
OBJECT_WITH_ACTS(192,10265,3468,390,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,10671,3310,-874,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,11370,3309,-330,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-6717,456,12404,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-6442,355,10848,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(192,-7533,347,12355,0,0,0,0x0, bhvGoomba,63),
OBJECT_WITH_ACTS(137,-7983,857,10154,0,-17,0,0x0, bhvExclamationBox,63),
OBJECT_WITH_ACTS(137,-8429,857,13020,0,31,0,0x10000, bhvExclamationBox,63),
OBJECT_WITH_ACTS(0,0,0,0,0,0,0,0x0, bhvLllBowserPuzzlePiece,63),
OBJECT_WITH_ACTS(58,1309,-432,16497,0,-13,0,0x12000000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,2028,-432,15710,0,-13,0,0x10000000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,2087,-432,17213,0,-13,0,0x10000000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,2804,-432,16438,0,-13,0,0x12000000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-3046,432,11861,0,0,0,0x1000000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-2504,432,12172,0,0,0,0x3040000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-3669,432,12941,0,0,0,0x1080000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-3440,432,13800,0,0,0,0x30c0000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-3981,432,13481,0,0,0,0x2100000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-3356,432,12397,0,0,0,0x140000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-3127,432,13254,0,0,0,0x2180000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(58,-2815,432,12712,0,0,0,0x1c0000, Bhv_Custom_0x13002050,63),
OBJECT_WITH_ACTS(59,-2335,409,14349,0,-110,0,0x1040000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(59,-1705,409,14331,0,-75,0,0x10c0000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(59,-786,409,13858,0,-47,0,0x1080000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(59,-397,409,13397,0,-34,0,0x1000000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(59,-2033,409,14382,0,-90,0,0x100000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(59,-1016,409,14075,0,-48,0,0x140000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(59,-1383,409,14245,0,-74,0,0x180000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(59,-565,409,13616,0,-34,0,0x1c0000, bhvLllBowserPuzzle,63),
OBJECT_WITH_ACTS(0,4446,1116,17932,0,-132,0,0x0, bhvTuxiesMother,63),
OBJECT_WITH_ACTS(0,3728,1112,18714,0,-132,0,0x40040000, bhvTuxiesMother,63),
OBJECT_WITH_ACTS(0,783,1115,18610,0,138,0,0x80080000, bhvTuxiesMother,63),
OBJECT_WITH_ACTS(0,-19,1114,17871,0,138,0,0xc00c0000, bhvTuxiesMother,63),
OBJECT_WITH_ACTS(124,-3760,432,12412,0,-101,0,0x580000, bhvMessagePanel,63),
OBJECT_WITH_ACTS(137,2278,-131,16451,0,47,0,0x0, bhvExclamationBox,63),
OBJECT_WITH_ACTS(137,2062,-131,16674,0,47,0,0x10000, bhvExclamationBox,63),
OBJECT_WITH_ACTS(25,930,-707,14686,0,47,0,0x0,Bhv_Custom_0x130020b4,63),
OBJECT_WITH_ACTS(25,232,-707,15478,0,47,0,0x0,Bhv_Custom_0x130020b4,63),
OBJECT_WITH_ACTS(25,3121,-707,14515,0,47,0,0x0,Bhv_Custom_0x130020b4,63),
OBJECT_WITH_ACTS(25,3909,-707,15205,0,47,0,0x0,Bhv_Custom_0x130020b4,63),
OBJECT_WITH_ACTS(0,2054,-174,16456,0,0,0,0x0, bhvFishGroup,63),
OBJECT_WITH_ACTS(27,-2881,1967,5552,0,-152,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(27,-6222,140,6217,0,157,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(27,-3117,140,7218,0,0,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(27,-482,1967,8705,0,-147,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(27,-6577,86,15160,0,159,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(27,-9285,86,20530,0,103,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(27,-4607,140,9300,0,123,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(27,-9008,566,11051,0,128,0,0x0, bhvBetaChestBottom,63),
OBJECT_WITH_ACTS(31,-1697,1799,-10243,0,0,0,0x3000000, bhvBouncingFireballFlame,63),
OBJECT_WITH_ACTS(31,-877,2166,-2605,0,0,0,0x3000000, bhvBouncingFireballFlame,63),
OBJECT_WITH_ACTS(31,-2567,2161,-2475,0,0,0,0x3000000, bhvBouncingFireballFlame,63),
OBJECT_WITH_ACTS(31,5089,120,-13892,0,0,0,0x3000000, bhvBouncingFireballFlame,63),
OBJECT_WITH_ACTS(31,8973,329,-3424,0,0,0,0x3000000, bhvBouncingFireballFlame,63),
OBJECT_WITH_ACTS(32,-179,-68,-778,0,-34,0,0x480000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,214,-68,-497,0,-34,0,0x3c0000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,587,-68,-207,0,-34,0,0x340000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,699,-8,-11509,0,83,0,0x200000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,684,-8,-11240,0,83,0,0x260000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,684,-8,-10985,0,83,0,0x2f0000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,-4051,-11,-148,0,35,0,0x460000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,-4376,-11,68,0,35,0,0x3a0000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,-4712,-11,296,0,35,0,0x320000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,-3259,1458,-10061,0,41,0,0x420000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,-2838,1458,-10499,0,33,0,0x420000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(32,-2279,1458,-10739,0,9,0,0x420000,Bhv_Custom_0x130020fc,63),
OBJECT_WITH_ACTS(34,-3505,140,6703,0,143,0,0x0, Bhv_Custom_0x13002114,63),
OBJECT_WITH_ACTS(34,-697,0,1477,0,-22,0,0x10000, Bhv_Custom_0x13002114,63),
OBJECT_WITH_ACTS(34,-8272,-73,16982,0,142,0,0x0, Bhv_Custom_0x13002114,63),
OBJECT_WITH_ACTS(34,-1215,1967,7697,0,-169,0,0x0, Bhv_Custom_0x13002114,63),
OBJECT_WITH_ACTS(34,1740,1218,-4608,0,-180,0,0x10000, Bhv_Custom_0x13002114,63),
OBJECT_WITH_ACTS(34,6139,0,-3605,0,0,0,0x10000, Bhv_Custom_0x13002114,63),
OBJECT_WITH_ACTS(34,4611,-174,-13575,0,-176,0,0x10000, Bhv_Custom_0x13002114,63),
OBJECT_WITH_ACTS(60,7678,1480,-8468,0,-2,0,0x2000000, bhvWdwExpressElevator,63),
OBJECT_WITH_ACTS(60,-15604,267,4179,0,53,0,0x1010000, bhvWdwExpressElevator,63),
OBJECT_WITH_ACTS(0,-2989,279,3542,0,0,0,0x0,Bhv_Custom_0x130021bc,63),
OBJECT_WITH_ACTS(0,-3101,140,7216,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-8716,86,20101,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-5772,1096,16739,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-3290,1728,9760,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-5642,1907,13860,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-9148,1176,12426,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-18522,421,4697,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-3219,210,9133,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(E_MODEL_RED_COIN,-6184,140,6115,0,0,0,0x0, id_bhvRedCoin,63),
OBJECT_WITH_ACTS(35,-8741,86,20108,0,41,0,0x1010000,Bhv_Custom_0x13001fe0,63),
OBJECT_WITH_ACTS(0,-6613,173,8211,0,0,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(0,-6613,-25,8211,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-7097,1907,10787,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-1000,1694,3185,0,-24,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,4362,79,485,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(101,-1787,1754,-6914,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,389,1661,-7101,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,2169,174,-11128,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,7539,0,-14290,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,11144,1684,-5112,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(101,1029,1839,-794,0,0,0,0x0, bhvScuttlebug,63),
OBJECT_WITH_ACTS(84,-5400,140,7104,0,0,0,0x0,Bhv_Custom_0x130021d0,63),
OBJECT_WITH_ACTS(84,-7671,-25,8292,0,0,0,0x0,Bhv_Custom_0x130021d0,63),
OBJECT_WITH_ACTS(84,-9622,566,11962,0,0,0,0x0,Bhv_Custom_0x130021d0,63),
OBJECT_WITH_ACTS(84,-6765,86,18680,0,0,0,0x0,Bhv_Custom_0x130021d0,63),
OBJECT_WITH_ACTS(84,-10325,-73,17932,0,0,0,0x0,Bhv_Custom_0x130021d0,63),
OBJECT_WITH_ACTS(84,-9138,86,15161,0,0,0,0x0,Bhv_Custom_0x130021d0,63),
OBJECT_WITH_ACTS(0,-8272,-73,16982,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,7155,1558,1170,0,-14,0,0x110000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,11342,-186,-15967,90,0,0,0x130000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(36,-10406,-73,19721,0,0,0,0x0, bhvBowserKeyCourseExit,63),
OBJECT_WITH_ACTS(36,11024,0,-14646,0,0,0,0x0, bhvBowserKeyCourseExit,63),
OBJECT_WITH_ACTS(0,11024,128,-14646,0,0,0,0xe0000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(0,-10406,55,19721,0,0,0,0xd0000, bhvFadingWarp,63),
OBJECT_WITH_ACTS(0,188,-186,-12895,90,32,0,0x130000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-697,0,1477,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(124,-9877,566,8280,0,50,0,0x590000, bhvMessagePanel,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x10000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x10000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x0, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x0, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x20000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x70000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x30000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x30000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x40000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x50000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14934,428,5924,0,0,0,0x60000, bhvRockSolid,63),
OBJECT_WITH_ACTS(0,-13552,428,6192,0,0,0,0x60000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x30000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x30000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x40000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x50000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14668,428,5958,0,0,0,0x60000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14668,428,5958,0,0,0,0x60000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x10000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x70000, bhvRockSolid,63),
OBJECT_WITH_ACTS(150,-14696,296,5863,0,0,0,0x70000, bhvRockSolid,63),
OBJECT_WITH_ACTS(0,3971,417,-14929,0,0,0,0x7070000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(0,-2900,1967,5585,0,0,0,0x0, bhvBowserSubDoor,63),
OBJECT_WITH_ACTS(0,121,1967,8346,0,0,0,0x10000, bhvBowserSubDoor,63),
RETURN()
};
const LevelScript local_warps_ssl_1_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,10,0),
WARP_NODE(12,8,2,10,0),
WARP_NODE(13,8,1,14,0),
WARP_NODE(14,8,1,13,0),
WARP_NODE(240,6,1,200,0),
WARP_NODE(241,6,1,216,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,23,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
const LevelScript local_area_ssl_2_[] = {
AREA(2,Geo_ssl_2_0x1781600),
TERRAIN(col_ssl_2_0x7021640),
SET_BACKGROUND_MUSIC(0,46),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_ssl_2_),
JUMP_LINK(local_warps_ssl_2_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_ssl_2_[] = {
OBJECT_WITH_ACTS(0,38,2989,2434,0,-180,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(0,329,3775,3395,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-260,3778,3372,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,42,3671,3424,0,0,0,0x380c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,329,4035,3395,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-260,4038,3372,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,42,3931,3424,0,0,0,0x380c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,329,3410,3395,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,-260,3413,3372,0,0,0,0x200c0000, bhvWarp,63),
OBJECT_WITH_ACTS(0,42,3306,3424,0,0,0,0x380c0000, bhvWarp,63),
OBJECT_WITH_ACTS(122,14754,-5436,1116,0,0,0,0x1000000, bhvStar,63),
OBJECT_WITH_ACTS(0,0,0,0,0,0,0,0x0, bhvSmallPenguin,63),
OBJECT_WITH_ACTS(0,-131,2984,1586,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-68,2875,-979,0,0,0,0x0, bhvCoinFormation,63),
RETURN()
};
const LevelScript local_warps_ssl_2_[] = {
WARP_NODE(10,9,1,10,0),
WARP_NODE(11,9,1,10,0),
WARP_NODE(12,8,1,12,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,6,1,200,0),
WARP_NODE(241,6,1,216,0),
RETURN()
};
