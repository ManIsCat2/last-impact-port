-- maps model IDs, beh IDs, text pointers and anim ptrs in ROM to lua values
-- these keys are found in cutscene data

gCutsceneModelIds = {
    [0x64] = E_MODEL_MIPS
}

gCutsceneBehIds = {}

gCutsceneTextPtrs = {}

gCutsceneAnimPtrs = {
    [0x06015724] = gObjectAnimations.mips_seg6_anims_06015634
}