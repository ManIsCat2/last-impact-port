local cutsceneData = nil
local scriptPos = 1
local waitTimer = 0

local cutsceneObjs = {}

local isSkipable = false
local skipTextTimer = 0

local curPos = gVec3fZero()
local curFocus = gVec3fZero()
local moveStep = gVec3fZero()
local focusStep = gVec3fZero()

local ls = gLakituState
local cam

local moveTimer = 0
local focusTimer = 0

local cutsceneMusic = 0
local keepMusic = false

local cmds = {}

function cmds.cutscene_obj(model, id, params, anim)
    if cutsceneObjs[id] then
        obj_mark_for_deletion(cutsceneObjs[id])
    end

    local modelId = model or E_MODEL_ERROR_MODEL

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

function cmds.skip_frames(nFrames)
    waitTimer = nFrames
    return true
end

function cmds.obj_speed(id, speed, rotSpd)
    local o = cutsceneObjs[id]
    if o then
        o.oForwardVel = speed
        o.oAngleVelYaw = rotSpd << 4
    end
end

function cmds.obj_rot(id, yRot, zRot)
    local o = cutsceneObjs[id]
    if o then
        o.oFaceAngleYaw = yRot << 8
        o.oMoveAngleYaw = yRot << 8
        o.oFaceAngleRoll = zRot << 8
    end
end

function cmds.obj_warp(id, x, y, z)
    local o = cutsceneObjs[id]
    if o then
        if x ~= 0 then o.oPosX = x end
        if y ~= 0 then o.oPosY = y end
        if z ~= 0 then o.oPosZ = z end
    end
end

function cmds.cam_focus(nFrames, x, y, z)
    nFrames = math.max(1, nFrames)
    focusTimer = nFrames
    vec3f_set(focusStep, (x - curFocus.x) / nFrames, (y - curFocus.y) / nFrames, (z - curFocus.z) / nFrames)
end

function cmds.cam_pos(nFrames, x, y, z)
    nFrames = math.max(1, nFrames)
    moveTimer = nFrames
    vec3f_set(moveStep, (x - curPos.x) / nFrames, (y - curPos.y) / nFrames, (z - curPos.z) / nFrames)
end

function cmds.obj_params(id, params, deactivate)
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

function cmds.obj_scale(id, scale)
    local o = cutsceneObjs[id]
    if o then
        obj_scale(o, scale / 100)
    end
end

function cmds.obj_anim(id, anim)
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

function cmds.play_sound(flags, soundId)
    if soundId == 0 then
        local layer = (flags >> 7) & 1
        local seqId = flags & 0x7F
        stop_background_music(cutsceneMusic)
        play_music(layer, (0x04 << 8) | seqId, 0)
        cutsceneMusic = seqId
    else
        play_sound((soundId << 16) | 0x81, gGlobalSoundSource)
    end
end

function cmds.set_mario(skipAnim, x, y, z, rRot, animSize, animPtr)
    -- unused
end

function cmds.set_flags(flags, daynight)
    if (flags & CUTSCENE_FLAG_KEEP_MUSIC) ~= 0 then keepMusic = true end
    if (flags & CUTSCENE_FLAG_SHOW_HUD) ~= 0 then hud_show() end
    if (flags & CUTSCENE_FLAG_SKIPABLE) ~= 0 then isSkipable = true end
    if (flags & CUTSCENE_FLAG_UNSKIPABLE) ~= 0 then isSkipable = false end
    if (flags & CUTSCENE_FLAG_SHAKE) ~= 0 then set_environmental_camera_shake(20) end
    if (flags & CUTSCENE_FLAG_END) ~= 0 then kaze_cutscene_end() end
end

function cmds.show_text(x, y, text)
    -- unused
end

function cmds.spawn_obj(modelId, x, y, z, behavior)
    spawn_non_sync_object(behavior, modelId, x, y, z, nil)
end

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
    keepMusic = false

    cam = gMarioStates[0].area.camera

    vec3f_copy(curPos, cam.pos)
    vec3f_copy(curFocus, cam.focus)

    set_mario_action(gMarioStates[0], ACT_KAZE_CUTSCENE, 0)
    hud_hide()
end

function kaze_cutscene_end()
    if not gCutsceneActive then
        return
    end

    gCutsceneActive = false

    hud_show()
    soft_reset_camera(cam)

    if not keepMusic then
        stop_background_music(cutsceneMusic)
    end

    for _, v in pairs(cutsceneObjs) do
        obj_mark_for_deletion(v)
    end
end

local function cutscene_update_camera()
    if moveTimer > 0 then
        vec3f_add(curPos, moveStep)
        moveTimer = moveTimer - 1
    end

    if focusTimer > 0 then
        vec3f_add(curFocus, focusStep)
        focusTimer = focusTimer - 1
    end

    cam.cutscene = -1
    approach_vec3f_asymptotic(cam.focus, curFocus, 0.6, 0.6, 0.6)
    approach_vec3f_asymptotic(cam.pos, curPos, 0.9, 0.9, 0.9)

    vec3f_copy(ls.goalPos, cam.pos)
    vec3f_copy(ls.goalFocus, cam.focus)
end

local function cutscene_run_frame()
    while gCutsceneActive do
        local instr = cutsceneData[scriptPos]

        if not instr then
            kaze_cutscene_end()
            return
        end

        local handler = cmds[instr[1]]

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

local function lock_r_if_active()
    return not gCutsceneActive
end

hook_event(HOOK_UPDATE, cutscene_update)
hook_event(HOOK_ON_WARP, kaze_cutscene_end)
hook_event(HOOK_ON_HUD_RENDER, draw_overlays)
hook_event(HOOK_ON_CHANGE_CAMERA_ANGLE, lock_r_if_active)