Lights1 totwc_entry_light_f3dlite_material_lights = gdSPDefLights1(
	0x7F, 0x7D, 0x57,
	0xFF, 0xFA, 0xB3, 0x49, 0x49, 0x49);

Gfx totwc_entry_light__0_i8_aligner[] = {gsSPEndDisplayList()};
u8 totwc_entry_light__0_i8[] = {
	0xff, 
};

Vtx totwc_entry_light_000_displaylist_mesh_layer_5_vtx_0[24] = {
	{{ {149, 0, -82}, 0, {141, -28}, {113, 2, 198, 255} }},
	{{ {0, 9690, 0}, 0, {-16, -261}, {255, 127, 0, 255} }},
	{{ {164, 0, 31}, 0, {-149, -28}, {124, 2, 27, 255} }},
	{{ {0, 9690, 0}, 0, {-16, -261}, {255, 127, 0, 255} }},
	{{ {149, 0, -82}, 0, {-153, -28}, {113, 2, 198, 255} }},
	{{ {65, 0, -160}, 0, {136, -28}, {49, 2, 139, 255} }},
	{{ {0, 9690, 0}, 0, {-16, -260}, {255, 127, 0, 255} }},
	{{ {102, 0, 128}, 0, {-150, -27}, {77, 2, 101, 255} }},
	{{ {164, 0, 31}, 0, {139, -27}, {124, 2, 27, 255} }},
	{{ {0, 9690, 0}, 0, {-16, -261}, {255, 127, 0, 255} }},
	{{ {65, 0, -160}, 0, {-161, -28}, {49, 2, 139, 255} }},
	{{ {-49, 0, -165}, 0, {128, -28}, {218, 2, 135, 255} }},
	{{ {-49, 0, -165}, 0, {-169, -28}, {218, 2, 135, 255} }},
	{{ {-141, 0, -95}, 0, {120, -28}, {149, 2, 187, 255} }},
	{{ {-141, 0, -95}, 0, {-174, -28}, {149, 2, 187, 255} }},
	{{ {-166, 0, 16}, 0, {116, -28}, {130, 2, 16, 255} }},
	{{ {0, 9690, 0}, 0, {-16, -260}, {255, 127, 0, 255} }},
	{{ {-166, 0, 16}, 0, {-172, -27}, {130, 2, 16, 255} }},
	{{ {-113, 0, 118}, 0, {117, -27}, {170, 2, 94, 255} }},
	{{ {0, 9690, 0}, 0, {-16, -260}, {255, 127, 0, 255} }},
	{{ {-113, 0, 118}, 0, {-166, -27}, {170, 2, 94, 255} }},
	{{ {-7, 0, 162}, 0, {124, -27}, {250, 2, 127, 255} }},
	{{ {-7, 0, 162}, 0, {-157, -27}, {250, 2, 127, 255} }},
	{{ {102, 0, 128}, 0, {133, -27}, {77, 2, 101, 255} }},
};

Gfx totwc_entry_light_000_displaylist_mesh_layer_5_tri_0[] = {
	gsSPVertex(totwc_entry_light_000_displaylist_mesh_layer_5_vtx_0 + 0, 16, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(3, 4, 5, 0),
	gsSP1Triangle(6, 7, 8, 0),
	gsSP1Triangle(9, 10, 11, 0),
	gsSP1Triangle(3, 12, 13, 0),
	gsSP1Triangle(14, 15, 1, 0),
	gsSPVertex(totwc_entry_light_000_displaylist_mesh_layer_5_vtx_0 + 16, 8, 0),
	gsSP1Triangle(0, 1, 2, 0),
	gsSP1Triangle(3, 4, 5, 0),
	gsSP1Triangle(3, 6, 7, 0),
	gsSPEndDisplayList(),
};


Gfx mat_totwc_entry_light_f3dlite_material[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsSPSetLights1(totwc_entry_light_f3dlite_material_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, TEXEL0, 0, PRIMITIVE, 0, TEXEL0, 0, SHADE, 0, TEXEL0, 0, PRIMITIVE, 0),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetPrimColor(0, 0, 255, 255, 255, 73),
	gsDPSetTextureImage(G_IM_FMT_I, G_IM_SIZ_8b, 1, totwc_entry_light__0_i8),
	gsDPSetTile(G_IM_FMT_I, G_IM_SIZ_8b, 1, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTile(7, 0, 0, 0, 0),
	gsDPSetTile(G_IM_FMT_I, G_IM_SIZ_8b, 1, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPSetTileSize(0, 0, 0, 0, 0),
	gsSPEndDisplayList(),
};

Gfx mat_revert_totwc_entry_light_f3dlite_material[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsSPEndDisplayList(),
};

Gfx totwc_entry_light_000_displaylist_mesh_layer_5[] = {
	gsSPDisplayList(mat_totwc_entry_light_f3dlite_material),
	gsSPDisplayList(totwc_entry_light_000_displaylist_mesh_layer_5_tri_0),
	gsSPDisplayList(mat_revert_totwc_entry_light_f3dlite_material),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

