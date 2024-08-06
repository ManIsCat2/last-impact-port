const Collision rocket_door_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(22),
	COL_VERTEX(-62, 239, 31),
	COL_VERTEX(-107, 189, 53),
	COL_VERTEX(62, 239, -31),
	COL_VERTEX(107, 189, -53),
	COL_VERTEX(-107, 0, 53),
	COL_VERTEX(107, 0, -53),
	COL_VERTEX(26, 71, -13),
	COL_VERTEX(6, 47, 13),
	COL_VERTEX(0, 47, 0),
	COL_VERTEX(33, 71, 0),
	COL_VERTEX(48, 94, -3),
	COL_VERTEX(38, 94, -23),
	COL_VERTEX(26, 118, -13),
	COL_VERTEX(33, 118, 0),
	COL_VERTEX(6, 142, 13),
	COL_VERTEX(0, 142, 0),
	COL_VERTEX(-20, 118, 26),
	COL_VERTEX(-26, 118, 13),
	COL_VERTEX(-42, 94, 16),
	COL_VERTEX(-32, 94, 36),
	COL_VERTEX(-20, 71, 26),
	COL_VERTEX(-26, 71, 13),
	COL_TRI_INIT(SURFACE_DEFAULT, 26),
	COL_TRI(0, 1, 2),
	COL_TRI(2, 1, 3),
	COL_TRI(4, 3, 1),
	COL_TRI(3, 4, 5),
	COL_TRI(6, 7, 8),
	COL_TRI(7, 6, 9),
	COL_TRI(6, 10, 9),
	COL_TRI(10, 6, 11),
	COL_TRI(12, 10, 11),
	COL_TRI(10, 12, 13),
	COL_TRI(12, 14, 13),
	COL_TRI(14, 12, 15),
	COL_TRI(15, 16, 14),
	COL_TRI(16, 15, 17),
	COL_TRI(18, 16, 17),
	COL_TRI(16, 18, 19),
	COL_TRI(18, 20, 19),
	COL_TRI(20, 18, 21),
	COL_TRI(8, 20, 21),
	COL_TRI(20, 8, 7),
	COL_TRI(9, 20, 7),
	COL_TRI(9, 19, 20),
	COL_TRI(19, 9, 10),
	COL_TRI(10, 16, 19),
	COL_TRI(16, 10, 13),
	COL_TRI(14, 16, 13),
	COL_TRI_STOP(),
	COL_END()
};