#include "src/game/envfx_snow.h"

const GeoLayout cloud2_aircruise_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, -896, cloud2_aircruise_000_offset_mesh_layer_1),
			GEO_ANIMATED_PART(LAYER_ALPHA, -272, 20, -336, cloud2_aircruise_001_offset_mesh_layer_4),
			GEO_ANIMATED_PART(LAYER_ALPHA, -272, 20, -1168, cloud2_aircruise_002_offset_mesh_layer_4),
			GEO_ANIMATED_PART(LAYER_ALPHA, 272, 20, -336, cloud2_aircruise_003_offset_mesh_layer_4),
			GEO_ANIMATED_PART(LAYER_ALPHA, 272, 20, -1168, cloud2_aircruise_004_offset_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
