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
#include "levels/wf/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_wf_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _wf_segment_7SegmentRomStart, _wf_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _water_skybox_mio0SegmentRomStart, _water_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario),

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, wf_area_1),
		WARP_NODE(6, LEVEL_BOB, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(153, LEVEL_JRB, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(4, LEVEL_BOB, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(3, LEVEL_ENDING, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(2, LEVEL_BOB, 1, 10, WARP_NO_CHECKPOINT),
		WARP_NODE(35, LEVEL_WF, 3, 0, WARP_NO_CHECKPOINT),
		WARP_NODE(34, LEVEL_WF, 2, 1, WARP_NO_CHECKPOINT),
		WARP_NODE(241, LEVEL_CASTLE_GROUNDS, 1, 210, WARP_NO_CHECKPOINT),
		WARP_NODE(240, LEVEL_CASTLE_GROUNDS, 1, 226, WARP_NO_CHECKPOINT),
		WARP_NODE(14, LEVEL_BOB, 1, 13, WARP_NO_CHECKPOINT),
		WARP_NODE(13, LEVEL_BOB, 1, 14, WARP_NO_CHECKPOINT),
		WARP_NODE(12, LEVEL_BOB, 1, 11, WARP_NO_CHECKPOINT),
		WARP_NODE(11, LEVEL_BOB, 1, 12, WARP_NO_CHECKPOINT),
		WARP_NODE(10, LEVEL_BOB, 1, 10, WARP_NO_CHECKPOINT),
		OBJECT(133, -5598, -3521, 5874, 0, 128, 0, 0x0, Bhv_Custom_0x130000c0),
		OBJECT(133, 4395, -2932, -5232, 0, -61, 0, 0x0, Bhv_Custom_0x130000c0),
		OBJECT(133, 9626, -2705, 764, 0, -58, 0, 0x0, Bhv_Custom_0x130000c0),
		OBJECT_WITH_ACTS(53, -2627, -1043, -3442, 0, 0, 90, 0x0, Bhv_Custom_0x1300067c, ACT_6),
		OBJECT_WITH_ACTS(56, 1488, -3520, 2010, 0, 0, 0, 0x400000, Bhv_Custom_0x130006f4, ACT_1),
		OBJECT_WITH_ACTS(56, 2688, -3542, 1878, 0, 0, 0, 0x200000, Bhv_Custom_0x130006f4, ACT_1),
		OBJECT_WITH_ACTS(56, 1620, -3542, 3609, 0, 0, 0, 0x100000, Bhv_Custom_0x130006f4, ACT_1),
		OBJECT(213, 3551, -313, -14324, 0, -22, 0, 0x0, Bhv_Custom_0x13000864),
		OBJECT(212, 7578, -484, 3942, 0, 0, 0, 0x0, bhv1Up),
		OBJECT(212, -6232, -2048, 3663, 0, -15, 0, 0x0, bhv1Up),
		OBJECT(212, 6972, -1886, -4339, 0, 0, 0, 0x0, bhv1Up),
		OBJECT(0, 2191, -3780, -633, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, -5624, -3360, -909, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, -4856, -3563, 5030, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 1954, -3410, 7950, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 999, -3300, 7378, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 4339, -3406, 6832, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 5611, -3417, 6821, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 5126, -3316, 7721, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 8826, -2842, 909, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 9785, -2726, 1586, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 9585, -2831, -299, 0, 0, 0, 0x0, bhvBetaChestBottom),
		OBJECT(0, 0, 0, 0, 0, 0, 0, 0x1000000, bhvBetaChestLid),
		OBJECT_WITH_ACTS(195, -2718, -1714, -3478, 0, 0, 0, 0x110000, bhvBobombBuddy, ACT_6),
		OBJECT(195, 4113, -154, -14934, 0, 0, 0, 0x40000, bhvBobombBuddy),
		OBJECT(195, 4202, -154, -14703, 0, 0, 0, 0x40000, bhvBobombBuddy),
		OBJECT(195, 3384, -691, -12114, 0, -30, 0, 0x410000, bhvBobombBuddy),
		OBJECT(129, 3364, 48, -15325, 0, -22, 0, 0x0, bhvBreakableBox),
		OBJECT(129, 3289, -152, -15139, 0, -22, 0, 0x10000, bhvBreakableBox),
		OBJECT(129, 3364, -152, -15325, 0, -22, 0, 0x10000, bhvBreakableBox),
		OBJECT(130, -3120, -1739, -3658, 0, 0, 0, 0x10000, bhvBreakableBox),
		OBJECT(0, 3901, -2751, -1339, 0, -112, 0, 0x0, bhvCoinFormation),
		OBJECT(0, 4802, -3594, 3679, 0, 58, 0, 0x0, bhvCoinFormation),
		OBJECT(0, 0, -2457, 5509, 0, 53, 0, 0x0, bhvCoinFormation),
		OBJECT_WITH_ACTS(0, -300, -819, -5677, 0, 157, 0, 0x0, bhvCoinFormation, ACT_1 | ACT_2 | ACT_3 | ACT_4 | ACT_5),
		OBJECT(0, -6127, -1493, -1900, 0, -31, 0, 0x0, bhvCoinFormation),
		OBJECT(0, 5052, -3271, 7193, 0, 0, 0, 0x20000, bhvCoinFormation),
		OBJECT(0, -6509, -3262, 2603, 0, -36, 0, 0x0, bhvCoinFormation),
		OBJECT(0, 4120, -1241, -6180, 0, -89, 0, 0x0, bhvCoinFormation),
		OBJECT(0, -1342, -2715, 1072, 0, 90, 0, 0x0, bhvCoinFormation),
		OBJECT(0, -5700, -3052, 3347, 0, -33, 0, 0x30000, bhvDeathWarp),
		OBJECT(137, 1892, -447, -6517, 0, 0, 0, 0x60000, bhvExclamationBox),
		OBJECT(137, 6146, -2693, -1128, 0, -24, 0, 0x50000, bhvExclamationBox),
		OBJECT(137, 3249, -2186, -5562, 0, 0, 0, 0x50000, bhvExclamationBox),
		OBJECT(192, 5629, -3027, -908, 0, 0, 0, 0x0, bhvGoomba),
		OBJECT(0, 5581, -2641, -3675, 0, 0, 0, 0x0, bhvGoombaTripletSpawner),
		OBJECT(0, -1265, -2976, 6034, 0, 0, 0, 0x0, bhvGoombaTripletSpawner),
		OBJECT(0, 4725, -2552, -1614, 0, 0, 0, 0x4000000, bhvHiddenRedCoinStar),
		OBJECT(124, -2652, -1128, -3668, 0, 0, 0, 0x200000, bhvMessagePanel),
		OBJECT(58, 3941, -682, -13596, 0, -22, 0, 0x10000, bhvMrIBlueCoin),
		OBJECT(58, 3549, -682, -13752, 0, -22, 0, 0x20000, bhvMrIBlueCoin),
		OBJECT(58, 3151, -682, -13914, 0, -22, 0, 0x40000, bhvMrIBlueCoin),
		OBJECT(58, 2750, -682, -14076, 0, -22, 0, 0x80000, bhvMrIBlueCoin),
		OBJECT(58, 3783, -682, -13196, 0, -22, 0, 0x100000, bhvMrIBlueCoin),
		OBJECT(58, 3384, -682, -13358, 0, -22, 0, 0x200000, bhvMrIBlueCoin),
		OBJECT(58, 2989, -682, -13513, 0, -22, 0, 0x400000, bhvMrIBlueCoin),
		OBJECT(58, 2590, -682, -13678, 0, -22, 0, 0x800000, bhvMrIBlueCoin),
		OBJECT(58, 3620, -682, -12795, 0, -22, 0, 0x1000000, bhvMrIBlueCoin),
		OBJECT(58, 3220, -682, -12957, 0, -22, 0, 0x2000000, bhvMrIBlueCoin),
		OBJECT(58, 2820, -682, -13119, 0, -22, 0, 0x4000000, bhvMrIBlueCoin),
		OBJECT(58, 2427, -682, -13279, 0, -22, 0, 0x8000000, bhvMrIBlueCoin),
		OBJECT(58, 3458, -682, -12395, 0, -22, 0, 0x10000000, bhvMrIBlueCoin),
		OBJECT(58, 3062, -682, -12559, 0, -22, 0, 0x20000000, bhvMrIBlueCoin),
		OBJECT(58, 2663, -682, -12723, 0, -22, 0, 0x40000000, bhvMrIBlueCoin),
		OBJECT(58, 2267, -682, -12880, 0, -22, 0, 0x80000000, bhvMrIBlueCoin),
		OBJECT(116, 6899, -2060, 3363, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(116, 8498, -2158, 3461, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(116, -4498, -3262, 3553, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(116, 528, -3219, -84, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(116, -5575, -3175, 192, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(116, 2563, -2842, -2411, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(116, 6901, -2852, 4819, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(116, 1974, -3245, 6938, 0, 0, 0, 0x0, bhvRedCoin),
		OBJECT(0, -2642, -3225, -334, 0, 0, 0, 0xa0000, bhvSpinAirborneWarp),
		OBJECT(0, -5699, -3263, 3368, 0, 145, 0, 0x220000, bhvSpinAirborneWarp),
		OBJECT(0, 2974, -3342, 6206, 0, -166, 0, 0x230000, bhvSpinAirborneWarp),
		OBJECT(122, 3736, 113, -14818, 0, 0, 0, 0x3000000, bhvStar),
		OBJECT(0, -6398, -3215, 4350, 0, 149, 0, 0x50220000, bhvWarp),
		OBJECT(0, 3157, -3251, 6958, 0, 0, 0, 0x20230000, bhvWarp),
		OBJECT(209, -2652, -1121, -3502, 0, 0, 0, 0x10000, bhvWaterAirBubble),
		OBJECT(55, -3462, -2163, -2578, 0, 0, 0, 0x10000, bhvWfRotatingWoodenPlatform),
		OBJECT(55, -1363, -2591, -2099, 0, 89, 0, 0x20000, bhvWfRotatingWoodenPlatform),
		OBJECT(55, -4051, -2593, -4714, 0, -145, 0, 0x40000, bhvWfRotatingWoodenPlatform),
		OBJECT(55, -1825, -2163, -4304, 0, 141, 0, 0x80000, bhvWfRotatingWoodenPlatform),
		OBJECT(55, -4631, -3031, -1528, 0, -58, 0, 0x100000, bhvWfRotatingWoodenPlatform),
		OBJECT(55, -2670, -1733, -3493, 0, 0, 0, 0x200000, bhvWfRotatingWoodenPlatform),
		OBJECT(116, -3013, -3124, -500, 0, 0, 0, 0x0, bhvYellowCoin),
		OBJECT(116, -2297, -3124, -497, 0, 0, 0, 0x0, bhvYellowCoin),
		OBJECT(116, -5647, -3124, -3813, 0, 0, 0, 0x0, bhvYellowCoin),
		OBJECT(116, -5636, -3124, -3098, 0, 0, 0, 0x0, bhvYellowCoin),
		OBJECT(116, 339, -3124, -3101, 0, 0, 0, 0x0, bhvYellowCoin),
		OBJECT(116, 329, -3124, -3804, 0, 0, 0, 0x0, bhvYellowCoin),
		OBJECT(116, -2299, -3124, -6431, 0, 0, 0, 0x0, bhvYellowCoin),
		OBJECT(116, -3004, -3124, -6426, 0, 0, 0, 0x0, bhvYellowCoin),
		TERRAIN(wf_area_1_collision),
		MACRO_OBJECTS(wf_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, 36),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(1, 0, 0, 0, 0),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};