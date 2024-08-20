#include "src/game/envfx_snow.h"

const GeoLayout goomba_bros_triangle_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_SWITCH_CASE(5, geo_switch_anim_state),
			GEO_OPEN_NODE(),
				GEO_NODE_START(),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, goomba_bros_triangle_000_displaylist_mesh_layer_1),
				GEO_CLOSE_NODE(),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, goomba_bros_triangle_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};