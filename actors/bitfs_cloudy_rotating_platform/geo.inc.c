#include "src/game/envfx_snow.h"

const GeoLayout bitfs_cloudy_rotating_platform_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, bitfs_cloudy_rotating_platform_000_displaylist_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, bitfs_cloudy_rotating_platform_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};