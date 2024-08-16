const Collision bitfs_gear_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(50),
	COL_VERTEX(-500, 0, 0),
	COL_VERTEX(-404, 293, 200),
	COL_VERTEX(-404, 293, 0),
	COL_VERTEX(-500, 0, 200),
	COL_VERTEX(-595, -30, 0),
	COL_VERTEX(-595, -30, 200),
	COL_VERTEX(-499, -324, 0),
	COL_VERTEX(-499, -324, 200),
	COL_VERTEX(-404, -293, 200),
	COL_VERTEX(-404, -293, 0),
	COL_VERTEX(-154, -475, 200),
	COL_VERTEX(-154, -475, 0),
	COL_VERTEX(-154, -575, 0),
	COL_VERTEX(-154, -575, 200),
	COL_VERTEX(154, -575, 200),
	COL_VERTEX(154, -575, 0),
	COL_VERTEX(154, -475, 200),
	COL_VERTEX(154, -475, 0),
	COL_VERTEX(404, -293, 200),
	COL_VERTEX(404, -293, 0),
	COL_VERTEX(499, -324, 200),
	COL_VERTEX(499, -324, 0),
	COL_VERTEX(595, -30, 200),
	COL_VERTEX(595, -30, 0),
	COL_VERTEX(500, 0, 0),
	COL_VERTEX(500, 0, 200),
	COL_VERTEX(404, 293, 200),
	COL_VERTEX(404, 293, 0),
	COL_VERTEX(463, 374, 200),
	COL_VERTEX(463, 374, 0),
	COL_VERTEX(213, 556, 0),
	COL_VERTEX(213, 556, 200),
	COL_VERTEX(154, 475, 0),
	COL_VERTEX(154, 475, 200),
	COL_VERTEX(-154, 475, 0),
	COL_VERTEX(-154, 475, 200),
	COL_VERTEX(-213, 556, 200),
	COL_VERTEX(-213, 556, 0),
	COL_VERTEX(-463, 374, 0),
	COL_VERTEX(-463, 374, 200),
	COL_VERTEX(-289, 415, 200),
	COL_VERTEX(-468, -135, 200),
	COL_VERTEX(0, -475, 200),
	COL_VERTEX(468, -135, 200),
	COL_VERTEX(289, 415, 200),
	COL_VERTEX(-195, 285, 275),
	COL_VERTEX(195, 285, 275),
	COL_VERTEX(315, -85, 275),
	COL_VERTEX(-315, -85, 275),
	COL_VERTEX(0, -315, 275),
	COL_TRI_INIT(SURFACE_DEFAULT, 40),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(4, 3, 0),
	COL_TRI(3, 4, 5),
	COL_TRI(6, 5, 4),
	COL_TRI(5, 6, 7),
	COL_TRI(6, 8, 7),
	COL_TRI(8, 6, 9),
	COL_TRI(9, 10, 8),
	COL_TRI(10, 9, 11),
	COL_TRI(12, 10, 11),
	COL_TRI(10, 12, 13),
	COL_TRI(12, 14, 13),
	COL_TRI(14, 12, 15),
	COL_TRI(15, 16, 14),
	COL_TRI(16, 15, 17),
	COL_TRI(17, 18, 16),
	COL_TRI(18, 17, 19),
	COL_TRI(19, 20, 18),
	COL_TRI(20, 19, 21),
	COL_TRI(21, 22, 20),
	COL_TRI(22, 21, 23),
	COL_TRI(24, 22, 23),
	COL_TRI(22, 24, 25),
	COL_TRI(24, 26, 25),
	COL_TRI(26, 24, 27),
	COL_TRI(27, 28, 26),
	COL_TRI(28, 27, 29),
	COL_TRI(30, 28, 29),
	COL_TRI(28, 30, 31),
	COL_TRI(32, 31, 30),
	COL_TRI(31, 32, 33),
	COL_TRI(34, 33, 32),
	COL_TRI(33, 34, 35),
	COL_TRI(34, 36, 35),
	COL_TRI(36, 34, 37),
	COL_TRI(38, 36, 37),
	COL_TRI(36, 38, 39),
	COL_TRI(2, 39, 38),
	COL_TRI(39, 2, 1),
	COL_TRI_INIT(SURFACE_NOT_SLIPPERY, 37),
	COL_TRI(1, 40, 39),
	COL_TRI(3, 40, 1),
	COL_TRI(3, 41, 40),
	COL_TRI(5, 41, 3),
	COL_TRI(5, 8, 41),
	COL_TRI(8, 5, 7),
	COL_TRI(8, 42, 41),
	COL_TRI(10, 42, 8),
	COL_TRI(10, 14, 16),
	COL_TRI(14, 10, 13),
	COL_TRI(18, 42, 16),
	COL_TRI(42, 18, 43),
	COL_TRI(18, 22, 43),
	COL_TRI(22, 18, 20),
	COL_TRI(43, 22, 25),
	COL_TRI(43, 25, 44),
	COL_TRI(44, 25, 26),
	COL_TRI(44, 26, 28),
	COL_TRI(44, 28, 31),
	COL_TRI(44, 31, 33),
	COL_TRI(44, 33, 40),
	COL_TRI(35, 40, 33),
	COL_TRI(36, 40, 35),
	COL_TRI(39, 40, 36),
	COL_TRI(45, 44, 40),
	COL_TRI(44, 45, 46),
	COL_TRI(45, 47, 46),
	COL_TRI(48, 47, 45),
	COL_TRI(47, 48, 49),
	COL_TRI(41, 49, 48),
	COL_TRI(49, 41, 42),
	COL_TRI(43, 49, 42),
	COL_TRI(49, 43, 47),
	COL_TRI(44, 47, 43),
	COL_TRI(47, 44, 46),
	COL_TRI(48, 40, 41),
	COL_TRI(40, 48, 45),
	COL_TRI_STOP(),
	COL_END()
};
