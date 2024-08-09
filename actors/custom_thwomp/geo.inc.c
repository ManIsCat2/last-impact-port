#include "src/game/envfx_snow.h"

const GeoLayout custom_thwomp_001_switch_opt1[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, custom_thwomp_000_displaylist_001_mesh_layer_1_mat_override_Material_4_f3d_001_0),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout custom_thwomp_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, custom_thwomp_000_displaylist_mesh_layer_1),
			GEO_SWITCH_CASE(2, geo_switch_anim_state),
			GEO_OPEN_NODE(),
				GEO_NODE_START(),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, custom_thwomp_000_displaylist_001_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_BRANCH(1, custom_thwomp_001_switch_opt1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, custom_thwomp_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};