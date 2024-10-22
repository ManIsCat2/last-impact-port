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


/* Fast64 begin persistent block [includes] */
/* Fast64 end persistent block [includes] */

#include "make_const_nonconst.h"
#include "levels/castle_grounds/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_castle_grounds_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _castle_grounds_segment_7SegmentRomStart, _castle_grounds_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _water_skybox_mio0SegmentRomStart, _water_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario),

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, castle_grounds_area_1),
		WARP_NODE(153, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(120, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(226, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(210, LEVEL_CASTLE_COURTYARD, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(211, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(227, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(209, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(225, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(229, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(241, LEVEL_CASTLE_GROUNDS, 1, 241, WARP_NO_CHECKPOINT),
		WARP_NODE(240, LEVEL_CASTLE_GROUNDS, 1, 240, WARP_NO_CHECKPOINT),
		WARP_NODE(14, LEVEL_TOTWC, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(228, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(212, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(9, LEVEL_BBH, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(13, LEVEL_CCM, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(0, LEVEL_WF, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(11, LEVEL_JRB, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(10, LEVEL_BOB, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(223, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(239, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(213, LEVEL_WMOTR, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(34, LEVEL_ENDING, 1, 12, WARP_NO_CHECKPOINT),
		WARP_NODE(33, LEVEL_ENDING, 1, 12, WARP_NO_CHECKPOINT),
		WARP_NODE(32, LEVEL_CASTLE_GROUNDS, 2, 10, WARP_NO_CHECKPOINT),
		MARIO_POS(0x01, 90, 3174, -376, 438),
		/*OBJECT(53, 1699, -533, -4073, 0, -154, 0, 0x0, Bhv_Custom_0x1300001c),
		OBJECT(53, 1337, -648, -3526, 0, 0, 0, 0x0, Bhv_Custom_0x1300001c),*/
		OBJECT(MODEL_BOAT, 1455, -1573, -2871, -2, -44, -58, 0x0, bhvBoat),
		OBJECT(MODEL_BOAT, 256, -865, -1635, 0, -90, 0, 0x10000, bhvBoat),
		/*OBJECT(0, 1344, -2079, -3346, 0, -100, 0, 0x30000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8426, -552, 5820, 41, 0, -17, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8435, -573, 5639, -41, 0, -70, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8245, -573, 5990, -24, 0, -14, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8530, -469, 5346, -40, 60, 5, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8504, -353, 5535, -14, 0, 4, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8385, -359, 5961, 18, 0, 2, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8809, -263, 5382, -53, 21, 21, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8687, -340, 5514, 70, 0, -115, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8487, -203, 5937, -34, 0, 28, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8683, -167, 5816, 15, 0, -153, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8727, -111, 6043, -16, 0, -17, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8621, -223, 6217, 0, 0, 0, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8846, -223, 6298, 55, 0, -32, 0x81130000, Bhv_Custom_0x1300024c),
		OBJECT(56, 8584, -223, 5738, 0, 0, 0, 0x81130000, Bhv_Custom_0x1300024c),*/
		OBJECT(MODEL_CG_20_GATE, 7507, -663, 5470, 0, -25, 0, 0x2130000, bhvCG20Gate),
		OBJECT(MODEL_CG_20_GATE, 7674, -655, 5108, 0, 155, 0, 0x2130000, bhvCG20Gate),
		OBJECT(MODEL_ROCKET_DOOR, 4278, 146, -4936, 0, 0, 0, 0x30e0000, bhvRocketDoor),
		OBJECT(E_MODEL_BITS_WARP_PIPE, 7945, -426, -3306, 0, 0, 0, 0x0, id_bhvWarpPipe),
		OBJECT(E_MODEL_TOAD, 7108, -662, 5262, 0, -130, 0, (DIALOG_019 << 24), id_bhvToadMessage),
		OBJECT(E_MODEL_TOAD, 535, -835, -2463, 0, 0, 0, (53 << 24), id_bhvToadMessage),
		OBJECT(E_MODEL_TOAD, 4688, 5, -4916, 0, 0, 0, (54 << 24) | (3 << 16), id_bhvToadMessage),
		//OBJECT(0, 372, 3095, 403, 0, 0, 0, 0x0, Bhv_Custom_0x13000668),
		OBJECT(MODEL_ROCKET, 4076, 47, -5412, 0, 28, 0, 0x0, bhvRocket),
		//OBJECT(102, 3169, -635, -1901, 0, -129, 0, 0x1e0000, Bhv_Custom_0x13002740),
		////OBJECT(222, 5382, -640, 749, 0, 0, 0, 0x0, Bhv_Custom_0x13002fe0),
		//OBJECT(32, 0, 21829, 0, 0, 0, 0, 0x0, Bhv_Custom_0x13003014),
		//OBJECT(0, 5866, -706, -706, 0, 0, 0, 0x3000000, Bhv_Custom_0x130030cc),
		//OBJECT(0, 6523, -429, -476, 0, 0, 0, 0x8020000, Bhv_Custom_0x130030cc),
		//OBJECT(0, 6588, -429, 114, 0, 0, 0, 0x10030000, Bhv_Custom_0x130030cc),
		//OBJECT(MODEL_GOOMBA_BRO1, 5871, -657, -428, 0, 0, 0, 0x1000000, bhvGoombaBros),
		//OBJECT(62, 1288, -643, 5764, 0, 0, 0, 0x0, Bhv_Custom_0x130044b4),
		//OBJECT(MODEL_GOOMBABROS_TRIANGLE, 5866, -654, -706, 0, 0, 0, 0x3000000, bhvGoombaBrosTraingle),
		//OBJECT(0, 6523, -429, -476, 0, 0, 0, 0x8020000, Bhv_Custom_0x13004830),
		//OBJECT(0, 6588, -429, 114, 0, 0, 0, 0x10030000, Bhv_Custom_0x13004830),
		//OBJECT(MODEL_GOOMBA_BRO2, 5940, -676, -977, 0, 0, 0, 0x2000000, bhvGoombaBros),
		//OBJECT(MODEL_GOOMBA_BRO3, 5625, -660, -732, 0, 0, 0, 0x0, bhvGoombaBros),
		OBJECT(212, 8624, 486, -3677, 0, 0, 0, 0x0, bhv1Up),
		OBJECT(0, 7645, -200, -3293, 0, 120, 0, 0xe20000, bhvAirborneStarCollectWarp),
		OBJECT(0, 903, -586, -2529, 0, 0, 0, 0xe30000, bhvAirborneStarCollectWarp),
		OBJECT(0, 347, -455, 4834, 0, -85, 0, 0xe10000, bhvAirborneStarCollectWarp),
		OBJECT(0, 7451, -79, -38, 0, 90, 0, 0xef0000, bhvAirborneStarCollectWarp),
		OBJECT(0, 2421, -657, -2147, 0, -90, 0, 0xe40000, bhvAirborneStarCollectWarp),
		OBJECT(0, 4500, 463, -4506, 0, -153, 0, 0xd50000, bhvAirborneStarCollectWarp),
		OBJECT(MODEL_TOTWC_ENTRY_LIGHT, 7781, -257, -28, 0, 0, 0, (14 << 16), bhvTOTWCEntryLight),
		/*OBJECT(150, 3163, -652, -1897, 0, 0, 0, 0x0, bhvBowserShockWave),
		OBJECT(150, 3170, -639, -1881, 0, 0, 0, 0x0, bhvBowserShockWave),
		OBJECT(150, 3164, -656, -1918, 0, 0, 0, 0x0, bhvBowserShockWave),
		OBJECT(150, 3147, -639, -1875, 0, 0, 0, 0x0, bhvBowserShockWave),
		OBJECT(150, 3194, -650, -1894, 0, 0, 0, 0x0, bhvBowserShockWave),
		OBJECT(150, 3117, -670, -1906, 0, 0, 0, 0x0, bhvBowserShockWave),
		OBJECT(150, 3122, -652, -1881, 0, 0, 0, 0x0, bhvBowserShockWave),*/
		OBJECT(0, 4162, -174, 479, 0, 90, 0, 0xf10000, bhvDeathWarp),
		OBJECT(0, 7645, -200, -3293, 0, 120, 0, 0xd20000, bhvDeathWarp),
		OBJECT(0, 903, -586, -2529, 0, 0, 0, 0xd30000, bhvDeathWarp),
		OBJECT(0, 347, -455, 4834, 0, -85, 0, 0xd10000, bhvDeathWarp),
		OBJECT(0, 7451, -79, -38, 0, 90, 0, 0xdf0000, bhvDeathWarp),
		OBJECT(0, 2421, -657, -2147, 0, -90, 0, 0xd40000, bhvDeathWarp),
		OBJECT(0, 4500, 524, -4506, 0, -153, 0, 0xe50000, bhvDeathWarp),
		/*OBJECT(0, 1441, -485, -3944, 0, 0, 0, 0x0, bhvMrI),
		OBJECT(0, 1367, -641, -3179, 0, 0, 0, 0x0, bhvMrI),
		OBJECT(0, 160, -697, -3329, 0, 0, 0, 0x0, bhvMrI),*/
		OBJECT(E_MODEL_PEACH, 4060, -373, 4537, 0, 0, 0, (15 << 24), bhvTalkingPeach),
		OBJECT(0, 3174, -376, 438, 0, 90, 0, (10 << 16), bhvSpinAirborneWarp),
		OBJECT(0, 7012, -590, 5056, 0, -108, 0, 0x200000, bhvSpinAirborneWarp),
		OBJECT(0, 6478, -633, 1063, 0, -119, 0, 0x780000, bhvSpinAirborneWarp),
		OBJECT(0, 4212, -473, 5396, 0, 0, 0, 0x990000, bhvSpinAirborneWarp),
		OBJECT(E_MODEL_YOSHI, 3911, -372, 4345, 0, 164, 0, 0x320000, bhvTalkingYoshi),
		OBJECT(0, 4137, 13531, -5383, 0, 0, 0, 0x0, bhvStaticObject),
		OBJECT(0, -1110, -833, 5128, 0, 0, 0, 0x500a0000, bhvWarp),
		OBJECT(0, 1274, -1298, -4281, 0, 0, 0, 0x400d0000, bhvWarp),
		OBJECT(0, 1274, -1548, -4281, 0, 0, 0, 0x400d0000, bhvWarp),
		OBJECT(0, 8401, -635, 5661, 0, 0, 0, 0x40200000, bhvWarp),
		OBJECT(MODEL_MINIGAME_HOUSE, 7099, -600, 1561, 0, -120, 0, 0x0, id_bhvStaticObject),
		OBJECT(MODEL_NONE, 4076, 4440, -5412, 0, -153, 0, (9 << 16), bhvWarp),
		OBJECT(MODEL_NONE, -1965, -729, -1635, 0, -90, 0, (80 << 24) | (11 << 16), bhvWarp),
		TERRAIN(castle_grounds_area_1_collision),
		MACRO_OBJECTS(castle_grounds_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, 0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	AREA(2, castle_grounds_area_2),
		WARP_NODE(37, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(36, LEVEL_PSS, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(35, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(34, LEVEL_BITDW, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(33, LEVEL_CASTLE, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(10, LEVEL_CASTLE_GROUNDS, 1, 32, WARP_NO_CHECKPOINT),
		WARP_NODE(241, LEVEL_CASTLE_GROUNDS, 1, 241, WARP_NO_CHECKPOINT),
		WARP_NODE(240, LEVEL_CASTLE_GROUNDS, 1, 240, WARP_NO_CHECKPOINT),
		WARP_NODE(206, LEVEL_PSS, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(191, LEVEL_PSS, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(207, LEVEL_PSS, 1, 10, WARP_NO_CHECKPOINT),
		OBJECT(MODEL_FLOATING_PLATFORM_GENERATOR, -310, -394, -278, 0, 90, 0, 0x120000, bhvFloatingPlatformGenerator),
		//OBJECT(0, -260, -266, -313, 0, 0, 0, 0x0, Bhv_Custom_0x13001bf0),
		//OBJECT(0, -7448, 16, -885, 0, 0, 0, 0x0, Bhv_Custom_0x13001bf0),
		//OBJECT(0, -1771, -1164, -2344, 0, 0, 0, 0x0, Bhv_Custom_0x13001bf0),
		//OBJECT(0, -7448, -54, -156, 0, 0, 0, 0x0, Bhv_Custom_0x13001bf0),
		OBJECT(0, 5594, 312, -249, 0, -90, 0, 0x220000, bhvAirborneStarCollectWarp),
		OBJECT(0, -5006, 11, -366, 0, 90, 0, 0x240000, bhvAirborneStarCollectWarp),
		OBJECT(0, 5555, 284, -220, 0, 90, 0, 0xcf0000, bhvAirborneStarCollectWarp),
		OBJECT(MODEL_BOWSER_KEY_GATE, -9039, 114, -2496, 0, 0, 0, 0xff0000, bhvBowserKeyGate),
		OBJECT(MODEL_BOWSER_KEY_GATE, -7610, 114, -2496, 0, -180, 0, 0x10000, bhvBowserKeyGate),
		OBJECT(0, 5594, 312, -249, 0, -90, 0, 0x230000, bhvDeathWarp),
		OBJECT(0, -5006, 11, -366, 0, 90, 0, 0x250000, bhvDeathWarp),
		OBJECT(0, 5555, 284, -220, 0, 90, 0, 0xbf0000, bhvDeathWarp),
		OBJECT(124, -7820, 112, -1737, 0, -20, 0, 0x400000, bhvMessagePanel),
		OBJECT(0, -8299, 67, 737, 0, -180, 0, 0xa0000, bhvSpinAirborneWarp),
		OBJECT(0, -8410, 143, -2101, 0, 0, 0, 0x210000, bhvSpinAirborneWarp),
		OBJECT(0, -8273, 156, 1821, 0, 0, 0, 0x400a0000, bhvWarp),
		OBJECT(0, -8384, 172, -3176, 0, 0, 0, 0x40210000, bhvWarp),
		OBJECT(0, 6870, -13, -349, 0, 0, 0, 0x40220000, bhvWarp),
		OBJECT(0, -1713, -1657, -2410, 0, 0, 0, 0x10240000, bhvWarp),
		TERRAIN(castle_grounds_area_2_collision),
		MACRO_OBJECTS(castle_grounds_area_2_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, 0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 90, 3174, -376, 438),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
