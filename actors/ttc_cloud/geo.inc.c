#include "src/game/envfx_snow.h"

const GeoLayout ttc_cloud_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, ttc_cloud_000_displaylist_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, ttc_cloud_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
