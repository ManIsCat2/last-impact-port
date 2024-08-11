const Collision hmc_moving_platform_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(98),
	COL_VERTEX(10, 4, 10),
	COL_VERTEX(0, -4, 14),
	COL_VERTEX(10, -4, 10),
	COL_VERTEX(0, 4, 14),
	COL_VERTEX(-10, -4, -10),
	COL_VERTEX(-14, 4, 0),
	COL_VERTEX(-10, 4, -10),
	COL_VERTEX(-14, -4, 0),
	COL_VERTEX(0, 4, -14),
	COL_VERTEX(0, -4, -14),
	COL_VERTEX(10, 4, -10),
	COL_VERTEX(10, -4, -10),
	COL_VERTEX(14, 4, 0),
	COL_VERTEX(14, -4, 0),
	COL_VERTEX(-10, -4, 10),
	COL_VERTEX(-10, 4, 10),
	COL_VERTEX(-236, -9, 189),
	COL_VERTEX(-217, -4, 189),
	COL_VERTEX(-217, -9, 189),
	COL_VERTEX(-236, -4, 189),
	COL_VERTEX(-236, -9, 264),
	COL_VERTEX(-236, -4, 264),
	COL_VERTEX(-217, -9, 264),
	COL_VERTEX(-217, -4, 264),
	COL_VERTEX(-217, -9, 279),
	COL_VERTEX(-217, 9, 264),
	COL_VERTEX(-217, 9, 279),
	COL_VERTEX(0, 0, 279),
	COL_VERTEX(0, 0, -279),
	COL_VERTEX(-217, -9, -189),
	COL_VERTEX(-217, -9, -264),
	COL_VERTEX(-217, -9, -279),
	COL_VERTEX(-217, -4, -264),
	COL_VERTEX(-236, -4, -264),
	COL_VERTEX(-236, -9, -264),
	COL_VERTEX(-236, -9, -189),
	COL_VERTEX(-217, -4, -189),
	COL_VERTEX(-236, -4, -189),
	COL_VERTEX(-217, 4, -264),
	COL_VERTEX(-217, 4, -189),
	COL_VERTEX(-217, 9, -189),
	COL_VERTEX(-217, 9, 189),
	COL_VERTEX(-217, 4, 189),
	COL_VERTEX(-217, 4, 264),
	COL_VERTEX(-236, 4, 264),
	COL_VERTEX(-236, 9, 264),
	COL_VERTEX(-236, 9, 189),
	COL_VERTEX(-168, 9, 219),
	COL_VERTEX(217, 9, 279),
	COL_VERTEX(217, -9, 279),
	COL_VERTEX(217, -9, -189),
	COL_VERTEX(217, -9, -279),
	COL_VERTEX(217, 9, -279),
	COL_VERTEX(217, 4, -264),
	COL_VERTEX(217, 9, -264),
	COL_VERTEX(168, 9, 219),
	COL_VERTEX(217, 9, -189),
	COL_VERTEX(168, 9, -219),
	COL_VERTEX(-168, 9, -219),
	COL_VERTEX(-217, 9, -279),
	COL_VERTEX(-236, 9, -264),
	COL_VERTEX(-217, 9, -264),
	COL_VERTEX(-236, 9, -189),
	COL_VERTEX(-236, 4, -189),
	COL_VERTEX(-236, 4, -264),
	COL_VERTEX(217, 9, 189),
	COL_VERTEX(217, 9, 264),
	COL_VERTEX(217, 4, 264),
	COL_VERTEX(217, -4, 264),
	COL_VERTEX(217, -9, 264),
	COL_VERTEX(236, -4, 264),
	COL_VERTEX(236, -9, 264),
	COL_VERTEX(236, -9, 189),
	COL_VERTEX(217, -9, 189),
	COL_VERTEX(217, -4, 189),
	COL_VERTEX(217, 4, 189),
	COL_VERTEX(236, -4, 189),
	COL_VERTEX(236, 4, 189),
	COL_VERTEX(236, 4, 264),
	COL_VERTEX(236, 9, 264),
	COL_VERTEX(236, 9, 189),
	COL_VERTEX(236, -9, -189),
	COL_VERTEX(217, -4, -189),
	COL_VERTEX(236, -4, -189),
	COL_VERTEX(236, -9, -264),
	COL_VERTEX(236, -4, -264),
	COL_VERTEX(217, -9, -264),
	COL_VERTEX(217, -4, -264),
	COL_VERTEX(217, 4, -189),
	COL_VERTEX(236, 9, -189),
	COL_VERTEX(236, 4, -189),
	COL_VERTEX(236, 4, -264),
	COL_VERTEX(236, 9, -264),
	COL_VERTEX(-236, 4, 189),
	COL_VERTEX(-112, 4, 153),
	COL_VERTEX(-112, 4, -153),
	COL_VERTEX(112, 4, 153),
	COL_VERTEX(112, 4, -153),
	COL_TRI_INIT(SURFACE_DEFAULT, 173),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(4, 5, 6),
	COL_TRI(5, 4, 7),
	COL_TRI(4, 8, 9),
	COL_TRI(8, 4, 6),
	COL_TRI(10, 9, 8),
	COL_TRI(9, 10, 11),
	COL_TRI(12, 11, 10),
	COL_TRI(11, 12, 13),
	COL_TRI(0, 13, 12),
	COL_TRI(13, 0, 2),
	COL_TRI(3, 14, 1),
	COL_TRI(14, 3, 15),
	COL_TRI(15, 7, 14),
	COL_TRI(7, 15, 5),
	COL_TRI(8, 3, 0),
	COL_TRI(6, 3, 8),
	COL_TRI(6, 15, 3),
	COL_TRI(15, 6, 5),
	COL_TRI(4, 14, 7),
	COL_TRI(14, 4, 9),
	COL_TRI(2, 11, 13),
	COL_TRI(1, 11, 2),
	COL_TRI(1, 9, 11),
	COL_TRI(14, 9, 1),
	COL_TRI(10, 0, 12),
	COL_TRI(8, 0, 10),
	COL_TRI(16, 17, 18),
	COL_TRI(17, 16, 19),
	COL_TRI(20, 19, 16),
	COL_TRI(19, 20, 21),
	COL_TRI(22, 21, 20),
	COL_TRI(21, 22, 23),
	COL_TRI(24, 23, 22),
	COL_TRI(24, 25, 23),
	COL_TRI(25, 24, 26),
	COL_TRI(26, 24, 27),
	COL_TRI(24, 28, 27),
	COL_TRI(22, 28, 24),
	COL_TRI(18, 28, 22),
	COL_TRI(29, 28, 18),
	COL_TRI(30, 28, 29),
	COL_TRI(28, 30, 31),
	COL_TRI(31, 30, 32),
	COL_TRI(30, 33, 32),
	COL_TRI(33, 30, 34),
	COL_TRI(30, 35, 34),
	COL_TRI(35, 30, 29),
	COL_TRI(36, 35, 29),
	COL_TRI(35, 36, 37),
	COL_TRI(36, 33, 37),
	COL_TRI(33, 36, 32),
	COL_TRI(36, 38, 32),
	COL_TRI(36, 39, 38),
	COL_TRI(18, 40, 29),
	COL_TRI(18, 41, 40),
	COL_TRI(23, 42, 17),
	COL_TRI(42, 23, 43),
	COL_TRI(25, 44, 43),
	COL_TRI(44, 25, 45),
	COL_TRI(25, 46, 45),
	COL_TRI(46, 25, 41),
	COL_TRI(25, 47, 41),
	COL_TRI(25, 48, 47),
	COL_TRI(48, 25, 26),
	COL_TRI(27, 48, 26),
	COL_TRI(48, 27, 49),
	COL_TRI(28, 49, 27),
	COL_TRI(49, 28, 50),
	COL_TRI(50, 28, 51),
	COL_TRI(52, 51, 28),
	COL_TRI(52, 53, 51),
	COL_TRI(53, 52, 54),
	COL_TRI(52, 55, 56),
	COL_TRI(52, 57, 55),
	COL_TRI(52, 58, 57),
	COL_TRI(59, 58, 52),
	COL_TRI(59, 40, 58),
	COL_TRI(60, 40, 61),
	COL_TRI(40, 60, 62),
	COL_TRI(60, 63, 62),
	COL_TRI(63, 60, 64),
	COL_TRI(61, 64, 60),
	COL_TRI(64, 61, 38),
	COL_TRI(59, 38, 61),
	COL_TRI(38, 59, 32),
	COL_TRI(32, 59, 31),
	COL_TRI(59, 28, 31),
	COL_TRI(28, 59, 52),
	COL_TRI(38, 63, 64),
	COL_TRI(63, 38, 39),
	COL_TRI(39, 62, 63),
	COL_TRI(62, 39, 40),
	COL_TRI(58, 40, 47),
	COL_TRI(41, 47, 40),
	COL_TRI(47, 48, 55),
	COL_TRI(55, 48, 65),
	COL_TRI(49, 66, 48),
	COL_TRI(66, 49, 67),
	COL_TRI(67, 49, 68),
	COL_TRI(69, 68, 49),
	COL_TRI(69, 70, 68),
	COL_TRI(70, 69, 71),
	COL_TRI(69, 72, 71),
	COL_TRI(72, 69, 73),
	COL_TRI(65, 73, 50),
	COL_TRI(67, 74, 75),
	COL_TRI(74, 67, 68),
	COL_TRI(70, 74, 68),
	COL_TRI(74, 70, 76),
	COL_TRI(71, 76, 70),
	COL_TRI(76, 71, 72),
	COL_TRI(72, 74, 76),
	COL_TRI(74, 72, 73),
	COL_TRI(77, 67, 75),
	COL_TRI(67, 77, 78),
	COL_TRI(77, 79, 78),
	COL_TRI(79, 77, 80),
	COL_TRI(75, 80, 77),
	COL_TRI(80, 75, 65),
	COL_TRI(65, 66, 80),
	COL_TRI(80, 66, 79),
	COL_TRI(66, 78, 79),
	COL_TRI(78, 66, 67),
	COL_TRI(65, 50, 56),
	COL_TRI(81, 82, 50),
	COL_TRI(82, 81, 83),
	COL_TRI(84, 83, 81),
	COL_TRI(83, 84, 85),
	COL_TRI(86, 85, 84),
	COL_TRI(85, 86, 87),
	COL_TRI(51, 87, 86),
	COL_TRI(87, 51, 53),
	COL_TRI(88, 87, 53),
	COL_TRI(88, 82, 87),
	COL_TRI(88, 89, 56),
	COL_TRI(89, 88, 90),
	COL_TRI(88, 91, 90),
	COL_TRI(91, 88, 53),
	COL_TRI(54, 91, 53),
	COL_TRI(91, 54, 92),
	COL_TRI(54, 89, 92),
	COL_TRI(89, 54, 56),
	COL_TRI(90, 92, 89),
	COL_TRI(92, 90, 91),
	COL_TRI(83, 87, 82),
	COL_TRI(87, 83, 85),
	COL_TRI(84, 50, 86),
	COL_TRI(50, 84, 81),
	COL_TRI(55, 65, 56),
	COL_TRI(42, 46, 41),
	COL_TRI(46, 42, 93),
	COL_TRI(42, 44, 93),
	COL_TRI(44, 42, 43),
	COL_TRI(45, 93, 44),
	COL_TRI(93, 45, 46),
	COL_TRI(19, 23, 17),
	COL_TRI(23, 19, 21),
	COL_TRI(34, 37, 33),
	COL_TRI(37, 34, 35),
	COL_TRI(20, 18, 22),
	COL_TRI(18, 20, 16),
	COL_TRI(94, 58, 47),
	COL_TRI(58, 94, 95),
	COL_TRI(96, 95, 94),
	COL_TRI(95, 96, 97),
	COL_TRI(96, 57, 97),
	COL_TRI(57, 96, 55),
	COL_TRI(94, 55, 96),
	COL_TRI(55, 94, 47),
	COL_TRI(57, 95, 97),
	COL_TRI(95, 57, 58),
	COL_TRI_STOP(),
	COL_END()
};
