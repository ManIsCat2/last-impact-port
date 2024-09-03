#include "src/game/envfx_snow.h"

const GeoLayout rashay_elevator_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, rashay_elevator_000_displaylist_mesh_layer_1),
			GEO_DISPLAY_LIST(LAYER_TRANSPARENT, rashay_elevator_000_displaylist_mesh_layer_5),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
