local wasActive = false

local CMD_SIZE  = {
    [0x00] = 8,
    [0x01] = 4,
    [0x02] = 4,
    [0x03] = 4,
    [0x04] = 8,
    [0x05] = 8,
    [0x06] = 8,
    [0x07] = 4,
    [0x08] = 4,
    [0x09] = 4,
    [0x0A] = 4,
    [0x0B] = 16,
    [0x0C] = 4,
    [0x0D] = 8,
    [0x0E] = 12,
}

local cd = debug.getinfo(1, "S").source:match("@?(.+[\\/])") or ""
local outDir = cd .. "cutscenes\\"
local hashes = outDir .. "hashes.txt"

local dumped = {}

local function crc32(data)
    local crc = 0xFFFFFFFF

    for i = 1, #data do
        local byte = data:byte(i)
        crc = crc ~ byte

        for _ = 1, 8 do
            if crc & 1 ~= 0 then
                crc = (crc >> 1) ~ 0xEDB88320
            else
                crc = crc >> 1
            end
        end
    end
    
    return (crc ~ 0xFFFFFFFF) & 0xFFFFFFFF
end

local function load_log()
    local f = io.open(hashes, "r")

    if f then
        for line in f:lines() do
            local hash = tonumber(line, 16)

            if hash then
                dumped[hash] = true
            end
        end

        f:close()
    end
end

local function append_log(hash)
    local f = io.open(hashes, "a")

    if f then
        f:write(string.format("%08X\n", hash))
        f:close()
    end
end

local function dump_cutscene(ptr)
    local result = {}
    local offset = 0

    while true do
        local cmd = mainmemory.read_u8(ptr + offset)
        local size = CMD_SIZE[cmd]

        if not size then
            gui.addmessage(string.format("invalid cmd 0x%02X at offset 0x%08X (0x%08X)", cmd, offset, ptr + offset))
            return table.concat(result)
        end

        for i = 0, size - 1 do
            table.insert(result, string.char(mainmemory.read_u8(ptr + offset + i)))
        end

        if cmd == 0x0C and (mainmemory.read_u8(ptr + offset + 1) & 0x80) ~= 0 then
            break
        end

        offset = offset + size
    end

    return table.concat(result)
end

os.execute('mkdir "' .. outDir .. '"')
load_log()

event.onframeend(function()
    local active = mainmemory.read_u8(0x41F004)

    if active ~= 0 and not wasActive then
        local ptr = mainmemory.read_u32_be(0x41F000)
        local data = dump_cutscene(ptr & 0x1FFFFFFF)
        local hash = crc32(data)

        if not dumped[hash] then
            local filename = outDir .. string.format("cutscene_%08X.bin", ptr)
            local f = io.open(filename, "wb")

            if f then
                f:write(data)
                f:close()

                dumped[hash] = true
                append_log(hash)

                gui.addmessage(string.format("dumped cutscene %s", filename))
            else
                gui.addmessage("failed to open: " .. filename)
            end
        end
    end

    wasActive = (active ~= 0)
end)