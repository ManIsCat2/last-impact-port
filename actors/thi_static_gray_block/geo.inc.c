#include "src/game/envfx_snow.h"

const GeoLayout thi_static_gray_block_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(500),
		GEO_OPEN_NODE(),
			GEO_SHADOW(0, 180, 70),
			GEO_OPEN_NODE(),
				GEO_DISPLAY_LIST(LAYER_OPAQUE, thi_static_gray_block_000_displaylist_mesh_layer_1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};