# HyperFrames Render Contract — Complete Specification

The 11 binding rules that every composition MUST follow for deterministic, frame-accurate rendering. Violating any rule produces broken output.

---

## Rule 1: Root Container

Every composition's root `<div>` MUST have:
- `id` — unique identifier
- `data-composition-id` — unique composition ID
- `data-start="0"` (for root) or seconds/clip-reference
- `data-width` and `data-height` — pixel dimensions (e.g. 1920x1080, 1080x1920)

```html
<div id="stage" data-composition-id="my-video" data-start="0" data-width="1920" data-height="1080">
```

## Rule 2: Clip Class

Every timed visible element (div, img, span) MUST have `class="clip"`.
EXCEPTION: `<video>` and `<audio>` — do NOT add `class="clip"` to media elements.

```html
<div id="title" class="clip" data-start="0" data-duration="5" data-track-index="1">Hello</div>
<!-- NOT: <video class="clip" ...> -->
```

## Rule 3: Timing Attributes

Every timed element needs:
- `data-start` — seconds or clip ID reference (`"intro"` or `"intro + 2"`)
- `data-duration` — seconds (required for img/div/compositions; video/audio defaults to media duration)
- `data-track-index` — integer; same-track clips cannot overlap

## Rule 4: Video + Audio

- `<video>` MUST have `muted` and `crossorigin="anonymous"` attributes
- `<video>` MUST have its own unique `id` attribute — the renderer requires id to discover media elements. Without id, video will be FROZEN in renders.
- `<video>` MUST be a direct child of the root composition div. Do NOT nest `<video>` inside a timed wrapper `<div>` that has `data-start`. The framework cannot manage playback of nested media — video will be FROZEN in renders. Use CSS `object-fit: cover` on the video element itself for layout styling.
- Audio is ALWAYS a separate `<audio>` element (sibling, not child)
- NEVER use video's built-in audio track

```html
<!-- ✅ CORRECT: video is direct child of root composition -->
<video id="scene1-vid" class="vid clip" src="video.mp4" muted
  data-start="0" data-duration="10" data-track-index="0"
  data-media-start="2" crossorigin="anonymous"></video>

<!-- ❌ WRONG: video nested inside a timed wrapper — will be FROZEN -->
<div id="wrapper" class="clip" data-start="0" data-duration="10" data-track-index="0">
  <video id="vid" src="video.mp4" muted data-start="0"></video>
</div>
```

## Rule 5: GSAP Timeline Registration

Every composition registers exactly one GSAP timeline:

```js
window.__timelines = window.__timelines || {};
window.__timelines["<composition-id>"] = gsap.timeline({ paused: true });
```

**Common typo pitfall:** Writing `window __timelines` (missing dot) instead of `window.__timelines` produces a syntax error that kills the entire script. This is easy to miss in a large composition. Always verify the dot is present.

The framework controls playback. Do NOT call `.play()`, `.pause()`, or set `.currentTime` on media.

## Rule 6: Duration Anchor (Law 11)

Every sub-composition timeline MUST end with a no-op anchor tween:

```js
tl.to({}, { duration: SLOT_DURATION }, 0);
```

Without this, if `tl.duration()` < `data-duration`, the framework hides the sub-composition — black frame flash. Non-negotiable.

## Rule 7: Deterministic Rendering

- NO `Math.random()` — use seeded PRNG (mulberry32, etc.)
- NO `Date.now()` or time-based logic
- NO network fetches at render time
- NO `AnalyserNode` or real-time audio (pre-compute offline)

## Rule 8: CSS Positioning

- Content containers MUST use `width: 100%; height: 100%; padding: Npx; display: flex; flex-direction: column; gap: Npx; box-sizing: border-box`
- NEVER use `position: absolute; top: Npx` on content containers (decorative elements only)
- Use `max-width` for text wrapping, never `<br>`

## Rule 9: Animation Rules

- Only animate visual properties: `opacity`, `x`, `y`, `scale`, `rotation`, `color`, `backgroundColor`, `borderRadius`, transforms
- Do NOT animate `visibility`, `display`
- Do NOT call `video.play()`/`audio.play()`
- Never animate `<video>` dimensions directly — animate a wrapper `<div>` instead (but NOT a timed wrapper, see Rule 4)
- NO `repeat: -1` — always finite: `repeat: Math.ceil(duration / cycleDuration) - 1`
- Never build timelines inside `async`/`await`, `setTimeout`, or Promises
- **GSAP overwrites the full CSS `transform`.** If your CSS has `transform: translate(-50%, -50%)` and GSAP animates `x` or `y`, GSAP will discard the CSS centering. Replace CSS transforms with GSAP properties: use `xPercent: -50`, `yPercent: -50` in your `gsap.from()` / `gsap.to()` calls. The same applies to CSS `scale` in transforms — use GSAP's `scale` property instead.
- **Flash transition hard-kill:** When animating a white flash overlay with `gsap.fromTo('#flash', { opacity: 0.9 }, { opacity: 0, duration: 0.12 })`, add a hard-kill `tl.set('#flash', { opacity: 0 }, <end_time>)` immediately after. Without this, non-linear seeking can land after the fade and leave stale visibility.

## Rule 10: Sub-Compositions

Sub-compositions loaded via `data-composition-src` use `<template>` wrapper:

```html
<template id="my-comp-template">
  <div data-composition-id="my-comp" data-width="1920" data-height="1080">
    <style>[data-composition-id="my-comp"] { /* scoped */ }</style>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.14.2/dist/gsap.min.js"></script>
    <script>
      (function(){
        const tl = gsap.timeline({ paused: true });
        // tweens...
        tl.to({}, { duration: SLOT_DURATION }, 0);
        window.__timelines["my-comp"] = tl;
      })();
    </script>
  </div>
</template>
```

Standalone compositions (main index.html) do NOT use `<template>` — put the div directly in `<body>`.

Load in root:
```html
<div id="el-1" data-composition-id="my-comp" data-composition-src="compositions/my-comp.html" data-start="0" data-duration="10" data-track-index="1"></div>
```

## Rule 11: Scene Transitions

- ALWAYS use transitions between scenes (no jump cuts)
- ALWAYS use entrance animations (`gsap.from()`) on every element in every scene
- NEVER use exit animations (`gsap.to(..., {opacity:0})`) except on the FINAL scene
- The transition IS the exit — outgoing scene content MUST be fully visible when transition starts

---

## Variables (Parametrized Compositions)

Declare on `<html>` root:
```html
<html data-composition-variables='[
  {"id":"title","type":"string","label":"Title","default":"Hello"},
  {"id":"theme","type":"enum","label":"Theme","default":"light","options":[
    {"value":"light","label":"Light"},
    {"value":"dark","label":"Dark"}
  ]}
]'>
```

Read in script:
```js
const { title, theme } = window.__hyperframes.getVariables();
```

Override at render:
```bash
npx hyperframes render --variables '{"title":"Q4 Report","theme":"dark"}'
```

Per-instance override on host element:
```html
<div data-composition-id="card-pro" data-composition-src="compositions/card.html"
     data-variable-values='{"title":"Pro","price":"$29"}'></div>
```

---

## Quality Verification

### Fast (block on results)
```bash
npx hyperframes lint
npx hyperframes validate
```

### Slow (run in parallel)
```bash
npx hyperframes inspect           # visual layout check
npx hyperframes inspect --json    # machine-readable output
npx hyperframes inspect --at 1.5,4,7.25   # specific timestamps
npx hyperframes inspect --samples 15       # dense videos
```

### Contrast Audit
`npx hyperframes validate` runs WCAG contrast audit. Fix warnings by brightening/darkening colors within the same palette family. Use `--no-contrast` when iterating rapidly.

### Design Adherence Check
If `design.md` exists, verify:
1. Every hex value appears in design.md's palette
2. Font families and weights match
3. Border-radius matches declared corner style
4. Padding/gap values within declared density range
5. Shadow usage matches declared depth level
6. No anti-patterns from the "What NOT to Do" list

### Animation Map
```bash
node skills/hyperframes/scripts/animation-map.mjs <composition-dir> \
  --out <composition-dir>/.hyperframes/anim-map
```

Check: per-tween summaries, ASCII timeline, stagger detection, dead zones, element lifecycles, scene snapshots, flags (offscreen, collision, invisible, paced-fast, paced-slow).

### Visual Verification Gate (from Student Kit)

Lint passing ≠ design working. Extract frames at word-exact timestamps and READ every PNG:

```bash
mkdir -p renders/frames
for pair in "<t>:<label>" "<t>:<label>" ...; do
  t="${pair%%:*}"; label="${pair##*:}"
  ffmpeg -y -ss "$t" -i renders/draft.mp4 -frames:v 1 -q:v 2 "renders/frames/t${t}-${label}.png"
done
```

Confirm per frame: expected visual, face not cropped, correct mode, captions readable, no blank frames, no overflow.