import re
import struct
import sys
from collections import defaultdict
from pathlib import Path

CUTSCENES_DIR = Path("./cutscenes")
CONVERTED_DIR = Path("./cutscenes_converted")
DEFINES_FILE  = Path("./cutscene-defines.lua")
OUT_BUNDLE    = Path("./cutscene-data.lua")

DEC      = "%d"
HEX8     = "0x%02x"
HEX16    = "0x%04x"
MODEL    = "dummy.model_0x%02x"
ANIM_PTR = "dummy.anim_0x%08x"
BEH_PTR  = "dummy.beh_0x%08x"
TEXT_PTR = "dummy.text_0x%08x"

# (size, name, fmt, field types)
COMMANDS = {
    0x00: (8,  "obj_new",    ">BBBI",   (MODEL, DEC, HEX8, ANIM_PTR)),
    0x01: (4,  "skip_frames", None,     (DEC,)),
    0x02: (4,  "obj_speed",  ">Bbb",   (DEC, DEC, DEC)),
    0x03: (4,  "obj_rot",    ">Bbb",   (DEC, DEC, DEC)),
    0x04: (8,  "obj_warp",   ">Bhhh",  (DEC, DEC, DEC, DEC)),
    0x05: (8,  "cam_focus",  ">Bhhh",  (DEC, DEC, DEC, DEC)),
    0x06: (8,  "cam_pos",    ">Bhhh",  (DEC, DEC, DEC, DEC)),
    0x07: (4,  "obj_params", ">BBB",   (DEC, HEX8, DEC)),
    0x08: (4,  "obj_scale",  ">BBx",   (DEC, DEC)),
    0x09: (4,  "obj_anim",   ">BxB",   (DEC, DEC)),
    0x0A: (4,  "play_sound", ">BH",    (HEX8, HEX16)),
    0x0B: (16, "set_mario",  ">BhhhhHI", (HEX8, DEC, DEC, DEC, DEC, DEC, ANIM_PTR)),
    0x0C: (4,  "set_params", ">BH",    (HEX8, HEX16)),
    0x0D: (8,  "show_text",  None,     (DEC, DEC, TEXT_PTR)),
    0x0E: (12, "spawn_obj",  ">BhhhI", (MODEL, DEC, DEC, DEC, BEH_PTR)),
}

COURSES = {
    "BOB", "WF",  "JRB", "CCM", "BBH",
    "HMC", "LLL", "SSL", "DDD", "SL",
    "WDW", "TTM", "THI", "TTC", "RR",
}

ACT_RE = re.compile(r"^CUTSCENE_([A-Z0-9]+)_ACT_(\d+)$")


def unpack_cmd(data: bytes, pos: int) -> tuple[str, list, int]:
    op = data[pos]
    if op not in COMMANDS:
        raise ValueError(f"Unknown opcode 0x{op:02X} at offset {pos}")

    size, name, fmt, field_specs = COMMANDS[op]
    payload = pos + 1

    if op == 0x01:
        raw = ((data[payload] << 16) | (data[payload + 1] << 8) | data[payload + 2],)
    elif op == 0x0D:
        b1, b2, b3 = data[payload], data[payload + 1], data[payload + 2]
        x = (b1 << 4) | (b2 >> 4)
        y = ((b2 & 0x0F) << 8) | b3
        ptr = struct.unpack_from(">I", data, payload + 3)[0]
        raw = (x, y, ptr)
    else:
        raw = struct.unpack_from(fmt, data, payload)

    return name, list(zip(field_specs, raw)), pos + size


def field_to_lua(spec: str, val: int) -> str:
    return spec % val


def cmd_to_lua(name: str, fields: list) -> str:
    parts = [f'"{name}"'] + [field_to_lua(spec, val) for spec, val in fields]
    return "{" + ", ".join(parts) + "}"


def convert_binary(data: bytes, varname: str) -> str:
    lines = [f"-- {varname}", "", f"{varname} = {{"]
    pos = 0
    while pos < len(data):
        name, fields, pos = unpack_cmd(data, pos)
        lines.append(f"\t{cmd_to_lua(name, fields)},")
    lines.append("}")
    return "\n".join(lines)


def cmd_convert(force: bool = False):
    if not CUTSCENES_DIR.is_dir():
        sys.exit(f"ERROR: directory not found: {CUTSCENES_DIR}")

    CONVERTED_DIR.mkdir(exist_ok=True)

    bin_files = sorted(CUTSCENES_DIR.glob("*.bin"))
    if not bin_files:
        print("No .bin files found in ./cutscenes/")
        return

    converted = skipped = errors = 0

    for filepath in bin_files:
        varname  = filepath.stem.upper()
        out_path = CONVERTED_DIR / (filepath.stem + ".lua")

        if out_path.exists() and not force:
            skipped += 1
            continue

        try:
            lua_src = convert_binary(filepath.read_bytes(), varname)
        except ValueError as e:
            print(f"\tERROR {filepath.name}: {e}")
            errors += 1
            continue

        out_path.write_text(lua_src + "\n", encoding="utf-8")
        print(f"\t{filepath.name}  =>  {out_path.name}")
        converted += 1

    print(f"\nDone. {converted} converted, {skipped} skipped, {errors} errors.")


def cmd_bundle():
    out_lines = []

    if DEFINES_FILE.is_file():
        out_lines.append(DEFINES_FILE.read_text(encoding="utf-8").rstrip())
        out_lines += ["", ""]
    else:
        print(f"WARNING: {DEFINES_FILE} not found, skipping defines header.")

    lua_files = sorted(CONVERTED_DIR.glob("*.lua"))
    if not lua_files:
        sys.exit(f"ERROR: no .lua files in {CONVERTED_DIR}. Run 'convert' first.")

    star_cs: dict[str, dict[int, str]] = defaultdict(dict)

    for lf in lua_files:
        varname = lf.stem.upper()
        m = ACT_RE.match(varname)
        if m:
            course, act = m.group(1), int(m.group(2))
            if course in COURSES:
                star_cs[course][act] = varname

        out_lines.append(lf.read_text(encoding="utf-8").rstrip())
        out_lines.append("")

    out_lines += ["", "gStarCutscenes = {"]
    for course in sorted(COURSES):
        acts = star_cs.get(course, {})
        if not acts:
            out_lines.append(f"\t[COURSE_{course}] = {{}},")
        else:
            out_lines.append(f"\t[COURSE_{course}] = {{")
            for act in sorted(acts):
                out_lines.append(f"\t\t[{act}] = {acts[act]},")
            out_lines.append("\t},")
    out_lines.append("}")

    OUT_BUNDLE.write_text("\n".join(out_lines) + "\n", encoding="utf-8")
    print(f"Written {OUT_BUNDLE}  ({len(lua_files)} files bundled)")


def main():
    args = sys.argv[1:]
    if not args or args[0] not in ("--convert", "--bundle"):
        sys.exit(1)

    if args[0] == "--convert":
        cmd_convert(force="--force" in args)
    else:
        cmd_bundle()


if __name__ == "__main__":
    main()