#include "src/game/envfx_snow.h"

const GeoLayout blue_nabbit_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 80, 155),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 20, 0, blue_nabbit_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 45, 0, blue_nabbit_000_offset_001_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 20, 35, 0, blue_nabbit_001_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -20, 35, 0, blue_nabbit_002_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 18, 20, 0, blue_nabbit_003_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -18, 20, 0, blue_nabbit_004_offset_mesh_layer_1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
