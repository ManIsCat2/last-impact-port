#include "src/game/envfx_snow.h"

const GeoLayout rainbow_snake_block_000_switch_opt1[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, rainbow_snake_block_000_displaylist_mesh_layer_1_mat_override_Material_2_f3d_001_0),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout rainbow_snake_block_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_SWITCH_CASE(4, geo_switch_anim_state),
			GEO_OPEN_NODE(),
				GEO_NODE_START(),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, rainbow_snake_block_000_displaylist_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_BRANCH(1, rainbow_snake_block_000_switch_opt1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, rainbow_snake_block_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
