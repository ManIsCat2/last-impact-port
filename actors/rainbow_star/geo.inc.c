#include "src/game/envfx_snow.h"

const GeoLayout rainbow_star_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 64),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, rainbow_star_000_displaylist_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, rainbow_star_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
