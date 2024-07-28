#include "src/game/envfx_snow.h"

const GeoLayout bob_prison_gate_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_ALPHA, bob_prison_gate_000_displaylist_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
