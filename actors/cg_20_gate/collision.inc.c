const Collision cg_20_gate_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(8),
	COL_VERTEX(-50, 998, -638),
	COL_VERTEX(50, 0, -638),
	COL_VERTEX(-50, 0, -638),
	COL_VERTEX(50, 998, -638),
	COL_VERTEX(50, 998, 0),
	COL_VERTEX(50, 0, 0),
	COL_VERTEX(-50, 0, 0),
	COL_VERTEX(-50, 998, 0),
	COL_TRI_INIT(SURFACE_DEFAULT, 8),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(4, 1, 3),
	COL_TRI(1, 4, 5),
	COL_TRI(4, 6, 5),
	COL_TRI(6, 4, 7),
	COL_TRI(0, 6, 7),
	COL_TRI(6, 0, 2),
	COL_TRI_STOP(),
	COL_END()
};
