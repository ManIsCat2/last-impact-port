#include "src/game/envfx_snow.h"

const GeoLayout luna_park_entrance_part1_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, luna_park_entrance_part1_000_displaylist_mesh_layer_1),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, -480, luna_park_entrance_part1_000_offset_mesh_layer_4),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, -970, luna_park_entrance_part1_001_offset_mesh_layer_4),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, -1460, luna_park_entrance_part1_002_offset_mesh_layer_4),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, -1950, luna_park_entrance_part1_003_offset_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
