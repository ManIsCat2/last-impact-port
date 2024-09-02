#include "src/game/envfx_snow.h"

const GeoLayout vcutm_fish_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_CULLING_RADIUS(10288),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, 0, vcutm_fish_000_offset_mesh_layer_4),
			GEO_OPEN_NODE(),
				GEO_DISPLAY_LIST(LAYER_OPAQUE, vcutm_fish_000_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_ALPHA, 0, -250, 0, vcutm_fish_000_offset_001_mesh_layer_4),
				GEO_ANIMATED_PART(LAYER_ALPHA, 0, 250, 0, vcutm_fish_001_offset_mesh_layer_4),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 100, -218, 0, vcutm_fish_002_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 100, -218, 0, vcutm_fish_003_offset_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_ALPHA, -220, 0, 0, vcutm_fish_004_offset_mesh_layer_4),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
