#include "src/game/envfx_snow.h"

const GeoLayout ice_flower_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_SHADOW(99, 255, 130),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, 0, ice_flower_Bone_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
