const Collision thi_static_gray_block_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(8),
	COL_VERTEX(154, 307, -153),
	COL_VERTEX(-153, 307, -153),
	COL_VERTEX(-153, 307, 154),
	COL_VERTEX(154, 307, 154),
	COL_VERTEX(-153, 0, -153),
	COL_VERTEX(154, 0, -153),
	COL_VERTEX(-153, 0, 154),
	COL_VERTEX(154, 0, 154),
	COL_TRI_INIT(SURFACE_DEFAULT, 12),
	COL_TRI(0, 1, 2),
	COL_TRI(0, 2, 3),
	COL_TRI(4, 1, 0),
	COL_TRI(4, 0, 5),
	COL_TRI(6, 2, 1),
	COL_TRI(6, 1, 4),
	COL_TRI(7, 6, 4),
	COL_TRI(7, 4, 5),
	COL_TRI(7, 2, 6),
	COL_TRI(7, 3, 2),
	COL_TRI(5, 0, 3),
	COL_TRI(5, 3, 7),
	COL_TRI_STOP(),
	COL_END()
};
