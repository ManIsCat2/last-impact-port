#include "src/game/envfx_snow.h"

const GeoLayout brown_hand_enemy_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 160),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, brown_hand_enemy_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 15, 45, brown_hand_enemy_000_offset_001_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -30, 15, 42, brown_hand_enemy_001_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 20, 15, 42, brown_hand_enemy_002_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 45, 15, 30, brown_hand_enemy_003_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -62, 15, 12, brown_hand_enemy_004_offset_mesh_layer_1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
