const Collision thi_flying_train_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(42),
	COL_VERTEX(200, 210, 250),
	COL_VERTEX(-200, 160, 250),
	COL_VERTEX(200, 160, 250),
	COL_VERTEX(-200, 210, 250),
	COL_VERTEX(200, 160, -598),
	COL_VERTEX(200, 210, -598),
	COL_VERTEX(200, 110, -598),
	COL_VERTEX(200, 110, 250),
	COL_VERTEX(-200, 110, 250),
	COL_VERTEX(-200, 160, -598),
	COL_VERTEX(-200, 110, -598),
	COL_VERTEX(-200, 210, -598),
	COL_VERTEX(200, 433, 250),
	COL_VERTEX(0, 210, 250),
	COL_VERTEX(0, 433, 250),
	COL_VERTEX(200, 433, -598),
	COL_VERTEX(-200, 433, -598),
	COL_VERTEX(0, 210, -598),
	COL_VERTEX(0, 433, -598),
	COL_VERTEX(-200, 433, 250),
	COL_VERTEX(-165, 0, 177),
	COL_VERTEX(-165, 0, -526),
	COL_VERTEX(165, 0, -526),
	COL_VERTEX(165, 0, 177),
	COL_VERTEX(204, 110, -169),
	COL_VERTEX(204, 210, 62),
	COL_VERTEX(204, 110, 62),
	COL_VERTEX(204, 210, -169),
	COL_VERTEX(204, 110, -417),
	COL_VERTEX(204, 210, -417),
	COL_VERTEX(-204, 110, -184),
	COL_VERTEX(-204, 210, -417),
	COL_VERTEX(-204, 110, -417),
	COL_VERTEX(-204, 210, -184),
	COL_VERTEX(-204, 110, 62),
	COL_VERTEX(-204, 210, 62),
	COL_VERTEX(165, 508, 177),
	COL_VERTEX(0, 508, 177),
	COL_VERTEX(0, 508, -526),
	COL_VERTEX(165, 508, -526),
	COL_VERTEX(-165, 508, -526),
	COL_VERTEX(-165, 508, 177),
	COL_TRI_INIT(SURFACE_DEFAULT, 48),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI(0, 4, 5),
	COL_TRI(4, 0, 2),
	COL_TRI(2, 6, 4),
	COL_TRI(6, 2, 7),
	COL_TRI(1, 7, 2),
	COL_TRI(7, 1, 8),
	COL_TRI(9, 8, 1),
	COL_TRI(8, 9, 10),
	COL_TRI(9, 6, 10),
	COL_TRI(6, 9, 4),
	COL_TRI(11, 4, 9),
	COL_TRI(4, 11, 5),
	COL_TRI(11, 1, 3),
	COL_TRI(1, 11, 9),
	COL_TRI(12, 13, 0),
	COL_TRI(13, 12, 14),
	COL_TRI(12, 5, 15),
	COL_TRI(5, 12, 0),
	COL_TRI(16, 17, 11),
	COL_TRI(17, 16, 18),
	COL_TRI(16, 3, 19),
	COL_TRI(3, 16, 11),
	COL_TRI(3, 14, 19),
	COL_TRI(14, 3, 13),
	COL_TRI(5, 18, 15),
	COL_TRI(18, 5, 17),
	COL_TRI(10, 7, 6),
	COL_TRI(7, 10, 8),
	COL_TRI(10, 20, 8),
	COL_TRI(20, 10, 21),
	COL_TRI(10, 22, 21),
	COL_TRI(22, 10, 6),
	COL_TRI(6, 23, 22),
	COL_TRI(23, 6, 7),
	COL_TRI(7, 20, 23),
	COL_TRI(20, 7, 8),
	COL_TRI(20, 22, 23),
	COL_TRI(22, 20, 21),
	COL_TRI(24, 25, 26),
	COL_TRI(25, 24, 27),
	COL_TRI(28, 27, 24),
	COL_TRI(27, 28, 29),
	COL_TRI(30, 31, 32),
	COL_TRI(31, 30, 33),
	COL_TRI(34, 33, 30),
	COL_TRI(33, 34, 35),
	COL_TRI_INIT(SURFACE_NOT_SLIPPERY, 16),
	COL_TRI(36, 14, 12),
	COL_TRI(14, 36, 37),
	COL_TRI(36, 38, 37),
	COL_TRI(38, 36, 39),
	COL_TRI(36, 15, 39),
	COL_TRI(15, 36, 12),
	COL_TRI(40, 18, 16),
	COL_TRI(18, 40, 38),
	COL_TRI(40, 37, 38),
	COL_TRI(37, 40, 41),
	COL_TRI(16, 41, 40),
	COL_TRI(41, 16, 19),
	COL_TRI(37, 19, 14),
	COL_TRI(19, 37, 41),
	COL_TRI(38, 15, 18),
	COL_TRI(15, 38, 39),
	COL_TRI_STOP(),
	COL_END()
};
