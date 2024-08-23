#include "src/game/envfx_snow.h"

const GeoLayout blooper_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 64),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, blooper_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 15, 0, 0, blooper_000_offset_001_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -15, 0, 0, blooper_001_offset_mesh_layer_1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
