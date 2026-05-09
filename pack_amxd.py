#!/usr/bin/env python3.11
"""
pack_amxd.py — wrap Attractor.maxpat + JS into a frozen .amxd.

Produces a self-contained device: the user only needs to drop the single
.amxd file into their User Library — no loose JS files required, no folder
structure, nothing else to copy. The JS deps are byte-for-byte embedded in
the .amxd binary container, exactly like Max's own "Freeze Device" output.

Format reverse-engineered from a real frozen .amxd (matches what Max writes
when you Freeze a device with embedded dependencies):

Outer wrapper (IFF chunks, LE sizes — same as unfrozen):

    ampf  [LE u32 = 4]   "iiii"                  ← device type tag
    meta  [LE u32 = 4]   uint32_LE(7)            ← format version (frozen=7)
    ptch  [LE u32 = N]   <mx@c blob>

mx@c blob layout (all internal sizes BE):

    'mx@c' [BE u32 = 16]                         ← data start offset
    [BE u64 = footer_offset]                     ← absolute from 'mx@c' byte 0
    [file_0 data]  ← patcher JSON  (type "JSON", flag 0x11)
    [file_1 data]  ← dep #1        (type "TEXT", flag 0x00)
    [file_2 data]  ← dep #2 …
    'dlst' [BE u32 = dlst_total_size]            ← file directory
      'dire' entries...

Each 'dire' entry fields (in order): type, fnam, sz32, of32, vers, flag, mdat.

Usage:
    python3.11 pack_amxd.py            # uses Attractor.maxpat next to script
    python3.11 pack_amxd.py audio      # build as Audio Effect (default = instrument)
"""

import datetime
import os
import struct
import sys
from pathlib import Path

HERE   = Path(__file__).resolve().parent
MAXPAT = HERE / "Attractor.maxpat"
OUTPUT = HERE / "Attractor.amxd"

DEVICE_CODES = {
    "instrument": b"iiii",
    "audio":      b"aaaa",
    "midi":       b"mmmm",
}

# JS dependencies referenced by [jsui] / [js] objects in the patcher. They
# get embedded into the .amxd so the device is fully self-contained.
DEPENDENCIES = [
    "attractor_viz.js",
]

MXC_HEADER_SIZE = 16   # 'mx@c'(4) + offset(4) + footer_offset(8)


def le32(n: int) -> bytes:
    return struct.pack("<I", n)


def be32(n: int) -> bytes:
    return struct.pack(">I", n)


def be64(n: int) -> bytes:
    return struct.pack(">Q", n)


def pad4(s: bytes) -> bytes:
    r = len(s) % 4
    return s + b"\x00" * (4 - r) if r else s


def hfs_timestamp(dt: datetime.datetime) -> int:
    # Max stores mtime in classic-Mac epoch (1904-01-01).
    return int(dt.timestamp()) + 2082844800


def field(tag: str, data: bytes) -> bytes:
    return tag.encode("ascii") + be32(8 + len(data)) + data


def make_dire_entry(file_type: str, filename: str, size: int, offset: int,
                    flag: int, mod_time: datetime.datetime) -> bytes:
    fields  = field("type", file_type.encode("ascii"))            # exactly 4 bytes, no pad
    fields += field("fnam", pad4(filename.encode("ascii") + b"\x00"))
    fields += field("sz32", be32(size))
    fields += field("of32", be32(offset))
    fields += field("vers", be32(0))
    fields += field("flag", be32(flag))
    fields += field("mdat", be32(hfs_timestamp(mod_time)))
    return b"dire" + be32(8 + len(fields)) + fields


def pack_amxd(maxpat_path: Path, out_path: Path, device: str = "instrument") -> None:
    if device not in DEVICE_CODES:
        raise ValueError(f"unknown device type {device!r}")

    maxpat_bytes = maxpat_path.read_bytes()
    now          = datetime.datetime.now(datetime.UTC)

    # Patcher first (type "JSON", flag 0x11), then deps (type "TEXT", flag 0x00).
    files: list[tuple[str, str, bytes, int, datetime.datetime]] = []
    files.append(("JSON", out_path.name, maxpat_bytes, 0x11, now))

    for dep_name in DEPENDENCIES:
        dep_path = HERE / dep_name
        if not dep_path.is_file():
            sys.exit(f"missing dependency: {dep_path}")
        mtime = datetime.datetime.fromtimestamp(
            dep_path.stat().st_mtime, datetime.UTC,
        )
        files.append(("TEXT", dep_name, dep_path.read_bytes(), 0x00, mtime))
        print(f"  embedding {dep_name} ({dep_path.stat().st_size:,} bytes)")

    # Build data region.
    data_region = bytearray()
    entries: list[tuple[str, str, int, int, int, datetime.datetime]] = []
    for ftype, fname, fdata, flag, mtime in files:
        offset = MXC_HEADER_SIZE + len(data_region)
        data_region += fdata
        entries.append((ftype, fname, len(fdata), offset, flag, mtime))

    # 'dlst' footer.
    dire_bytes = b""
    for ftype, fname, size, offset, flag, mtime in entries:
        dire_bytes += make_dire_entry(ftype, fname, size, offset, flag, mtime)
    dlst = b"dlst" + be32(8 + len(dire_bytes)) + dire_bytes

    footer_offset = MXC_HEADER_SIZE + len(data_region)

    mxc_blob = (
        b"mx@c"
        + be32(MXC_HEADER_SIZE)
        + be64(footer_offset)
        + bytes(data_region)
        + dlst
    )

    out  = bytearray()
    out += b"ampf" + le32(4) + DEVICE_CODES[device]
    out += b"meta" + le32(4) + le32(7)             # format version 7 = frozen
    out += b"ptch" + le32(len(mxc_blob)) + mxc_blob

    out_path.write_bytes(bytes(out))
    print(f"wrote {out_path} ({len(out):,} bytes, device={device})")
    print(f"  patcher json:  {len(maxpat_bytes):,} bytes")
    print(f"  dependencies:  {len(DEPENDENCIES)}")
    print(f"  frozen payload:{len(mxc_blob):,} bytes")


def main() -> int:
    args   = sys.argv[1:]
    device = args[0] if args else "instrument"

    if not MAXPAT.is_file():
        sys.exit(f"input not found: {MAXPAT}")

    pack_amxd(MAXPAT, OUTPUT, device)
    return 0


if __name__ == "__main__":
    sys.exit(main())
