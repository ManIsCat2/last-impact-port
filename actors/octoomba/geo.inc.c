#include "src/game/envfx_snow.h"

const GeoLayout octoomba_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(0, 155, 96),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 24, 0, octoomba_000_offset_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_DISPLAY_LIST(LAYER_ALPHA, octoomba_000_offset_mesh_layer_4),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 32, 0, 0, octoomba_000_offset_001_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -32, 0, 0, octoomba_001_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 106, 0, octoomba_002_offset_mesh_layer_1),
				GEO_OPEN_NODE(),
					GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 14, 0, octoomba_000_offset_002_mesh_layer_1),
					GEO_OPEN_NODE(),
						GEO_DISPLAY_LIST(LAYER_OPAQUE, octoomba_000_displaylist_mesh_layer_1),
					GEO_CLOSE_NODE(),
				GEO_CLOSE_NODE(),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
