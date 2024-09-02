#include "src/game/envfx_snow.h"

const GeoLayout bitdw_gate_to_star_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, bitdw_gate_to_star_000_displaylist_mesh_layer_1),
			GEO_DISPLAY_LIST(LAYER_ALPHA, bitdw_gate_to_star_000_displaylist_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
