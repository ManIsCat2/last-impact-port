#include "src/game/envfx_snow.h"

const GeoLayout star_hexagon_000_switch_opt1[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, star_hexagon_000_displaylist_mesh_layer_1_mat_override_Fast3D_Material_0),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout star_hexagon_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_SWITCH_CASE(2, geo_switch_anim_state),
			GEO_OPEN_NODE(),
				GEO_NODE_START(),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, star_hexagon_000_displaylist_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_BRANCH(1, star_hexagon_000_switch_opt1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
