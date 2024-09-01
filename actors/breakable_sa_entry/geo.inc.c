#include "src/game/envfx_snow.h"

const GeoLayout breakable_sa_entry_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, breakable_sa_entry_node_mesh_layer_1),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
