#include "src/game/envfx_snow.h"

const GeoLayout bee_npc_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 96),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, bee_npc_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 30, 0, bee_npc_000_offset_001_mesh_layer_1),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_ALPHA, bee_npc_000_offset_001_mesh_layer_4),
				GEO_CLOSE_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 25, 8, 5, bee_npc_001_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -25, 8, 5, bee_npc_002_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 19, -13, 7, bee_npc_003_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -19, -13, 7, bee_npc_004_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_ALPHA, 23, 23, -20, bee_npc_005_offset_mesh_layer_4),
				GEO_ANIMATED_PART(LAYER_ALPHA, -23, 23, -20, bee_npc_006_offset_mesh_layer_4),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
