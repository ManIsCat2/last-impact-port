local dummy = setmetatable({}, {
    __index = function(_, _)
        return 0
    end
})

CUTSCENE_FLAG_SHOW_HUD = 0x04
CUTSCENE_FLAG_SKIPABLE = 0x08
CUTSCENE_FLAG_UNSKIPABLE = 0x10
CUTSCENE_FLAG_GREYOUT = 0x20
CUTSCENE_FLAG_SHAKE = 0x40
CUTSCENE_FLAG_END = 0x80

-- custom flags!
CUTSCENE_FLAG_KEEP_MUSIC = 0x100
CUTSCENE_FLAG_NEXT_CREDITS_ENTRY = 0x200


-- CUTSCENE_BBH_ACT_1

CUTSCENE_BBH_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -8765, -321, 15615},
	{"cam_pos", 1, -9760, 96, 13811},
	{"skip_frames", 0},
	{"cam_focus", 80, -6887, 1869, 16610},
	{"cam_pos", 80, -9833, 2999, 16389},
	{"skip_frames", 79},
	{"cam_focus", 80, -3315, 150, -74},
	{"cam_pos", 80, -5524, 929, 1252},
	{"skip_frames", 104},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BBH_ACT_2

CUTSCENE_BBH_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 13099, -894, 15948},
	{"cam_pos", 1, 7382, -256, 15046},
	{"skip_frames", 0},
	{"cam_focus", 160, 13099, 2307, 15948},
	{"cam_pos", 160, 11957, 3044, 16103},
	{"skip_frames", 192},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BBH_ACT_4

CUTSCENE_BBH_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 2476, 6772, -2367},
	{"cam_pos", 1, 2905, 7153, -1877},
	{"skip_frames", 0},
	{"cam_pos", 96, 3324, 6943, -2859},
	{"skip_frames", 31},
	{"cam_focus", 128, -1670, 10617, -3280},
	{"skip_frames", 159},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOB_ACT_1

CUTSCENE_BOB_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, -3151, 1825, 5429},
	{"cam_focus", 1, -1156, -16, 11273},
	{"skip_frames", 0},
	{"cam_pos", 88, -1778, 94, 13176},
	{"cam_focus", 88, -3704, 792, 15654},
	{"skip_frames", 87},
	{"cam_focus", 96, -7112, 1413, 18656},
	{"cam_pos", 96, -4824, 947, 17674},
	{"skip_frames", 108},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOB_ACT_2

CUTSCENE_BOB_ACT_2 = {
	{"play_sound", 0x04, 0x0000},
	{"cam_pos", 1, 1175, -1150, -5334},
	{"cam_focus", 1, -266, -2659, -12747},
	{"skip_frames", 0},
	{"cam_pos", 64, 1015, -2387, -12236},
	{"skip_frames", 63},
	{"cam_focus", 1, 6328, -2581, -8174},
	{"cam_pos", 1, 4673, -2309, -9413},
	{"skip_frames", 0},
	{"cam_pos", 120, 4824, -2076, -7143},
	{"skip_frames", 132},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOB_ACT_3

CUTSCENE_BOB_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, 1347, 5069, -2399},
	{"cam_focus", 1, 2187, 59, 4460},
	{"skip_frames", 0},
	{"cam_pos", 62, -2797, 2739, 2843},
	{"cam_focus", 62, 1594, -795, 5647},
	{"skip_frames", 61},
	{"cam_pos", 112, -1490, -756, 7861},
	{"cam_focus", 112, 1596, -2387, 6741},
	{"skip_frames", 135},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOB_ACT_5

CUTSCENE_BOB_ACT_5 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, -3779, 1486, 11871},
	{"cam_focus", 1, -2399, 864, 12642},
	{"skip_frames", 0},
	{"cam_pos", 180, 999, 1486, 10388},
	{"cam_focus", 180, 2316, 864, 11061},
	{"skip_frames", 196},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOB_ACT_6

CUTSCENE_BOB_ACT_6 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, 2774, 2884, -1606},
	{"cam_focus", 1, -2962, 591, -2055},
	{"skip_frames", 0},
	{"cam_pos", 180, 852, 2884, -7065},
	{"cam_focus", 180, 6271, 591, -12187},
	{"skip_frames", 196},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOB_PRISON_OPEN

CUTSCENE_BOB_PRISON_OPEN = {
	{"cutscene_obj", E_MODEL_MIPS, 0, 0xc0, gObjectAnimations.mips_seg6_anims_06015634},
	{"obj_warp", 0, 6327, -2646, -8171},
	{"obj_anim", 0, 0},
	{"obj_rot", 0, -96, 0},
	{"cam_focus", 16, 6184, -2124, -8051},
	{"cam_pos", 16, 2743, -1681, -7908},
	{"play_sound", 0x9b, 0x0000},
	{"skip_frames", 80},
	{"obj_speed", 0, 32, 32},
	{"obj_anim", 0, 1},
	{"skip_frames", 26},
	{"cam_pos", 32, 4475, -2055, -7769},
	{"cam_focus", 32, 5311, -2655, -9437},
	{"skip_frames", 64},
	{"obj_speed", 0, 0, 0},
	{"obj_warp", 0, -230, -2653, -12822},
	{"obj_rot", 0, 0, 0},
	{"obj_anim", 0, 0},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOWSER_DEFEATED

CUTSCENE_BOWSER_DEFEATED = {
	{"cam_focus", 32, 9642, 7700, 12508},
	{"cam_pos", 32, 7984, 8804, 13309},
	{"skip_frames", 79},
	{"cam_pos", 64, 9300, 8600, 16251},
	{"cam_focus", 64, 9174, 8431, 18637},
	{"skip_frames", 104},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_BOWSER_INTRO

CUTSCENE_BOWSER_INTRO = {
	{"cam_pos", 16, 8889, 8825, 7825},
	{"cam_focus", 16, 9530, 8431, 17065},
	{"skip_frames", 47},
	{"cam_focus", 64, 9122, 8431, 18935},
	{"cam_pos", 64, 9247, 8713, 17355},
	{"skip_frames", 85},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_CCM_ACT_1

CUTSCENE_CCM_ACT_1 = {
	{"cam_pos", 1, 1347, -260, 3645},
	{"cam_focus", 1, -43, -468, 5772},
	{"skip_frames", 0},
	{"cam_pos", 48, -600, -260, 7569},
	{"cam_focus", 16, -704, -468, 7015},
	{"skip_frames", 15},
	{"cam_focus", 16, -2044, -468, 8256},
	{"skip_frames", 15},
	{"cam_focus", 64, -3066, -573, 7832},
	{"skip_frames", 15},
	{"cam_pos", 48, -2092, -312, 7306},
	{"skip_frames", 96},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_CCM_ACT_2

CUTSCENE_CCM_ACT_2 = {
	{"cam_pos", 1, 11326, 1928, 13816},
	{"cam_focus", 1, 11045, 1431, 12402},
	{"skip_frames", 32},
	{"cam_pos", 1, 9337, 285, 12648},
	{"cam_focus", 1, 10308, -184, 12284},
	{"skip_frames", 32},
	{"cam_pos", 1, 7967, -340, 15623},
	{"cam_focus", 1, 9009, -600, 15639},
	{"skip_frames", 32},
	{"cam_pos", 1, 9340, 858, 19905},
	{"cam_focus", 1, 10121, 545, 19351},
	{"skip_frames", 32},
	{"cam_pos", 1, 11702, 1952, 16074},
	{"cam_focus", 1, 8223, 910, 16350},
	{"skip_frames", 64},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_CCM_ACT_6

CUTSCENE_CCM_ACT_6 = {
	{"cam_pos", 1, 7064, 556, -5775},
	{"play_sound", 0x16, 0x0000},
	{"cam_focus", 1, 7248, -1614, -6916},
	{"skip_frames", 0},
	{"cam_focus", 64, 6107, -1614, -6290},
	{"skip_frames", 64},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_CCM_BEAST_CONTAINED

CUTSCENE_CCM_BEAST_CONTAINED = {
	{"cam_pos", 32, 6346, -884, -6341},
	{"cam_focus", 32, 5142, -1238, -7620},
	{"play_sound", 0x1b, 0x0000},
	{"skip_frames", 80},
	{"play_sound", 0x07, 0x0000},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_CREDITS_01

CUTSCENE_CREDITS_01 = {
	{"cam_pos", 1, -2811, 1325, -3893},
	{"cam_focus", 1, 2784, -2359, -8260},
	{"skip_frames", 0},
	{"cam_pos", 144, -2395, 1325, -514},
	{"cam_focus", 144, -1266, -2449, 6434},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_02

CUTSCENE_CREDITS_02 = {
	{"cam_pos", 1, -4819, 1, -2724},
	{"cam_focus", 1, -377, -885, -5761},
	{"skip_frames", 0},
	{"cam_pos", 144, -2263, -1563, 325},
	{"cam_focus", 144, 9003, -2656, 915},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_03

CUTSCENE_CREDITS_03 = {
	{"cam_pos", 1, 5062, 7292, -5973},
	{"cam_focus", 1, -3751, 4740, -7645},
	{"skip_frames", 0},
	{"cam_pos", 144, 3209, 7548, -8305},
	{"cam_focus", 144, -4690, 2761, 5781},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_04

CUTSCENE_CREDITS_04 = {
	{"cam_pos", 1, 8480, -548, -3604},
	{"cam_focus", 1, 8891, -625, -3444},
	{"skip_frames", 0},
	{"cam_pos", 144, 5277, 363, -3523},
	{"cam_focus", 144, 7310, -789, -5472},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_05

CUTSCENE_CREDITS_05 = {
	{"cam_pos", 1, -13596, 3773, 8436},
	{"cam_focus", 1, -6473, 1521, 14482},
	{"skip_frames", 0},
	{"cam_pos", 144, -14816, 2880, 4566},
	{"cam_focus", 144, -212, 5249, 13},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_06

CUTSCENE_CREDITS_06 = {
	{"cam_pos", 1, 3325, 5204, 570},
	{"cam_focus", 1, 150, 3301, 5038},
	{"skip_frames", 0},
	{"cam_pos", 144, -1180, 10601, -463},
	{"cam_focus", 144, 281, 8932, 4141},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_07

CUTSCENE_CREDITS_07 = {
	{"cam_pos", 1, -9717, 1670, -8597},
	{"cam_focus", 1, -11189, 1243, -3754},
	{"skip_frames", 0},
	{"cam_pos", 144, -5767, 3068, -6679},
	{"cam_focus", 144, 5426, 5825, 3131},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_08

CUTSCENE_CREDITS_08 = {
	{"cam_pos", 1, -2360, 1592, 1860},
	{"cam_focus", 1, 15, 1087, 8525},
	{"skip_frames", 0},
	{"cam_pos", 144, 6069, -78, -644},
	{"cam_focus", 144, -3452, -2175, -279},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_09

CUTSCENE_CREDITS_09 = {
	{"cam_pos", 1, -18822, 2068, 226},
	{"cam_focus", 1, -14968, -146, -7423},
	{"skip_frames", 0},
	{"cam_pos", 144, -11723, 2068, 6101},
	{"cam_focus", 144, 3586, -806, 3265},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_10

CUTSCENE_CREDITS_10 = {
	{"cam_pos", 1, -8442, 747, 1024},
	{"cam_focus", 1, -8221, 320, -2352},
	{"skip_frames", 0},
	{"cam_pos", 144, -7965, 1368, 8635},
	{"cam_focus", 144, -4002, 512, 5193},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_11

CUTSCENE_CREDITS_11 = {
	{"cam_pos", 1, -5448, 1040, 8001},
	{"cam_focus", 1, -5335, 453, 6086},
	{"skip_frames", 0},
	{"cam_pos", 64, 143, 2627, 5980},
	{"cam_focus", 144, -702, 1851, -769},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_12

CUTSCENE_CREDITS_12 = {
	{"cam_pos", 1, 2110, 2485, -230},
	{"cam_focus", 1, 3035, 2447, 71},
	{"skip_frames", 0},
	{"cam_pos", 144, -159, 2757, 186},
	{"cam_focus", 144, -234, 1653, 3436},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_13

CUTSCENE_CREDITS_13 = {
	{"cam_pos", 1, 3204, 437, 1842},
	{"cam_focus", 1, -2781, 126, 1230},
	{"skip_frames", 0},
	{"cam_pos", 144, 11103, 3766, 4297},
	{"cam_focus", 144, 11794, 5730, -11775},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_14

CUTSCENE_CREDITS_14 = {
	{"cam_pos", 1, 3113, 2214, 4511},
	{"cam_focus", 1, -1707, 427, 2916},
	{"skip_frames", 0},
	{"cam_pos", 144, -1335, 3417, 4624},
	{"cam_focus", 144, 2809, 1514, -5399},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_15

CUTSCENE_CREDITS_15 = {
	{"cam_pos", 1, 712, 469, -2391},
	{"cam_focus", 1, 989, -1771, 3111},
	{"skip_frames", 0},
	{"cam_pos", 144, 2061, -313, 1936},
	{"cam_focus", 144, -2192, 1875, -2316},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_16

CUTSCENE_CREDITS_16 = {
	{"cam_pos", 1, 6935, -7344, -3065},
	{"cam_focus", 1, 9572, -7708, -2730},
	{"skip_frames", 0},
	{"cam_pos", 144, 7440, -6510, -5318},
	{"cam_focus", 144, 5069, -5521, -1451},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_17

CUTSCENE_CREDITS_17 = {
	{"cam_pos", 1, -3729, -1719, -3049},
	{"cam_focus", 1, 2068, -2135, 220},
	{"skip_frames", 0},
	{"cam_pos", 144, -3256, -2240, -1397},
	{"cam_focus", 144, -1383, -2917, -6916},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_18

CUTSCENE_CREDITS_18 = {
	{"cam_pos", 1, 861, -52, -1415},
	{"cam_focus", 1, -778, -52, 2241},
	{"skip_frames", 0},
	{"cam_pos", 144, 2915, -36, 513},
	{"cam_focus", 144, -952, 3958, 259},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_19

CUTSCENE_CREDITS_19 = {
	{"cam_pos", 1, -3881, 2800, -14686},
	{"cam_focus", 1, 11230, -100, -5984},
	{"skip_frames", 0},
	{"cam_pos", 144, 7049, 2028, -8192},
	{"cam_focus", 144, -3857, 3334, -1090},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_20

CUTSCENE_CREDITS_20 = {
	{"cam_pos", 1, -4578, 9784, -1211},
	{"cam_focus", 1, 3902, 7024, -3564},
	{"skip_frames", 0},
	{"cam_pos", 144, -1717, 8066, -2718},
	{"cam_focus", 144, -2282, 4784, 7528},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_21

CUTSCENE_CREDITS_21 = {
	{"cam_pos", 1, 7069, 2552, 547},
	{"cam_focus", 1, 9595, 1771, -3242},
	{"skip_frames", 0},
	{"cam_pos", 144, 5286, 1406, 1222},
	{"cam_focus", 144, 709, 469, -1003},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_22

CUTSCENE_CREDITS_22 = {
	{"cam_pos", 1, 1740, 2969, -6317},
	{"cam_focus", 1, -6142, 1979, 767},
	{"skip_frames", 0},
	{"cam_pos", 144, -1180, 1667, -5606},
	{"cam_focus", 144, 6600, 208, 3964},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_CREDITS_23

CUTSCENE_CREDITS_23 = {
	{"cam_pos", 1, 3094, 885, -2931},
	{"cam_focus", 1, -208, 208, 13},
	{"skip_frames", 0},
	{"cam_pos", 144, 8641, 3385, -403},
	{"cam_focus", 144, -208, 208, 13},
	{"skip_frames", 143},
	{"cutscene_obj", dummy.model_0x00, 0, 0x00, dummy.anim_0x00000000},
}

-- CUTSCENE_DDD_ACT_1

CUTSCENE_DDD_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, 368, 469, -4920},
	{"cam_focus", 1, -825, -156, -9147},
	{"skip_frames", 0},
	{"cam_focus", 64, -3804, 521, -11782},
	{"cam_pos", 64, -1118, 625, -9925},
	{"skip_frames", 63},
	{"cam_focus", 112, -11554, -2, -8077},
	{"cam_pos", 112, -8482, 1613, -11336},
	{"skip_frames", 127},
	{"set_flags", CUTSCENE_FLAG_END, 1},
}

-- CUTSCENE_DDD_ACT_2

CUTSCENE_DDD_ACT_2 = {
	{"play_sound", 0x04, 0x0000},
	{"cam_focus", 1, -1035, 623, 1749},
	{"cam_pos", 1, 1189, 363, -1529},
	{"skip_frames", 0},
	{"cam_focus", 96, -1637, 2137, 2035},
	{"cam_pos", 112, -969, 2342, 1254},
	{"skip_frames", 95},
	{"cam_pos", 80, -1382, 2160, 2288},
	{"cam_focus", 80, -2960, 1873, 1929},
	{"skip_frames", 96},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_DDD_ACT_5

CUTSCENE_DDD_ACT_5 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -192, 145, -3481},
	{"cam_pos", 1, 742, 562, -3386},
	{"skip_frames", 0},
	{"cam_focus", 64, -1240, 1291, -3858},
	{"cam_pos", 64, -414, 666, -3411},
	{"skip_frames", 63},
	{"cam_focus", 96, -1705, 1916, -4248},
	{"cam_pos", 96, -1447, 1239, -4279},
	{"skip_frames", 136},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_DDD_ACT_6

CUTSCENE_DDD_ACT_6 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -192, 145, -3481},
	{"cam_pos", 1, 742, 562, -3386},
	{"skip_frames", 0},
	{"cam_focus", 64, -1240, 1291, -3858},
	{"cam_pos", 64, -414, 666, -3411},
	{"skip_frames", 63},
	{"cam_focus", 96, -1705, 1916, -4248},
	{"cam_pos", 96, -1447, 1239, -4279},
	{"skip_frames", 136},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_DDD_SPIDER_BOSS

CUTSCENE_DDD_SPIDER_BOSS = {
	{"play_sound", 0x3b, 0x0000},
	{"cam_focus", 1, 4128, -192, -960},
	{"cam_pos", 64, 3254, 508, 985},
	{"skip_frames", 32},
	{"play_sound", 0x00, 0x5004},
	{"skip_frames", 52},
	{"play_sound", 0x00, 0x5004},
	{"skip_frames", 32},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_DDD_SPIDER_DEFEATED

CUTSCENE_DDD_SPIDER_DEFEATED = {
	{"cam_focus", 1, 4128, -192, -960},
	{"cam_pos", 1, 5391, 343, -1063},
	{"skip_frames", 0},
	{"cam_pos", 165, 3615, 149, 476},
	{"skip_frames", 164},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_ENDING_DIALOG

CUTSCENE_ENDING_DIALOG = {
	{"cutscene_obj", dummy.model_0x22, 0, 0x00, dummy.anim_0x0801da4c},
	{"obj_warp", 0, 4253, -472, 6037},
	{"obj_rot", 0, -128, 0},
	{"cutscene_obj", dummy.model_0x23, 2, 0x00, dummy.anim_0x0801da4c},
	{"obj_warp", 2, 4461, -472, 6037},
	{"obj_rot", 2, -128, 0},
	{"cutscene_obj", dummy.model_0x24, 4, 0x00, dummy.anim_0x0801da4c},
	{"obj_warp", 4, 4659, -472, 6037},
	{"obj_rot", 4, -128, 0},
	{"obj_anim", 0, 0},
	{"obj_anim", 2, 0},
	{"obj_anim", 4, 0},
	{"cam_focus", 1, 4264, -390, 4642},
	{"cam_pos", 1, 2378, 885, 396},
	{"skip_frames", 0},
	{"cam_focus", 80, 4208, -496, 5625},
	{"cam_pos", 80, 5167, 71, 4699},
	{"skip_frames", 79},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_ENDING_THE_END

CUTSCENE_ENDING_THE_END = {
	{"cam_focus", 160, 4264, -390, 4642},
	{"cam_pos", 160, 2378, 885, 396},
	{"skip_frames", 159},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_HMC_ACT_1

CUTSCENE_HMC_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, 2867, 408, 6172},
	{"cam_focus", 1, 9913, -1654, -4973},
	{"skip_frames", 0},
	{"cam_pos", 112, 7209, -1052, -4097},
	{"skip_frames", 111},
	{"cam_pos", 50, 9066, -1406, -4912},
	{"skip_frames", 65},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_HMC_ACT_2

CUTSCENE_HMC_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, -6063, 825, -10882},
	{"cam_focus", 1, -7254, 282, -13274},
	{"skip_frames", 0},
	{"cam_focus", 64, -4701, 460, -13803},
	{"cam_pos", 64, -6620, 460, -12705},
	{"skip_frames", 63},
	{"cam_focus", 64, -3606, 2704, -14895},
	{"cam_pos", 104, -4000, 3222, -11490},
	{"skip_frames", 128},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_HMC_ACT_3

CUTSCENE_HMC_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, 2867, 408, 6172},
	{"cam_focus", 1, 9913, -1654, -4973},
	{"skip_frames", 0},
	{"cam_pos", 112, 7209, -1052, -4097},
	{"skip_frames", 111},
	{"cam_pos", 50, 9066, -1406, -4912},
	{"skip_frames", 65},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_HMC_ACT_4

CUTSCENE_HMC_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -2726, -986, 10064},
	{"cam_pos", 1, -3599, -734, 8979},
	{"skip_frames", 8},
	{"cam_pos", 32, -4485, 6335, -1393},
	{"cam_focus", 32, -3125, -416, 11108},
	{"skip_frames", 31},
	{"cam_focus", 32, -19510, 2533, 7432},
	{"skip_frames", 31},
	{"cam_focus", 16, -26422, 3653, -1967},
	{"skip_frames", 15},
	{"cam_focus", 16, -22645, 3653, -15878},
	{"cam_focus", 16, -5000, 2309, -22053},
	{"skip_frames", 15},
	{"cam_focus", 16, 5509, -492, -16593},
	{"skip_frames", 15},
	{"cam_focus", 16, 6218, -492, -3701},
	{"skip_frames", 15},
	{"cam_focus", 16, 924, 1219, 2373},
	{"skip_frames", 15},
	{"cam_focus", 16, -2085, -350, 10889},
	{"skip_frames", 40},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_HMC_ACT_6

CUTSCENE_HMC_ACT_6 = {
	{"play_sound", 0x03, 0x0000},
	{"cutscene_obj", E_MODEL_CHAIN_CHOMP, 0, 0x00, gObjectAnimations.chain_chomp_seg6_anims_06025178},
	{"obj_warp", 0, 2085, -891, -1199},
	{"obj_anim", 0, 0},
	{"obj_scale", 0, 200},
	{"cam_pos", 1, 1109, -390, 304},
	{"cam_focus", 1, 2039, -1159, -1200},
	{"skip_frames", 0},
	{"cam_pos", 64, 303, 718, -1205},
	{"skip_frames", 63},
	{"cam_pos", 104, 1346, 3481, 1362},
	{"cam_focus", 64, 2430, 1497, -7353},
	{"skip_frames", 63},
	{"cam_focus", 64, -4019, 2430, -9823},
	{"skip_frames", 63},
	{"play_sound", 0x00, 0x0000},
	{"cam_focus", 64, -10787, 2430, -6536},
	{"skip_frames", 79},
	{"obj_params", 0, 0x00, 1},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_HMC_ROLLERCOASTER_RIDE

CUTSCENE_HMC_ROLLERCOASTER_RIDE = {
	{"cam_pos", 40, -4445, -321, 10187},
	{"skip_frames", 24},
	{"cam_focus", 32, -2010, -288, 10916},
	{"skip_frames", 48},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_INTRO

CUTSCENE_INTRO = {
	{"play_sound", 0x08, 0x0000},
	{"spawn_obj", E_MODEL_TOAD, 4226, -379, 4468, id_bhvToadMessage},
	{"skip_frames", 1},
	{"cam_focus", 1, 4155, -390, 4667},
	{"cam_pos", 1, 6255, 443, 3084},
	{"skip_frames", 24},
	{"cam_pos", 64, 5187, 235, 6361},
	{"skip_frames", 64},
	{"cam_pos", 64, 2544, 235, 5770},
	{"skip_frames", 64},
	{"cam_pos", 96, 3292, 235, 3343},
	{"skip_frames", 96},
	{"cam_focus", 160, 12323, 21936, 5064},
	{"spawn_obj", E_MODEL_INTRO_METEOR, 12323, 26032, 5064, bhvIntroMeteor1},
	{"spawn_obj", E_MODEL_INTRO_METEOR, 12323, 26032, 5064, bhvIntroMeteor2},
	{"spawn_obj", E_MODEL_INTRO_METEOR, 12323, 26032, 5064, bhvIntroMeteor3},
	{"skip_frames", 64},
	{"cam_focus", 32, 4686, -527, 4911},
	{"cam_pos", 32, 2270, 1335, 3895},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 16},
	{"spawn_obj", E_MODEL_NONE, 4332, -527, 3419, id_bhvMistCircParticleSpawner},
	{"spawn_obj", E_MODEL_NONE, 4271, -527, 5579, id_bhvMistCircParticleSpawner},
	{"play_sound", 0x00, 0x302e},
	{"cutscene_obj", E_MODEL_SPIKY_PIRANHA_PLANT, 0, 0x00, 0},
	{"cutscene_obj", E_MODEL_SPIKY_PIRANHA_PLANT, 2, 0x00, 0},
	{"obj_rot", 0, -128, 0},
	{"obj_warp", 0, 4271, -1295, 5579},
	{"obj_warp", 2, 4332, -1295, 3419},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -1247, 0},
	{"obj_warp", 2, 0, -1247, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -1199, 0},
	{"obj_warp", 2, 0, -1199, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -1151, 0},
	{"obj_warp", 2, 0, -1151, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -1103, 0},
	{"obj_warp", 2, 0, -1103, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -1055, 0},
	{"obj_warp", 2, 0, -1055, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -1007, 0},
	{"obj_warp", 2, 0, -1007, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -959, 0},
	{"obj_warp", 2, 0, -959, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -911, 0},
	{"obj_warp", 2, 0, -911, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -863, 0},
	{"obj_warp", 2, 0, -863, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -815, 0},
	{"obj_warp", 2, 0, -815, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -767, 0},
	{"obj_warp", 2, 0, -767, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -719, 0},
	{"obj_warp", 2, 0, -719, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -671, 0},
	{"obj_warp", 2, 0, -671, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -623, 0},
	{"obj_warp", 2, 0, -623, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -575, 0},
	{"obj_warp", 2, 0, -575, 0},
	{"skip_frames", 0},
	{"obj_warp", 0, 0, -527, 0},
	{"obj_warp", 2, 0, -527, 0},
	{"skip_frames", 16},
	{"obj_anim", 0, "anim_spiky_piranha_plant_idle"},
	{"obj_anim", 2, "anim_spiky_piranha_plant_idle"},
	{"skip_frames", 48},
	{"obj_params", 0, 0x00, 1},
	{"obj_params", 2, 0x00, 1},
	{"spawn_obj", E_MODEL_NONE, 0, 0, 0, bhvIntroSpawner},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_JRB_ACT_1

CUTSCENE_JRB_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -4252, 3453, -7826},
	{"cam_pos", 1, -6149, 4515, -6788},
	{"skip_frames", 0},
	{"cam_pos", 65, -3188, 4355, -4074},
	{"skip_frames", 64},
	{"cam_pos", 65, -573, 3311, -6470},
	{"cam_focus", 65, -4252, 2677, -7826},
	{"skip_frames", 64},
	{"cam_pos", 32, -3051, 2709, -7927},
	{"skip_frames", 66},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_JRB_ACT_2

CUTSCENE_JRB_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 3967, 549, 5218},
	{"cam_pos", 1, 4513, 2709, 644},
	{"skip_frames", 0},
	{"cam_focus", 65, 1229, 549, 6026},
	{"cam_pos", 65, -1490, 1540, 4485},
	{"skip_frames", 64},
	{"cam_focus", 65, 3115, -89, 6869},
	{"cam_pos", 65, 1449, 1044, 7641},
	{"skip_frames", 64},
	{"cam_focus", 24, 4612, -158, 6632},
	{"cam_pos", 24, 3068, 161, 7021},
	{"skip_frames", 66},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_JRB_ACT_3

CUTSCENE_JRB_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -5458, 1117, 2278},
	{"cam_pos", 1, -7046, 1825, -921},
	{"skip_frames", 1},
	{"cam_focus", 172, -2197, 1117, 5874},
	{"cam_pos", 172, 1666, 3738, 1210},
	{"skip_frames", 196},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_JRB_ACT_4

CUTSCENE_JRB_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 9367, -187, 2195},
	{"cam_pos", 1, 6578, 1655, 4151},
	{"skip_frames", 1},
	{"cam_focus", 172, 9367, -187, -1901},
	{"cam_pos", 172, 6578, 1655, 55},
	{"skip_frames", 196},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_JRB_ACT_5

CUTSCENE_JRB_ACT_5 = {
	{"play_sound", 0x04, 0x0000},
	{"cam_focus", 1, 443, 285, 5734},
	{"cam_pos", 1, -750, 1064, 3901},
	{"skip_frames", 1},
	{"cam_pos", 80, 2934, 1064, 4247},
	{"skip_frames", 80},
	{"cam_pos", 1, -554, 2311, -8692},
	{"cam_focus", 1, -978, 2181, -9876},
	{"skip_frames", 114},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_JRB_ACT_6

CUTSCENE_JRB_ACT_6 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -4038, 5355, -7755},
	{"cam_pos", 1, -2984, 5780, -7028},
	{"skip_frames", 1},
	{"cam_pos", 80, -3308, 5957, -8858},
	{"skip_frames", 80},
	{"cam_pos", 96, -4562, 6241, -8522},
	{"cam_focus", 96, -3687, 2628, 7038},
	{"skip_frames", 114},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_LLL_ACT_1

CUTSCENE_LLL_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -7616, -365, 756},
	{"cam_pos", 1, -9135, 2113, 11572},
	{"skip_frames", 0},
	{"cam_pos", 128, 3747, 2083, -7819},
	{"skip_frames", 79},
	{"cam_focus", 48, 5298, 833, -5488},
	{"skip_frames", 47},
	{"cam_focus", 48, 5794, 729, -3729},
	{"cam_pos", 48, 6108, 1034, -4859},
	{"skip_frames", 64},
	{"play_sound", 0x31, 0x0000},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_LLL_ACT_3

CUTSCENE_LLL_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -3876, 822, 4765},
	{"cam_pos", 1, -1390, 1416, 3064},
	{"skip_frames", 0},
	{"cam_pos", 88, -6387, 568, 4631},
	{"cam_focus", 88, -6109, 144, 6246},
	{"skip_frames", 87},
	{"cam_pos", 88, -7324, 400, 6220},
	{"cam_focus", 88, -6104, 186, 6720},
	{"skip_frames", 103},
	{"play_sound", 0x31, 0x0000},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_LLL_CRAFT_STAR

CUTSCENE_LLL_CRAFT_STAR = {
	{"cam_pos", 48, -9068, 191, -1410},
	{"cam_focus", 80, -9110, -150, -2254},
	{"skip_frames", 64},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x4003},
	{"skip_frames", 16},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_LLL_WITCH_FREED

CUTSCENE_LLL_WITCH_FREED = {
	{"cam_focus", 67, -1760, 312, -2336},
	{"cam_pos", 24, -4522, 64, -4057},
	{"skip_frames", 82},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_MINIGAME_CAKE

CUTSCENE_MINIGAME_CAKE = {
	{"play_sound", 0x0f, 0x0000},
	{"cam_focus", 1, -8827, -232, -66},
	{"cam_pos", 1, -7955, 205, -8},
	{"skip_frames", 0},
	{"cam_pos", 48, -8391, 496, 836},
	{"skip_frames", 60},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_MINIGAME_CAKE_EATEN

CUTSCENE_MINIGAME_CAKE_EATEN = {
	{"cutscene_obj", E_MODEL_GOOMBA, 1, 0x80, gObjectAnimations.goomba_seg8_anims_0801DA4C},
	{"cutscene_obj", E_MODEL_GOOMBA, 3, 0x80, gObjectAnimations.goomba_seg8_anims_0801DA4C},
	{"cutscene_obj", E_MODEL_GOOMBA, 5, 0x80, gObjectAnimations.goomba_seg8_anims_0801DA4C},
	{"obj_anim", 1, 0},
	{"obj_anim", 3, 0},
	{"obj_anim", 5, 0},
	{"obj_warp", 1, -8820, -280, -150},
	{"obj_warp", 3, -8737, -280, -106},
	{"obj_warp", 5, -8914, -280, -83},
	{"obj_rot", 5, 52, 0},
	{"obj_rot", 3, -36, 0},
	{"cam_focus", 1, -8823, -312, -72},
	{"cam_pos", 1, -8907, -172, 314},
	{"skip_frames", 0},
	{"cam_focus", 97, -8823, -312, -72},
	{"skip_frames", 47},
	{"play_sound", 0x00, 0x2420},
	{"skip_frames", 48},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_MINIGAME_FLOWER

CUTSCENE_MINIGAME_FLOWER = {
	{"play_sound", 0x0e, 0x0000},
	{"cam_focus", 1, -8865, 505, 9968},
	{"cam_pos", 1, -10621, 2074, 10841},
	{"skip_frames", 0},
	{"cam_pos", 48, -8396, 2074, 12046},
	{"skip_frames", 60},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_MINIGAME_HEXAGON

CUTSCENE_MINIGAME_HEXAGON = {
	{"play_sound", 0x0b, 0x0000},
	{"cam_focus", 1, 6825, 700, 3703},
	{"cam_pos", 1, 5867, 1649, 4817},
	{"skip_frames", 0},
	{"cam_pos", 48, 4815, 2118, 3543},
	{"skip_frames", 59},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_MINIGAME_LOG

CUTSCENE_MINIGAME_LOG = {
	{"play_sound", 0x0b, 0x0000},
	{"cam_focus", 1, -16477, 250, -8032},
	{"cam_pos", 1, -14535, 1182, -8070},
	{"skip_frames", 0},
	{"cam_pos", 128, -8477, 1182, -8070},
	{"cam_focus", 128, 1697, 250, -8032},
	{"skip_frames", 139},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_MINIGAME_WHACKAMOLE

CUTSCENE_MINIGAME_WHACKAMOLE = {
	{"play_sound", 0x0e, 0x0000},
	{"cam_focus", 1, 11285, 1034, -10613},
	{"cam_pos", 1, 11250, 1884, -12171},
	{"skip_frames", 0},
	{"cam_pos", 32, 13086, 1884, -10588},
	{"skip_frames", 31},
	{"cam_pos", 32, 11250, 1884, -9134},
	{"skip_frames", 31},
	{"cam_pos", 32, 9596, 1884, -10588},
	{"skip_frames", 31},
	{"cam_pos", 32, 11250, 1884, -12171},
	{"skip_frames", 42},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_OW1_BOAT_FIXED

CUTSCENE_OW1_BOAT_FIXED = {
	{"cam_focus", 1, 336, -1081, -1593},
	{"cam_pos", 1, 1792, -352, -3284},
	{"skip_frames", 48},
	{"cam_pos", 48, 4261, 693, -4052},
	{"skip_frames", 63},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW1_BOAT_SAIL

CUTSCENE_OW1_BOAT_SAIL = {
	{"cam_pos", 48, 1024, 256, -3624},
	{"cam_focus", 80, -3007, -894, -1524},
	{"skip_frames", 80},
	{"cam_focus", 88, -9934, 80, -1163},
	{"skip_frames", 23},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW1_GATE_OPEN

CUTSCENE_OW1_GATE_OPEN = {
	{"cam_pos", 1, 6867, 0, 4562},
	{"cam_focus", 1, 8161, -519, 5852},
	{"cutscene_obj", MODEL_CG_20_GATE, 0, 0x00, 0},
	{"cutscene_obj", MODEL_CG_20_GATE, 2, 0x00, 0},
	{"obj_warp", 0, 8063, -707, 4804},
	{"obj_warp", 2, 7527, -707, 5957},
	{"play_sound", 0x00, 0x3006},
	{"obj_speed", 2, 0, -16},
	{"obj_rot", 2, -18, 0},
	{"obj_rot", 0, 110, 0},
	{"obj_speed", 0, 0, 16},
	{"skip_frames", 64},
	{"obj_params", 0, 0x00, 1},
	{"obj_params", 2, 0x00, 1},
	{"cam_pos", 32, 5347, -162, 3006},
	{"cam_focus", 56, 7076, -579, 749},
	{"skip_frames", 84},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW1_GOOMBA_BROS_RUN_AWAY

CUTSCENE_OW1_GOOMBA_BROS_RUN_AWAY = {
	{"cam_pos", 64, 3687, 102, -100},
	{"cam_focus", 64, 7034, -627, 4825},
	{"skip_frames", 160},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW1_MARIO_ASCEND

CUTSCENE_OW1_MARIO_ASCEND = {
	{"cam_pos", 88, 7285, -422, -1024},
	{"cam_focus", 88, 7843, 1098, -153},
	{"skip_frames", 121},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW1_MOON

CUTSCENE_OW1_MOON = {
	{"cam_focus", 1, 4779, -500, 3346},
	{"cam_pos", 1, 3304, 879, 183},
	{"skip_frames", 0},
	{"cam_pos", 96, 4796, -527, 3597},
	{"skip_frames", 111},
	{"cam_focus", 112, 3047, 12536, 1},
	{"skip_frames", 131},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW1_ROCKET_LAUNCH

CUTSCENE_OW1_ROCKET_LAUNCH = {
	{"cam_focus", 16, 3830, 402, -5575},
	{"cam_pos", 32, 4704, 720, -5076},
	{"skip_frames", 15},
	{"cam_focus", 80, 3830, 8594, -5575},
	{"skip_frames", 15},
	{"cam_pos", 64, 5216, 10960, -5588},
	{"skip_frames", 80},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW1_ROCKET_OPEN

CUTSCENE_OW1_ROCKET_OPEN = {
	{"cam_pos", 1, 4336, -91, -4373},
	{"cam_focus", 1, 3981, 86, -5444},
	{"skip_frames", 0},
	{"cam_pos", 64, 4973, 219, -4629},
	{"cam_focus", 64, 3370, 971, -5521},
	{"skip_frames", 79},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW2_ROCKET_LAUNCH

CUTSCENE_OW2_ROCKET_LAUNCH = {
	{"cam_pos", 1, -183, 1544, 1490},
	{"skip_frames", 1},
	{"cam_pos", 160, -183, 0, 1490},
	{"cam_focus", 160, -11641, 19788, -15682},
	{"skip_frames", 160},
	{"cam_pos", 64, -183, 0, 1490},
	{"skip_frames", 79},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_OW3_ENTER_THE_BEAST

CUTSCENE_OW3_ENTER_THE_BEAST = {
	{"cam_focus", 32, 2239, 1794, 3916},
	{"cam_pos", 48, -1168, 2034, 846},
	{"skip_frames", 95},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_RASHAY_BUTTON_BLUE

CUTSCENE_RASHAY_BUTTON_BLUE = {
	{"cam_focus", 16, -1, 384, -1},
	{"cam_pos", 16, 999, 999, 999},
	{"skip_frames", 48},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_RASHAY_BUTTON_RED

CUTSCENE_RASHAY_BUTTON_RED = {
	{"cam_focus", 16, -1, 384, -1},
	{"cam_pos", 16, -1000, 999, 999},
	{"skip_frames", 48},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_RASHAY_BUTTON_WHITE

CUTSCENE_RASHAY_BUTTON_WHITE = {
	{"cam_focus", 16, -1, 384, -1},
	{"cam_pos", 16, -1000, 999, -1000},
	{"skip_frames", 48},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_RASHAY_BUTTON_YELLOW

CUTSCENE_RASHAY_BUTTON_YELLOW = {
	{"cam_focus", 16, -1, 384, -1},
	{"cam_pos", 16, 999, 999, -1000},
	{"skip_frames", 48},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_RASHAY_DEFEATED

CUTSCENE_RASHAY_DEFEATED = {
	{"play_sound", 0x1f, 0x0000},
	{"cam_pos", 48, 612, 752, 4608},
	{"cam_focus", 48, 1, 768, 1},
	{"skip_frames", 47},
	{"cam_focus", 48, -1, 4096, -1},
	{"skip_frames", 207},
	{"cam_focus", 64, -1, 16, -1},
	{"skip_frames", 127},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_RASHAY_ELEVATOR_RIDE

CUTSCENE_RASHAY_ELEVATOR_RIDE = {
	{"cam_focus", 16, -1, 384, -1},
	{"cam_pos", 16, -1000, 999, -1000},
	{"skip_frames", 16},
	{"cam_focus", 48, -1, -2048, -1},
	{"skip_frames", 60},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_RASHAY_TRANSFORM

CUTSCENE_RASHAY_TRANSFORM = {
	{"cam_focus", 16, -2868, 365, 170},
	{"cam_pos", 16, -3591, 365, 2994},
	{"skip_frames", 15},
	{"play_sound", 0x00, 0x507f},
	{"cam_focus", 112, -3159, 2345, 2035},
	{"cam_pos", 112, -1765, 994, 4284},
	{"skip_frames", 18},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 16},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 14},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 12},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 10},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 8},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 6},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 4},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 2},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 2},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 1},
	{"play_sound", 0x00, 0x507f},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 0},
	{"skip_frames", 69},
	{"cam_focus", 112, 1584, 968, -5024},
	{"skip_frames", 160},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SL_ACT_1

CUTSCENE_SL_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, 5223, 768, 6322},
	{"cam_focus", 1, 5306, -2656, -2362},
	{"skip_frames", 0},
	{"cam_focus", 80, 389, -1926, -2084},
	{"cam_pos", 80, 3974, -989, -1259},
	{"skip_frames", 79},
	{"cam_focus", 32, -3406, -1926, 3000},
	{"cam_pos", 80, -2352, -1770, 2985},
	{"skip_frames", 96},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SL_ACT_2

CUTSCENE_SL_ACT_2 = {
	{"play_sound", 0x04, 0x0000},
	{"cam_focus", 1, 11303, -6072, 14695},
	{"cam_pos", 1, 4803, -5551, 17585},
	{"skip_frames", 0},
	{"cam_pos", 178, -32, -4796, 13432},
	{"cam_focus", 178, 3733, -3250, 12115},
	{"skip_frames", 136},
	{"cam_focus", 255, 3733, -3250, 12115},
	{"skip_frames", 40},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SL_ACT_3

CUTSCENE_SL_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 12797, 3511, -12588},
	{"cam_pos", 1, 6710, 2574, -14112},
	{"skip_frames", 0},
	{"cam_pos", 72, 9531, 6115, -7023},
	{"cam_focus", 160, 12797, 10126, -12588},
	{"skip_frames", 71},
	{"cam_pos", 104, 3033, 10438, -9393},
	{"skip_frames", 120},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SL_ACT_4

CUTSCENE_SL_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 9791, -1701, 2293},
	{"cam_pos", 1, 10086, -1073, 4117},
	{"skip_frames", 0},
	{"cam_pos", 176, 7485, 683, 7123},
	{"cam_focus", 176, 8937, -1580, 3702},
	{"skip_frames", 192},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SL_ACT_6

CUTSCENE_SL_ACT_6 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 60, 659, -2966},
	{"cam_pos", 1, -409, 815, -1669},
	{"skip_frames", 0},
	{"cam_pos", 32, 636, 815, -1609},
	{"skip_frames", 31},
	{"cam_pos", 64, -988, 1232, 1134},
	{"cam_focus", 48, -2868, 189, 784},
	{"skip_frames", 63},
	{"cam_pos", 88, -2690, 1232, 1788},
	{"skip_frames", 104},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SL_KURMA_DEFEATED

CUTSCENE_SL_KURMA_DEFEATED = {
	{"cam_focus", 1, -7116, -3776, 19514},
	{"cam_pos", 1, -2058, -1511, 6876},
	{"cutscene_obj", dummy.model_0x17, 0, 0x40, dummy.anim_0x0e0bf1e0},
	{"obj_warp", 0, -7116, -3776, 19514},
	{"obj_anim", 0, 3},
	{"skip_frames", 0},
	{"obj_speed", 0, 40, 0},
	{"obj_rot", 0, 64, 0},
	{"play_sound", 0x00, 0x5070},
	{"cam_focus", 112, -1024, -5056, 19514},
	{"skip_frames", 174},
	{"play_sound", 0x2b, 0x0000},
	{"set_flags", CUTSCENE_FLAG_END | CUTSCENE_FLAG_KEEP_MUSIC, 0},
}

-- CUTSCENE_SL_PASSPHRASE_DOOR_OPEN

CUTSCENE_SL_PASSPHRASE_DOOR_OPEN = {
	{"cam_focus", 37, 50, 561, -2832},
	{"skip_frames", 128},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SSL_ACT_1

CUTSCENE_SSL_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -1473, 729, 2431},
	{"cam_pos", 1, -5989, 2031, -2595},
	{"skip_frames", 0},
	{"cam_focus", 120, 4910, 365, 1226},
	{"cam_pos", 56, -6035, 4844, -7266},
	{"skip_frames", 55},
	{"cam_pos", 56, 3573, 4844, -11455},
	{"skip_frames", 55},
	{"cam_pos", 40, 5330, 885, -2175},
	{"skip_frames", 39},
	{"cam_pos", 32, 4147, 521, 1292},
	{"cam_focus", 32, 7322, 1823, 3206},
	{"skip_frames", 48},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SSL_ACT_2

CUTSCENE_SSL_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, -10314, 2917, 11810},
	{"cam_focus", 1, -6947, 951, 17214},
	{"skip_frames", 0},
	{"cam_focus", 128, -7139, 641, 20986},
	{"cam_pos", 160, -8683, 742, 19983},
	{"skip_frames", 192},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SSL_ACT_3

CUTSCENE_SSL_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, -1750, 2126, 2405},
	{"cam_focus", 1, -3074, 1967, 5523},
	{"skip_frames", 0},
	{"cam_focus", 64, -5210, 1967, 12162},
	{"cam_pos", 111, -10164, 3984, 11139},
	{"skip_frames", 112},
	{"cam_pos", 48, -7195, 3984, 13400},
	{"skip_frames", 76},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_SSL_ACT_4

CUTSCENE_SSL_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, -1475, 2031, -9006},
	{"cam_focus", 1, -1697, 1799, -10243},
	{"skip_frames", 36},
	{"cam_pos", 1, -1675, 2560, -4257},
	{"cam_focus", 1, -1712, 2083, -2639},
	{"skip_frames", 48},
	{"cam_pos", 1, 4856, 625, -15570},
	{"cam_focus", 1, 5089, 120, -13892},
	{"skip_frames", 36},
	{"cam_pos", 1, 6320, 512, -2025},
	{"cam_focus", 1, 8973, 329, -3424},
	{"skip_frames", 52},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_THI_ACT_1

CUTSCENE_THI_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 188, 35, -5692},
	{"cam_pos", 1, 3098, 1523, -5581},
	{"skip_frames", 0},
	{"cam_focus", 88, -798, 291, -12639},
	{"cam_pos", 88, 4118, 1983, -8842},
	{"skip_frames", 87},
	{"cam_focus", 88, 4689, 1735, -17379},
	{"cam_pos", 88, 2959, 3329, -11601},
	{"skip_frames", 104},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_THI_ACT_2

CUTSCENE_THI_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -3497, 3177, -1262},
	{"cam_pos", 1, -784, 5030, -4312},
	{"skip_frames", 0},
	{"cam_focus", 88, -6933, 6533, -1336},
	{"cam_pos", 88, -292, 9788, -2868},
	{"skip_frames", 87},
	{"cam_focus", 88, -6567, 8786, 4535},
	{"cam_pos", 88, -803, 14145, -3958},
	{"skip_frames", 103},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_THI_ACT_3

CUTSCENE_THI_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 4887, 22, -6201},
	{"cam_pos", 1, 3410, 1875, -1996},
	{"skip_frames", 71},
	{"cam_focus", 1, 11655, 623, -10435},
	{"cam_pos", 1, 9765, 2075, -7935},
	{"skip_frames", 0},
	{"cam_pos", 103, 12845, 2075, -7381},
	{"skip_frames", 119},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_THI_ACT_4

CUTSCENE_THI_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 13774, 1639, -8186},
	{"cam_pos", 1, 13782, 1829, -9041},
	{"skip_frames", 16},
	{"cam_focus", 168, 13475, 3239, -3297},
	{"cam_pos", 168, 13109, 4926, -9189},
	{"skip_frames", 180},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_THI_ACT_6

CUTSCENE_THI_ACT_6 = {
	{"play_sound", 0x04, 0x0000},
	{"cam_focus", 1, 10069, 1342, -1970},
	{"cam_pos", 1, 9075, 1787, -3218},
	{"skip_frames", 0},
	{"cam_pos", 184, 12830, 2121, -9546},
	{"cam_focus", 184, 11937, 1302, -1720},
	{"skip_frames", 196},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_THI_VIRUS_JUMP_OFF

CUTSCENE_THI_VIRUS_JUMP_OFF = {
	{"cam_focus", 32, 10139, 1253, -2141},
	{"cam_pos", 24, 10134, -104, -3779},
	{"skip_frames", 72},
	{"cam_focus", 64, 11321, -104, -3392},
	{"cam_pos", 64, 10120, 228, -3851},
	{"skip_frames", 64},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_TTC_ACT_1

CUTSCENE_TTC_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -815, 7039, -780},
	{"cam_pos", 1, -79, 7364, -1160},
	{"skip_frames", 8},
	{"cam_focus", 64, -2830, 7892, 2517},
	{"cam_pos", 80, -4764, 8257, 1578},
	{"skip_frames", 79},
	{"cam_focus", 80, 4221, 10450, 7265},
	{"cam_pos", 56, -1358, 11140, 4352},
	{"skip_frames", 39},
	{"cam_pos", 40, 2542, 11140, 6941},
	{"skip_frames", 55},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_TTC_ACT_2

CUTSCENE_TTC_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -2662, 9638, -5450},
	{"cam_pos", 1, -247, 10328, -5476},
	{"skip_frames", 8},
	{"cam_focus", 80, -10233, 10328, -4516},
	{"cam_pos", 48, -3534, 11993, -4882},
	{"skip_frames", 47},
	{"cam_pos", 32, -10233, 11993, -4516},
	{"skip_frames", 31},
	{"cam_focus", 80, -10233, 256, -4516},
	{"skip_frames", 96},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_TTC_ACT_3

CUTSCENE_TTC_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 126, 7430, -4361},
	{"cam_pos", 1, 824, 7464, -4173},
	{"skip_frames", 44},
	{"cam_focus", 1, 2783, 7464, -6720},
	{"cam_pos", 1, 3233, 7593, -7135},
	{"skip_frames", 44},
	{"cam_focus", 1, 6479, 8091, -5834},
	{"cam_pos", 1, 6138, 8256, -5246},
	{"skip_frames", 44},
	{"cam_focus", 1, 2275, 6636, 11066},
	{"cam_pos", 1, 3105, 6746, 12243},
	{"skip_frames", 60},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_TTC_ACT_6

CUTSCENE_TTC_ACT_6 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -38, 7080, -7984},
	{"cam_pos", 1, 685, 7415, -7556},
	{"skip_frames", 4},
	{"cam_pos", 48, 650, 7415, -8345},
	{"skip_frames", 47},
	{"cam_pos", 48, 9, 7415, -8785},
	{"skip_frames", 47},
	{"cam_pos", 32, -1072, 7415, -8585},
	{"skip_frames", 31},
	{"cam_focus", 48, -55, 8050, -7987},
	{"cam_pos", 32, -1918, 7553, -8752},
	{"skip_frames", 56},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_TTM_ACT_1

CUTSCENE_TTM_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_pos", 1, -4354, 260, -1428},
	{"cam_focus", 1, -3954, -52, -784},
	{"skip_frames", 0},
	{"cam_focus", 48, -4, -52, 52},
	{"cam_pos", 48, -154, 469, 2242},
	{"skip_frames", 47},
	{"cam_pos", 48, -28, 1927, 2470},
	{"cam_focus", 72, -48, 2760, -5},
	{"skip_frames", 47},
	{"cam_pos", 24, 3553, 3906, 2815},
	{"skip_frames", 23},
	{"cam_focus", 64, -137, 6510, -123},
	{"skip_frames", 72},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_UNUSED_LAVA_RISE

CUTSCENE_UNUSED_LAVA_RISE = {
	{"skip_frames", 32},
	{"cam_pos", 32, 451, -2489, 9351},
	{"cam_focus", 32, -677, -3644, 10355},
	{"skip_frames", 56},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WDW_ACT_1

CUTSCENE_WDW_ACT_1 = {
	{"play_sound", 0x04, 0x0000},
	{"cam_focus", 1, 4312, -1833, 641},
	{"cam_pos", 1, 2724, -1639, 1589},
	{"skip_frames", 0},
	{"cam_pos", 144, 3036, -1703, 162},
	{"skip_frames", 179},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WDW_ACT_2

CUTSCENE_WDW_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -943, -2641, 4478},
	{"cam_pos", 1, -1502, -1689, 2606},
	{"skip_frames", 0},
	{"cam_pos", 64, -385, -2340, 3470},
	{"skip_frames", 63},
	{"cam_pos", 48, -1216, -2490, 5154},
	{"cam_focus", 48, -2230, -2645, 6838},
	{"skip_frames", 47},
	{"cam_focus", 48, -2487, -2511, 7032},
	{"cam_pos", 48, -1755, -2626, 6493},
	{"skip_frames", 72},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WDW_ACT_3

CUTSCENE_WDW_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -2593, -3759, -409},
	{"cam_pos", 1, -2953, -3425, -1364},
	{"skip_frames", 0},
	{"cam_pos", 72, -2239, -3561, -973},
	{"skip_frames", 87},
	{"cam_focus", 1, -1859, 669, -9199},
	{"cam_pos", 1, -2655, 269, -10185},
	{"skip_frames", 0},
	{"cam_pos", 72, -1728, 569, -10758},
	{"skip_frames", 87},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WDW_ACT_4

CUTSCENE_WDW_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -943, -2641, 4478},
	{"cam_pos", 1, -1502, -1689, 2606},
	{"skip_frames", 0},
	{"cam_pos", 64, -385, -2340, 3470},
	{"skip_frames", 63},
	{"cam_pos", 48, -1430, -2621, 5153},
	{"cam_focus", 48, -1071, -2767, 6241},
	{"skip_frames", 47},
	{"cam_pos", 48, -1438, -2631, 6048},
	{"cam_focus", 48, 653, -2733, 6820},
	{"skip_frames", 71},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WDW_PRISON_OPEN

CUTSCENE_WDW_PRISON_OPEN = {
	{"cam_focus", 32, 4144, -1867, 623},
	{"cam_pos", 48, 1738, -1479, 1266},
	{"skip_frames", 72},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WF_ACT_1

CUTSCENE_WF_ACT_1 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 1815, -3365, 2943},
	{"cam_pos", 1, -876, -1461, 5064},
	{"skip_frames", 1},
	{"cam_pos", 32, -1742, -1461, 3083},
	{"skip_frames", 32},
	{"cam_pos", 64, 1194, -2745, -730},
	{"skip_frames", 64},
	{"cam_focus", 64, 3066, -3320, 6927},
	{"cam_pos", 64, 2889, -3320, 5868},
	{"skip_frames", 96},
	{"cam_focus", 0, -2642, -3225, -334},
	{"cam_pos", 0, -3422, -2878, 440},
	{"skip_frames", 0},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WF_ACT_2

CUTSCENE_WF_ACT_2 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -2626, -3276, -3453},
	{"cam_pos", 1, 124, -1244, -845},
	{"skip_frames", 1},
	{"cam_pos", 40, -2830, -1244, -129},
	{"skip_frames", 40},
	{"cam_pos", 48, -6153, -1244, -2063},
	{"skip_frames", 48},
	{"cam_pos", 40, -5576, -1244, -5262},
	{"skip_frames", 40},
	{"cam_pos", 8, -4094, 443, -4048},
	{"cam_focus", 16, -2627, -1043, -3442},
	{"skip_frames", 8},
	{"cam_pos", 16, -3251, -841, -3974},
	{"skip_frames", 54},
	{"cam_focus", 0, -2642, -3225, -334},
	{"cam_pos", 0, -3422, -2878, 440},
	{"skip_frames", 0},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WF_ACT_3

CUTSCENE_WF_ACT_3 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, -1232, -1594, -3983},
	{"cam_pos", 1, 1076, -89, -8916},
	{"skip_frames", 1},
	{"cam_pos", 48, 184, -708, -4982},
	{"cam_focus", 48, -1090, -3143, -168},
	{"skip_frames", 48},
	{"cam_focus", 48, -5605, -3232, 3275},
	{"cam_pos", 48, -3358, -2302, 2368},
	{"skip_frames", 48},
	{"cam_focus", 16, -6586, -3276, 3967},
	{"cam_pos", 16, -4797, -2966, 3185},
	{"skip_frames", 96},
	{"cam_focus", 0, -2642, -3225, -334},
	{"cam_pos", 0, -3422, -2878, 440},
	{"skip_frames", 0},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WF_ACT_4

CUTSCENE_WF_ACT_4 = {
	{"play_sound", 0x03, 0x0000},
	{"cam_focus", 1, 206, -620, -6479},
	{"cam_pos", 1, 1764, 310, -1520},
	{"skip_frames", 0},
	{"cam_pos", 80, -1829, -512, -1487},
	{"skip_frames", 79},
	{"cam_pos", 80, -5192, 310, -4146},
	{"skip_frames", 116},
	{"cam_focus", 0, -2642, -3225, -334},
	{"cam_pos", 0, -3422, -2878, 440},
	{"skip_frames", 0},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WF_ACT_6

CUTSCENE_WF_ACT_6 = {
	{"play_sound", 0x04, 0x0000},
	{"cam_focus", 1, -2716, -1771, -3482},
	{"cam_pos", 1, -2552, -1405, -1689},
	{"skip_frames", 1},
	{"cam_pos", 64, -4270, -1405, -2267},
	{"skip_frames", 1},
	{"cam_pos", 96, -4141, -1893, -4741},
	{"cam_focus", 96, -632, -390, -4963},
	{"skip_frames", 144},
	{"cam_focus", 0, -2642, -3225, -334},
	{"cam_pos", 0, -3422, -2878, 440},
	{"skip_frames", 0},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WF_ANCIENT_ATTACKER_APPEAR

CUTSCENE_WF_ANCIENT_ATTACKER_APPEAR = {
	{"cam_pos", 32, -2893, -1522, -3872},
	{"skip_frames", 32},
	{"cam_focus", 1, 2748, 256, -5946},
	{"skip_frames", 16},
	{"cam_focus", 240, 2712, -656, -3939},
	{"skip_frames", 240},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}

-- CUTSCENE_WF_PUZZLE_PANEL_SOLVED

CUTSCENE_WF_PUZZLE_PANEL_SOLVED = {
	{"cam_focus", 5, 3551, -313, -14324},
	{"play_sound", 0x9b, 0x0000},
	{"cam_pos", 10, 2575, -32, -11844},
	{"skip_frames", 2},
	{"play_sound", 0x00, 0x303f},
	{"skip_frames", 46},
	{"set_flags", CUTSCENE_FLAG_END, 0},
}


gStarCutscenes = {
    [COURSE_BOB] = {
        [1] = CUTSCENE_BOB_ACT_1,
        [2] = CUTSCENE_BOB_ACT_2,
        [3] = CUTSCENE_BOB_ACT_3,
        [5] = CUTSCENE_BOB_ACT_5,
        [6] = CUTSCENE_BOB_ACT_6,
    },
    [COURSE_WF] = {
        [1] = CUTSCENE_WF_ACT_1,
        [2] = CUTSCENE_WF_ACT_2,
        [3] = CUTSCENE_WF_ACT_3,
        [4] = CUTSCENE_WF_ACT_4,
        [6] = CUTSCENE_WF_ACT_6,
    },
    [COURSE_JRB] = {
        [1] = CUTSCENE_JRB_ACT_1,
        [2] = CUTSCENE_JRB_ACT_2,
        [3] = CUTSCENE_JRB_ACT_3,
        [4] = CUTSCENE_JRB_ACT_4,
        [5] = CUTSCENE_JRB_ACT_5,
        [6] = CUTSCENE_JRB_ACT_6,
    },
    [COURSE_CCM] = {
        [1] = CUTSCENE_CCM_ACT_1,
        [2] = CUTSCENE_CCM_ACT_2,
        [6] = CUTSCENE_CCM_ACT_6,
    },
    [COURSE_BBH] = {
        [1] = CUTSCENE_BBH_ACT_1,
        [2] = CUTSCENE_BBH_ACT_2,
        [4] = CUTSCENE_BBH_ACT_4,
    },
    [COURSE_HMC] = {
        [1] = CUTSCENE_HMC_ACT_1,
        [2] = CUTSCENE_HMC_ACT_2,
        [3] = CUTSCENE_HMC_ACT_3,
        [4] = CUTSCENE_HMC_ACT_4,
        [6] = CUTSCENE_HMC_ACT_6,
    },
    [COURSE_LLL] = {
        [1] = CUTSCENE_LLL_ACT_1,
        [3] = CUTSCENE_LLL_ACT_3,
    },
    [COURSE_SSL] = {
        [1] = CUTSCENE_SSL_ACT_1,
        [2] = CUTSCENE_SSL_ACT_2,
        [3] = CUTSCENE_SSL_ACT_3,
        [4] = CUTSCENE_SSL_ACT_4,
    },
    [COURSE_DDD] = {
        [1] = CUTSCENE_DDD_ACT_1,
        [2] = CUTSCENE_DDD_ACT_2,
        [5] = CUTSCENE_DDD_ACT_5,
        [6] = CUTSCENE_DDD_ACT_6,
    },
    [COURSE_SL] = {
        [1] = CUTSCENE_SL_ACT_1,
        [2] = CUTSCENE_SL_ACT_2,
        [3] = CUTSCENE_SL_ACT_3,
        [4] = CUTSCENE_SL_ACT_4,
        [6] = CUTSCENE_SL_ACT_6,
    },
    [COURSE_WDW] = {
        [1] = CUTSCENE_WDW_ACT_1,
        [2] = CUTSCENE_WDW_ACT_2,
        [3] = CUTSCENE_WDW_ACT_3,
        [4] = CUTSCENE_WDW_ACT_4,
    },
    [COURSE_TTM] = {
        [1] = CUTSCENE_TTM_ACT_1,
    },
    [COURSE_THI] = {
        [1] = CUTSCENE_THI_ACT_1,
        [2] = CUTSCENE_THI_ACT_2,
        [3] = CUTSCENE_THI_ACT_3,
        [4] = CUTSCENE_THI_ACT_4,
        [6] = CUTSCENE_THI_ACT_6,
    },
    [COURSE_TTC] = {
        [1] = CUTSCENE_TTC_ACT_1,
        [2] = CUTSCENE_TTC_ACT_2,
        [3] = CUTSCENE_TTC_ACT_3,
        [6] = CUTSCENE_TTC_ACT_6,
    },
    [COURSE_RR] = {},
}

gCreditsEntries = {
    {
        level = LEVEL_BOB,
        area = 1,
        cutscene = CUTSCENE_CREDITS_01,

        header = "GAME DIRECTOR",
        footer = "KAZE EMANUAR"
    },
    {
        level = LEVEL_WF,
        area = 1,
        cutscene = CUTSCENE_CREDITS_02,

        header = "OBJECT CODING",
        footer = "KAZE           NINTENDO"
    },
    {
        level = LEVEL_JRB,
        area = 1,
        cutscene = CUTSCENE_CREDITS_03,

        header = "ENGINE CODING",
        footer = "KAZE           NINTENDO"
    },
    {
        level = LEVEL_CCM,
        area = 1,
        cutscene = CUTSCENE_CREDITS_04,

        header = "3D MODELLING",
        footer = "KAZE           KINOPIO"
    },
    {
        level = LEVEL_BBH,
        area = 1,
        cutscene = CUTSCENE_CREDITS_05,

        header = "MUSIC COMPOSING",
        footer = "DOTSTARMONEY LEZG JESS64"
    },
    {
        level = LEVEL_TOTWC,
        area = 1,
        cutscene = CUTSCENE_CREDITS_06,

        header = "MORE MUSIC",
        footer = "DOBIEMELTFIRE   SLOWFREQ"
    },
    {
        level = LEVEL_BITDW,
        area = 1,
        cutscene = CUTSCENE_CREDITS_07,

        header = "TOOLS",
        footer = "FRAUBER VLTONE CAJETAN"
    },
    {
        level = LEVEL_PSS,
        area = 1,
        cutscene = CUTSCENE_CREDITS_08,

        header = "SOUND DESIGN",
        footer = "DOTSTARMONEY NINTENDO"
    },
    {
        level = LEVEL_HMC,
        area = 1,
        cutscene = CUTSCENE_CREDITS_09,

        header = "GAME DESIGN",
        footer = "KAZE EMANUAR"
    },
    {
        level = LEVEL_LLL,
        area = 1,
        cutscene = CUTSCENE_CREDITS_10,

        header = "LEVEL AND WORLD DESIGN",
        footer = "KAZE EMANUAR"
    },
    {
        level = LEVEL_SSL,
        area = 1,
        cutscene = CUTSCENE_CREDITS_11,

        header = "ANIMATIONS AND CUTSCENES",
        footer = "KAZE EMANUAR"
    },
    {
        level = LEVEL_DDD,
        area = 1,
        cutscene = CUTSCENE_CREDITS_12,

        header = "SPECIAL THANKS",
        footer = "SUBDRAG STOMATOL QUASMOK"
    },
    {
        level = LEVEL_SL,
        area = 1,
        cutscene = CUTSCENE_CREDITS_13,

        header = "SPECIAL THANKS",
        footer = "PIEORDIE FLAME8765 GEOSHI"
    },
    {
        level = LEVEL_SA,
        area = 1,
        cutscene = CUTSCENE_CREDITS_14,

        header = "SPECIAL THANKS",
        footer = "GREENTHUNDER PABLO TRENT"
    },
    {
        level = LEVEL_VCUTM,
        area = 1,
        cutscene = CUTSCENE_CREDITS_15,

        header = "SPECIAL THANKS",
        footer = "SKELU0 LEMMY SHYGOO"
    },
    {
        level = LEVEL_BITFS,
        area = 1,
        cutscene = CUTSCENE_CREDITS_16,

        header = "SPECIAL THANKS",
        footer = "QUEUERAM DAVID BLAZEDY"
    },
    {
        level = LEVEL_WDW,
        area = 1,
        cutscene = CUTSCENE_CREDITS_17,

        header = "THANKS TO ALL DONORS",
        footer = "AUSTIN HARGRAVES AGLAB2"
    },
    {
        level = LEVEL_TTM,
        area = 1,
        cutscene = CUTSCENE_CREDITS_18,

        header = "THANKS TO ALL DONORS",
        footer = "OBLIVIONWALKER MATTDOAK"
    },
    {
        level = LEVEL_THI,
        area = 1,
        cutscene = CUTSCENE_CREDITS_19,

        header = "THANKS TO ALL DONORS",
        footer = "THIRTEEN1355 QUEUERAM"
    },
    {
        level = LEVEL_TTC,
        area = 1,
        cutscene = CUTSCENE_CREDITS_20,

        header = "THANKS TO ALL DONORS",
        footer = "DANIELLONIGRO NATEEMMERT"
    },
    {
       level = LEVEL_RR,
       area = 1,
       cutscene = CUTSCENE_CREDITS_21,

       header = "THANKS TO ALL DONORS",
       footer = "LUISOTERO WILLIAMARMKE",
    },
    {
        level = LEVEL_COTMC,
        area = 1,
        cutscene = CUTSCENE_CREDITS_22,

        header = "THANKS TO ALL DONORS",
        footer = "ASBETH4567 ZACHMOORE COLE"
    },
    {
        level = LEVEL_BITS,
        area = 1,
        cutscene = CUTSCENE_CREDITS_23,

        header = "THANKS TO ALL DONORS",
        footer = "UNREALECKO CHRISM"
    },
    {
        level = LEVEL_CASTLE_GROUNDS,
        area = 1,
        cutscene = CUTSCENE_ENDING_DIALOG,

        header = "THANKS TO ALL DONORS",
        footer = "BRANDENBARBAR KARADUR"
    },
}
