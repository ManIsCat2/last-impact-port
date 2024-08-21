#include "src/game/envfx_snow.h"

const GeoLayout pianta_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 155),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 64, 0, pianta_000_offset_mesh_layer_4),
			GEO_OPEN_NODE(),
				GEO_DISPLAY_LIST(LAYER_OPAQUE, pianta_000_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_ALPHA, 0, 97, 0, pianta_000_offset_001_mesh_layer_4),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 30, 62, 0, pianta_001_offset_mesh_layer_1),
				GEO_OPEN_NODE(),
					GEO_ANIMATED_PART(LAYER_OPAQUE, 56, 1, 0, pianta_000_offset_002_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -31, 62, 0, pianta_003_offset_mesh_layer_1),
				GEO_OPEN_NODE(),
					GEO_ANIMATED_PART(LAYER_OPAQUE, 56, 1, 0, pianta_000_offset_003_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_ANIMATED_PART(LAYER_ALPHA, 0, 19, 0, pianta_005_offset_mesh_layer_4),
				GEO_OPEN_NODE(),
					GEO_ANIMATED_PART(LAYER_OPAQUE, 25, -5, 0, pianta_000_offset_004_mesh_layer_1),
					GEO_OPEN_NODE(),
						GEO_ANIMATED_PART(LAYER_OPAQUE, 0, -30, 0, pianta_000_offset_005_mesh_layer_1),
					GEO_CLOSE_NODE(),
					GEO_ANIMATED_PART(LAYER_OPAQUE, -25, -5, 0, pianta_002_offset_mesh_layer_1),
					GEO_OPEN_NODE(),
						GEO_ANIMATED_PART(LAYER_OPAQUE, 0, -30, 0, pianta_000_offset_006_mesh_layer_1),
					GEO_CLOSE_NODE(),
				GEO_CLOSE_NODE(),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};