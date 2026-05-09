#!/usr/bin/env python3.11
"""
build_attractor.py — emits Attractor.maxpat for the ATTRACTOR M4L instrument.

Compact layout (800×169) — 169 px is the Live-enforced device height ceiling
(Cycling74 docs: "The height of all Live devices is fixed at 169 pixels.").
Live forces its grey theme on M4L devices, so the look is built from clean
Live-native widgets + a single brand accent panel + a wide jsui visualizer.

Re-run after edits:    python3.11 build_attractor.py
"""

import json
import os

OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Attractor.maxpat")


# ---------- helpers ---------------------------------------------------------

class Patch:
    def __init__(self):
        self.boxes = []
        self.lines = []
        self._uid  = 0

    def _next_id(self):
        self._uid += 1
        return f"obj-{self._uid}"

    def add(self, **box):
        bid = self._next_id()
        box.setdefault("id", bid)
        self.boxes.append({"box": box})
        return bid

    def link(self, src, src_out, dst, dst_in, order=0):
        self.lines.append({
            "patchline": {
                "source":      [src, src_out],
                "destination": [dst, dst_in],
                "order":       order,
            }
        })

    def newobj(self, text, x, y, w=120, h=22, n_in=1, n_out=None, outtype=None):
        # Derive n_out from outtype length when caller provides outtype but
        # not n_out. Without this, every multi-outlet object built via outtype
        # (e.g. trigger with 14 b's, unpack 0 0, line~) ends up with
        # numoutlets=1 in the JSON — Max silently drops links to outlet>=1
        # for some object classes (notably trigger), which broke loadbang init
        # of the chaos toggle.
        if outtype is None and n_out is None:
            n_out = 1
        elif outtype is None:
            outtype = [""] * n_out
        elif n_out is None:
            n_out = len(outtype)
        return self.add(
            maxclass="newobj",
            text=text,
            patching_rect=[x, y, w, h],
            numinlets=n_in,
            numoutlets=n_out,
            outlettype=outtype,
        )

    def message(self, text, x, y, w=80):
        return self.add(
            maxclass="message",
            text=text,
            patching_rect=[x, y, w, 22],
            numinlets=2,
            numoutlets=1,
            outlettype=[""],
        )

    def comment(self, text, px, py, pw, ph=14, fontsize=10, bold=False,
                color=None, align=0):
        b = {
            "maxclass":          "comment",
            "text":              text,
            "patching_rect":     [px + 800, py, pw, ph],   # park out of patch view
            "presentation":      1,
            "presentation_rect": [px, py, pw, ph],
            "numinlets":         1,
            "numoutlets":        0,
            "fontsize":          fontsize,
            "textjustification": align,
        }
        if bold:
            b["fontface"] = 1
        if color is not None:
            b["textcolor"] = list(color)
        return self.add(**b)

    def live_dial(self, longname, shortname, vmin, vmax, default,
                  ptype=0, exponent=1.0, unit_style=1,
                  annotation=None,
                  px=0, py=0, w=36, h=36):
        # display_parameter_name=0 hides the white auto-label that Live renders
        # above the dial. We draw our own colored labels below.
        valueof = {
            "parameter_initial":         [default],
            "parameter_initial_enable":  1,
            "parameter_longname":        longname,
            "parameter_shortname":       shortname,
            "parameter_linknames":       1,
            "parameter_type":            ptype,
            "parameter_mmin":            vmin,
            "parameter_mmax":            vmax,
            "parameter_unitstyle":       unit_style,
        }
        if exponent != 1.0:
            valueof["parameter_exponent"] = exponent
        if annotation:
            valueof["parameter_annotation_name"] = longname

        box = dict(
            maxclass="live.dial",
            varname=longname.lower().replace(" ", "_"),
            patching_rect=[px + 800, py, w, h],
            presentation=1,
            presentation_rect=[px, py, w, h],
            numinlets=1,
            numoutlets=2,
            outlettype=["", "float"],
            parameter_enable=1,
            saved_attribute_attributes={"valueof": valueof},
            # showname=0 hides the parameter name above the dial — we draw
            # our own colored labels below. shownumber stays at 1 (default)
            # so values render inside the rect for at-a-glance feedback.
            showname=0,
        )
        if annotation:
            box["annotation"] = annotation
        return self.add(**box)

    def live_menu(self, longname, items, default, annotation=None,
                  px=0, py=0, w=120, h=22):
        valueof = {
            "parameter_enum":            items,
            "parameter_initial":         [default],
            "parameter_initial_enable":  1,
            "parameter_longname":        longname,
            "parameter_shortname":       longname,
            "parameter_linknames":       1,
            "parameter_mmax":            len(items) - 1,
            "parameter_type":            2,
            "parameter_unitstyle":       9,
        }
        if annotation:
            valueof["parameter_annotation_name"] = longname
        box = dict(
            maxclass="live.menu",
            varname=longname.lower().replace(" ", "_"),
            patching_rect=[px + 800, py, w, h],
            presentation=1,
            presentation_rect=[px, py, w, h],
            numinlets=1,
            numoutlets=3,
            outlettype=["", "", "float"],
            parameter_enable=1,
            saved_attribute_attributes={"valueof": valueof},
            showname=0,
        )
        if annotation:
            box["annotation"] = annotation
        return self.add(**box)

    def live_toggle(self, longname, default=0, annotation=None,
                    px=0, py=0, w=22, h=22):
        # Real M4L devices (verified against Harmonia) require:
        # • parameter_mmin AND parameter_mmax (mmin was missing → Live failed
        #   to apply parameter_initial on fresh load and the toggle came up
        #   OFF despite default=1)
        # • INT (not float) values for mmin/mmax/parameter_initial
        # • parameter_enum with text labels Live shows in the right-click menu
        valueof = {
            "parameter_initial":         [int(default)],
            "parameter_initial_enable":  1,
            "parameter_longname":        longname,
            "parameter_shortname":       longname,
            "parameter_linknames":       1,
            "parameter_mmin":            0,
            "parameter_mmax":            1,
            "parameter_enum":            ["off", "on"],
            "parameter_type":            2,
        }
        if annotation:
            valueof["parameter_annotation_name"] = longname
        box = dict(
            maxclass="live.toggle",
            varname=longname.lower().replace(" ", "_"),
            patching_rect=[px + 800, py, w, h],
            presentation=1,
            presentation_rect=[px, py, w, h],
            numinlets=1,
            numoutlets=2,
            outlettype=["", ""],
            parameter_enable=1,
            saved_attribute_attributes={"valueof": valueof},
            showname=0,
        )
        if annotation:
            box["annotation"] = annotation
        return self.add(**box)

    def live_gain(self, db_init, x_patch, y_patch, w=33, h=110):
        return self.add(
            maxclass="live.gain~",
            varname="out_gain",
            patching_rect=[x_patch, y_patch, w, h],
            numinlets=2,
            numoutlets=5,
            outlettype=["signal", "signal", "", "float", "list"],
            parameter_enable=1,
            saved_attribute_attributes={
                "valueof": {
                    "parameter_initial":         [db_init],
                    "parameter_initial_enable":  1,
                    "parameter_longname":        "Output",
                    "parameter_shortname":       "Out",
                }
            },
        )

    def jsui(self, filename, px, py, pw, ph, n_out=3):
        return self.add(
            maxclass="jsui",
            filename=filename,
            patching_rect=[px + 800, py, pw, ph],
            presentation=1,
            presentation_rect=[px, py, pw, ph],
            numinlets=1,
            numoutlets=n_out,
            outlettype=["float"] * n_out,
            parameter_enable=0,
        )

    def to_dict(self):
        return {
            "patcher": {
                "fileversion":     1,
                "appversion": {
                    "major":        8,
                    "minor":        6,
                    "revision":     2,
                    "architecture": "x64",
                    "modernui":     1,
                },
                "classnamespace":          "box",
                "rect":                    [80, 100, 800, 600],
                "bglocked":                0,
                "openinpresentation":      1,
                "default_fontsize":        11.0,
                "default_fontface":        0,
                "default_fontname":        "Arial",
                "gridonopen":              1,
                "gridsize":                [10.0, 10.0],
                "gridsnaponopen":          1,
                "objectsnaponopen":        1,
                "statusbarvisible":        2,
                "toolbarvisible":          1,
                "boxanimatetime":          200,
                "enablehscroll":           1,
                "enablevscroll":           1,
                "devicewidth":             800.0,
                "description":             "Strange-attractor FM synthesizer",
                "digest":                  "ATTRACTOR — chaos-driven FM synth",
                "tags":                    "synth chaos fm attractor",
                "style":                   "",
                "subpatcher_template":     "Instrument_Device",
                "assistshowspatchername":  0,
                "boxes":                   self.boxes,
                "lines":                   self.lines,
                "dependency_cache":        [],
                "autosave":                0,
            }
        }


# ---------- build the device ------------------------------------------------

# Live device dimensions. Cycling74 docs (User Interfaces in Max for Live →
# Device Width and Height): "The height of all Live devices is fixed at 169
# pixels." Anything beyond 169 gets clipped at the bottom — that's why the
# viz panel traces appeared cropped. We tighten DIAL_H to make room for the
# viz panel inside the 169-px ceiling.
DEV_W      = 800
DEV_H      = 169
DIAL_W     = 40
DIAL_H     = 32       # body + value display, compact enough for the 169-px frame
LABEL_H    = 14
MENU_H     = 22
TOGGLE_H   = 18
ROW_TITLE  = 10                                        # banner — slightly less than the 12 px left
                                                       # padding (Live's title bar steals visual
                                                       # space from the top, so true visual symmetry
                                                       # actually wants py < px)
ROW_HEADER = 22                                        # group headers — right column
ROW_SUBTL  = 28                                        # subtitle — under the brand accent line
ROW_TOGGLE = 46                                        # chaos engine row — below subtitle
ROW_DIALS  = 40                                        # dialy — every row up by 4 to give viz more height
ROW_LABEL  = ROW_DIALS + DIAL_H + 4                    # 4-px breathing room below the dial value
                                                       # text. live.dial w/ shownumber=1 packs the
                                                       # value flush against the bottom of the rect;
                                                       # without this gap "10.00" sits visually on top
                                                       # of the "σ" caption.
# Menu is on the LEFT column, below the toggle, with its bottom aligned to
# the right-column dial labels (ROW_LABEL + LABEL_H = 90). This keeps the
# branded chaos column visually anchored to the same baseline as the dialy.
ROW_MENU   = (ROW_LABEL + LABEL_H) - MENU_H            # menu bottom = dial-label bottom = 90
ROW_VIZ    = ROW_LABEL + LABEL_H + 2
VIZ_H      = DEV_H - ROW_VIZ - 4                       # viz fills the rest, fits inside Live's 169-px frame


def build():
    p = Patch()

    # ============================================================
    # Group spec: name → (start_x, end_x, dial_count_for_centering)
    # All dialy live in one row; group headers live above them.
    # ============================================================
    HEADER_COLOR = (0.62, 0.66, 0.78, 1.0)
    LABEL_COLOR  = (0.78, 0.82, 0.92, 1.0)

    def header(text, x, w):
        p.comment(text, px=x, py=ROW_HEADER, pw=w, ph=14,
                  fontsize=9, bold=True, color=HEADER_COLOR, align=1)

    def label(text, x, w):
        p.comment(text, px=x, py=ROW_LABEL, pw=w, ph=LABEL_H,
                  fontsize=9, color=LABEL_COLOR, align=1)

    # ----- Banner row -----
    # Logo. Live's comment widget vertically centers text in its rect, so we
    # match centers (not py) — for two boxes with different ph and fontsize,
    # equal `py + ph/2` puts the text mid-lines on the same horizontal line.
    LOGO_W = 140
    p.comment("ATTRACTOR", px=12, py=ROW_TITLE, pw=LOGO_W, ph=22,
              fontsize=15, bold=True, color=(0.95, 0.97, 1.0, 1.0))
    # Invisible click target on top of the wordmark — matches the aurora-m4l /
    # harmonia-m4l pattern: clicking the logo opens the device's GitHub repo
    # in the user's default browser. Live's [max] receive accepts the
    # `launchbrowser <url>` message for this.
    GH_URL = "https://github.com/adriank1410/attractor-m4l"
    logo_btn = p.add(
        maxclass="ubutton",
        patching_rect=[12 + 800, ROW_TITLE, LOGO_W, 22],
        presentation=1,
        presentation_rect=[12, ROW_TITLE, LOGO_W, 22],
        numinlets=1,
        numoutlets=4,
        outlettype=["bang", "bang", "", "int"],
    )
    logo_msg = p.message(f"; max launchbrowser {GH_URL}",
                         12 + 800, ROW_TITLE + 30, w=440)
    p.link(logo_btn, 0, logo_msg, 0)

    # Brand accent line directly under "ATTRACTOR" — signature mark anchoring
    # the chaos engine column.
    ACCENT_W = 100
    ACCENT_Y = ROW_TITLE + 20      # logo's text baseline-ish, sits at logo bottom
    p.add(
        maxclass="panel",
        patching_rect=[12 + 800, ACCENT_Y, ACCENT_W, 2],
        presentation=1,
        presentation_rect=[12, ACCENT_Y, ACCENT_W, 2],
        numinlets=1,
        numoutlets=0,
        bgfillcolor_type="color",
        bgfillcolor_color=[0.95, 0.55, 0.20, 1.0],
        bgcolor=[0.95, 0.55, 0.20, 1.0],
        background=1,
        border=0,
    )

    # Subtitle: top-right tagline carrying the version + author info.
    # Clicking it opens the author's personal website (mirrors aurora-m4l's
    # footer pattern — logo→repo, tagline→site).
    SUB_TEXT = "strange-attractor FM synthesizer · v1.0"
    SUB_W    = 290
    SUB_X    = DEV_W - SUB_W
    SITE_URL = "https://adriankwiatkowski.eu"
    p.comment(SUB_TEXT,
              px=SUB_X, py=0, pw=SUB_W, ph=14,
              fontsize=10, color=(0.55, 0.62, 0.82, 1.0), align=2)
    sub_btn = p.add(
        maxclass="ubutton",
        patching_rect=[SUB_X + 800, 0, SUB_W, 14],
        presentation=1,
        presentation_rect=[SUB_X, 0, SUB_W, 14],
        numinlets=1,
        numoutlets=4,
        outlettype=["bang", "bang", "", "int"],
    )
    sub_msg = p.message(f"; max launchbrowser {SITE_URL}",
                        SUB_X + 800, 30, w=320)
    p.link(sub_btn, 0, sub_msg, 0)

    # Chaos toggle: under the logo, above the type menu — visually anchors the
    # whole left "chaos engine" column. The toggle reads as the master switch
    # for the column (mode + σ/ρ/β/speed dialy further right).
    TOGGLE_W = 18
    TOGGLE_X = 14
    chaos_toggle = p.live_toggle("Chaos", default=1,
        px=TOGGLE_X, py=ROW_TOGGLE, w=TOGGLE_W, h=TOGGLE_H,
        annotation="Master switch for the chaos engine. When off, no modulation is applied.")
    # Inline "chaos engine" label — give the comment the SAME ph as the toggle
    # so Live vertically centers the text in a box matching the toggle's full
    # height (otherwise a shorter ph + py-offset math sometimes ends up a
    # pixel off the toggle's visual center).
    p.comment("chaos engine",
              px=TOGGLE_X + TOGGLE_W + 6, py=ROW_TOGGLE, pw=92, ph=TOGGLE_H,
              fontsize=10, color=HEADER_COLOR, align=0)

    # ----- Dial row planning -----
    # Group widths:    chaos_engine = mode_menu + 4 dialy
    #                  fm           = 2 dialy
    #                  envelope     = 2 dialy
    #                  modulation   = 3 dialy
    #                  output       = 1 dial
    # Keep gaps big so the eye groups things naturally.
    DIAL_GAP   = 8
    GROUP_GAP  = 26

    def dial(longname, vmin, vmax, default, label_text, annotation,
             exp=1.0, unit=1):
        nonlocal x
        d = p.live_dial(longname, longname, vmin, vmax, default,
                        exponent=exp, unit_style=unit,
                        annotation=annotation,
                        px=x, py=ROW_DIALS, w=DIAL_W, h=DIAL_H)
        label(label_text, x - 2, DIAL_W + 4)
        x += DIAL_W + DIAL_GAP
        return d

    x = 14

    # ---- CHAOS ENGINE group ----
    # No "type" caption under the menu: the dropdown's currently-selected
    # attractor name (Lorenz / Rössler / Aizawa / Thomas) is self-describing,
    # and Live shows "Attractor" in right-click → automation. Dropping the
    # caption frees vertical space for the chaos column to sit lower on the
    # device, reads cleaner.
    mode_w   = 110
    mode_menu = p.live_menu(
        "Attractor", ["Lorenz", "Rössler", "Aizawa", "Thomas"],
        default=0, px=x, py=ROW_MENU, w=mode_w, h=MENU_H,
        annotation="Strange-attractor algorithm — each gives a different chaos signature.")
    chaos_dials_x0 = x + mode_w + DIAL_GAP

    x = chaos_dials_x0
    sigma_dial = dial("Sigma",  1.0,    30.0, 10.0,    "σ",
        "Lorenz σ — Prandtl number. Higher = wilder swirl.")
    rho_dial   = dial("Rho",    1.0,    50.0, 28.0,    "ρ",
        "Lorenz ρ — Rayleigh number. Below ~24 the system settles, above blooms into chaos.")
    beta_dial  = dial("Beta",   0.1,    10.0,  2.667,  "β",
        "Lorenz β — vertical damping. Classic butterfly value is 8/3 ≈ 2.667.")
    speed_dial = dial("Speed",  0.0001, 0.020, 0.005,  "speed",
        "Integration step size. Larger = faster trajectory.", exp=2.0)
    # Backtrack one DIAL_GAP so header centers over the four dialy only
    chaos_dials_x1 = x - DIAL_GAP
    header("CHAOS ENGINE", chaos_dials_x0, chaos_dials_x1 - chaos_dials_x0)

    x += GROUP_GAP - DIAL_GAP

    # ---- FM group ----
    fm_x0 = x
    ratio_dial = dial("Ratio",  0.25,    8.0,  2.0,    "ratio",
        "FM modulator-to-carrier frequency ratio.", exp=2.0)
    index_dial = dial("Index",  0.0,    10.0,  3.0,    "index",
        "FM modulation index. 0 = pure sine, higher = brighter.")
    fm_x1 = x - DIAL_GAP
    header("FM", fm_x0, fm_x1 - fm_x0)
    x += GROUP_GAP - DIAL_GAP

    # ---- ENVELOPE group ----
    env_x0 = x
    atk_dial   = dial("Attack",  1.0,  2000.0, 8.0,    "attack",
        "Note attack time in milliseconds.", exp=3.0, unit=2)
    rel_dial   = dial("Release", 5.0,  4000.0, 320.0,  "release",
        "Note release time — how long the tail rings.", exp=3.0, unit=2)
    env_x1 = x - DIAL_GAP
    header("ENVELOPE", env_x0, env_x1 - env_x0)
    x += GROUP_GAP - DIAL_GAP

    # ---- MODULATION group ----
    mod_x0 = x
    depth_dial = dial("Depth",   0.0,    1.0,   0.55,  "depth",
        "How strongly chaos modulates ratio, index and amplitude.")
    drive_dial = dial("Drive",   0.0,    1.0,   0.30,  "drive",
        "Soft saturation — tanh waveshaper.")
    glide_dial = dial("Glide",   0.0,    500.0, 30.0,  "glide",
        "Portamento time. 0 = retrigger, higher = legato.", exp=2.0, unit=2)
    mod_x1 = x - DIAL_GAP
    header("MODULATION", mod_x0, mod_x1 - mod_x0)
    x += GROUP_GAP - DIAL_GAP

    # ---- OUTPUT group ----
    out_x0 = x
    gain_dial = dial("Volume", -60.0,  6.0, -12.0,  "volume",
        "Output level (dB). Per-note level scales with MIDI velocity.",
        unit=4)
    out_x1 = x - DIAL_GAP
    header("OUT", out_x0, out_x1 - out_x0)

    # ----- jsui visualizer (full width, takes the bottom strip) -----
    viz = p.jsui("attractor_viz.js",
                 px=4, py=ROW_VIZ, pw=DEV_W - 8, ph=VIZ_H)

    # ===================== PATCHING (DSP) =================================
    # Layout in patching: vertical lanes, x grows right.
    L_MIDI  =   20
    L_CHAOS =  220
    L_FM    =  500

    # ---- MIDI input ----
    midiin    = p.newobj("midiin",      L_MIDI,  20, w=70, n_in=0, outtype=["int"])
    midiparse = p.newobj("midiparse",   L_MIDI,  56, n_out=6,
                         outtype=["list","list","int","int","int","int"])
    # FIX: stripnote was eating note-offs → adsr~ never released. Now we use
    # unpack so vel reaches adsr~ for both note-on (attack) and note-off
    # (release on vel=0). Pitch goes through stripnote to ignore note-off
    # pitches → mtof only fires on note-on, no freq glitches under legato.
    strip     = p.newobj("stripnote",   L_MIDI,  92, n_in=1, n_out=2,
                         outtype=["int","int"])
    unpk      = p.newobj("unpack 0 0",  L_MIDI, 124, w=110, outtype=["int","int"])
    p.link(midiin,    0, midiparse, 0)
    p.link(midiparse, 0, strip,     0)   # pitch path (note-on only)
    p.link(midiparse, 0, unpk,      0)   # vel path (always, incl. note-off)

    mtof      = p.newobj("mtof",        L_MIDI, 156, w=50)
    pak_freq  = p.newobj("pak 0. 30.",  L_MIDI, 188, w=120, outtype=["list"])
    line_freq = p.newobj("line~",       L_MIDI, 220, w=70, outtype=["signal","bang"])
    p.link(strip,    0, mtof,     0)
    p.link(mtof,     0, pak_freq, 0)
    p.link(pak_freq, 0, line_freq,0)

    # Velocity → adsr~  (vel=0 from note-off triggers release)
    # CRITICAL: adsr~ ramps the envelope to the GATE VALUE — i.e. with
    # raw velocity 100 the envelope peaks at 100, multiplying audio by 100
    # → instant earrape. Divide by 127 first so envelope tops out at vel/127
    # (always ≤ 1.0), and audio output stays in normal range.
    vel_norm  = p.newobj("/ 127.",  L_MIDI+140,  20, w=70)
    pak_atk   = p.newobj("pak attack 8.",   L_MIDI+140,  56, w=140, outtype=["list"])
    pak_rel   = p.newobj("pak release 320.",L_MIDI+140,  88, w=140, outtype=["list"])
    adsr      = p.newobj("adsr~ 8 50 0.85 320", L_MIDI+140, 124, w=200,
                         outtype=["signal"])
    p.link(unpk,     1, vel_norm, 0)
    p.link(vel_norm, 0, adsr,     0)
    p.link(atk_dial, 0, pak_atk,  1)
    p.link(rel_dial, 0, pak_rel,  1)
    p.link(pak_atk,  0, adsr,     0)
    p.link(pak_rel,  0, adsr,     0)
    # Glide → portamento ramp on freq pak
    p.link(glide_dial, 0, pak_freq, 1)

    # ---- chaos engine ----
    # Metro is gated by BOTH the user's chaos_toggle AND the envelope being
    # non-zero — no notes → no chaos → no animation, exactly what the user
    # wants. Implementation: snapshot~ samples the envelope at 50 Hz; once
    # > 0.001, output 1; multiplied with chaos_toggle by [expr], the product
    # drives the metro gate (1=run, 0=stop).
    env_snap   = p.newobj("snapshot~ 50", L_CHAOS-220,  20, w=110, outtype=["float"])
    env_gt0    = p.newobj("> 0.001",      L_CHAOS-220,  44, w=70,  outtype=["int"])
    env_and    = p.newobj("expr $i1 * $i2", L_CHAOS-220, 68, w=140, outtype=["int"])
    p.link(adsr,         0, env_snap, 0)
    p.link(env_snap,     0, env_gt0,  0)
    p.link(env_gt0,      0, env_and,  0)        # leftmost = trigger
    p.link(chaos_toggle, 0, env_and,  1)        # rightmost = stored multiplier

    metro     = p.newobj("metro 5",      L_CHAOS,  20, w=70, outtype=["bang"])
    p.link(env_and, 0, metro, 0)
    p.link(metro,   0, viz,   0)                # bang the visualizer/engine

    # Always-on slow metro for fade animation. When the chaos metro stops the
    # viz won't get bangs — without this fade-pump it would freeze on the last
    # frame. The fade message in viz triggers a redraw with time-based fade.
    fade_metro = p.newobj("metro 50",   L_CHAOS-220, 100, w=80,  outtype=["bang"])
    fade_loadbang = p.newobj("loadbang", L_CHAOS-300, 100, w=70, outtype=["bang"])
    fade_one   = p.message("1",         L_CHAOS-300, 124, w=30)
    fade_pre   = p.newobj("prepend fade", L_CHAOS-220, 130, w=110, outtype=["list"])
    p.link(fade_loadbang, 0, fade_one, 0)
    p.link(fade_one,      0, fade_metro, 0)
    p.link(fade_metro,    0, fade_pre, 0)
    p.link(fade_pre,      0, viz, 0)

    # ---- grey out chaos-only controls when chaos engine is off ----
    # When chaos_toggle = 0, these dialy and the menu have no audible effect.
    # We send `active 0/1` to each one so Live renders them dimmed and ignores
    # interaction — clear visual cue that they're inert in the current state.
    active_pre = p.newobj("prepend active", L_CHAOS-200, 156, w=120,
                          outtype=["list"])
    p.link(chaos_toggle, 0, active_pre, 0)
    for target in (mode_menu, sigma_dial, rho_dial, beta_dial, speed_dial,
                   depth_dial):
        p.link(active_pre, 0, target, 0)

    # parameter feeds → viz (typed messages: "sigma 10", "rho 28", ...)
    pre_sigma = p.newobj("prepend sigma", L_CHAOS-160,  20, w=110, outtype=["list"])
    pre_rho   = p.newobj("prepend rho",   L_CHAOS-160,  44, w=110, outtype=["list"])
    pre_beta  = p.newobj("prepend beta",  L_CHAOS-160,  68, w=110, outtype=["list"])
    pre_speed = p.newobj("prepend speed", L_CHAOS-160,  92, w=110, outtype=["list"])
    pre_mode  = p.newobj("prepend mode",  L_CHAOS-160, 116, w=110, outtype=["list"])
    p.link(sigma_dial, 0, pre_sigma, 0)
    p.link(rho_dial,   0, pre_rho,   0)
    p.link(beta_dial,  0, pre_beta,  0)
    p.link(speed_dial, 0, pre_speed, 0)
    p.link(mode_menu,  0, pre_mode,  0)
    for pre in (pre_sigma, pre_rho, pre_beta, pre_speed, pre_mode):
        p.link(pre, 0, viz, 0)

    # smoothed chaos signals — viz outlets 0/1/2 carry x/y/z floats
    pak_x = p.newobj("pak 0. 5.", L_CHAOS,     92, w=110, outtype=["list"])
    line_x= p.newobj("line~",     L_CHAOS,    124, w=70, outtype=["signal","bang"])
    pak_y = p.newobj("pak 0. 5.", L_CHAOS+120, 92, w=110, outtype=["list"])
    line_y= p.newobj("line~",     L_CHAOS+120,124, w=70, outtype=["signal","bang"])
    pak_z = p.newobj("pak 0. 5.", L_CHAOS+240, 92, w=110, outtype=["list"])
    line_z= p.newobj("line~",     L_CHAOS+240,124, w=70, outtype=["signal","bang"])
    p.link(viz, 0, pak_x, 0)
    p.link(viz, 1, pak_y, 0)
    p.link(viz, 2, pak_z, 0)
    p.link(pak_x, 0, line_x, 0)
    p.link(pak_y, 0, line_y, 0)
    p.link(pak_z, 0, line_z, 0)

    # ---- depth, ratio, index smoothed ----
    pak_depth  = p.newobj("pak 0.55 20.", L_CHAOS+120, 156, w=120, outtype=["list"])
    line_depth = p.newobj("line~",        L_CHAOS+120, 188, w=60,
                          outtype=["signal","bang"])
    p.link(depth_dial, 0, pak_depth, 0)
    p.link(pak_depth,  0, line_depth, 0)

    pak_ratio  = p.newobj("pak 2.0 20.",  L_FM,       20, w=120, outtype=["list"])
    line_ratio = p.newobj("line~",        L_FM,       52, w=60,
                          outtype=["signal","bang"])
    p.link(ratio_dial, 0, pak_ratio, 0)
    p.link(pak_ratio,  0, line_ratio, 0)

    pak_index  = p.newobj("pak 3.0 20.",  L_FM+140,   20, w=120, outtype=["list"])
    line_index = p.newobj("line~",        L_FM+140,   52, w=60,
                          outtype=["signal","bang"])
    p.link(index_dial, 0, pak_index, 0)
    p.link(pak_index,  0, line_index, 0)

    # ---- chaos-modulated ratio ----
    mul_y_dep  = p.newobj("*~", L_FM,  88, w=40, n_in=2, outtype=["signal"])
    p.link(line_y,     0, mul_y_dep, 0)
    p.link(line_depth, 0, mul_y_dep, 1)
    mul_y_2    = p.newobj("*~ 2.", L_FM, 116, w=50, outtype=["signal"])
    p.link(mul_y_dep, 0, mul_y_2, 0)
    add_ratio  = p.newobj("+~", L_FM, 144, w=40, n_in=2, outtype=["signal"])
    p.link(line_ratio, 0, add_ratio, 0)
    p.link(mul_y_2,    0, add_ratio, 1)

    # mod_freq = freq * modulated_ratio
    mul_modfreq = p.newobj("*~", L_FM, 176, w=40, n_in=2, outtype=["signal"])
    p.link(line_freq, 0, mul_modfreq, 0)
    p.link(add_ratio, 0, mul_modfreq, 1)

    mod_phasor = p.newobj("phasor~ 0", L_FM, 208, w=70, outtype=["signal"])
    p.link(mul_modfreq, 0, mod_phasor, 0)
    mod_cos    = p.newobj("cos~",      L_FM, 240, w=50, outtype=["signal"])
    p.link(mod_phasor, 0, mod_cos, 0)

    # chaos-modulated index
    mul_x_dep  = p.newobj("*~", L_FM+200,  88, w=40, n_in=2, outtype=["signal"])
    p.link(line_x,     0, mul_x_dep, 0)
    p.link(line_depth, 0, mul_x_dep, 1)
    mul_x_4    = p.newobj("*~ 4.", L_FM+200, 116, w=50, outtype=["signal"])
    p.link(mul_x_dep, 0, mul_x_4, 0)
    add_index  = p.newobj("+~", L_FM+200, 144, w=40, n_in=2, outtype=["signal"])
    p.link(line_index, 0, add_index, 0)
    p.link(mul_x_4,    0, add_index, 1)

    # phase mod
    pm_mul1    = p.newobj("*~", L_FM+200, 240, w=40, n_in=2, outtype=["signal"])
    p.link(mod_cos,   0, pm_mul1, 0)
    p.link(add_index, 0, pm_mul1, 1)
    pm_scale   = p.newobj("*~ 0.1", L_FM+200, 268, w=60, outtype=["signal"])
    p.link(pm_mul1, 0, pm_scale, 0)

    # carrier
    car_phasor = p.newobj("phasor~ 0", L_FM, 272, w=70, outtype=["signal"])
    p.link(line_freq, 0, car_phasor, 0)
    car_phase_add = p.newobj("+~", L_FM, 304, w=40, n_in=2, outtype=["signal"])
    p.link(car_phasor, 0, car_phase_add, 0)
    p.link(pm_scale,   0, car_phase_add, 1)
    car_cos    = p.newobj("cos~", L_FM, 332, w=50, outtype=["signal"])
    p.link(car_phase_add, 0, car_cos, 0)

    # drive (1..6) into tanh
    drive_pak  = p.newobj("pak 0.3 20.", L_FM+200, 304, w=120, outtype=["list"])
    drive_line = p.newobj("line~",       L_FM+200, 332, w=60,
                          outtype=["signal","bang"])
    p.link(drive_dial, 0, drive_pak, 0)
    p.link(drive_pak,  0, drive_line, 0)
    drive_scl  = p.newobj("scale~ 0. 1. 1. 6.", L_FM+200, 360, w=140,
                          outtype=["signal"])
    p.link(drive_line, 0, drive_scl, 0)
    drive_mul  = p.newobj("*~", L_FM, 360, w=40, n_in=2, outtype=["signal"])
    p.link(car_cos,   0, drive_mul, 0)
    p.link(drive_scl, 0, drive_mul, 1)
    sat        = p.newobj("tanh~", L_FM, 388, w=60, outtype=["signal"])
    p.link(drive_mul, 0, sat, 0)

    # envelope * (1 + chaos_z * depth * 0.3)
    env_mul    = p.newobj("*~", L_FM, 416, w=40, n_in=2, outtype=["signal"])
    p.link(sat,  0, env_mul, 0)
    p.link(adsr, 0, env_mul, 1)

    mul_z_dep   = p.newobj("*~", L_FM+200, 416, w=40, n_in=2, outtype=["signal"])
    p.link(line_z,     0, mul_z_dep, 0)
    p.link(line_depth, 0, mul_z_dep, 1)
    mul_z_03    = p.newobj("*~ 0.3", L_FM+200, 444, w=60, outtype=["signal"])
    p.link(mul_z_dep, 0, mul_z_03, 0)
    add_amp_one = p.newobj("+~ 1.",  L_FM+200, 472, w=60, outtype=["signal"])
    p.link(mul_z_03, 0, add_amp_one, 0)

    amp_mul     = p.newobj("*~", L_FM, 472, w=40, n_in=2, outtype=["signal"])
    p.link(env_mul,    0, amp_mul, 0)
    p.link(add_amp_one,0, amp_mul, 1)

    # Output trim — final headroom regardless of vol dial.
    trim       = p.newobj("*~ 0.5", L_FM, 500, w=70, outtype=["signal"])
    p.link(amp_mul, 0, trim, 0)

    # Volume dial → linear gain via dbtoa, smoothed.
    # Default initial value of pak's left inlet uses dbtoa(-24) ≈ 0.063 so the
    # synth is quiet even before the dial fires its initial value through.
    dbtoa      = p.newobj("dbtoa",          L_FM-160, 500, w=60)
    pak_vol    = p.newobj("pak 0.25 20.",   L_FM-160, 528, w=130, outtype=["list"])
    line_vol   = p.newobj("line~",          L_FM-160, 556, w=60,
                          outtype=["signal","bang"])
    p.link(gain_dial, 0, dbtoa,    0)
    p.link(dbtoa,     0, pak_vol,  0)
    p.link(pak_vol,   0, line_vol, 0)
    vol_mul    = p.newobj("*~", L_FM, 528, w=40, n_in=2, outtype=["signal"])
    p.link(trim,     0, vol_mul, 0)
    p.link(line_vol, 0, vol_mul, 1)

    # Final hard safety limiter — even if the chain explodes, output stays
    # within ±1.0. This is the brick wall against earrape.
    safety     = p.newobj("tanh~", L_FM, 560, w=60, outtype=["signal"])
    p.link(vol_mul, 0, safety, 0)

    # Plugout
    plugout = p.newobj("plugout~ 1 2", L_FM, 590, w=110)
    p.link(safety, 0, plugout, 0)
    p.link(safety, 0, plugout, 1)

    # ===================== INITIALIZATION (loadbang) =====================
    # live.dial sets its display from parameter_initial, but the OUTLET
    # doesn't always fire on load — meaning downstream chains (dbtoa, pak,
    # line~, prepend → js) never see the initial value. We hand-fire each
    # parameter via loadbang → bang → dial.
    lb         = p.newobj("loadbang",       L_MIDI - 200,  20, w=70,
                          n_in=0, outtype=["bang"])
    delay_init = p.newobj("delay 50",       L_MIDI - 200,  50, w=70,
                          outtype=["bang"])
    p.link(lb, 0, delay_init, 0)
    # Trigger forks the bang to all parameters so they fire their initials.
    init_t     = p.newobj("t b b b b b b b b b b b b b b",
                          L_MIDI - 200, 80, w=300,
                          outtype=["bang"]*14)
    p.link(delay_init, 0, init_t, 0)

    # bang → live.dial outputs current value (the parameter_initial)
    targets = [
        gain_dial, sigma_dial, rho_dial, beta_dial, speed_dial,
        ratio_dial, index_dial, atk_dial, rel_dial,
        depth_dial, drive_dial, glide_dial, mode_menu,
    ]
    for i, t in enumerate(targets):
        p.link(init_t, i, t, 0)
    # Last outlet: explicitly set chaos toggle to its initial state (1=on)
    init_one   = p.message("1", L_MIDI - 200, 110, w=30)
    p.link(init_t, len(targets), init_one, 0)
    p.link(init_one, 0, chaos_toggle, 0)

    # Belt-and-suspenders: dedicated [loadmess 1] → chaos_toggle, bypassing
    # init_t entirely. live.toggle's parameter_initial=[1] proved unreliable
    # on fresh device load (Cycling74 docs: "the current value of the
    # parameter is stored as the initial value" — the toggle's intrinsic
    # default of 0 evidently wins over our [1] sometimes), AND the trigger
    # fan-out path went through a `[t b b ... b]` whose previous numoutlets=1
    # bug we've fixed. This dedicated path removes any single point of
    # failure: [loadmess 1] fires "1" at the toggle the moment loadbang
    # arrives, no trigger, no delay, no value coercion.
    chaos_lm   = p.newobj("loadmess 1",      L_MIDI - 100, 140, w=110,
                          n_in=0, outtype=["bang"])
    p.link(chaos_lm, 0, chaos_toggle, 0)

    return p


def main():
    p = build()
    out = p.to_dict()
    with open(OUT, "w") as f:
        json.dump(out, f, indent="\t")
    size = os.path.getsize(OUT)
    print(f"wrote {OUT} ({size:,} bytes, {len(p.boxes)} boxes, {len(p.lines)} lines)")


if __name__ == "__main__":
    main()
