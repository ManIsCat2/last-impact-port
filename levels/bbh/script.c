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
#include "levels/bbh/header.h"
extern u8 _bbh_segment_ESegmentRomStart[]; 
extern u8 _bbh_segment_ESegmentRomEnd[];
const LevelScript level_bbh_entry[] = {
INIT_LEVEL(),
LOAD_RAW(0x0E, _bbh_segment_ESegmentRomStart, _bbh_segment_ESegmentRomEnd),
LOAD_MIO0(0xA,_SkyboxCustom19949824_skybox_mio0SegmentRomStart,_SkyboxCustom19949824_skybox_mio0SegmentRomEnd),
LOAD_MIO0(8,_common0_mio0SegmentRomStart,_common0_mio0SegmentRomEnd),
LOAD_RAW(15,_common0_geoSegmentRomStart,_common0_geoSegmentRomEnd),
LOAD_MIO0(5,_group9_mio0SegmentRomStart,_group9_mio0SegmentRomEnd),
LOAD_RAW(12,_group9_geoSegmentRomStart,_group9_geoSegmentRomEnd),
LOAD_MIO0(6,_group17_mio0SegmentRomStart,_group17_mio0SegmentRomEnd),
LOAD_RAW(13,_group17_geoSegmentRomStart,_group17_geoSegmentRomEnd),
ALLOC_LEVEL_POOL(),
MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
JUMP_LINK(script_func_global_1),
JUMP_LINK(script_func_global_10),
JUMP_LINK(script_func_global_18),
LOAD_MODEL_FROM_GEO(23, crocodile_geo),
LOAD_MODEL_FROM_GEO(24, octoomba_geo),
LOAD_MODEL_FROM_GEO(25, red_rock_shooter_geo),
LOAD_MODEL_FROM_GEO(54, bbh_cage_geo),
LOAD_MODEL_FROM_GEO(55, cage_opener_geo),
LOAD_MODEL_FROM_GEO(57, mario_galaxy_block_geo),
JUMP_LINK(local_area_bbh_1_),
FREE_LEVEL_POOL(),
MARIO_POS(1,135,-6558,0,6464),
CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
CLEAR_LEVEL(),
SLEEP_BEFORE_EXIT(/*frames*/ 1),
EXIT(),
};
const LevelScript local_area_bbh_1_[] = {
AREA(1,Geo_bbh_1_0x1201700),
TERRAIN(col_bbh_1_0xe0e14b8),
SET_BACKGROUND_MUSIC(0,39),
TERRAIN_TYPE(0),
JUMP_LINK(local_objects_bbh_1_),
JUMP_LINK(local_warps_bbh_1_),
END_AREA(),
RETURN()
};
const LevelScript local_objects_bbh_1_[] = {
OBJECT_WITH_ACTS(0,-9066,-321,14728,0,-183,0,0xa0000, bhvSpinAirborneWarp,63),
OBJECT_WITH_ACTS(122,-35,7461,-6879,0,-154,0,0x0, bhvStar,63),
OBJECT_WITH_ACTS(122,7,211,2740,0,-153,0,0x1000000, bhvStar,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,1793,-921,-14319,0,107,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,1859,-893,-15996,0,-151,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,6296,-910,-15888,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,6032,-893,-17506,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,10791,-941,-14604,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,12240,-916,-15786,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,9271,-941,-11786,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,9799,-894,-10112,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,5973,-894,-8746,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,4177,-954,-8714,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(212,2888,5646,-2311,0,0,0,0x0, bhv1Up,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,11027,-882,-6971,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,10644,-894,-8792,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,13975,-867,-5642,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,15349,-894,-6897,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,15713,-968,1816,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,15984,-863,-1793,0,0,0,0x20000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,15560,-888,5586,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,17219,-888,6291,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,13024,-929,8043,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,14487,-920,9190,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,13173,-932,13871,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,11539,-888,13017,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,7779,-888,16756,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,8481,-887,14928,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,5756,-888,12531,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,4665,-889,14033,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,1636,-913,10790,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,1620,-888,12823,0,0,0,0x10000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-1458,-924,10969,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-1442,-896,12580,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-3694,-937,10351,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-4993,-922,11603,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-4867,-924,6951,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-6394,-912,7702,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-8386,-890,5036,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-8393,-957,6778,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-10883,-890,4373,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-12260,-898,5436,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-11379,-882,1441,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-13308,-934,1511,0,0,0,0x0, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-12311,-912,-2584,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-7932,-914,-4853,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-9419,-921,-8371,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-10966,-894,-11706,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-14400,-927,-11254,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-16435,-912,-14799,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-14115,-893,-17737,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-9428,-893,-15506,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-6204,-935,-15622,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-6615,-1003,-13732,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-1857,-894,-16233,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-1737,-915,-14423,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-14380,-896,-14586,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-8786,-893,-17169,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-10589,-867,-2125,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-11789,-878,-9951,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-7921,-920,-9402,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-9416,-947,-5892,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-13397,-911,-12584,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(MODEL_FLASHING_LIGHT,-13393,-911,-16222,0,0,0,0x30000, id_bhvFloorSwitchAnimatesObject,63),
OBJECT_WITH_ACTS(0,2604,6176,2448,0,0,0,0x0, Bhv_Custom_0x13001488,63),
OBJECT_WITH_ACTS(0,-13256,-865,10145,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,-14573,-865,-5296,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,-5593,-865,-10068,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,4641,-865,-13563,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,3207,-865,15881,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,13776,-865,4455,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,6310,-865,-3727,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,15468,-865,-9773,0,0,0,0x0, bhvRedCoin,63),
OBJECT_WITH_ACTS(0,-9760,-10,16027,0,0,0,0x4000000, bhvHiddenRedCoinStar,63),
OBJECT_WITH_ACTS(54,-3270,0,0,0,-90,0,0x20000, bhvHiddenObject,63),
OBJECT_WITH_ACTS(54,0,0,3270,0,0,0,0x10000, bhvHiddenObject,63),
OBJECT_WITH_ACTS(54,3270,0,0,0,90,0,0x80000, bhvHiddenObject,63),
OBJECT_WITH_ACTS(54,0,0,-3270,0,180,0,0x40000, bhvHiddenObject,63),
OBJECT_WITH_ACTS(55,-5816,2056,14361,0,6,0,0x20000,bhvBlueCageOpener,63),
OBJECT_WITH_ACTS(55,15014,2028,15093,0,34,0,0x10000,bhvRedCageOpener,63),
OBJECT_WITH_ACTS(55,16216,882,-13630,0,18,0,0x40000,bhvYellowCageOpener,63),
OBJECT_WITH_ACTS(22,1562,-803,-15205,0,87,0,0x0, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,10856,-803,-11515,0,-53,0,0x70000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,7556,-803,-6521,0,-96,0,0xf0000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,16497,-803,5436,0,-20,0,0x170000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,10032,-803,15879,0,-64,0,0x1f0000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,-4940,-803,10342,0,39,0,0x270000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,-12395,-803,3922,0,31,0,0x2f0000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,-7923,-803,-7257,0,0,0,0x370000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(22,-14924,-803,-16091,0,-34,0,0x3e0000, bhvPushableMetalBox,63),
OBJECT_WITH_ACTS(195,447,0,-2353,0,180,0,0x0, bhvBobombBuddyOpensCannon,63),
OBJECT_WITH_ACTS(201,2451,6765,-2377,0,31,0,0x7f0000, bhvCannonClosed,63),
OBJECT_WITH_ACTS(58,-728,9875,-1313,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-2599,9298,-1243,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-1082,11002,-3888,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-775,9211,-2425,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-200,10730,-2624,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-2056,11118,-3170,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-2964,9371,-2329,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-787,10613,-1689,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(58,-1366,8827,-3410,0,0,0,0x0, Bhv_Custom_0x13001558,63),
OBJECT_WITH_ACTS(122,-1679,10303,-2741,0,0,0,0x3000000, bhvStar,63),
OBJECT_WITH_ACTS(122,805,6634,5810,0,0,0,0x2000000, bhvStar,63),
OBJECT_WITH_ACTS(0,0,0,-2750,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(137,-525,354,-2405,0,0,0,0x60000, bhvExclamationBox,63),
OBJECT_WITH_ACTS(137,12861,155,-4340,0,-55,0,0x10000, bhvExclamationBox,63),
OBJECT_WITH_ACTS(59,-8709,-898,10172,0,0,0,0x0, Bhv_Custom_0x13001578,63),
OBJECT_WITH_ACTS(59,-13406,-738,5230,0,0,0,0x0, Bhv_Custom_0x13001578,63),
OBJECT_WITH_ACTS(59,-6519,-644,6740,0,0,0,0x0, Bhv_Custom_0x13001578,63),
OBJECT_WITH_ACTS(59,-13788,-694,11185,0,0,0,0x0, Bhv_Custom_0x13001578,63),
OBJECT_WITH_ACTS(23,17309,-738,-5146,0,0,0,0x0, bhvCcmTouchedStarSpawn,63),
OBJECT_WITH_ACTS(23,15292,-729,-9700,0,0,0,0x0, bhvCcmTouchedStarSpawn,63),
OBJECT_WITH_ACTS(23,9742,-747,-9427,0,0,0,0x0, bhvCcmTouchedStarSpawn,63),
OBJECT_WITH_ACTS(24,13314,-512,15716,0,42,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(24,13000,412,15808,0,44,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(24,13038,1042,15873,0,44,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(24,13333,1956,15684,0,44,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(24,13511,2149,16163,0,134,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(24,663,4022,945,0,0,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(24,-2373,5723,1735,0,90,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(24,-1717,1684,1043,0,90,0,0x0,bhvOctoomba,63),
OBJECT_WITH_ACTS(25,15163,3955,15241,0,0,0,0x0, bhvRedRockShooter,63),
OBJECT_WITH_ACTS(38,-3904,9233,-2500,0,-90,0,0x6800000, Bhv_Custom_0x13002304,63),
OBJECT_WITH_ACTS(25,5125,7396,4710,0,-108,0,0x0, bhvRedRockShooter,63),
OBJECT_WITH_ACTS(25,683,8598,-7051,0,0,0,0x0, bhvRedRockShooter,63),
OBJECT_WITH_ACTS(25,-4874,6492,-282,0,-141,0,0x0, bhvRedRockShooter,63),
OBJECT_WITH_ACTS(25,-2680,8442,-7694,0,81,0,0x0, bhvRedRockShooter,63),
OBJECT_WITH_ACTS(25,-4228,8837,-4947,0,144,0,0x0, bhvRedRockShooter,63),
//Bhv_Custom_0x13001638
OBJECT_WITH_ACTS(122,-10355,-499,-7828,0,0,0,(5 << 24 | 25 << 8), bhvStar,63),
OBJECT_WITH_ACTS(0,7550,-865,6961,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-11711,-159,-14216,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(124,-8221,-321,14419,0,-79,0,0xa50000, bhvMessagePanel,63),
OBJECT_WITH_ACTS(0,16205,882,-13627,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-3650,-30,0,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,3650,-29,0,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,-30,3650,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,-29,-3650,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,1800,3773,0,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-1800,3773,0,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-2379,6127,9,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,2262,350,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,17000,0,0,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,0,11650,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,0,-15350,0,90,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-12000,0,0,0,0,0,0x0, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,-7004,1869,17022,0,0,0,0x20000, bhvCoinFormation,63),
OBJECT_WITH_ACTS(0,0,5052,0,0,0,0,0x4050000, bhvBetaChestLid,63),
OBJECT_WITH_ACTS(130,10662,-168,12476,0,26,0,0x30000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(130,10448,-168,12624,0,26,0,0x20000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(130,10572,-168,12226,0,26,0,0x10000, bhvBreakableBox,63),
OBJECT_WITH_ACTS(36,2385,127,300,0,0,0,0x0,Bhv_Custom_0x1300184c,63),
//start
// left then right if theres two (no one understands what this means besides maniscat2)
OBJECT_WITH_ACTS(57,2367,6500,2950,0,0,0,(1 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,2367,6500,3400,0,90,0,(2 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,1894,6500,3550,0,0,0,(0 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,1894,6500,4150,0,0,0,(2 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,2200,6500,4600,0,90,0,(3 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,2200,6500,5200,0,90,0,(2 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,2200,6500,5800,0,90,0,(0 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,1600,6500,5800,0,90,0,(1 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,1000,6500,5800,0,90,0,(1 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,1600,6500,4600,0,90,0,(1 << 16), bhvMarioGalaxyBlock,63),
OBJECT_WITH_ACTS(57,1130,6500,4600,0,0,0,(3 << 16), bhvMarioGalaxyBlock,63),
//end
OBJECT_WITH_ACTS(0,8768,11264,12288,0,0,0,0xda2a0000,editor_Scroll_Texture,31),
RETURN()
};
const LevelScript local_warps_bbh_1_[] = {
WARP_NODE(10,LEVEL_BBH,1,10,0),
WARP_NODE(11,9,1,12,0),
WARP_NODE(12,9,1,11,0),
WARP_NODE(13,9,1,14,0),
WARP_NODE(14,9,1,13,0),
WARP_NODE(240,16,1,213,0),
WARP_NODE(241,16,1,229,0),
WARP_NODE(0,9,1,10,0),
WARP_NODE(1,9,1,10,0),
WARP_NODE(2,9,1,10,0),
WARP_NODE(3,9,1,10,0),
WARP_NODE(4,9,1,10,0),
WARP_NODE(153,29,1,10,0),
WARP_NODE(6,9,1,10,0),
RETURN()
};
