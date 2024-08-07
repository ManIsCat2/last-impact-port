const Collision fading_warp_stand_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(17),
	COL_VERTEX(0, 19, 0),
	COL_VERTEX(-146, 19, 0),
	COL_VERTEX(-103, 19, 103),
	COL_VERTEX(-103, 19, -103),
	COL_VERTEX(0, 19, -146),
	COL_VERTEX(103, 19, -103),
	COL_VERTEX(146, 19, 0),
	COL_VERTEX(103, 19, 103),
	COL_VERTEX(0, 19, 146),
	COL_VERTEX(0, 0, 174),
	COL_VERTEX(-123, 0, 123),
	COL_VERTEX(123, 0, 123),
	COL_VERTEX(174, 0, 0),
	COL_VERTEX(123, 0, -123),
	COL_VERTEX(0, 0, -174),
	COL_VERTEX(-123, 0, -123),
	COL_VERTEX(-174, 0, 0),
	COL_TRI_INIT(SURFACE_DEFAULT, 24),
	COL_TRI(0, 1, 2),
	COL_TRI(0, 3, 1),
	COL_TRI(4, 3, 0),
	COL_TRI(5, 4, 0),
	COL_TRI(6, 5, 0),
	COL_TRI(6, 0, 7),
	COL_TRI(7, 0, 8),
	COL_TRI(0, 2, 8),
	COL_TRI(9, 2, 10),
	COL_TRI(2, 9, 8),
	COL_TRI(9, 7, 8),
	COL_TRI(7, 9, 11),
	COL_TRI(11, 6, 7),
	COL_TRI(6, 11, 12),
	COL_TRI(13, 6, 12),
	COL_TRI(6, 13, 5),
	COL_TRI(13, 4, 5),
	COL_TRI(4, 13, 14),
	COL_TRI(14, 3, 4),
	COL_TRI(3, 14, 15),
	COL_TRI(15, 1, 3),
	COL_TRI(1, 15, 16),
	COL_TRI(10, 1, 16),
	COL_TRI(1, 10, 2),
	COL_TRI_STOP(),
	COL_END()
};