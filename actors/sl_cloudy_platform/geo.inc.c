#include "src/game/envfx_snow.h"

const GeoLayout sl_cloudy_platform_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, sl_cloudy_platform_000_displaylist_mesh_layer_1),
			GEO_DISPLAY_LIST(LAYER_TRANSPARENT, sl_cloudy_platform_000_displaylist_mesh_layer_5),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, sl_cloudy_platform_material_revert_render_settings),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, sl_cloudy_platform_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};