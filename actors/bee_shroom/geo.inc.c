#include "src/game/envfx_snow.h"

const GeoLayout bee_shroom_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(1, 180, 100),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, bee_shroom_Bee_Shroom_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, bee_shroom_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
