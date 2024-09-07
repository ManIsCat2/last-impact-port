const Collision cork_drain_water_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(11),
	COL_VERTEX(-36, 1, -133),
	COL_VERTEX(-36, 1, 133),
	COL_VERTEX(-133, 1, 0),
	COL_VERTEX(119, 1, -82),
	COL_VERTEX(-45, 276, -171),
	COL_VERTEX(156, 276, -106),
	COL_VERTEX(119, 1, 82),
	COL_VERTEX(156, 276, 106),
	COL_VERTEX(6, 276, 0),
	COL_VERTEX(-170, 276, 0),
	COL_VERTEX(-45, 276, 171),
	COL_TRI_INIT(SURFACE_DEFAULT, 18),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(4, 3, 0),
	COL_TRI(5, 3, 4),
	COL_TRI(5, 6, 3),
	COL_TRI(5, 7, 6),
	COL_TRI(5, 8, 7),
	COL_TRI(5, 4, 8),
	COL_TRI(8, 4, 9),
	COL_TRI(4, 2, 9),
	COL_TRI(4, 0, 2),
	COL_TRI(2, 1, 9),
	COL_TRI(9, 1, 10),
	COL_TRI(10, 1, 7),
	COL_TRI(7, 1, 6),
	COL_TRI(1, 3, 6),
	COL_TRI(7, 8, 10),
	COL_TRI(8, 9, 10),
	COL_TRI_STOP(),
	COL_END()
};