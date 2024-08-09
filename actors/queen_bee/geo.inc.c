#include "src/game/envfx_snow.h"

const GeoLayout queen_bee_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 512),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, queen_bee_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_ANIMATED_PART(LAYER_ALPHA, 0, 99, -36, queen_bee_000_offset_001_mesh_layer_4),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, queen_bee_000_offset_001_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 80, 0, 105, queen_bee_001_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -80, 0, 105, queen_bee_002_offset_mesh_layer_1),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, queen_bee_material_revert_render_settings),
		GEO_DISPLAY_LIST(LAYER_ALPHA, queen_bee_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};