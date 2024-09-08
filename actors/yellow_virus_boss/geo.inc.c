#include "src/game/envfx_snow.h"

const GeoLayout yellow_virus_boss_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 96),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 112, 0, yellow_virus_boss_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 40, 0, 0, yellow_virus_boss_000_offset_001_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -40, 0, 0, yellow_virus_boss_001_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, yellow_virus_boss_002_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, yellow_virus_boss_003_offset_mesh_layer_1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
