const Collision bitfs_general_use_cage_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(4),
	COL_VERTEX(0, 0, -204),
	COL_VERTEX(0, 474, 204),
	COL_VERTEX(0, 0, 204),
	COL_VERTEX(0, 474, -204),
	COL_TRI_INIT(SURFACE_DEFAULT, 2),
	COL_TRI(0, 1, 2),
	COL_TRI(1, 0, 3),
	COL_TRI_STOP(),
	COL_END()
};
