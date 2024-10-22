#include "custom.model.inc.h"
const GeoLayout Geo_bbh_1_0x1201700[]= {
GEO_NODE_SCREEN_AREA(10,160,120,160,120),
GEO_OPEN_NODE(),
GEO_ZBUFFER(0),
GEO_OPEN_NODE(),
GEO_NODE_ORTHO(100),
GEO_OPEN_NODE(),
GEO_BACKGROUND(SkyboxCustom19949824_skybox_ptrlist, geo_skybox_main),
GEO_CLOSE_NODE(),
GEO_CLOSE_NODE(),
GEO_ZBUFFER(1),
GEO_OPEN_NODE(),
GEO_CAMERA_FRUSTUM_WITH_FUNC(45,100,38550, geo_camera_fov),
GEO_OPEN_NODE(),
GEO_CAMERA(1,0,2000,6000,3072,0,60928, geo_camera_main),
GEO_OPEN_NODE(),
GEO_DISPLAY_LIST(1,DL_bbh_1_0xe0a9580),
GEO_DISPLAY_LIST(4,DL_bbh_1_0xe0f5c78),
GEO_DISPLAY_LIST(5,DL_bbh_1_0x7001620),
GEO_DISPLAY_LIST(2,DL_bbh_1_0x7002440),
GEO_DISPLAY_LIST(2,DL_bbh_1_0x7003410),
GEO_DISPLAY_LIST(2,DL_bbh_1_0x7003b80),
GEO_DISPLAY_LIST(2,DL_bbh_1_0x7002760),
GEO_RENDER_OBJ(),
GEO_ASM(0, geo_envfx_main),
GEO_CLOSE_NODE(),
GEO_CLOSE_NODE(),
GEO_CLOSE_NODE(),
GEO_ZBUFFER(0),
GEO_OPEN_NODE(),
GEO_ASM(0, geo_cannon_circle_base),
GEO_CLOSE_NODE(),
GEO_CLOSE_NODE(),
GEO_END(),
};
