#include "src/game/envfx_snow.h"

const GeoLayout bowser_door_key_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_ANIMATED_PART(LAYER_ALPHA, 0, 0, 0, bowser_door_key_displaylist_000_mesh_layer_4),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_OPAQUE, bowser_door_key_displaylist_000_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, bowser_door_key_material_revert_render_settings),
		GEO_DISPLAY_LIST(LAYER_ALPHA, bowser_door_key_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
