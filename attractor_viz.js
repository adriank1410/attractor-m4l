// attractor_viz.js — chaos engine + triple-trace scrolling oscilloscope.
//
// Visual concept: time on the X axis, value on Y. Three traces — one per
// chaos axis (X, Y, Z) — scroll from right (newest) to left (oldest).
// Each trace has its own hue from the per-mode palette, bloomed for glow,
// alpha-faded toward the older end so the most recent samples pop. A hot
// dot at the right edge marks the live "now" sample of each trace. This
// fills the wide horizontal Live device strip naturally — orbital phase
// space rendering wasted half the panel.

autowatch = 1;
inlets    = 1;
outlets   = 3;          // x, y, z floats for synth modulation

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill        = 0;

var DEBUG         = false;

var TRAIL_LEN     = 700;           // horizontal samples (≈ 1 sample per device pixel of width)
var BG_TOP        = [0.040, 0.045, 0.072];
var BG_BOTTOM     = [0.010, 0.010, 0.020];
var GRID_COLOR    = [0.32, 0.36, 0.55, 0.10];
var FRAME_COLOR   = [0.42, 0.46, 0.68, 0.30];
var INTEGRATIONS_PER_BANG = 3;
var PREWARM_STEPS = 250;
var FADE_HOLD_MS  = 80;
var FADE_TAIL_MS  = 1400;

// Per-mode palette: three hues for the three chaos axes (x, y, z).
//   x = the lead voice color
//   y = mid harmonic
//   z = deep bass (also drives amp mod)
var PALETTES = [
  // 0 Lorenz — cosmic cyan / magenta / electric violet
  { x: 195, y: 290, z: 320, sat: 0.70, lum: 0.55, halo: [0.10, 0.06, 0.42] },
  // 1 Rössler — green / amber / orange (organic)
  { x:  85, y:  45, z:  20, sat: 0.75, lum: 0.55, halo: [0.06, 0.20, 0.10] },
  // 2 Aizawa — pink / purple / hot magenta (warm cosmic)
  { x: 330, y: 280, z: 220, sat: 0.70, lum: 0.55, halo: [0.30, 0.05, 0.30] },
  // 3 Thomas — ice (cyan / blue / teal)
  { x: 195, y: 215, z: 180, sat: 0.60, lum: 0.60, halo: [0.04, 0.18, 0.30] },
];

var sx = 0.1, sy = 0.0, sz = 0.0;
var p_sigma = 10.0, p_rho = 28.0, p_beta = 2.6667;
var p_speed = 0.005, p_mode = 0;

var trail   = new Array(TRAIL_LEN);
var head    = 0;
var trailFill = 0;
var bangCount = 0;
var lastBangMs = 0;
var lastXYZ = [0, 0, 0];

// Per-axis auto-amplitude tracker. Without this the trace can sit close to
// zero and look like a flat line, especially in modes (Aizawa, Thomas) where
// the chaos magnitude is small. We track a slowly-decaying recent peak per
// axis and divide by it before plotting, so each trace fills its panel band.
var peakX = 0.5, peakY = 0.5, peakZ = 0.5;
var PEAK_DECAY = 0.9985;     // peaks fade slowly while the chaos plays
var PEAK_MIN   = 0.15;       // floor so we don't divide by ~zero

// Per-axis DC blocker. Each attractor mode has a different natural mean (e.g.
// Lorenz z hovers around +28; Aizawa z bobs around its own offset). Without DC
// removal the trace appears pushed off-center vertically, looking like a
// shifted baseline rather than centered on zero. We subtract a slowly-tracked
// running mean before peak normalization and plotting, so every mode appears
// vertically centered regardless of its natural offset.
var meanX = 0, meanY = 0, meanZ = 0;
var DC_ALPHA = 1.0 / 1500;   // ≈ 5–10s settle time at 200 Hz × 3 substeps

for (var i = 0; i < TRAIL_LEN; i++) trail[i] = [0, 0, 0];

// ---- parameter setters -----------------------------------------------------
function sigma(v) { p_sigma = +v; }
function rho(v)   { p_rho   = +v; }
function beta(v)  { p_beta  = +v; }
function speed(v) { p_speed = +v; }
function mode(v)  {
  // Clamp incoming value defensively — a stray "mode 7" would otherwise leave
  // p_mode out of range, falling through bang()'s switch to Lorenz-default
  // integration but skipping resetState/prewarm because m !== p_mode.
  var m = v | 0;
  if (m < 0) m = 0;
  if (m > 3) m = 3;
  if (m !== p_mode) { p_mode = m; resetState(); prewarm(); }
}
function resetState() { sx = 0.1; sy = 0.0; sz = 0.0;
                        meanX = meanY = meanZ = 0; }
function prewarm() {
  // Run one prewarm pass so the chaos has converged onto its attractor before
  // the user sees anything. During the second half we accumulate the mean per
  // axis and seed meanX/Y/Z from it — that way DC removal is already correct
  // on frame zero, no visible "drift to center" warm-up.
  var sumX = 0, sumY = 0, sumZ = 0, n = 0;
  var half = PREWARM_STEPS >> 1;
  for (var i = 0; i < PREWARM_STEPS; i++) {
    var v;
    switch (p_mode) {
      case 1:  v = step_rossler(p_speed); break;
      case 2:  v = step_aizawa (p_speed); break;
      case 3:  v = step_thomas (p_speed); break;
      default: v = step_lorenz (p_speed); break;
    }
    if (!isFinite(sx) || !isFinite(sy) || !isFinite(sz)) {
      sx = 0.1; sy = 0; sz = 0;
      break;
    }
    if (i >= half) {
      sumX += v[0]; sumY += v[1]; sumZ += v[2]; n++;
    }
  }
  if (n > 0) {
    meanX = sumX / n;
    meanY = sumY / n;
    meanZ = sumZ / n;
  }
}
function clear() { trailFill = 0; head = 0; bangCount = 0;
                   for (var i = 0; i < TRAIL_LEN; i++) trail[i] = [0, 0, 0];
                   resetState(); prewarm(); mgraphics.redraw(); }

// ---- chaos integrators -----------------------------------------------------
function step_lorenz(dt) {
  var dx = p_sigma * (sy - sx);
  var dy = sx * (p_rho - sz) - sy;
  var dz = sx * sy - p_beta * sz;
  sx += dx * dt;  sy += dy * dt;  sz += dz * dt;
  return [sx * 0.04, sy * 0.04, sz * 0.04 - 0.5];
}
function step_rossler(dt) {
  var a = p_sigma * 0.02, b = p_beta * 0.075, c = p_rho * 0.2;
  var dx = -sy - sz, dy = sx + a * sy, dz = b + sz * (sx - c);
  sx += dx * dt * 4;  sy += dy * dt * 4;  sz += dz * dt * 4;
  return [sx * 0.08, sy * 0.08, sz * 0.06 - 0.3];
}
function step_aizawa(dt) {
  var a = 0.5 + p_sigma * 0.05, b = 0.7, c = 0.3 + p_rho * 0.03;
  var d = 3.5, e = 0.25, f = 0.1;
  var dx = (sz - b) * sx - d * sy;
  var dy = d * sx + (sz - b) * sy;
  var dz = c + a * sz - (sz*sz*sz)/3 - (sx*sx + sy*sy) * (1 + e*sz) + f*sz*sx*sx*sx;
  sx += dx * dt * 8;  sy += dy * dt * 8;  sz += dz * dt * 8;
  return [sx * 0.6, sy * 0.6, sz * 0.4 - 0.2];
}
function step_thomas(dt) {
  var b = p_beta * 0.07;
  var dx = Math.sin(sy) - b * sx;
  var dy = Math.sin(sz) - b * sy;
  var dz = Math.sin(sx) - b * sz;
  sx += dx * dt * 30;  sy += dy * dt * 30;  sz += dz * dt * 30;
  return [sx * 0.3, sy * 0.3, sz * 0.3];
}

function clipv(v) { return v > 1.5 ? 1.5 : (v < -1.5 ? -1.5 : v); }

// ---- main tick (chaos compute) ---------------------------------------------
function bang() {
  var n;
  for (var s = 0; s < INTEGRATIONS_PER_BANG; s++) {
    switch (p_mode) {
      case 1:  n = step_rossler(p_speed); break;
      case 2:  n = step_aizawa (p_speed); break;
      case 3:  n = step_thomas (p_speed); break;
      default: n = step_lorenz (p_speed); break;
    }
  }
  if (!isFinite(n[0]) || !isFinite(n[1]) || !isFinite(n[2])) {
    resetState();
    n = [0, 0, 0];
  }
  var cx = clipv(n[0]), cy = clipv(n[1]), cz = clipv(n[2]);
  outlet(0, cx);
  outlet(1, cy);
  outlet(2, cz);

  // Track running mean per axis (DC component) — see meanX/Y/Z declaration.
  meanX += (cx - meanX) * DC_ALPHA;
  meanY += (cy - meanY) * DC_ALPHA;
  meanZ += (cz - meanZ) * DC_ALPHA;

  // DC-removed values used for ALL visualization math (peak track + draw).
  var dx = cx - meanX, dy = cy - meanY, dz = cz - meanZ;

  // Update auto-amplitude peaks (on DC-removed signal so peak == swing, not offset)
  var ax = Math.abs(dx);
  var ay = Math.abs(dy);
  var az = Math.abs(dz);
  peakX = ax > peakX ? ax : peakX * PEAK_DECAY;
  peakY = ay > peakY ? ay : peakY * PEAK_DECAY;
  peakZ = az > peakZ ? az : peakZ * PEAK_DECAY;
  if (peakX < PEAK_MIN) peakX = PEAK_MIN;
  if (peakY < PEAK_MIN) peakY = PEAK_MIN;
  if (peakZ < PEAK_MIN) peakZ = PEAK_MIN;

  // Store DC-removed values in trail — draw_trace consumes these directly.
  trail[head] = [dx, dy, dz];
  head = (head + 1) % TRAIL_LEN;
  if (trailFill < TRAIL_LEN) trailFill++;
  bangCount++;
  lastBangMs = (new Date()).getTime();
  lastXYZ = [cx, cy, cz];
  mgraphics.redraw();
}

// ---- fade tick (always-on slow metro) --------------------------------------
function fade() {
  var dt = (new Date()).getTime() - lastBangMs;
  if (dt > FADE_HOLD_MS + FADE_TAIL_MS + 200) return;
  mgraphics.redraw();
}

// ---- helpers ---------------------------------------------------------------
function hsl_to_rgb(h, s, l) {
  h = ((h % 360) + 360) % 360 / 360;
  if (s === 0) return [l, l, l];
  var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
  var p = 2 * l - q;
  return [h2c(p, q, h + 1/3), h2c(p, q, h), h2c(p, q, h - 1/3)];
}
function h2c(p, q, t) {
  if (t < 0) t += 1;
  if (t > 1) t -= 1;
  if (t < 1/6) return p + (q - p) * 6 * t;
  if (t < 1/2) return q;
  if (t < 2/3) return p + (q - p) * (2/3 - t) * 6;
  return p;
}

function paint_bg(w, h) {
  var stripes = 16, sh = h / stripes;
  for (var i = 0; i < stripes; i++) {
    var t = i / (stripes - 1);
    var r = BG_TOP[0] * (1 - t) + BG_BOTTOM[0] * t;
    var g = BG_TOP[1] * (1 - t) + BG_BOTTOM[1] * t;
    var b = BG_TOP[2] * (1 - t) + BG_BOTTOM[2] * t;
    mgraphics.set_source_rgba(r, g, b, 1);
    mgraphics.rectangle(0, i * sh - 0.5, w, sh + 1);
    mgraphics.fill();
  }
}

function paint_centerline(w, h, palette, alpha) {
  // Single faint horizontal line at y=center as zero reference + soft glow
  // bands above & below.
  var cy = h * 0.5;
  // Gradient halo bands
  for (var k = 1; k <= 6; k++) {
    var bandH = k * (h * 0.05);
    var a = 0.04 * Math.pow(1 - k / 6, 1.6) * alpha;
    mgraphics.set_source_rgba(palette.halo[0], palette.halo[1], palette.halo[2], a);
    mgraphics.rectangle(0, cy - bandH, w, bandH * 2);
    mgraphics.fill();
  }
  mgraphics.set_source_rgba(GRID_COLOR[0], GRID_COLOR[1], GRID_COLOR[2], GRID_COLOR[3] * alpha);
  mgraphics.set_line_width(1);
  mgraphics.move_to(0, cy);
  mgraphics.line_to(w, cy);
  mgraphics.stroke();
}

// Draw one trace as a polyline. axis: 0=x, 1=y, 2=z.
// kStart..kEnd is the sample range to draw (inclusive bounds, indexes 0..n-1).
// invPeak normalizes the value so each axis fills the band even if its
// natural magnitude is small.
function draw_trace(axis, n, kStart, kEnd, w, cy, ySc, invPeak) {
  for (var k = kStart; k <= kEnd; k++) {
    var idx  = (head - n + k + TRAIL_LEN) % TRAIL_LEN;
    var screen_x = (k / (n - 1)) * w;
    var v = trail[idx][axis] * invPeak;
    if (v >  1.0) v =  1.0;
    if (v < -1.0) v = -1.0;
    var screen_y = cy - v * ySc;
    if (k === kStart) mgraphics.move_to(screen_x, screen_y);
    else              mgraphics.line_to(screen_x, screen_y);
  }
  mgraphics.stroke();
}

// ---- paint -----------------------------------------------------------------
function paint() {
  var w = box.rect[2] - box.rect[0];
  var h = box.rect[3] - box.rect[1];
  if (w < 4 || h < 4) return;

  var dt = (new Date()).getTime() - lastBangMs;
  var alpha;
  if (dt <= FADE_HOLD_MS)            alpha = 1.0;
  else if (dt < FADE_HOLD_MS + FADE_TAIL_MS) {
    var u = (dt - FADE_HOLD_MS) / FADE_TAIL_MS;
    alpha = Math.pow(1 - u, 1.6);
  } else                              alpha = 0.0;

  paint_bg(w, h);

  if (alpha < 0.001) {
    paint_frame(w, h);
    return;
  }

  var palette = PALETTES[p_mode] || PALETTES[0];
  paint_centerline(w, h, palette, alpha);

  var n = trailFill;
  if (n < 2) {
    paint_frame(w, h);
    return;
  }

  var cy  = h * 0.5;
  // ySc * max_normalized_value must stay < h/2 or the trace clips against
  // the panel edge. With clip at ±1.0 and ySc = 0.46*h the trace lives in
  // [cy - 0.46h, cy + 0.46h] — 4% margin on each edge.
  var ySc = h * 0.46;

  mgraphics.set_line_cap("round");
  mgraphics.set_line_join("round");

  // Three traces, drawn in two passes each (bloom + line), oldest underneath
  // so the most recent samples are visually on top.
  var axes = [
    { idx: 0, hue: palette.x, invPeak: 1.0 / peakX },
    { idx: 1, hue: palette.y, invPeak: 1.0 / peakY },
    { idx: 2, hue: palette.z, invPeak: 1.0 / peakZ },
  ];

  // We split the trace into chunks so we can fade older samples — each
  // chunk gets its own alpha. 8 chunks is enough for a smooth gradient
  // without too many state changes.
  var CHUNKS = 8;
  for (var ai = 0; ai < axes.length; ai++) {
    var axis = axes[ai];

    for (var ci = 0; ci < CHUNKS; ci++) {
      var kStart = Math.floor(ci * n / CHUNKS);
      var kEnd   = Math.min(n - 1, Math.floor((ci + 1) * n / CHUNKS));
      if (kEnd <= kStart) continue;
      // Overlap by 1 to avoid gaps between chunks
      if (ci > 0) kStart -= 1;

      var t = (ci + 0.5) / CHUNKS;          // 0 (oldest) → 1 (newest)
      // Linear ramp instead of pow(t, 1.5): the older end was almost invisible
      // before, leaving the left side of the panel feeling empty even when
      // the trail was full. Ranges 0.4 (oldest) to 1.0 (newest).
      var chunkAlpha = (0.4 + 0.6 * t) * alpha;

      // Bloom pass — wide, low alpha
      var c = hsl_to_rgb(axis.hue, palette.sat, palette.lum + 0.05);
      mgraphics.set_source_rgba(c[0], c[1], c[2], chunkAlpha * 0.22);
      mgraphics.set_line_width(5.5);
      draw_trace(axis.idx, n, kStart, kEnd, w, cy, ySc, axis.invPeak);

      // Sharp pass — thin, high alpha
      var c2 = hsl_to_rgb(axis.hue, palette.sat + 0.15, palette.lum + 0.20);
      mgraphics.set_source_rgba(c2[0], c2[1], c2[2], chunkAlpha * 0.95);
      mgraphics.set_line_width(1.2 + 0.6 * t);
      draw_trace(axis.idx, n, kStart, kEnd, w, cy, ySc, axis.invPeak);
    }

    // Hot dot at the right edge — the live "now" sample (auto-scaled)
    var nowV = trail[(head - 1 + TRAIL_LEN) % TRAIL_LEN][axis.idx] * axis.invPeak;
    if (nowV >  1.0) nowV =  1.0;
    if (nowV < -1.0) nowV = -1.0;
    var screen_y = cy - nowV * ySc;
    var cdot = hsl_to_rgb(axis.hue, palette.sat + 0.25, 0.78);
    // bloom rings
    for (var rr = 12; rr > 0; rr -= 2) {
      var ga = 0.10 * (rr / 12) * alpha;
      mgraphics.set_source_rgba(cdot[0], cdot[1], cdot[2], ga);
      mgraphics.ellipse(w - rr - 4, screen_y - rr, rr * 2, rr * 2);
      mgraphics.fill();
    }
    // hot core
    mgraphics.set_source_rgba(1, 1, 1, 0.9 * alpha);
    mgraphics.ellipse(w - 4 - 2, screen_y - 2, 4, 4);
    mgraphics.fill();
  }

  if (DEBUG) {
    mgraphics.set_source_rgba(0.55, 0.62, 0.80, 0.85);
    mgraphics.select_font_face("Arial");
    mgraphics.set_font_size(10);
    var lines = [
      "ticks: " + bangCount + "   fill: " + trailFill + "/" + TRAIL_LEN,
      "box:   " + Math.round(w) + " × " + Math.round(h),
      "alpha: " + alpha.toFixed(2) + "   dt=" + dt + "ms",
      "last:  x=" + lastXYZ[0].toFixed(3) +
            "  y=" + lastXYZ[1].toFixed(3) +
            "  z=" + lastXYZ[2].toFixed(3),
    ];
    var ly = 14;
    for (var li = 0; li < lines.length; li++) {
      mgraphics.move_to(6, ly);
      mgraphics.text_path(lines[li]);
      mgraphics.fill();
      ly += 12;
    }
  }

  paint_frame(w, h);
}

function paint_frame(w, h) {
  mgraphics.set_source_rgba(FRAME_COLOR[0], FRAME_COLOR[1], FRAME_COLOR[2], FRAME_COLOR[3]);
  mgraphics.set_line_width(1);
  mgraphics.rectangle(0.5, 0.5, w - 1, h - 1);
  mgraphics.stroke();
}

// Initial prewarm so the chaos has converged onto the attractor and DC means
// are seeded before the first metro tick. Without this, the trace would drift
// toward center over the first few seconds (DC blocker still settling).
prewarm();
mgraphics.redraw();
