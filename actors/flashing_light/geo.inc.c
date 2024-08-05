#include "src/game/envfx_snow.h"

const GeoLayout flashing_light_001_switch_opt1[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, flashing_light_000_displaylist_001_mesh_layer_1_mat_override_f3dlite_material_002_0),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout flashing_light_001_switch_opt2[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, flashing_light_000_displaylist_001_mesh_layer_1_mat_override_f3dlite_material_003_1),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout flashing_light_001_switch_opt3[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, flashing_light_000_displaylist_001_mesh_layer_1_mat_override_f3dlite_material_004_2),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout flashing_light_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 144),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, flashing_light_000_displaylist_mesh_layer_1),
			GEO_SWITCH_CASE(4, geo_switch_anim_state),
			GEO_OPEN_NODE(),
				GEO_NODE_START(),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, flashing_light_000_displaylist_001_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_BRANCH(1, flashing_light_001_switch_opt1),
				GEO_BRANCH(1, flashing_light_001_switch_opt2),
				GEO_BRANCH(1, flashing_light_001_switch_opt3),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, flashing_light_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
