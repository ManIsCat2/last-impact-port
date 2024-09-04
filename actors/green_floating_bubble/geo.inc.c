#include "src/game/envfx_snow.h"

const GeoLayout green_floating_bubble_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 411),
		GEO_OPEN_NODE(),
			GEO_CULLING_RADIUS(4000),
			GEO_OPEN_NODE(),
				GEO_DISPLAY_LIST(LAYER_TRANSPARENT, green_floating_bubble_000_displaylist_mesh_layer_5),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
