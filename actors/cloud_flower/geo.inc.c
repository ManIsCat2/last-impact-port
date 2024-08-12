#include "src/game/envfx_snow.h"

const GeoLayout cloud_flower_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 96),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, cloud_flower_000_displaylist_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, cloud_flower_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
