#include "src/game/envfx_snow.h"

const GeoLayout fludd_blackspot_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(32767),
		GEO_OPEN_NODE(),
			GEO_ASM(0, geo_update_layer_transparency),
			GEO_DISPLAY_LIST(LAYER_TRANSPARENT, fludd_blackspot_000_displaylist_mesh_layer_5),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
