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

#include "levels/rr/header.h"
extern u8 _rr_segment_ESegmentRomStart[];
extern u8 _rr_segment_ESegmentRomEnd[];

const LevelScript level_rr_entry[] = {
	INIT_LEVEL(),
	LOAD_RAW(0x0E, _rr_segment_ESegmentRomStart, _rr_segment_ESegmentRomEnd),
	LOAD_MIO0(0xA, _SkyboxCustom36044480_skybox_mio0SegmentRomStart, _SkyboxCustom36044480_skybox_mio0SegmentRomEnd),
	LOAD_MIO0(8, _common0_mio0SegmentRomStart, _common0_mio0SegmentRomEnd),
	LOAD_RAW(15, _common0_geoSegmentRomStart, _common0_geoSegmentRomEnd),
	LOAD_MIO0(5, _group11_mio0SegmentRomStart, _group11_mio0SegmentRomEnd),
	LOAD_RAW(12, _group11_geoSegmentRomStart, _group11_geoSegmentRomEnd),
	LOAD_MIO0(6, _group14_mio0SegmentRomStart, _group14_mio0SegmentRomEnd),
	LOAD_RAW(13, _group14_geoSegmentRomStart, _group14_geoSegmentRomEnd),
	ALLOC_LEVEL_POOL(),
	MARIO(/*model*/ MODEL_MARIO, /*behParam*/ 0x00000001, /*beh*/ bhvMario),
	// Unspecified Models
	LOAD_MODEL_FROM_GEO(22,  warp_pipe_geo),
	LOAD_MODEL_FROM_GEO(23, meteor_geo),
	LOAD_MODEL_FROM_GEO(24, rainbow_snake_block_geo),
	// LOAD_MODEL_FROM_GEO(25, 0x19001da0),
	LOAD_MODEL_FROM_GEO(27,  palm_tree_geo),
	LOAD_MODEL_FROM_GEO(29,  haunted_door_geo),
	LOAD_MODEL_FROM_GEO(31,  metal_door_geo),
	LOAD_MODEL_FROM_GEO(32,  hazy_maze_door_geo),
	LOAD_MODEL_FROM_GEO(34,  castle_door_0_star_geo),
	LOAD_MODEL_FROM_GEO(35,  castle_door_1_star_geo),
	LOAD_MODEL_FROM_GEO(36,  castle_door_3_stars_geo),
	LOAD_MODEL_FROM_GEO(37,  key_door_geo),
	LOAD_MODEL_FROM_GEO(38,  castle_door_geo),
	LOAD_MODEL_FROM_GEO(53, rr_rotating_thing_geo),
	LOAD_MODEL_FROM_GEO(54, launch_star_geo),
	LOAD_MODEL_FROM_GEO(55, rainbow_thwomp_geo),
	LOAD_MODEL_FROM_GEO(56, Noteblock_MOP),
	LOAD_MODEL_FROM_GEO(57, rainbow_star_geo),
	// LOAD_MODEL_FROM_GEO(58, 0x19001cc0),
	// LOAD_MODEL_FROM_GEO(59, 0x19001ce0),
	LOAD_MODEL_FROM_GEO(60, rr_cart_geo),
	// LOAD_MODEL_FROM_GEO(88, 0x0500c778),
	// LOAD_MODEL_FROM_DL(132, 0x08025f08, 4),
	// LOAD_MODEL_FROM_GEO(133, 0x007e0000),
	// LOAD_MODEL_FROM_DL(158, 0x0302c8a0, 4),
	// LOAD_MODEL_FROM_DL(159, 0x0302bcd0, 4),
	// LOAD_MODEL_FROM_DL(161, 0x0301cb00, 4),
	// LOAD_MODEL_FROM_DL(164, 0x04032a18, 4),
	// LOAD_MODEL_FROM_DL(201, 0x080048e0, 4),
	// LOAD_MODEL_FROM_DL(218, 0x08024bb8, 4),
	JUMP_LINK(script_func_global_1),
	JUMP_LINK(script_func_global_12),
	JUMP_LINK(script_func_global_15),
	JUMP_LINK(local_area_rr_1_),
	JUMP_LINK(local_area_rr_2_),
	FREE_LEVEL_POOL(),
	MARIO_POS(/* area */ 1, /* yaw */ 0, /* pos */ 6227, 4096, -7558),
	CALL(/*arg*/ 0, /*func*/ lvl_init_or_update),
	CALL_LOOP(/*arg*/ 1, /*func*/ lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(/*frames*/ 1),
	EXIT(),
};

const LevelScript local_area_rr_1_[] = {
	AREA(1, Geo_rr_1_0x2121700),
	TERRAIN(col_rr_1_0xe0829a0),
	SET_BACKGROUND_MUSIC(0, 67),
	TERRAIN_TYPE(0),
	JUMP_LINK(local_objects_rr_1_),
	JUMP_LINK(local_warps_rr_1_),
	END_AREA(),
	RETURN()
};

const LevelScript local_objects_rr_1_[] = {
	OBJECT_WITH_ACTS(0, 3253, 2371, -1124, 0, 90, 0, 0xa0000,  bhvSpinAirborneWarp, 63),
	OBJECT_WITH_ACTS(215, 1451, -45, -3029, 0, -154, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(215, 4655, -13, -2797, 0, -153, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(215, 1670, -206, 475, 0, 107, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(215, 4968, -239, 551, 0, -151, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(215, 3250, -85, -4180, 0, 0, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(215, 170, -85, -1127, 0, 0, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(215, 3263, -85, 1874, 0, 0, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(215, 6264, -85, -1088, 0, 0, 0, 0x0,  bhvRedCoin, 63),
	OBJECT_WITH_ACTS(0, 1271, 171, -1118, 0, 0, 0, 0x4000000,  bhvHiddenRedCoinStar, 63),
	OBJECT_WITH_ACTS(122, 1979, 6864, -1240, 0, 0, 0, 0x0,  bhvStar, 63),
	OBJECT_WITH_ACTS(122, 10353, 5201, -10050, 0, 0, 0, 0x1000000,  bhvStar, 63),
	OBJECT_WITH_ACTS(122, 737, 1086, 7494, 0, 0, 0, 0x2000000,  bhvStar, 63),
	OBJECT_WITH_ACTS(122, -4363, 2549, -4212, 0, 0, 0, 0x3000000,  bhvStar, 63),
	OBJECT_WITH_ACTS(53, -3394, 1309, 2156, 164, 158, 278, 0x0,  bhvRRrotatingThing, 63),
	OBJECT_WITH_ACTS(54, -1787, 174, -64, -35, -68, 0, 0x26280000,  bhvLaunchStar, 63),
	OBJECT_WITH_ACTS(54, 3224, 160, 891, -45, -176, 0, 0x412e0000,  bhvLaunchStar, 63),
	OBJECT_WITH_ACTS(54, -2698, 1575, 3711, -45, 113, 0, 0x30240000,  bhvLaunchStar, 63),
	OBJECT_WITH_ACTS(54, 4115, 5297, 2196, -30, 211, 0, 0x45220000,  bhvLaunchStar, 63),
	OBJECT_WITH_ACTS(0, 3228, 2222, -3625, 0, 90, 0, 0x0,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(0, 3244, 590, -1131, 0, 0, 0, 0x20000,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(212, 3240, 3037, -1127, 0, 0, 0, 0x0,  bhv1Up, 63),
	OBJECT_WITH_ACTS(0, 3248, -722, -2293, 0, 180, 0, 0x40000,  bhvSpinAirborneWarp, 63),
	OBJECT_WITH_ACTS(0, 3250, -859, -1751, 0, 0, 0, 0x18040000,  bhvWarp, 63),
	OBJECT_WITH_ACTS(55, -456, -7, -604, 0, 112, 0, 0x74300000,  bhvThwomp, 63),
	OBJECT_WITH_ACTS(55, -1317, -7, -253, 0, 112, 0, 0x74340000,  bhvThwomp, 63),
	OBJECT_WITH_ACTS(55, 7803, 2443, -4311, 0, 111, 0, 0x5c440000,  bhvThwomp, 63),
	OBJECT_WITH_ACTS(0, 7838, 337, -1873, 0, 112, 0, 0x0,  bhvFakeRRWind, 63),
	OBJECT_WITH_ACTS(56, 64, 2368, 2555, 0, 112, 0, 0x30000000,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, -490, 3612, 974, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, -290, 3612, 774, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, -490, 3612, 774, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, -290, 3612, 974, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, 2230, 4994, 298, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, 2030, 4994, 498, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, 2230, 4994, 498, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(56, 2030, 4994, 298, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	OBJECT_WITH_ACTS(102, 4874, 3095, -7073, 0, 0, 0, 0x30000000,  bhvMovingChomp, 63),
	OBJECT_WITH_ACTS(102, 4291, 3098, -5335, 0, 21, 0, 0x40000000,  bhvMovingChomp, 63),
	OBJECT_WITH_ACTS(102, 5463, 3095, -3210, 0, 51, 0, 0x1c000000,  bhvMovingChomp, 63),
	OBJECT_WITH_ACTS(102, 4838, 3095, -6042, 0, -13, 0, 0xd7000000,  bhvMovingChomp, 63),
	OBJECT_WITH_ACTS(102, 5327, 3095, -4779, 0, 31, 0, 0xe0000000,  bhvMovingChomp, 63),
	OBJECT_WITH_ACTS(0, 5936, 3095, -3414, 0, 0, 0, 0x20000,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(0, 7869, 287, -2462, 0, 0, 0, 0x110000,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(116, 3007, 2313, -1738, 0, 0, 0, 0x0,  bhvOneCoin, 63),
	OBJECT_WITH_ACTS(116, 3053, 2248, -1098, 0, 0, 0, 0x0,  bhvOneCoin, 63),
	OBJECT_WITH_ACTS(116, 3126, 1837, -462, 0, 0, 0, 0x0,  bhvOneCoin, 63),
	OBJECT_WITH_ACTS(116, 3138, 1253, 15, 0, 0, 0, 0x0,  bhvOneCoin, 63),
	OBJECT_WITH_ACTS(116, 2930, 2257, -2528, 0, 0, 0, 0x0,  bhvOneCoin, 63),
	OBJECT_WITH_ACTS(0, -864, -7, -469, 0, 112, 0, 0x0,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(0, 7856, 1480, -1860, 0, 0, 0, 0x20000,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(57, 6227, 3674, -7558, 0, 0, 0, 0x430000,  bhvRainbowStar, 63),
	OBJECT_WITH_ACTS(0, 10363, 1968, -3127, 0, -11, 0, 0x0,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(84, 10119, 2556, -4370, 0, 0, 0, 0x0,  bhvBigBoulderGenerator, 63),
	OBJECT_WITH_ACTS(84, 10156, 2166, -2292, 0, 0, 0, 0x0,  bhvBigBoulderGenerator, 63),
	OBJECT_WITH_ACTS(84, 7135, 3812, -4063, 0, 0, 0, 0x0,  bhvBigBoulderGenerator, 63),
	OBJECT_WITH_ACTS(84, -1246, 1130, -4800, 0, 0, 0, 0x0,  bhvBigBoulderGenerator, 63),
	OBJECT_WITH_ACTS(60, 3331, -41, 2426, 0, 90, 0, 0x0,  bhvRRRideableCart, 63),
	OBJECT_WITH_ACTS(122, -2168, 7737, 7916, 0, 102, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, 4179, 8127, 6658, 0, 118, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, -3542, 7418, 7827, 0, -160, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, 11015, 8056, 1098, 0, 161, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, 12644, 7525, -8429, 0, 9, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, 9527, 7631, 708, 0, -31, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, -6269, 7843, -885, 0, 6, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, 9740, 8658, -12467, 0, -74, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, 4250, 7525, -14202, 0, -55, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, -5985, 7962, -8146, 0, 99, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, -3951, 7534, -6214, 0, 137, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, -507, 8851, -13846, 0, -36, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(122, 15400, 9324, -3411, 0, -163, 0, 0x0,  bhvFakeStar, 63),
	OBJECT_WITH_ACTS(23, 6561, 4427, -13073, 0, 36, 0, 0x7f000000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, 2054, 2773, 11749, 93, 0, 157, 0x69010000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, 12960, 2447, 2448, 18, 0, 155, 0xa0000000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, -7624, 1154, -4216, 201, 0, -181, 0x64010000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, 8568, -1247, 11126, 104, 98, -119, 0x60000000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, 15780, 1108, -4796, 224, 0, -177, 0x64010000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, -6367, -1524, 1549, 8, 0, 67, 0x8f000000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, -5801, 970, 6426, 32, 0, -59, 0x92010000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, -4949, 0, -3954, -151, 0, 232, 0xc0000000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, 16454, 4017, 460, -112, 0, 25, 0x50010000,  bhvStaticObject, 63),
	OBJECT_WITH_ACTS(23, 1110, -2585, 13374, 120, 0, 42, 0x84000000,  bhvStaticObject, 63),
	//OBJECT_WITH_ACTS(24, 2101, -143, -4101, 0, -113, 0, 0x10000,  bhvRainbowSnakeBlock, 63),
	OBJECT_WITH_ACTS(56, 1676, -143, -4245, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),

	OBJECT_WITH_ACTS(56, 993, -143, -4553, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),

	OBJECT_WITH_ACTS(56, -321, 397, -5122, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),

	OBJECT_WITH_ACTS(56, -1030, 397, -5448, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),

	OBJECT_WITH_ACTS(56, -2088, 847, -5003, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	
	OBJECT_WITH_ACTS(56, -2929, 1057, -3610, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),

	OBJECT_WITH_ACTS(56, -3670, 2167, -4014, 0, 0, 0, 0x0,  bhvNoteblock_MOP, 63),
	//end
	OBJECT_WITH_ACTS(0, -1822, 870, -5727, 0, 0, 0, 0x0,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(0, -291, 3609, 1719, 0, 24, 0, 0x0,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(140, 6057, -85, -1546, 0, -23, 0, 0x10000,  bhvBlueCoinSwitch, 63),
	OBJECT_WITH_ACTS(118, 7254, 224, -2504, 0, 0, 0, 0x0,  bhvHiddenBlueCoin, 63),
	OBJECT_WITH_ACTS(118, 6754, 162, -2325, 0, 0, 0, 0x0,  bhvHiddenBlueCoin, 63),
	OBJECT_WITH_ACTS(118, 6281, 100, -1869, 0, 0, 0, 0x0,  bhvHiddenBlueCoin, 63),
	OBJECT_WITH_ACTS(0, 1723, 911, 3495, 0, 7, 0, 0x0,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(0, 16, 4, 180, 3, 0, 0, 0, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 4, 360, 3, 0, 0, 1, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 4, 360, 3, 0, 0, 2, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 5, 204, 3, 0, 0, 3, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 5, 72, 9, 0, 0, 4, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 5, 60, 3, 0, 0, 5, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 4, 360, 3, 0, 0, 6, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 64, 4, 24, 0, 0, 0, 7, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 5, 24, 0, 0, 0, 8, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 32, 5, 360, 6, 0, 0, 9, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 5, 375, 3, 0, 0, 10, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 5, 375, 3, 0, 0, 11, editor_Scroll_Texture, 63),
	OBJECT_WITH_ACTS(0, 16, 5, 372, 6, 0, 0, 12, editor_Scroll_Texture, 63),
	RETURN()
};

const LevelScript local_warps_rr_1_[] = {
	WARP_NODE(10, 9, 1, 10, 0),
	WARP_NODE(11, 9, 1, 12, 0),
	WARP_NODE(12, 9, 1, 11, 0),
	WARP_NODE(13, 9, 1, 14, 0),
	WARP_NODE(14, 9, 1, 13, 0),
	WARP_NODE(240, 26, 1, 213, 0),
	WARP_NODE(241, 26, 1, 229, 0),
	WARP_NODE(0, 9, 1, 10, 0),
	WARP_NODE(1, 9, 1, 10, 0),
	WARP_NODE(2, 9, 1, 10, 0),
	WARP_NODE(3, 9, 1, 10, 0),
	WARP_NODE(4, 15, 2, 10, 0),
	WARP_NODE(153, 28, 1, 10, 0),
	WARP_NODE(6, 9, 1, 10, 0),
	RETURN()
};

const LevelScript local_area_rr_2_[] = {
	AREA(2, Geo_rr_2_0x2121600),
	TERRAIN(col_rr_2_0xe095fa8),
	SET_BACKGROUND_MUSIC(0, 64),
	TERRAIN_TYPE(0),
	JUMP_LINK(local_objects_rr_2_),
	JUMP_LINK(local_warps_rr_2_),
	END_AREA(),
	RETURN()
};

const LevelScript local_objects_rr_2_[] = {
	OBJECT_WITH_ACTS(0, -3408, 0, 8, 0, 90, 0, 0x880a0000,  bhvSpinAirborneWarp, 63),
	OBJECT_WITH_ACTS(0, -3940, 0, 11, 0, 90, 0, 0x280a0000,  bhvWarp, 63),
	OBJECT_WITH_ACTS(0, 0, 0, 0, 0, 0, 0, 0x0,  Bhv_Custom_0x13003d8c, 63),
	OBJECT_WITH_ACTS(0, 5, -829, 19, 0, 107, 0, 0x20000,  bhvCoinFormation, 63),
	OBJECT_WITH_ACTS(140, 2850, -82, 0, 0, 0, 0, 0x0,  bhvBlueCoinSwitch, 63),
	OBJECT_WITH_ACTS(118, 1500, -735, 0, 0, 0, 0, 0x0,  bhvHiddenBlueCoin, 63),
	OBJECT_WITH_ACTS(118, 0, -735, -1500, 0, 0, 0, 0x0,  bhvHiddenBlueCoin, 63),
	OBJECT_WITH_ACTS(118, 0, -735, 1500, 0, 0, 0, 0x0,  bhvHiddenBlueCoin, 63),
	OBJECT_WITH_ACTS(118, -1500, -735, 0, 0, 0, 0, 0x0,  bhvHiddenBlueCoin, 63),
	OBJECT_WITH_ACTS(25, -878, 1744, -878, 0, 45, 0, 0x0,  Bhv_Custom_0x13003f64, 63),
	OBJECT_WITH_ACTS(25, 878, 1744, -878, 0, -45, 0, 0x0,  Bhv_Custom_0x13003f64, 63),
	OBJECT_WITH_ACTS(25, -878, 1744, 878, 0, 135, 0, 0x0,  Bhv_Custom_0x13003f64, 63),
	OBJECT_WITH_ACTS(25, 878, 1744, 878, 0, 225, 0, 0x0,  Bhv_Custom_0x13003f64, 63),
	RETURN()
};

const LevelScript local_warps_rr_2_[] = {
	WARP_NODE(240, 26, 1, 213, 0),
	WARP_NODE(241, 26, 1, 229, 0),
	WARP_NODE(0, 9, 1, 10, 0),
	WARP_NODE(1, 9, 1, 10, 0),
	WARP_NODE(2, 9, 1, 10, 0),
	WARP_NODE(3, 9, 1, 10, 0),
	WARP_NODE(4, 9, 1, 10, 0),
	WARP_NODE(5, 9, 1, 10, 0),
	WARP_NODE(10, 15, 1, 4, 0),
	RETURN()
};
