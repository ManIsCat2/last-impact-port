#include "src/game/envfx_snow.h"

const GeoLayout pss_secret_hidden_geometry_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, pss_secret_hidden_geometry_000_displaylist_mesh_layer_1),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};