#include "src/game/envfx_snow.h"

const GeoLayout quicksand_shadow_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, quicksand_shadow_sm64_mesh_mesh_layer_4),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
