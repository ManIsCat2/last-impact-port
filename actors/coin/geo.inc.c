#include "src/game/envfx_snow.h"

const GeoLayout yellow_coin_geo[] = {
GEO_NODE_START(),
GEO_OPEN_NODE(),
GEO_SHADOW(0, 180, 50),
GEO_ASM(0, geo_rotate_coin),
GEO_ROTATION_NODE(0, 0, 0, 0)
GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, 0, yellow_coin_000_offset_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};

const GeoLayout yellow_coin_no_shadow_geo[] = {
GEO_NODE_START(),
GEO_OPEN_NODE(),
GEO_ASM(0, geo_rotate_coin),
GEO_ROTATION_NODE(0, 0, 0, 0)
GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, 0, yellow_coin_000_offset_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};

const GeoLayout red_coin_geo[] = {
GEO_NODE_START(),
GEO_OPEN_NODE(),
GEO_SHADOW(0, 180, 50),
GEO_ASM(0, geo_rotate_coin),
GEO_ROTATION_NODE(0, 0, 0, 0)
GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, red_coin_skinned_001_mesh_layer_4),
	GEO_CLOSE_NODE(),
	GEO_END(),
};

const GeoLayout red_coin_no_shadow_geo[] = {
GEO_NODE_START(),
GEO_OPEN_NODE(),
GEO_ASM(0, geo_rotate_coin),
GEO_ROTATION_NODE(0, 0, 0, 0)
GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, red_coin_skinned_001_mesh_layer_4),
	GEO_CLOSE_NODE(),
	GEO_END(),
};

const GeoLayout blue_coin_geo[] = {
GEO_NODE_START(),
GEO_OPEN_NODE(),
GEO_SHADOW(0, 180, 50),
GEO_ASM(0, geo_rotate_coin),
GEO_ROTATION_NODE(0, 0, 0, 0)
GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, blue_coin_skinned_002_mesh_layer_4),
	GEO_CLOSE_NODE(),
	GEO_END(),
};

const GeoLayout blue_coin_no_shadow_geo[] = {
GEO_NODE_START(),
GEO_OPEN_NODE(),
GEO_ASM(0, geo_rotate_coin),
GEO_ROTATION_NODE(0, 0, 0, 0)
GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, blue_coin_skinned_002_mesh_layer_4),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
