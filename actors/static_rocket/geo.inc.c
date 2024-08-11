#include "src/game/envfx_snow.h"

const GeoLayout static_rocket_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(32767),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, static_rocket_000_displaylist_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, static_rocket_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
