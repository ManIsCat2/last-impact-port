const Collision marshmallow_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(24),
	COL_VERTEX(127, 0, 127),
	COL_VERTEX(0, 0, 180),
	COL_VERTEX(0, 0, -180),
	COL_VERTEX(127, 340, 127),
	COL_VERTEX(0, 340, 180),
	COL_VERTEX(-127, 0, 127),
	COL_VERTEX(-127, 340, 127),
	COL_VERTEX(-180, 340, 0),
	COL_VERTEX(-180, 0, 0),
	COL_VERTEX(-127, 0, -127),
	COL_VERTEX(-127, 340, -127),
	COL_VERTEX(-141, 335, 0),
	COL_VERTEX(-100, 335, 100),
	COL_VERTEX(-100, 335, -100),
	COL_VERTEX(0, 340, -180),
	COL_VERTEX(127, 0, -127),
	COL_VERTEX(127, 340, -127),
	COL_VERTEX(180, 340, 0),
	COL_VERTEX(141, 335, 0),
	COL_VERTEX(100, 335, -100),
	COL_VERTEX(0, 335, -141),
	COL_VERTEX(0, 335, 141),
	COL_VERTEX(100, 335, 100),
	COL_VERTEX(180, 0, 0),
	COL_TRI_INIT(SURFACE_DEFAULT, 44),
	COL_TRI(0, 1, 2),
	COL_TRI(3, 1, 0),
	COL_TRI(4, 1, 3),
	COL_TRI(4, 5, 1),
	COL_TRI(6, 5, 4),
	COL_TRI(7, 5, 6),
	COL_TRI(8, 5, 7),
	COL_TRI(5, 8, 9),
	COL_TRI(9, 8, 10),
	COL_TRI(10, 8, 7),
	COL_TRI(10, 7, 11),
	COL_TRI(6, 11, 7),
	COL_TRI(12, 11, 6),
	COL_TRI(13, 11, 12),
	COL_TRI(13, 10, 11),
	COL_TRI(14, 10, 13),
	COL_TRI(14, 2, 10),
	COL_TRI(14, 15, 2),
	COL_TRI(16, 15, 14),
	COL_TRI(16, 17, 15),
	COL_TRI(17, 16, 18),
	COL_TRI(18, 16, 19),
	COL_TRI(16, 20, 19),
	COL_TRI(16, 14, 20),
	COL_TRI(14, 13, 20),
	COL_TRI(20, 13, 21),
	COL_TRI(21, 13, 12),
	COL_TRI(21, 12, 4),
	COL_TRI(4, 12, 6),
	COL_TRI(22, 21, 4),
	COL_TRI(22, 20, 21),
	COL_TRI(19, 20, 22),
	COL_TRI(18, 19, 22),
	COL_TRI(18, 22, 3),
	COL_TRI(3, 22, 4),
	COL_TRI(17, 18, 3),
	COL_TRI(17, 3, 23),
	COL_TRI(23, 3, 0),
	COL_TRI(23, 0, 15),
	COL_TRI(0, 2, 15),
	COL_TRI(15, 17, 23),
	COL_TRI(10, 2, 9),
	COL_TRI(1, 9, 2),
	COL_TRI(1, 5, 9),
	COL_TRI_STOP(),
	COL_END()
};
