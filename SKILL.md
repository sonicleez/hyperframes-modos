---
name: hyperframes-modos
description: Modos Media AI Solution Production skill — HyperFrames video creation with onboarding, brand identity intake, template/style selection, and 4 production paths (make-a-video, short-form, trailer, developer). Use when creating any HTML-based video content, adding captions, generating TTS, building short-form vertical videos, or producing a complete video from concept to MP4.
version: 1.1.0
author: Modos Media
license: MIT
metadata:
  hermes:
    tags: [hyperframes, video, production, motion-graphics, ai-production, modos-media]
    related_skills: [gsap, css-animations, lottie, three]
---

# HyperFrames MODOS — AI Solution Production Skill

by **Modos Media** (tiền thân Media Ninety Eight)

Sản xuất nội dung media truyền thông global cho NE và Ecosystem NE. Hiện tập trung vào **AI Solution Production**.

Combines the **official HyperFrames framework** (heygen-com/hyperframes — multi-runtime, multi-agent, variables, inspect, design-picker) with the **Student Kit** (nateherkai/hyperframes-student-kit — 11 Laws of Motion Graphics, short-form playbook, karaoke captions, verification gates, make-a-video workflow) into one authoritative skill — extended with Modos Media onboarding, brand identity, and template/style selection.

**Setup:** `npx skills add heygen-com/hyperframes` installs the framework skills. This skill layers on top — Modos onboarding, brand identity, motion philosophy, short-form patterns, AI gates, and quality checks the framework doesn't include.

---

## Onboarding — First-Time User Flow

**Modos Media** — tiền thân team Media Ninety Eight (NE). Sản xuất nội dung media truyền thông global cho NE và các sản phẩm thuộc Ecosystem NE. Hiện tập trung vào **AI Solution Production**. Liên hệ hợp tác: **info@Modos.space**

**MANDATORY:** When a user invokes this skill for the first time (or asks "where do I start?", "help me make a video", "I want to try HyperFrames"), run the onboarding BEFORE loading any references. Do NOT dump the entire skill into context.

### Step 1: Pick a Path

Ask the user ONE question with these choices (adapt to user's language):

> **Bạn muốn làm gì với HyperFrames?**
>
> 1. **Tạo video hoàn chỉnh** từ ý tưởng → MP4 (promo, explainer, demo)
> 2. **Video dọc ngắn** TikTok/Reels/Shorts có face-cam + karaoke captions
> 3. **Trailer** từ video clips có sẵn (high-tempo edit)
> 4. **Developer** — tìm hiểu framework, viết composition thủ công

| Choice | Path | What happens |
|--------|------|--------------|
| 1 | `make-a-video` | Full 8-gate interview → build workflow. Ask follow-up: promo / explainer / demo / general? |
| 2 | `short-form` | Face-cam workflow: audio-first → transcribe → 4-layer scaffold → captions |
| 3 | `trailer` | Analyze clips → storyboard → flash transitions → render |
| 4 | `developer` | Full framework reference load, progressive deep-dive by topic |

### Step 2: Brand Identity

Ask the user for brand info. This is REQUIRED for paths 1-3 (make-a-video, short-form, trailer). Optional for developer path.

> **Bạn có brand guide không?** (Cung cấp bất kỳ mục nào có sẵn — bỏ qua nếu chưa có)

| Info | What to ask | Used for |
|------|-------------|----------|
| Brand / Tổ chức | Tên công ty, project, hoặc cá nhân? | Logo text, watermark, outro card |
| Brand guide / design.md | Có file brand guide, style guide, design.md? → paste path hoặc nội dung | Source of truth cho colors, fonts, spacing — KHÔNG tự chế if có |
| Logo | Có file logo? → path (SVG/PNG ưa thích) | Outro, watermark, hero frame |
| Brand colors | Hex codes (primary, accent, background) | Palette — override house-style defaults |
| Brand fonts | Google Fonts name hoặc file .woff2 paths | Typography — override Inter/JetBrains defaults |
| Visual mood | Dark/light? Cinematic/clean/kinetic/minimal? | Maps to visual-styles.md preset (8 styles) |
| Logo animation | Logo cần animate kiểu gì? (fade-in / SLAM / draw-on / morph / none) | Outro card + intro reveal |

**If NO brand info provided:** Use MOTION_PHILOSOPHY defaults from `references/house-style.md`. Auto-pick visual style based on the path chosen:

| Path | Default visual style | Mood |
|------|---------------------|------|
| make-a-video (promo) | Deconstructed | Industrial, raw |
| make-a-video (explainer) | Swiss Pulse | Clinical, precise |
| make-a-video (demo) | Data Drift | Futuristic, immersive |
| short-form | Shadow Cut | Dark, cinematic |
| trailer | Maximalist Type | Loud, kinetic |

**If brand info IS provided:** Check `<workspace>/assets/` for existing assets first (logos, fonts, images). Then write or update `design.md` with the brand values before proceeding.

### Step 3: Template & Style Selection

After Step 2, present template + style options. The user picks a template, and the style is either brand-driven or picked from presets.

**Templates by path:**

| Path | Template | Description |
|------|----------|-------------|
| make-a-video (promo) | `composition-template.html` | 16:9 landscape, ambient background, entrance animations |
| make-a-video (explainer) | `composition-template.html` | Same base, slower pacing preset |
| make-a-video (demo) | `composition-template.html` | Same base, PiP + slide patterns |
| short-form | `short-form-9-16-template.html` | 9:16 vertical, 4-layer scaffold, face-mode, seam treatment |
| trailer | `trailer-high-tempo.html` | 16:9 flash transitions, kinetic text, vignette, grid-floor |
| developer | Any — user picks | Sub-composition template also available |

**Visual styles (if no brand guide):**

| # | Style | Mood | Best for |
|---|-------|------|----------|
| 1 | Swiss Pulse | Clinical, precise | SaaS, data, dev tools, metrics |
| 2 | Velvet Standard | Premium, timeless | Luxury, enterprise, keynotes |
| 3 | Deconstructed | Industrial, raw | Tech launches, security, punk |
| 4 | Maximalist Type | Loud, kinetic | Big announcements, launches |
| 5 | Data Drift | Futuristic, immersive | AI, ML, cutting-edge tech |
| 6 | Soft Signal | Intimate, warm | Wellness, personal stories, brand |
| 7 | Folk Frequency | Cultural, vivid | Consumer apps, food, communities |
| 8 | Shadow Cut | Dark, cinematic | Dramatic reveals, security, exposé |

Full style specs with hex palettes, GSAP easing, shader pairings: `references/visual-styles.md`

**Quick start if user just wants to go:**
```bash
npx hyperframes init my-project && cd my-project
cp ~/.hermes/skills/hyperframes-unified/templates/<template>.html index.html
npx hyperframes preview
```

### Step 4: Load Only What the Path Needs

Each path loads specific SKILL.md sections + reference files. Everything else is skipped.

**Full mapping:** `references/onboarding-paths.md` — read this file after the user picks a path.

Quick summary:

| Path | SKILL.md sections | Key references |
|------|-------------------|---------------|
| make-a-video | Approach, Layout, Data Attrs, Composition, Timeline, Rules, Transitions, Guardrails, Quality, CLI | `make-a-video.md`, `interview-questions.md`, `style-intake.md`, `storyboard-template.md`, `composition-scaffold.md`, `build-checklist.md`, `render-contract.md` |
| short-form | Short-Form 9:16 Quick Ref, Data Attrs, Composition, Timeline, Rules, 11 Laws, Quality, CLI | `short-form-playbook.md`, `caption-system.md`, `transcript-guide.md`, `composition-scaffold.md`, `render-contract.md`, `house-style.md` |
| trailer | Layout, Data Attrs, Composition, Timeline, Rules, Transitions, 11 Laws, Guardrails, Quality, CLI | `trailer-production.md`, `transitions.md`, `transitions/`, `beat-direction.md`, `composition-scaffold.md`, `render-contract.md` |
| developer | **All sections** | Start with core 5 (`render-contract.md`, `composition-scaffold.md`, `house-style.md`, `visual-styles.md`, `beat-direction.md`), load rest on demand |

Additionally, if brand info was provided in Step 2:
- If `design.md` exists → load it (source of truth)
- If visual style picked → load `references/visual-styles.md`
- If custom palette → load relevant `references/palettes/<name>.md`

### Step 5: Environment Check

After picking a path, verify dependencies. Only check what matters for that path:

```bash
node -v                          # Need >= 22 (all paths)
npx hyperframes --version        # CLI (all paths)
ffmpeg -version 2>/dev/null      # Render paths (make-a-video, short-form, trailer)
# Chrome check — macOS only:
ls /Applications/Google\ Chrome.app 2>/dev/null
```

Missing? Quick install:
```bash
brew install node          # Node.js
brew install ffmpeg         # FFmpeg
npx hyperframes init first-project   # Installs CLI
```

### Step 6: First Action

| Path | First action |
|------|-------------|
| make-a-video | Start Gate 1 interview (intent, audience, duration, aspect ratio, fps, platform) |
| short-form | Ask for face-cam video file path, measure with `ffprobe`, start audio-first workflow |
| trailer | Ask for source video directory, run `ffprobe` analysis loop across all clips |
| developer | Ask what they want to build, suggest relevant reference subset |

All paths: brand info from Step 2 feeds directly into Gate 3 (style intake) / composition authoring. Skip re-asking what the user already provided.

---

## Approach

### Discovery (exploratory requests only)

For open-ended requests ("make me a product launch video", "create something for our brand") where the user hasn't committed to a direction, understand intent before picking colors:

- **Audience** — who watches this? Developers? Executives? General consumers?
- **Platform** — where does it play? Social (15s), website hero, product demo, internal?
- **Priority** — what matters most? Motion quality? Content accuracy? Brand fidelity? Speed?
- **Variations** — does the user want options, or a single best shot?

For specific requests ("add a title card", "fix the timing on scene 3"), skip discovery.

### Step 1: Design system

Read `design.md` or `DESIGN.md` first (check both casings). It's the source of truth for brand colors, fonts, and constraints. Use its exact values — don't invent colors or substitute fonts.

If no `design.md` exists, offer the user a choice:

1. **User named a style or mood?** → Read [visual-styles.md](references/visual-styles.md) for the 8 named presets (Swiss Pulse, Velvet Standard, Deconstructed, Maximalist Type, Data Drift, Soft Signal, Folk Frequency, Shadow Cut).
2. **Want to browse options visually?** → Use [references/design-picker.md](references/design-picker-external.md) to serve a visual picker page.
3. **Want to skip and go fast?** → Ask: mood, light or dark, any brand colors/fonts? Then pick from [house-style.md](references/house-style.md) defaults.

### Step 2: Prompt expansion

Always run on every new composition (except trivial edits). Read [references/prompt-expansion.md](references/prompt-expansion-external.md) for the full process and output format.

### Step 3: Plan

Before writing HTML:

1. **What** — narrative arc, key moments, emotional beats
2. **Structure** — compositions, sub-compositions, tracks
3. **Rhythm** — declare scene rhythm before implementing. Read [references/beat-direction.md](references/beat-direction-external.md) for templates
4. **Timing** — which clips drive duration, where transitions land
5. **Layout** — build end-state first (see "Layout Before Animation" below)
6. **Animate** — then add motion

<HARD-GATE>
Before writing ANY composition HTML — verify you have a visual identity from Step 1. If you're reaching for `#333`, `#3b82f6`, or `Roboto`, you skipped it.
</HARD-GATE>

---

## Layout Before Animation

Position every element at its **most visible moment** — the hero frame. Write static HTML+CSS first. No GSAP yet.

1. **Identify the hero frame** for each scene
2. **Write static CSS** for that frame. `.scene-content` MUST use `width: 100%; height: 100%; padding: Npx; display: flex; flex-direction: column; gap: Npx; box-sizing: border-box`. NEVER `position: absolute; top: Npx` on content containers.
3. **Add entrances with `gsap.from()`** — animate FROM offscreen/invisible TO the CSS position
4. **Add exits with `gsap.to()`** — animate TO offscreen/invisible (final scene only; other exits are transitions)

---

## Data Attributes

### All Clips

| Attribute          | Required                          | Values                                                 |
| ------------------ | --------------------------------- | ------------------------------------------------------ |
| `id`               | Yes                               | Unique identifier                                      |
| `data-start`       | Yes                               | Seconds or clip ID reference (`"el-1"`, `"intro + 2"`) |
| `data-duration`    | Required for img/div/compositions | Seconds. Video/audio defaults to media duration.       |
| `data-track-index` | Yes                               | Integer. Same-track clips cannot overlap.              |
| `data-media-start` | No                                | Trim offset into source (seconds)                      |
| `data-volume`      | No                                | 0-1 (default 1)                                        |

`data-track-index` does **not** affect visual layering — use CSS `z-index`.

### Composition Clips

| Attribute                    | Required | Values                                                            |
| ---------------------------- | -------- | ----------------------------------------------------------------- |
| `data-composition-id`        | Yes      | Unique composition ID                                             |
| `data-start`                 | Yes      | Start time (root composition: use `"0"`)                          |
| `data-duration`              | Yes      | Takes precedence over GSAP timeline duration                      |
| `data-width` / `data-height` | Yes      | Pixel dimensions (1920x1080 or 1080x1920)                         |
| `data-composition-src`       | No       | Path to external HTML file                                        |
| `data-variable-values`       | No       | JSON object of per-instance variable overrides on a sub-comp host |

---

## Composition Structure

Sub-compositions use `<template>` wrapper. Standalone compositions (main index.html) do NOT use `<template>`:

```html
<template id="my-comp-template">
  <div data-composition-id="my-comp" data-width="1920" data-height="1080">
    <!-- content -->
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.14.2/dist/gsap.min.js"></script>
    <script>
      window.__timelines = window.__timelines || {};
      const tl = gsap.timeline({ paused: true });
      // tweens...
      window.__timelines["my-comp"] = tl;
    </script>
  </div>
</template>
```

---

## Variables (Parametrized Compositions)

Render the same composition with different content without editing source HTML.

1. **Declare** variables on `<html>` root with `data-composition-variables`
2. **Read** resolved values via `window.__hyperframes.getVariables()`
3. **Override** at render time with `npx hyperframes render --variables '{...}'` or `data-variable-values='{...}'` on host elements

---

## Timeline Contract

- All timelines start `{ paused: true }` — the player controls playback
- Register: `window.__timelines["<composition-id>"] = tl`
- Framework auto-nests sub-timelines — do NOT manually add them
- Duration comes from `data-duration`, not from GSAP timeline length
- **Law 11 anchor:** Every sub-composition timeline ends with `tl.to({}, { duration: SLOT_DURATION }, 0)` as a no-op duration anchor. Non-negotiable — missing anchor = black frame flash.

---

## Rules (Non-Negotiable)

**Deterministic:** No `Math.random()`, `Date.now()`, or time-based logic. Use seeded PRNG (e.g. mulberry32) if pseudo-random needed.

**GSAP:** Only animate visual properties. Do NOT animate `visibility`, `display`, or call `video.play()`/`audio.play()`.

**No `repeat: -1`:** Always `repeat: Math.ceil(duration / cycleDuration) - 1`.

**Synchronous timeline construction:** Never build timelines inside `async`/`await`, `setTimeout`, or Promises.

**Never do:**

1. Forget `window.__timelines` registration
2. Use video for audio — always muted video + separate `<audio>`
3. Nest video inside a timed div — `<video>` MUST be a direct child of the root composition, not inside any `<div>` with `data-start`. Use CSS classes (`object-fit: cover`) for video styling, not wrapper divs
4. Use `data-layer` (use `data-track-index`) or `data-end` (use `data-duration`)
5. Animate video element dimensions — animate a wrapper div (non-timed, no data-start)
6. Call play/pause/seek on media — framework owns playback
7. Create a top-level container without `data-composition-id`
8. Use `repeat: -1` on any timeline or tween — always finite repeats
9. Build timelines asynchronously
10. Use `gsap.set()` on clip elements from later scenes — use `tl.set(selector, vars, timePosition)` inside the timeline at or after the clip's `data-start`
11. Use `<br>` in content text — let text wrap via `max-width`
12. Put CSS `transform: translate()` on elements that GSAP animates — GSAP overwrites the whole transform, discarding CSS centering. Use GSAP `xPercent`/`yPercent` instead
13. Forget `tl.set('#el', {opacity:0}, end_time)` hard-kill after exit tweens — without it, non-linear seeking can leave stale visibility

---

## Scene Transitions (Non-Negotiable)

1. **ALWAYS use transitions between scenes.** No jump cuts.
2. **ALWAYS use entrance animations on every scene.** Every element animates IN via `gsap.from()`.
3. **NEVER use exit animations** except on the final scene. The transition IS the exit.
4. **Final scene only:** may fade elements out.

---

## Animation Guardrails

- Offset first animation 0.1–0.3s (not t=0)
- Vary eases across entrance tweens — at least 3 different eases per scene
- Don't repeat an entrance pattern within a scene
- Avoid full-screen linear gradients on dark backgrounds (H.264 banding)
- 60px+ headlines, 20px+ body, 16px+ data labels
- `font-variant-numeric: tabular-nums` on number columns

---

## Typography and Assets

- Fonts embedded automatically by the compiler — just write `font-family` in CSS
- Custom fonts: provide `.woff2` files in `fonts/` directory + `@font-face` declarations
- Add `crossorigin="anonymous"` to external media
- Dynamic text overflow: `window.__hyperframes.fitTextFontSize(text, { maxWidth, fontFamily, fontWeight })`

---

## Quality Checklist

### Mandatory (block on results)

- [ ] `npx hyperframes lint` and `npx hyperframes validate` both pass
- [ ] Design adherence verified if design.md exists

### Slow (run in parallel)

- [ ] `npx hyperframes inspect` passes, or every reported overflow is intentionally marked
- [ ] Contrast warnings addressed
- [ ] Animation choreography verified via animation map

### Visual Verification Gate (MANDATORY — from Student Kit)

Lint passing ≠ design working. Never ship without frame extraction:

```bash
npx hyperframes render --quality draft --output renders/draft.mp4
mkdir -p renders/frames
for pair in "<t>:<label>" ...; do
  t="${pair%%:*}"; label="${pair##*:}"
  ffmpeg -y -ss "$t" -i renders/draft.mp4 -frames:v 1 -q:v 2 "renders/frames/t${t}-${label}.png"
done
```

**Read every PNG.** Confirm: expected visual on-screen, face not cropped, correct mode per scene, captions readable, no blank frames, no overflow.

---

## 11 Laws of Motion Graphics (from Student Kit)

Re-read before starting any new composition:

1. **One idea per beat. Cut fast.** Average scene length ~1.5s
2. **Black is the canvas.** ~90% of every frame is black/near-black. Color earns its place
3. **Light is the brand, not color.** Chrome gradients on type, soft halos, vignettes, light beams
4. **Camera never sleeps.** Even on "still" frames, particles drift, vignette breathes. Static = death
5. **Motion blur is a feature.** Every transition uses a streak/blur trail
6. **Object metaphors carry meaning.** Each visual element represents a concept
7. **Palette is symbolic, not decorative.** Each color owns one concept
8. **Type is a character.** Words SCALE 8×, MORPH, COMPRESS, GLOW. Typography drives 60% of storytelling
9. **Hold the hero shot.** Logo reveal = ~2s stillness. Outro card = 5+ seconds. Kinetic chaos → calm = catharsis
10. **One unifying texture across everything.** Perspective grid + crosshair marks. The spine of the whole piece
11. **Timelines must fill their slots.** Missing duration anchor = black frame flash. Always add `tl.to({}, { duration: SLOT_DURATION }, 0)`

---

## Short-Form Vertical Video (9:16) — Quick Reference

For full details, load [references/short-form-playbook.md](references/short-form-playbook.md).

**Composition scaffold (4 always-on layers):**
```
index.html (root, 1080x1920)
├── ambient-bg.html        track-index="3"
├── face-wrapper + <video> track-index="0"
├── seam-treatment.html    track-index="5"
├── scene1-<label>.html    track-index="1"
└── captions.html          track-index="2"
```

**Face-mode choreography:**
```js
const BOTTOM     = { x: -180, y: 1110, scale: 0.75 }; // preferred — crops dead space
const FULLSCREEN = { x: -1166.5, y: 0, scale: 1.7778 };
const HIDDEN     = { ...BOTTOM, opacity: 0 }; // same geometry, just invisible
```

**10 Quality Rules:**
1. No dead frames — every 100ms has animation
2. Scene payoff ≥ 1s hold
3. Face is a character — grade + Ken Burns + vignette
4. No hard seams — feather y=960
5. One jaw-dropper per 5s
6. Audio reactivity: 3–6% text, 10–30% background
7. Rotate transition flavors — no two consecutive same
8. Captions pop (stroke not pill) — Montserrat 900, 46-58px, scale 1.08 + accent color on active word
9. Motion through full scene duration — secondary motion if entrances land early
10. Background is a layer, not a color — radial + noise + particles + vignette minimum

---

## Make a Video — End-to-End Workflow

For full details, load [references/make-a-video.md](references/make-a-video.md).

**8 sequential gates:**

1. **Intent & format** — type, audience, duration, aspect ratio, fps, platform
2. **Script & voice** — script source, TTS/voice/captions plan
3. **Style intake** — brand doc, palette, fonts, logo, references; inventory existing assets first
4. **Brief synthesis** (HARD-GATE) — write BRIEF.md, wait for explicit approval
5. **Scaffold & storyboard** — `npx hyperframes init`, storyboard with timing table
6. **Build compositions** — invoke framework rules, scope catalog block CSS, determinism
7. **Lint → Studio preview** (PREVIEW GATE 1) — `npx hyperframes lint && validate`, preview on localhost:3002, wait for sign-off
8. **Draft render → visual verify → final** (PREVIEW GATE 2) — extract word-exact frames, read every PNG, then final render

---

## Editing Existing Compositions

- **Read actual files, don't guess.** Extract exact values from source
- Match existing fonts, colors, animation patterns
- Only change what was requested
- Preserve timing of unrelated clips

---

## CLI Quick Reference

```bash
npx hyperframes init <name>       # Create new project
npx hyperframes preview            # Studio preview (localhost:3002, hot-reload)
npx hyperframes lint               # Static HTML structure check
npx hyperframes validate           # Runtime check (headless Chrome)
npx hyperframes inspect            # Visual layout check (overflow, clipping)
npx hyperframes render             # Render MP4 (draft/standard/high)
npx hyperframes add <name>         # Install block/component from catalog
npx hyperframes catalog            # Browse registry
npx hyperframes transcribe <file>  # Whisper word-level timestamps
npx hyperframes tts                # Text-to-speech (Kokoro-82M)
npx hyperframes doctor             # Check environment
```

---

## Animation Runtimes (Framework)

HyperFrames supports multiple animation runtimes via the Frame Adapter pattern:

- **GSAP** — primary, see `/gsap` skill for patterns and effects
- **Anime.js** — see `/animejs` skill
- **Lottie** — see `/lottie` skill
- **Three.js** — see `/three` skill
- **CSS keyframes** — see `/css-animations` skill
- **Web Animations API** — see `/waapi` skill

All runtimes register paused, seekable timelines for deterministic rendering.

---

## Related Skills (invoke as needed)

- `/hyperframes-cli` — CLI commands: init, lint, inspect, preview, render, doctor
- `/hyperframes-media` — TTS, transcribe, remove-background
- `/hyperframes-registry` — Installing catalog blocks
- `/gsap` — GSAP timeline patterns and effects
- `/animejs` — Anime.js animations
- `/css-animations` — CSS keyframe patterns
- `/lottie` — Lottie animation players
- `/three` — Three.js scenes
- `/waapi` — Web Animations API
- `/website-to-hyperframes` — Capture URL → video
- `/remotion-to-hyperframes` — Migrate React Remotion compositions

---

## References (loaded on demand)

### Onboarding
- **[references/onboarding-paths.md](references/onboarding-paths.md)** — First-time user onboarding: 4 paths (make-a-video, short-form, trailer, developer), reference loading maps per path, environment checks, first-action guidance, quick template start. MANDATORY: read this before loading references for new users.

### Core (from Student Kit — not in framework skills)
- **[references/motion-philosophy.md](references/motion-philosophy.md)** — 11 Laws, reference timeline (Infinite Payments 30s deconstruction), visual vocabulary (backgrounds, type system, transitions, ambient effects), color story, motion recipe. 38KB gold standard.
- **[references/render-contract.md](references/render-contract.md)** — 11 binding Render Contract rules, composition structure, variables, quality verification (lint/validate/inspect/contrast/animation-map/visual-verification-gate).
- **[references/short-form-playbook.md](references/short-form-playbook.md)** — Complete 9:16 vertical video: 4-layer scaffold, face-mode choreography (BOTTOM/FULLSCREEN/HIDDEN), audio-sync protocol, karaoke captions, retime protocol, lessons from may-shorts-18 v1→v2, 10 quality rules.
- **[references/make-a-video.md](references/make-a-video.md)** — 8-gate end-to-end production workflow: interview → brief → storyboard → build → preview → render. Two mandatory preview gates.
- **[references/caption-system.md](references/caption-system.md)** — Karaoke caption implementation: per-word `<span>` elements, data-word-start, GSAP tweens, tone-adaptive style detection, text overflow prevention, caption exit guarantees.
- **[references/trailer-production.md](references/trailer-production.md)** — Trailer production from existing clips: analyze videos, storyboard (high-tempo 30s pattern), track layout, flash transitions, common lint errors and fixes, render+verify workflow.

### Design & Style
- **[references/house-style.md](references/house-style.md)** — Default motion, sizing, color palettes, easing signatures when no design.md exists.
- **[references/visual-styles.md](references/visual-styles.md)** — 8 named visual presets (Swiss Pulse, Velvet Standard, Deconstructed, Maximalist Type, Data Drift, Soft Signal, Folk Frequency, Shadow Cut) with hex palettes, GSAP easing, shader pairings.
- **[references/palettes/](references/palettes/)** — 9 individual palette files (bold-energetic, clean-corporate, dark-premium, jewel-rich, monochrome, nature-earth, neon-electric, pastel-soft, warm-editorial).
- **[references/design-picker.md](references/design-picker.md)** — Design picker system: interactive design.md creation, composition variables, brand-driven style generation.
- **[references/design-picker-external.md](references/design-picker-external.md)** — Visual design picker page for creating design.md interactively.
- **[templates/design-picker.html](templates/design-picker.html)** — Interactive design picker HTML tool for creating design.md visually.
- **[references/prompt-expansion.md](references/prompt-expansion.md)** — Prompt expansion process: grounding user intent against design.md and house-style.md, variable inference.
- **[references/prompt-expansion-external.md](references/prompt-expansion-external.md)** — Prompt expansion (external tool variant).

### Motion Philosophy
- **[references/motion-philosophy.md](references/motion-philosophy.md)** — 11 Laws of Motion Graphics from Student Kit: reference timeline, visual vocabulary, color story, motion recipe.

### Animation & Motion
- **[references/audio-reactive.md](references/audio-reactive.md)** — Audio-reactive animation: map frequency bands and amplitude to GSAP properties.
- **[references/css-patterns.md](references/css-patterns.md)** — CSS+GSAP marker highlighting: highlight, circle, burst, scribble, sketchout.
- **[references/dynamic-techniques.md](references/dynamic-techniques.md)** — Dynamic caption animation: karaoke, clip-path, slam, scatter, elastic, 3D.
- **[references/frame-adapter-motion.md](references/frame-adapter-motion.md)** — Motion design principles from the framework: image motion treatment, load-bearing GSAP rules.
- **[references/techniques.md](references/techniques.md)** — 11 visual techniques with code patterns: SVG drawing, Canvas 2D, CSS 3D, kinetic type, Lottie, video compositing, typing effect, variable fonts, MotionPath, velocity transitions, audio-reactive.

### Composition & Transitions
- **[references/transitions.md](references/transitions.md)** — Scene transitions overview: crossfades, wipes, reveals, shader transitions. Energy/mood selection, CSS vs WebGL guidance.
- **[references/transitions/](references/transitions/)** — 12 per-type transition guides (catalog, css-3d, blur, cover, destruction, dissolution, distortion, grid, light, mechanical, push, radial, scale).
- **[references/video-composition.md](references/video-composition.md)** — Video-medium rules: density, color presence, scale, frame composition, design.md as brand not layout.
- **[references/beat-direction.md](references/beat-direction.md)** — Beat planning: concept, mood, choreography verbs, rhythm templates, transition decisions, depth layers.
- **[references/narration.md](references/narration.md)** — Pacing, tone, script structure, number pronunciation, opening line patterns.
- **[references/patterns.md](references/patterns.md)** — PiP, title cards, slide show patterns.
- **[references/data-in-motion.md](references/data-in-motion.md)** — Data, stats, and infographic patterns.

### Typography & Media
- **[references/typography.md](references/typography.md)** — Font pairing, OpenType features, dark-background adjustments, font discovery.
- **[references/tts.md](references/tts.md)** — Kokoro-82M TTS: voice selection, speed tuning, TTS+captions workflow.
- **[references/transcript-guide.md](references/transcript-guide.md)** — Whisper transcription: models, .en gotcha, shift() retiming, API fallbacks.
- **[references/captions.md](references/captions.md)** — Caption system technical reference: per-word spans, data attributes, GSAP tweens, style detection, overflow prevention.
- **[references/audio-reactive.md](references/audio-reactive.md)** — (see Animation & Motion above)

### GSAP
- **[references/gsap-effects.md](references/gsap-effects.md)** — GSAP timeline patterns, effect registration, animation presets.
- **[references/gsap-effects-student.md](references/gsap-effects-student.md)** — Student Kit GSAP effects supplement.

### Hyperframes Registry
- **[references/registry-skills.md](references/registry-skills.md)** — Registry overview: installing blocks, components, discovery.
- **[references/registry/](references/registry/)** — Registry sub-references: add-block, add-component, demo-html-pattern, discovery, install-locations, wiring-blocks, wiring-components.

### Migration & Conversion
- **[references/website-to-hyperframes.md](references/website-to-hyperframes.md)** — Overview: URL → video composition conversion (7-step process).
- **[references/website-to-hf/](references/website-to-hf/)** — 7 detailed steps: step-1-capture through step-7-validate.
- **[references/remotion-to-hyperframes.md](references/remotion-to-hyperframes.md)** — Overview: migrate React Remotion compositions to HTML HyperFrames.
- **[references/remotion-skills.md](references/remotion-skills.md)** — Full Remotion migration skill reference.
- **[references/remotion/](references/remotion/)** — Remotion sub-references: api-map, escape-hatch, eval, fonts, limitations, lottie, media, parameters, sequencing, timing.

### Contributing
- **[references/contribute-templates.md](references/contribute-templates.md)** — Catalog contribution templates and guidelines.

### Scripts (Tooling)
- **[scripts/animation-map.mjs](scripts/animation-map.mjs)** — Generate JSON animation map from composition for timing inspection.
- **[scripts/contrast-report.mjs](scripts/contrast-report.mjs)** — WCAG contrast audit: check text/background combinations.
- **[scripts/package-loader.mjs](scripts/package-loader.mjs)** — Dynamic package/dependency loader for HyperFrames runtimes.
- **[scripts/extract-audio-data.py](scripts/extract-audio-data.py)** — Extract audio metadata (duration, sample rate, channels) for timeline sync.
- **[scripts/frame_strip.sh](scripts/frame_strip.sh)** — Extract frame strips from rendered video for visual verification.
- **[scripts/render_diff.sh](scripts/render_diff.sh)** — Compare renders between versions for regression detection.
- **[scripts/remotion-tests/](scripts/remotion-tests/)** — Remotion migration test scripts (smoke.sh).

### make-a-video Supporting References
- **[references/interview-questions.md](references/interview-questions.md)** — Full question bank by gate for the make-a-video workflow.
- **[references/style-intake.md](references/style-intake.md)** — Style interview flow + MOTION_PHILOSOPHY defaults.
- **[references/catalog-intent-map.md](references/catalog-intent-map.md)** — "User says X → install Y" block mapping.
- **[references/storyboard-template.md](references/storyboard-template.md)** — Beat-by-beat storyboard template.
- **[references/composition-scaffold.md](references/composition-scaffold.md)** — Scoped-styles + IIFE GSAP boilerplate.
- **[references/build-checklist.md](references/build-checklist.md)** — Preflight + pre-delivery gates.

## Templates

Ready-to-use project scaffolds in `templates/`:

- **[templates/composition-template.html](templates/composition-template.html)** — 16:9 landscape composition with variables, ambient background, entrance animations.
- **[templates/sub-composition-template.html](templates/sub-composition-template.html)** — Sub-composition `<template>` wrapper with IIFE and Law 11 duration anchor.
- **[templates/short-form-9-16-template.html](templates/short-form-9-16-template.html)** — 9:16 vertical video with 4-layer scaffold, face-mode choreography (BOTTOM/FULLSCREEN/HIDDEN), Ken Burns, seam treatment.
- **[templates/trailer-high-tempo.html](templates/trailer-high-tempo.html)** — 16:9 high-tempo trailer: flash transitions, kinetic text, vignette variants, grid-floor + crosshair (Law 10), multi-scene track layout, GSAP flash hard-kill pattern.
- **[templates/design-picker.html](templates/design-picker.html)** — Interactive design picker tool for creating design.md visually.
- **[templates/meta.json](templates/meta.json)** — Project metadata template.
- **[templates/setup.sh](templates/setup.sh)** — One-command community setup: checks Node/FFmpeg/Chrome, installs HyperFrames CLI + framework skills.