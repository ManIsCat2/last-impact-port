static const s16 blooper_anim_blooper_idle_values[] = {
	0x0000, 0x0000, 0x0000, 0x0001, 0x0002, 0x0003, 0x0003, 0x0004, 0x0005, 
	0x0006, 0x0006, 0x0007, 0x0007, 0x0007, 0x0007, 0x0006, 0x0005, 0x0005, 
	0x0004, 0x0003, 0x0002, 0x0001, 0x0001, 0x0000, 0x0000, 0xFFFF, 0xFFFF, 
	0xFFFE, 0xFFFD, 0xFFFC, 0xFFFC, 0xFFFB, 0xFFFA, 0xFFFA, 0xFFFA, 0xFFFA, 
	0xFFFB, 0xFFFB, 0xFFFC, 0xFFFC, 0xFFFD, 0xFFFD, 0xFFFE, 0xFFFE, 0xFFFF, 
	0xFFFF, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 
	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xFFFD, 
	0xFFF3, 0xFFDF, 0xFFCA, 0xFFB6, 0xFFA1, 0xFF8C, 0xFF78, 0xFF63, 0xFF4F, 
	0xFF3A, 0xFF38, 0xFF23, 0xFF0E, 0xFEFA, 0xFEE6, 0xFED2, 0xFEBE, 0xFEAB, 
	0xFE9A, 0xFE90, 0xFE95, 0xFEA8, 0xFEC5, 0xFEE3, 0xFF01, 0xFF1F, 0xFF3D, 
	0xFF48, 0xFF66, 0xFF84, 0xFFA1, 0xFFBE, 0xFFD9, 0xFFF2, 0x0000, 0x0000, 
	0xFFB1, 0xFEA4, 0xFD41, 0xFBD6, 0xFA6C, 0xF902, 0xF79B, 0xF638, 0xF4DC, 
	0xF38E, 0xF269, 0xF1C4, 0xF1EC, 0xF2B5, 0xF45B, 0xF5FA, 0xF7AC, 0xF95D, 
	0xFAFD, 0xFCAE, 0xFE5F, 0x0010, 0x01C0, 0x0370, 0x050C, 0x06BA, 0x0867, 
	0x09FE, 0x0BA3, 0x0D40, 0x0ECB, 0x1029, 0x10EC, 0x10B0, 0x0FE1, 0x0E9D, 
	0x0D50, 0x0C02, 0x0AB5, 0x0957, 0x080B, 0x06C1, 0x0579, 0x0435, 0x02E4, 
	0x01B4, 0x00A8, 0xFFFF, 0xFFFF, 0x0000, 0x0000, 0xFFFF, 0xFFFF, 0x0000, 
	0x0000, 0x0000, 0xFFFF, 0xFFFF, 0xFFFF, 0x0000, 0xFFFF, 0x0000, 0x0000, 
	0xFFFF, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 
	0x0000, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
	0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x0000, 0xFFFF, 
	0x0000, 0xFFFF, 0x0000, 0x7FF8, 0x0054, 0x0173, 0x02DE, 0x0463, 0x05E7, 
	0x076B, 0x08EC, 0x0A69, 0x0BDE, 0x0D44, 0x0E7F, 0x0F30, 0x0F07, 0x0E7F, 
	0x0D5F, 0x0C26, 0x0AFF, 0x09D8, 0x089E, 0x0777, 0x0650, 0x0517, 0x03F1, 
	0x02CB, 0x0193, 0x006F, 0xFF39, 0xFE05, 0xFCE7, 0xFBBC, 0xFAB0, 0xF9B2, 
	0xF92D, 0xF946, 0xF98E, 0xFA1F, 0xFAA1, 0xFB24, 0xFBB8, 0xFC3A, 0xFCBC, 
	0xFD3D, 0xFDCF, 0xFE4E, 0xFECB, 0xFF41, 0xFFBC, 
};

static const u16 blooper_anim_blooper_idle_indices[] = {
	0x0001, 0x0000, 0x002E, 0x0001, 0x0001, 0x002F, 0x0001, 0x0030, 0x0001, 
	0x0031, 0x002F, 0x0032, 0x0001, 0x0061, 0x0001, 0x0062, 0x002F, 0x0063, 
	0x002E, 0x0092, 0x0001, 0x00C0, 0x002F, 0x00C1, 
};

static const struct Animation blooper_anim_blooper_idle = {
	0,
	0,
	0,
	1,
	47,
	ANIMINDEX_NUMPARTS(blooper_anim_blooper_idle_indices),
	blooper_anim_blooper_idle_values,
	blooper_anim_blooper_idle_indices,
	0,
};

