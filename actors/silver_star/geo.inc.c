#include "src/game/envfx_snow.h"

const GeoLayout silver_star_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 80),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, silver_star_000_displaylist_mesh_layer_1),
			GEO_DISPLAY_LIST(LAYER_ALPHA, silver_star_000_displaylist_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
