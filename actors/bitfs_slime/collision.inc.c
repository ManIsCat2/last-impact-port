const Collision bitfs_slime_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(8),
	COL_VERTEX(-100, 200, 100),
	COL_VERTEX(100, 0, 100),
	COL_VERTEX(100, 200, 100),
	COL_VERTEX(-100, 0, 100),
	COL_VERTEX(-100, 0, -100),
	COL_VERTEX(-100, 200, -100),
	COL_VERTEX(100, 200, -100),
	COL_VERTEX(100, 0, -100),
	COL_TRI_INIT(SURFACE_DEFAULT, 12),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(0, 4, 3),
	COL_TRI(4, 0, 5),
	COL_TRI(2, 5, 0),
	COL_TRI(5, 2, 6),
	COL_TRI(1, 6, 2),
	COL_TRI(6, 1, 7),
	COL_TRI(1, 4, 7),
	COL_TRI(4, 1, 3),
	COL_TRI(4, 6, 7),
	COL_TRI(6, 4, 5),
	COL_TRI_STOP(),
	COL_END()
};
