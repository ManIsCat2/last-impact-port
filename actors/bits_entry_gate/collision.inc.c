const Collision bits_entry_gate_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(12),
	COL_VERTEX(-228, 374, -25),
	COL_VERTEX(-228, -9, 25),
	COL_VERTEX(-228, 374, 25),
	COL_VERTEX(-228, -9, -25),
	COL_VERTEX(0, 374, -25),
	COL_VERTEX(0, -9, -25),
	COL_VERTEX(50, 374, -12),
	COL_VERTEX(50, -9, -12),
	COL_VERTEX(0, 374, 25),
	COL_VERTEX(0, -9, 25),
	COL_VERTEX(50, 374, 12),
	COL_VERTEX(50, -9, 12),
	COL_TRI_INIT(SURFACE_DEFAULT, 14),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(4, 3, 0),
	COL_TRI(3, 4, 5),
	COL_TRI(6, 5, 4),
	COL_TRI(5, 6, 7),
	COL_TRI(4, 8, 6),
	COL_TRI(0, 8, 4),
	COL_TRI(8, 0, 2),
	COL_TRI(1, 8, 2),
	COL_TRI(8, 1, 9),
	COL_TRI(9, 10, 8),
	COL_TRI(10, 9, 11),
	COL_TRI(6, 8, 10),
	COL_TRI_STOP(),
	COL_END()
};