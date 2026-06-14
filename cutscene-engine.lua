local cutsceneData = nil
local scriptPos = 1
local waitTimer = 0

local cutsceneObjs = {}

local isSkipable = false
local skipTextTimer = 0

local prevCamMode = nil
local curPos = gVec3fZero()
local curFocus = gVec3fZero()
local moveStep = gVec3fZero()
local focusStep = gVec3fZero()
local moveTimer = 0
local focusTimer = 0

local cutsceneMusic = 0
local keepMusicOnEnd = false

local ls = gLakituState

function kaze_cutscene_play(data, skipable)
    if not data or gCutsceneActive then
        return
    end

    gCutsceneActive = true
    cutsceneData = data
    scriptPos = 1
    cutsceneObjs = {}

    isSkipable = skipable

    skipTextTimer = 0
    waitTimer = 0
    moveTimer = 0
    focusTimer = 0

    cutsceneMusic = 0

    prevCamMode = ls.mode
    ls.mode = CAMERA_MODE_NONE

    vec3f_copy(curPos, ls.pos)
    vec3f_copy(curFocus, ls.focus)
    vec3f_set(moveStep, 0, 0, 0)
    vec3f_set(focusStep, 0, 0, 0)

    set_mario_action(gMarioStates[0], ACT_KAZE_CUTSCENE, 0)
    hud_hide()
end

function kaze_cutscene_end()
    if not gCutsceneActive then
        return
    end

    gCutsceneActive = false
    ls.mode = prevCamMode

    hud_show()

    if not keepMusicOnEnd then
        stop_background_music(cutsceneMusic)
    end

    for _, v in pairs(cutsceneObjs) do
        obj_mark_for_deletion(v)
    end
end

local function cmd_new_cutscene_obj(model, id, params, anim)
    if cutsceneObjs[id] then
        obj_mark_for_deletion(cutsceneObjs[id])
    end

    local modelId = model or E_MODEL_ERROR_MODEL

    -- sync??
    local o = spawn_non_sync_object(bhvCutsceneObject, modelId, 0, 0, 0, function(o)
        o.oBehParams = params

        if type(anim) == "string" then
            smlua_anim_util_set_animation(o, anim)
        elseif anim ~= 0 then
            o.oAnimations = anim
            obj_init_animation(o, 0)
        end
    end)

    cutsceneObjs[id] = o
end

local function cmd_skip_frames(nFrames)
    waitTimer = nFrames
    return true -- yield
end

local function cmd_obj_spd(id, speed, rotSpd)
    local o = cutsceneObjs[id] ---@type Object

    if o then
        o.oForwardVel = speed
        -- docs say left shift by 10??? that doesnt make sense
        -- the asm left shifts by 4
        o.oAngleVelYaw = rotSpd << 4
    end
end

local function cmd_obj_rot(id, yRot, zRot)
    local o = cutsceneObjs[id]

    if o then 
        o.oFaceAngleYaw = yRot << 8
        o.oMoveAngleYaw = yRot << 8
        o.oFaceAngleRoll = zRot << 8
    end
end

local function cmd_obj_warp(id, x, y, z)
    local o = cutsceneObjs[id]

    if o then
        if x ~= 0 then o.oPosX = x end
        if y ~= 0 then o.oPosY = y end
        if z ~= 0 then o.oPosZ = z end
    end
end

local function cmd_cam_focus(nFrames, x, y, z)
    nFrames = math.max(1, nFrames)
    focusTimer = nFrames

    local dx = (x - curFocus.x) / nFrames
    local dy = (y - curFocus.y) / nFrames
    local dz = (z - curFocus.z) / nFrames

    vec3f_set(focusStep, dx, dy, dz)
end

local function cmd_cam_pos(nFrames, x, y, z)
    nFrames = math.max(1, nFrames)
    moveTimer = nFrames

    local dx = (x - curPos.x) / nFrames
    local dy = (y - curPos.y) / nFrames
    local dz = (z - curPos.z) / nFrames

    vec3f_set(moveStep, dx, dy, dz)
end

local function cmd_obj_params(id, params, deactivate)
    local o = cutsceneObjs[id]

    if o then
        if deactivate then
            obj_mark_for_deletion(o)
            cutsceneObjs[id] = nil
            return
        end

        o.oBehParams = params
    end
end

local function cmd_obj_scale(id, scale)
    local o = cutsceneObjs[id]

    if o then
        obj_scale(o, scale / 100)
    end
end

local function cmd_obj_anim(id, anim)
    local o = cutsceneObjs[id]

    if o then
        if type(anim) == "string" then
            smlua_anim_util_set_animation(o, anim)
            o.header.gfx.animInfo.animFrame = 0
            o.header.gfx.animInfo.animAccel = 0
        elseif anim ~= 0 then
            obj_init_animation(o, anim)
        end
    end
end

local function cmd_play_sound(flags, soundId, keepOnEnd)
    if soundId == 0 then
        local layer = (flags >> 7) & 1
        local seqId = flags & 0x7F

        stop_background_music(cutsceneMusic)
        play_music(layer, (0x04 << 8) | seqId, 0)

        cutsceneMusic = seqId
        keepMusicOnEnd = keepOnEnd
    else
        play_sound((soundId << 16) | 0x81, gGlobalSoundSource)
    end
end

local function cmd_set_mario(skipAnim, x, y, z, rRot, animSize, animPtr)

end

-- tf does daynight do??
-- *(u32*)0x80370008 = daynight;
local function cmd_cutscene_params(flags, daynight)
    if (flags & 0x80) ~= 0 then kaze_cutscene_end() end
    if (flags & 0x40) ~= 0 then set_environmental_camera_shake(20) end
    if (flags & 0x20) ~= 0 then end -- greyout
    if (flags & 0x10) ~= 0 then isSkipable = false end
    if (flags & 0x08) ~= 0 then isSkipable = true end
    if (flags & 0x04) ~= 0 then hud_show() end
end

local function cmd_show_text(x, y, text)
end

local function cmd_spawn_obj(modelId, x, y, z, behavior)
    spawn_non_sync_object(behavior, modelId, x, y, z, nil)
end

local cmdHandlers = {
    obj_new = cmd_new_cutscene_obj,
    skip_frames = cmd_skip_frames,
    obj_speed = cmd_obj_spd,
    obj_rot = cmd_obj_rot,
    obj_warp = cmd_obj_warp,
    cam_focus = cmd_cam_focus,
    cam_pos = cmd_cam_pos,
    obj_params = cmd_obj_params,
    obj_scale = cmd_obj_scale,
    obj_anim = cmd_obj_anim,
    play_sound = cmd_play_sound,
    set_mario = cmd_set_mario,
    set_params = cmd_cutscene_params,
    show_text = cmd_show_text,
    spawn_obj = cmd_spawn_obj,
}

local function cutscene_update_camera()
    if moveTimer > 0 then
        vec3f_add(curPos, moveStep)
        moveTimer = moveTimer - 1
    end

    if focusTimer > 0 then
        vec3f_add(curFocus, focusStep)
        focusTimer = focusTimer - 1
    end

    vec3f_copy(ls.pos, curPos)
    vec3f_copy(ls.curPos, curPos)
    vec3f_copy(ls.goalPos, curPos)
    vec3f_copy(ls.focus, curFocus)
    vec3f_copy(ls.goalFocus, curFocus)
end

local function cutscene_run_frame()
    while gCutsceneActive do
        local instr = cutsceneData[scriptPos]

        if not instr then
            kaze_cutscene_end()
            error("Cutscene reached EOF!!! Should not happen!!!")
            return
        end

        local handler = cmdHandlers[instr[1]]

        if not handler then
            kaze_cutscene_end()
            error(string.format("unknown cutscene cmd '%s' at offset %d", tostring(instr[1]), scriptPos))
            return
        end

        scriptPos = scriptPos + 1

        -- yield if handler returns true
        if handler(table.unpack(instr, 2)) then
            return
        end
    end
end

local function cutscene_update()
    if not gCutsceneActive then
        return
    end

    if skipTextTimer > 0 then
        skipTextTimer = skipTextTimer - 1
    end

    if isSkipable and (gControllers[0].buttonPressed & A_BUTTON) ~= 0 then
        if skipTextTimer > 0 then
            kaze_cutscene_end()
            return
        end

        skipTextTimer = 60
    end

    if waitTimer > 0 then
        waitTimer = waitTimer - 1
    else
        cutscene_run_frame()
    end

    cutscene_update_camera()
end

local function draw_overlays()
    if not gCutsceneActive then
        return
    end

    if skipTextTimer > 0 then
        djui_hud_set_resolution(RESOLUTION_N64)
        djui_hud_set_font(FONT_HUD)
        djui_hud_set_color(255, 255, 255, 255)

        djui_hud_print_text("PRESS A TO SKIP", 28, djui_hud_get_screen_height() - 32, 1, 1)
    end
end

local function lock_r_if_active(mode)
    return not gCutsceneActive
end

hook_event(HOOK_UPDATE, cutscene_update)
hook_event(HOOK_ON_WARP, kaze_cutscene_end)
hook_event(HOOK_ON_HUD_RENDER, draw_overlays)
hook_event(HOOK_ON_CHANGE_CAMERA_ANGLE, lock_r_if_active)