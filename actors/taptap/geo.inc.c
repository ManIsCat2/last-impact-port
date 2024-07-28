#include "src/game/envfx_snow.h"

const GeoLayout taptap_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 80),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, taptap_000_offset_mesh_layer_1),
			GEO_ANIMATED_PART(LAYER_OPAQUE, -16, 0, 0, taptap_001_offset_mesh_layer_1),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 16, 0, 0, taptap_002_offset_mesh_layer_1),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
