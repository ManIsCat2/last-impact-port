#include "src/game/envfx_snow.h"

const GeoLayout fludd_box_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SCALE(LAYER_FORCE, 65536),
		GEO_OPEN_NODE(),
			GEO_SHADOW(0, 192, 256),
			GEO_OPEN_NODE(),
				GEO_DISPLAY_LIST(LAYER_OPAQUE, fludd_box_000_displaylist_mesh_layer_1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
