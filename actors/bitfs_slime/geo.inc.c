#include "src/game/envfx_snow.h"

const GeoLayout bitfs_slime_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_TRANSPARENT, bitfs_slime_000_displaylist_mesh_layer_5),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, bitfs_slime_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
