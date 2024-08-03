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
	LOAD_MODEL_FROM_GEO(MODEL_BITS_WARP_PIPE, warp_pipe_geo),

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, castle_grounds_area_1),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0B, LEVEL_WF, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0C, LEVEL_JRB, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x0D, LEVEL_CCM, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x0E, LEVEL_BBH, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE_GROUNDS, 0x01,0xF0 , WARP_NO_CHECKPOINT), /*Success Warp Node*/
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01,0xF1 , WARP_NO_CHECKPOINT), /*Failure Warp Node*/
		WARP_NODE(0x0F, LEVEL_ENDING, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x10, LEVEL_ENDING, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x11, LEVEL_ENDING, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x12, LEVEL_ENDING, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x13, LEVEL_ENDING, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x04, LEVEL_ENDING, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x15, LEVEL_WMOTR, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(0x16, LEVEL_TOTWC, 0x01,0x0A , WARP_NO_CHECKPOINT),
		WARP_NODE(64, 26, 1, 253, 0),
		OBJECT(MODEL_NONE, 1039, -100, 608, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		OBJECT(MODEL_BITS_WARP_PIPE, 303,9,-9068,0,0,0,(64 << 16), bhvWarpPipe),
		OBJECT(MODEL_NONE ,-4398,-788,747,0,0,0,0x500A0000, bhvWarp),
		OBJECT(MODEL_BITS_WARP_PIPE, ,4117,-427,-7098,0,0,0,0x000B0000, bhvWarpPipe),
		OBJECT(E_MODEL_YOSHI,352,-340,236,0,0,0, (50 << 16), bhvYoshi),
		OBJECT(E_MODEL_PEACH,643,-340,196,0,0,0, (16 << 16), bhvPeach),
		OBJECT(E_MODEL_GOOMBA,2110,-679,-4914,0,0,0,0x00000000, bhvBossGoombaOne),
		OBJECT(E_MODEL_GOOMBA,2131,-668,-4545,0,0,0,0x00000000, bhvBossGoombaTwo),
		OBJECT(E_MODEL_GOOMBA,1920,-666,-4707,0,0,0,0x00000000, bhvBossGoombaThree),
		OBJECT(E_MODEL_BREAKABLE_BOX_SMALL,-2333,-641,-7127,0,0,0,0x00000000, id_bhvBreakableBoxSmall),
		MARIO_POS(0x01, 0, 1039, 41, 608),
		TERRAIN(castle_grounds_area_1_collision),
		MACRO_OBJECTS(castle_grounds_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_SOUND_PLAYER),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, 1039, 41, 608),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
