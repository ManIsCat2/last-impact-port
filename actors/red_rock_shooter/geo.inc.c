#include "src/game/envfx_snow.h"

const GeoLayout red_rock_shooter_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(4000),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, red_rock_shooter_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -112, 0, 0, red_rock_shooter_000_offset_001_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 112, 0, red_rock_shooter_001_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, -112, 0, red_rock_shooter_002_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 112, 0, 0, red_rock_shooter_003_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 17, -576, red_rock_shooter_004_offset_mesh_layer_1),
				GEO_OPEN_NODE(),
					GEO_ANIMATED_PART(LAYER_OPAQUE, 0, -4, -488, red_rock_shooter_000_offset_002_mesh_layer_1),
				GEO_CLOSE_NODE(),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, red_rock_shooter_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
