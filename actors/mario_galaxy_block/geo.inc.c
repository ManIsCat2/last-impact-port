#include "src/game/envfx_snow.h"

const GeoLayout mario_galaxy_block_000_switch_opt1[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, mario_galaxy_block_000_displaylist_mesh_layer_1_mat_override_f3dlite_material_0),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout mario_galaxy_block_000_switch_opt2[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, mario_galaxy_block_000_displaylist_mesh_layer_1_mat_override_f3dlite_material_001_1),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout mario_galaxy_block_000_switch_opt3[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, mario_galaxy_block_000_displaylist_mesh_layer_1_mat_override_f3dlite_material_002_2),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout mario_galaxy_block_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_SWITCH_CASE(4, geo_switch_anim_state),
			GEO_OPEN_NODE(),
				GEO_NODE_START(),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, mario_galaxy_block_000_displaylist_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_BRANCH(1, mario_galaxy_block_000_switch_opt1),
				GEO_BRANCH(1, mario_galaxy_block_000_switch_opt2),
				GEO_BRANCH(1, mario_galaxy_block_000_switch_opt3),
			GEO_CLOSE_NODE(),
			GEO_DISPLAY_LIST(LAYER_ALPHA, mario_galaxy_block_002_displaylist_mesh_layer_4),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, mario_galaxy_block_material_revert_render_settings),
		GEO_DISPLAY_LIST(LAYER_ALPHA, mario_galaxy_block_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
