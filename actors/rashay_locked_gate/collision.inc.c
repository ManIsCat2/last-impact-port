const Collision rashay_locked_gate_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(4),
	COL_VERTEX(356, 522, 0),
	COL_VERTEX(-356, 0, 0),
	COL_VERTEX(356, 0, 0),
	COL_VERTEX(-356, 522, 0),
	COL_TRI_INIT(SURFACE_DEFAULT, 2),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI_STOP(),
	COL_END()
};
