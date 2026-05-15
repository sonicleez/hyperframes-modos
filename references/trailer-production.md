# Trailer Production — High-Tempo Video Edit from Existing Clips

End-to-end workflow for editing a trailer from a directory of source video clips using HyperFrames.

---

## Prerequisites

- FFmpeg installed (`brew install ffmpeg`) — needed by HyperFrames render and for metadata extraction
- Node.js 18+ and `npx hyperframes` CLI available
- Source videos in a local directory (e.g., `~/Downloads/Videos/`)

## Workflow

### 1. Analyze Source Videos

```bash
cd /path/to/videos
for f in *.mp4; do
  ffprobe -v error -show_entries format=duration -show_entries stream=width,height,codec_name -of json "$f" | \
  python3 -c "import json,sys; d=json.load(sys.stdin); dur=d.get('format',{}).get('duration','?'); vs=[s for s in d.get('streams',[]) if s.get('codec_type')=='video']; print(f'{dur}s | {vs[0].get(\"width\",\"?\")}x{vs[0].get(\"height\",\"?\")} | {f[:60]}')" 2>/dev/null
done
```

Note: ffprobe must be in PATH. On macOS with Homebrew: `/opt/homebrew/bin/ffprobe`. Python subprocess may not share the same PATH — invoke with full path if needed.

### 2. Select and Rename Clips

Pick 8-12 clips for variety (combat, atmosphere, close-ups, wide shots). Copy to `assets/` with clean names:

```bash
mkdir -p project-name/assets
cp "/path/long filename with spaces.mp4" project-name/assets/clean-name.mp4
```

Clean filenames avoid path issues and make HTML references readable.

### 3. Initialize Project

```bash
npx hyperframes init project-name
cd project-name
```

### 4. Storyboard (Follow 11 Laws)

For a 30s high-tempo trailer, use this rhythm pattern:
- **0-3s**: Cold open — hero portrait + title SLAM
- **3-7s**: Rapid cuts — 2s each, flash transitions (SLAM-proof-SLAM)
- **7-13s**: Build — 3s each, more atmosphere
- **13-19s**: Acceleration — kinetic text, crosshair marks
- **19-25s**: PEAK — most dramatic clip, revelation text
- **25-28s**: Breathing room — slow down for catharsis (Law 9)
- **28-30s**: Final title card + fade out

**Kinetic text verbs** (from beat-direction.md energy table):
- High: SLAMS, CRASHES, PUNCHES, STAMPS, SHATTERS
- Medium: CASCADES, SLIDES, DROPS, FILLS, DRAWS
- Low: types on, FLOATS, morphs, COUNTS UP, fades in

### 5. Track Layout

For multi-scene compositions with multiple element types per scene:

| Track | Content |
|-------|---------|
| 0 | Video clips (one per scene, non-overlapping) |
| 1 | Vignettes (one per scene, matching video timing) |
| 2 | Texture overlays (grain, burn) |
| 3 | Grid floor, decorative elements |
| 4 | Crosshairs, markers |
| 5 | Kinetic text, titles |
| 6 | Accent lines |
| 10 | Flash overlays (transition between scenes) |

### 6. Write Composition

Use the `templates/trailer-high-tempo.html` template. Key patterns:

**Video element (MUST be direct child of root):**
```html
<video id="s1-vid" class="vid clip" src="assets/clip.mp4" muted
  data-start="0" data-duration="3" data-track-index="0"
  data-media-start="0" crossorigin="anonymous"></video>
```

**Flash transition between scenes:**
```html
<div id="flash1" class="overlay clip flash-overlay"
  data-start="2.95" data-duration="0.15" data-track-index="10"></div>
```
```js
tl.fromTo('#flash1', { opacity: 0.9 }, { opacity: 0, duration: 0.12, ease: 'power2.in' }, 2.95);
tl.set('#flash1', { opacity: 0 }, 3.1); // hard-kill — required!
```

**Kinetic text (no CSS transform — let GSAP handle centering):**
```html
<!-- ❌ WRONG: CSS transform conflicts with GSAP -->
<div style="top:50%;left:50%;transform:translate(-50%,-50%)">TEXT</div>
<!-- ✅ CORRECT: Position with top/left, GSAP handles centering -->
<div id="s1-text" style="top:50%;left:50%;" >TEXT</div>
```

### 7. Lint and Validate

```bash
npx hyperframes lint    # Must pass 0 errors
npx hyperframes validate # Must pass
```

**Common lint errors and fixes:**

| Error | Cause | Fix |
|-------|-------|-----|
| `video_nested_in_timed_element` | `<video>` inside a `<div>` with `data-start` | Move `<video>` to direct child of root |
| `media_missing_data_start` | `<video>` has `src` but no `data-start` | Add `data-start="0"` |
| `media_missing_id` | `<video>` has `data-start` but no `id` | Add unique `id` |
| `invalid_inline_script_syntax` | JS syntax error (e.g. `window __timelines`) | Fix typo in `window.__timelines` |
| `gsap_css_transform_conflict` | CSS `transform: translate()` + GSAP animating x/y | Remove CSS transform, use GSAP `xPercent`/`yPercent` |
| `gsap_exit_missing_hard_kill` | GSAP exit without matching `tl.set()` | Add `tl.set('#el', { opacity: 0 }, end_time)` |
| `overlapping_clips_same_track` | Two clips on same track-index overlap | Adjust timing or use different track |
| `timeline_registry_missing_init` | Missing `window.__timelines = window.__timelines \|\| {};` | Add init line before assignment |
| `duplicate_media_discovery_risk` | Same video src+start+duration used twice | Use different `data-media-start` or different tracks |

### 8. Render and Verify

```bash
npx hyperframes render --quality draft --output renders/draft.mp4
mkdir -p renders/frames
for t in 0.5 1 3 5 7 10 13 16 19 22 25 29; do
  ffmpeg -y -ss "$t" -i renders/draft.mp4 -frames:v 1 -q:v 2 "renders/frames/t${t}s.png"
done
```

Read every PNG. Confirm: expected visual on-screen, text readable, no blank frames.

### 9. Final Render

```bash
npx hyperframes render --quality high --output renders/final.mp4
```

---

## Pitfalls

1. **ffprobe PATH**: On macOS, `ffprobe` is at `/opt/homebrew/bin/ffprobe`. Python subprocess may not inherit shell PATH. Use full path or set PATH explicitly.

2. **Video nesting** (MUST): `<video>` MUST be direct child of root composition. Do NOT wrap in timed containers. Use CSS classes for video styling.

3. **CSS transform conflict**: GSAP overwrites entire `transform`. Replace CSS `transform: translate(-50%, -50%)` with GSAP `xPercent: -50, yPercent: -50`.

4. **Flash hard-kill**: After `fromTo` fade, add `tl.set('#flash', { opacity: 0 }, end_time)` for non-linear seeking safety.

5. **Duration anchor**: Every timeline MUST end with `tl.to({}, { duration: SLOT_DURATION }, 0)`. Law 11 — missing anchor causes black frame flashes.

6. **Timeline registry typo**: `window.__timelines` uses double underscore and a dot. `window __timelines` (missing dot) is a syntax error that kills the entire script silently.

7. **Track density**: 30s+ multi-scene trailers with 10+ clips will trigger track density warnings. Acceptable for single-file compositions. Split into sub-compositions if unwieldy.