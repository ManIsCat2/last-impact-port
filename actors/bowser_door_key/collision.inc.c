const Collision bowser_door_key_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(63),
	COL_VERTEX(343, 761, 12),
	COL_VERTEX(50, 50, 12),
	COL_VERTEX(343, 50, 12),
	COL_VERTEX(50, 761, 12),
	COL_VERTEX(50, 761, -12),
	COL_VERTEX(343, 50, -12),
	COL_VERTEX(50, 50, -12),
	COL_VERTEX(343, 761, -12),
	COL_VERTEX(373, 761, -12),
	COL_VERTEX(667, 50, -12),
	COL_VERTEX(373, 50, -12),
	COL_VERTEX(667, 761, -12),
	COL_VERTEX(667, 761, 12),
	COL_VERTEX(373, 50, 12),
	COL_VERTEX(667, 50, 12),
	COL_VERTEX(373, 761, 12),
	COL_VERTEX(717, 327, -55),
	COL_VERTEX(681, 327, 53),
	COL_VERTEX(682, 327, -55),
	COL_VERTEX(717, 327, 55),
	COL_VERTEX(677, 446, 46),
	COL_VERTEX(645, 426, 48),
	COL_VERTEX(677, 447, -46),
	COL_VERTEX(645, 427, -49),
	COL_VERTEX(717, 447, -46),
	COL_VERTEX(717, 447, 46),
	COL_VERTEX(614, 364, -53),
	COL_VERTEX(614, 363, 51),
	COL_VERTEX(634, 394, -47),
	COL_VERTEX(625, 376, 0),
	COL_VERTEX(591, 430, -33),
	COL_VERTEX(577, 426, 0),
	COL_VERTEX(591, 430, 32),
	COL_VERTEX(634, 394, 46),
	COL_VERTEX(613, 436, 19),
	COL_VERTEX(620, 475, 0),
	COL_VERTEX(613, 436, -20),
	COL_VERTEX(648, 424, -29),
	COL_VERTEX(647, 424, 28),
	COL_VERTEX(717, 0, -25),
	COL_VERTEX(0, 0, 25),
	COL_VERTEX(0, 0, -25),
	COL_VERTEX(717, 0, 25),
	COL_VERTEX(717, 811, 25),
	COL_VERTEX(717, 811, -25),
	COL_VERTEX(667, 50, -30),
	COL_VERTEX(667, 761, -30),
	COL_VERTEX(667, 50, 30),
	COL_VERTEX(667, 761, 30),
	COL_VERTEX(50, 50, 30),
	COL_VERTEX(373, 50, -30),
	COL_VERTEX(373, 50, 30),
	COL_VERTEX(50, 50, -30),
	COL_VERTEX(0, 811, -25),
	COL_VERTEX(50, 761, -30),
	COL_VERTEX(343, 761, -30),
	COL_VERTEX(373, 761, -30),
	COL_VERTEX(0, 811, 25),
	COL_VERTEX(50, 761, 30),
	COL_VERTEX(343, 761, 30),
	COL_VERTEX(343, 50, 30),
	COL_VERTEX(343, 50, -30),
	COL_VERTEX(373, 761, 30),
	COL_TRI_INIT(SURFACE_DEFAULT, 95),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(4, 5, 6),
	COL_TRI(5, 4, 7),
	COL_TRI(8, 9, 10),
	COL_TRI(9, 8, 11),
	COL_TRI(12, 13, 14),
	COL_TRI(13, 12, 15),
	COL_TRI(16, 17, 18),
	COL_TRI(19, 17, 16),
	COL_TRI(20, 17, 19),
	COL_TRI(20, 21, 17),
	COL_TRI(22, 21, 20),
	COL_TRI(22, 23, 21),
	COL_TRI(22, 18, 23),
	COL_TRI(24, 18, 22),
	COL_TRI(24, 16, 18),
	COL_TRI(25, 16, 24),
	COL_TRI(16, 25, 19),
	COL_TRI(25, 20, 19),
	COL_TRI(25, 22, 20),
	COL_TRI(25, 24, 22),
	COL_TRI(23, 18, 26),
	COL_TRI(18, 17, 26),
	COL_TRI(17, 27, 26),
	COL_TRI(21, 27, 17),
	COL_TRI(23, 27, 21),
	COL_TRI(26, 27, 23),
	COL_TRI(28, 29, 30),
	COL_TRI(30, 29, 31),
	COL_TRI(29, 32, 31),
	COL_TRI(29, 33, 32),
	COL_TRI(34, 32, 33),
	COL_TRI(35, 32, 34),
	COL_TRI(31, 32, 35),
	COL_TRI(30, 31, 35),
	COL_TRI(35, 36, 30),
	COL_TRI(36, 35, 34),
	COL_TRI(37, 36, 34),
	COL_TRI(36, 37, 28),
	COL_TRI(36, 28, 30),
	COL_TRI(37, 34, 38),
	COL_TRI(34, 33, 38),
	COL_TRI(39, 40, 41),
	COL_TRI(40, 39, 42),
	COL_TRI(39, 43, 42),
	COL_TRI(43, 39, 44),
	COL_TRI(45, 44, 39),
	COL_TRI(44, 45, 46),
	COL_TRI(47, 46, 45),
	COL_TRI(46, 47, 48),
	COL_TRI(47, 43, 48),
	COL_TRI(43, 47, 42),
	COL_TRI(47, 40, 42),
	COL_TRI(40, 47, 49),
	COL_TRI(47, 50, 51),
	COL_TRI(50, 47, 45),
	COL_TRI(39, 52, 45),
	COL_TRI(52, 39, 41),
	COL_TRI(53, 52, 41),
	COL_TRI(52, 53, 54),
	COL_TRI(53, 55, 54),
	COL_TRI(55, 53, 56),
	COL_TRI(56, 53, 46),
	COL_TRI(46, 53, 44),
	COL_TRI(53, 43, 44),
	COL_TRI(43, 53, 57),
	COL_TRI(53, 40, 57),
	COL_TRI(40, 53, 41),
	COL_TRI(49, 57, 40),
	COL_TRI(57, 49, 58),
	COL_TRI(52, 58, 49),
	COL_TRI(58, 52, 54),
	COL_TRI(55, 58, 54),
	COL_TRI(58, 55, 59),
	COL_TRI(55, 60, 59),
	COL_TRI(60, 55, 61),
	COL_TRI(55, 50, 61),
	COL_TRI(50, 55, 56),
	COL_TRI(62, 55, 56),
	COL_TRI(55, 62, 59),
	COL_TRI(62, 43, 59),
	COL_TRI(43, 62, 48),
	COL_TRI(56, 48, 62),
	COL_TRI(48, 56, 46),
	COL_TRI(62, 50, 56),
	COL_TRI(50, 62, 51),
	COL_TRI(62, 60, 51),
	COL_TRI(60, 62, 59),
	COL_TRI(51, 61, 60),
	COL_TRI(61, 51, 50),
	COL_TRI(52, 60, 61),
	COL_TRI(60, 52, 49),
	COL_TRI(59, 43, 58),
	COL_TRI(58, 43, 57),
	COL_TRI_STOP(),
	COL_END()
};
