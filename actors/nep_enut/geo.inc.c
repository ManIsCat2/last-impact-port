#include "src/game/envfx_snow.h"

const GeoLayout nep_enut_000_switch_opt1[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, nep_enut_000_displaylist_mesh_layer_1_mat_override_Material_0_f3d_0),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout nep_enut_000_switch_opt2[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, nep_enut_000_displaylist_mesh_layer_1_mat_override_Fast3D_Material_003_1),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout nep_enut_002_switch_opt1[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, nep_enut_000_displaylist_001_mesh_layer_1_mat_override_Material_0_f3d_0),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout nep_enut_002_switch_opt2[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, nep_enut_000_displaylist_001_mesh_layer_1_mat_override_Fast3D_Material_003_1),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout nep_enut_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, NULL),
			GEO_OPEN_NODE(),
				GEO_SWITCH_CASE(3, geo_switch_anim_state),
				GEO_OPEN_NODE(),
					GEO_NODE_START(),
					GEO_OPEN_NODE(),
						GEO_DISPLAY_LIST(LAYER_OPAQUE, nep_enut_000_displaylist_mesh_layer_1),
					GEO_CLOSE_NODE(),
					GEO_BRANCH(1, nep_enut_000_switch_opt1),
					GEO_BRANCH(1, nep_enut_000_switch_opt2),
				GEO_CLOSE_NODE(),
			GEO_CLOSE_NODE(),
			GEO_SWITCH_CASE(3, geo_switch_anim_state),
			GEO_OPEN_NODE(),
				GEO_NODE_START(),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, nep_enut_000_displaylist_001_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_BRANCH(1, nep_enut_002_switch_opt1),
				GEO_BRANCH(1, nep_enut_002_switch_opt2),
			GEO_CLOSE_NODE(),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 2045, 0, nep_enut_004_offset_mesh_layer_4),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 2045, 0, nep_enut_005_offset_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
