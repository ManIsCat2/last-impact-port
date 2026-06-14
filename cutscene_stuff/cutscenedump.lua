local CMD_SIZE  = {
    [0x00] = 8, [0x01] = 4, [0x02] = 4, [0x03] = 4,
    [0x04] = 8, [0x05] = 8, [0x06] = 8, [0x07] = 4,
    [0x08] = 4, [0x09] = 4, [0x0A] = 4, [0x0B] = 16,
    [0x0C] = 4, [0x0D] = 8, [0x0E] = 12,
}

local OUT = "cutscenes\\"
local HASHES = OUT .. "hashes.txt"

local dumped = {}
local chkForce
local chkCredits

local function load_log()
    local f = io.open(HASHES, "r")

    if f then
        for hash in f:lines() do
            dumped[hash] = true
        end

        f:close()
    end
end

local function append_log(hash)
    local f = io.open(HASHES, "a")

    if f then
        f:write(string.format("%s\n", hash))
        f:close()
    end
end

local function dump_cutscene(ptr)
    local offset = 0
    local output = {}

    while true do
        local cmd = memory.read_u8(ptr + offset)
        local size = CMD_SIZE[cmd]

        if not size then
            gui.addmessage(string.format("Failed to dump %08X: Invalid command %02X at offset 0x%X", ptr, cmd, offset))
            return
        end

        local data = memory.read_bytes_as_binary_string(ptr + offset, size)
        table.insert(output, data)

        if cmd == 0x0C and data:byte(2, 2) & 0x80 ~= 0 then
            break
        end

        local isCredits = forms.ischecked(chkCredits)
        if data:match("\0\0\0\0\0\0\0\0") and isCredits then
            break
        end

        offset = offset + size
    end

    return table.concat(output, "")
end

local function call_cutscene_post()
    local ptr = memory.read_u32_be(0x8041F000)
    local data = dump_cutscene(ptr)

    if data then
        local hash = memory.hash_region(ptr, #data)
        local force = forms.ischecked(chkForce)

        if not force and dumped[hash] then
            return
        end

        local filename = string.format("cutscene_%08X.bin", ptr)
        local f = io.open(OUT .. filename, "wb")

        if f then
            f:write(data)
            f:close()

            dumped[hash] = true
            append_log(hash)

            gui.addmessage("Dumped " .. filename)
        end
    end
end

local function create_form()
    local form = forms.newform(300, 110, "Cutscene Dumper")

    chkForce = forms.checkbox(form, "Force dump", 10, 10)
    chkCredits = forms.checkbox(form, "Is Credits?", 10, 30)

    forms.button(form, "Reload hashes",
        function()
            dumped = {}
            load_log()
            gui.addmessage("Hashes reloaded.")
        end,
        10, 70, 280, 30
    )
end

load_log()
create_form()

memory.usememorydomain("System Bus")
event.onmemoryexecute(call_cutscene_post, 0x8040F910 + 0x48, "cs_entry")