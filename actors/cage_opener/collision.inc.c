const Collision cage_opener_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(8),
	COL_VERTEX(98, 50, 98),
	COL_VERTEX(-98, 50, -98),
	COL_VERTEX(-98, 50, 98),
	COL_VERTEX(98, 50, -98),
	COL_VERTEX(98, 0, -98),
	COL_VERTEX(98, 0, 98),
	COL_VERTEX(-98, 0, 98),
	COL_VERTEX(-98, 0, -98),
	COL_TRI_INIT(SURFACE_DEFAULT, 10),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(0, 4, 3),
	COL_TRI(4, 0, 5),
	COL_TRI(0, 6, 5),
	COL_TRI(6, 0, 2),
	COL_TRI(1, 6, 2),
	COL_TRI(6, 1, 7),
	COL_TRI(1, 4, 7),
	COL_TRI(4, 1, 3),
	COL_TRI_STOP(),
	COL_END()
};
