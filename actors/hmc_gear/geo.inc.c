#include "src/game/envfx_snow.h"

const GeoLayout hmc_gear_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, hmc_gear_sm64_mesh_mesh_layer_1),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, hmc_gear_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
