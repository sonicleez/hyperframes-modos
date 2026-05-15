# Onboarding Paths — Pick Your Path First

**Modos Media** — tiền thân team Media Ninety Eight (NE). Sản xuất nội dung media truyền thông global cho NE và các sản phẩm thuộc Ecosystem NE. Hiện tập trung vào **AI Solution Production**. Liên hệ hợp tác: **info@Modos.space**

When a user invokes the hyperframes-modos skill for the first time (or says something vague like "help me make a video", "I want to try HyperFrames", "where do I start?"), run the onboarding flow below BEFORE loading any references.

The goal: avoid dumping 60KB of skill content. Instead, ask 2-3 questions, pick the right path, collect brand info, and only load what that path needs.

---

## Step 1: Ask the User — Pick a Path (use clarify tool)

Ask ONE question with 4 choices:

**"Bạn muốn làm gì với HyperFrames?"** (or in the user's language)

| # | Option | Path |
|---|--------|------|
| 1 | Tạo video hoàn chỉnh từ ý tưởng → MP4 | **make-a-video** |
| 2 | Tạo video dọc ngắn (TikTok/Reels/Shorts) có face-cam | **short-form** |
| 3 | Tạo trailer từ video clips có sẵn | **trailer** |
| 4 | Tìm hiểu framework / viết composition thủ công | **developer** |

If the user picks option 1, ask a follow-up:

**"Video của bạn thuộc loại nào?"**

| # | Option | Sub-path |
|---|--------|----------|
| 1 | Promo / quảng cáo / social ad (10-45s) | **promo** |
| 2 | Giải thích / tutorial / explainer (45s-3min) | **explainer** |
| 3 | Product demo / walkthrough | **demo** |
| 4 | Chưa chắc — tôi chỉ muốn bắt đầu | **general** |

---

## Step 2: Brand Identity (use clarify tool)

REQUIRED for paths 1-3. Optional for developer path.

**"Bạn có brand guide không?"** (Cung cấp bất kỳ mục nào có sẵn — bỏ qua nếu chưa có)

| Info | What to ask | Used for |
|------|-------------|----------|
| Brand / Tổ chức | Tên công ty, project, hoặc cá nhân? | Logo text, watermark, outro card |
| Brand guide / design.md | Có file brand guide, style guide, design.md? → paste path hoặc nội dung | Source of truth cho colors, fonts, spacing — KHÔNG tự chế if có |
| Logo | Có file logo? → path (SVG/PNG ưa thích) | Outro, watermark, hero frame |
| Brand colors | Hex codes (primary, accent, background) | Palette — override house-style defaults |
| Brand fonts | Google Fonts name hoặc file .woff2 paths | Typography — override Inter/JetBrains defaults |
| Visual mood | Dark/light? Cinematic/clean/kinetic/minimal? | Maps to visual-styles.md preset (8 styles) |
| Logo animation | Logo cần animate kiểu gì? (fade-in / SLAM / draw-on / morph / none) | Outro card + intro reveal |

**If NO brand info:** Use MOTION_PHILOSOPHY defaults. Auto-pick style:

| Path | Default visual style | Mood |
|------|---------------------|------|
| make-a-video (promo) | Deconstructed | Industrial, raw |
| make-a-video (explainer) | Swiss Pulse | Clinical, precise |
| make-a-video (demo) | Data Drift | Futuristic, immersive |
| short-form | Shadow Cut | Dark, cinematic |
| trailer | Maximalist Type | Loud, kinetic |

**If brand info IS provided:** Check `<workspace>/assets/` for existing assets first (logos, fonts, images). Write or update `design.md` with brand values before proceeding.

---

## Step 3: Template & Style Selection (use clarify tool)

Present templates + visual style options. User picks one of each.

### Templates by path

| Path | Template | Description |
|------|----------|-------------|
| make-a-video (promo) | `composition-template.html` | 16:9 landscape, ambient background, entrance animations |
| make-a-video (explainer) | `composition-template.html` | Same base, slower pacing preset |
| make-a-video (demo) | `composition-template.html` | Same base, PiP + slide patterns |
| short-form | `short-form-9-16-template.html` | 9:16 vertical, 4-layer scaffold, face-mode, seam treatment |
| trailer | `trailer-high-tempo.html` | 16:9 flash transitions, kinetic text, vignette, grid-floor |
| developer | Any — user picks | Sub-composition template also available |

### Visual styles (if no brand guide)

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

Full style specs: `references/visual-styles.md` — load after user picks.

If user picked a style in Step 2 (brand-driven), skip this selection. Use their brand style.

### Quick start (no selection needed)

If user just wants to go NOW — use the default template for their path:
```bash
npx hyperframes init my-project
cd my-project

# Chọn template theo hướng:
# make-a-video (promo/explainer/demo):
cp ~/.hermes/skills/hyperframes-modos/templates/composition-template.html index.html
# short-form (9:16 dọc):
cp ~/.hermes/skills/hyperframes-modos/templates/short-form-9-16-template.html index.html
# trailer (16:9 high-tempo):
cp ~/.hermes/skills/hyperframes-modos/templates/trailer-high-tempo.html index.html

npx hyperframes preview
mkdir -p renders
npx hyperframes render --quality standard --output renders/final.mp4

# Khi xong — TẮT PREVIEW SERVER:
kill $(lsof -ti:3002) 2>/dev/null && echo "✅ Server đã tắt" || echo "Server không chạy"
# Hoặc Ctrl+C trong terminal đang chạy preview
```

---

## Step 4: Load Only What the Path Needs

Each path below lists exactly which sections of SKILL.md and which reference files to load. Everything else is SKIPPED for this session.

Additionally — if brand info was collected in Step 2:
- If `design.md` exists → load it (source of truth)
- If visual style was picked → load `references/visual-styles.md`
- If custom palette → load relevant `references/palettes/<name>.md`

### Path: make-a-video

**SKILL.md sections to load:**
- Approach (Discovery, Steps 1-3)
- Layout Before Animation
- Data Attributes (quick scan)
- Composition Structure
- Timeline Contract
- Rules (Non-Negotiable)
- Scene Transitions
- Animation Guardrails
- Quality Checklist
- Make a Video → references/make-a-video.md (FULL — this IS the workflow)
- CLI Quick Reference

**References to load:**
- `references/make-a-video.md` ← main workflow
- `references/interview-questions.md` ← Gate 1-4 questions
- `references/style-intake.md` ← Gate 3
- `references/storyboard-template.md` ← Gate 5
- `references/composition-scaffold.md` ← Gate 6
- `references/build-checklist.md` ← Gate 7-8
- `references/render-contract.md` ← quality gates

**Sub-path promo:** also load `references/transitions.md`, `references/house-style.md`
**Sub-path explainer:** also load `references/narration.md`, `references/captions.md`
**Sub-path demo:** also load `references/patterns.md` (PiP, title cards)
**Sub-path general:** load all of the above — full make-a-video

**References to SKIP:**
- `references/motion-philosophy.md` (only if user picks MOTION_PHILOSOPHY style)
- `references/short-form-playbook.md` (that's the short-form path)
- `references/audio-reactive.md` (only if user wants audio-reactive)
- `references/remotion-to-hyperframes.md`, `references/website-to-hyperframes.md` (migration — not needed)

---

### Path: short-form

**SKILL.md sections to load:**
- Approach (Discovery only)
- Data Attributes (full)
- Composition Structure (full)
- Timeline Contract (full)
- Rules (Non-Negotiable)
- Scene Transitions
- Short-Form Vertical Video (9:16) — Quick Reference
- 11 Laws of Motion Graphics
- Quality Checklist (mandatory part + visual verification gate)
- CLI Quick Reference

**References to load:**
- `references/short-form-playbook.md` ← THE core reference
- `references/captions.md` ← karaoke captions
- `references/transcript-guide.md` ← Whisper transcription
- `references/composition-scaffold.md` ← sub-comp pattern
- `references/render-contract.md` ← quality gates
- `references/house-style.md` ← defaults for short-form style

**References to SKIP:**
- `references/make-a-video.md` (different workflow)
- `references/trailer-production.md` (different format)
- `references/audio-reactive.md` (only if asked)
- `references/data-in-motion.md` (not typical for short-form)

---

### Path: trailer

**SKILL.md sections to load:**
- Approach (Steps 1-3)
- Layout Before Animation
- Data Attributes
- Composition Structure
- Timeline Contract
- Rules
- Scene Transitions
- Animation Guardrails
- 11 Laws of Motion Graphics
- Quality Checklist
- CLI Quick Reference

**References to load:**
- `references/trailer-production.md` ← THE core reference
- `references/transitions.md` ← flash transitions, wipes
- `references/transitions/` ← specific transition types used in trailers
- `references/beat-direction.md` ← rhythm planning
- `references/composition-scaffold.md`
- `references/render-contract.md`

**References to SKIP:**
- `references/make-a-video.md`
- `references/short-form-playbook.md`
- `references/captions.md`

---

### Path: developer

**SKILL.md — FULL LOAD.** This path reads everything.

**References — progressive load:**
1. First load (core framework):
   - `references/render-contract.md`
   - `references/composition-scaffold.md`
   - `references/house-style.md`
   - `references/visual-styles.md`
   - `references/beat-direction.md`

2. Second load (on demand — ask what the user needs):
   - Animation? → `references/audio-reactive.md`, `references/techniques.md`, `references/css-patterns.md`, `references/dynamic-techniques.md`
   - Captions? → `references/captions.md`, `references/transcript-guide.md`, `references/tts.md`
   - Transitions? → `references/transitions.md`, `references/transitions/`
   - Typography? → `references/typography.md`
   - Short-form? → `references/short-form-playbook.md`
   - Trailer? → `references/trailer-production.md`
   - Data viz? → `references/data-in-motion.md`

---

## Step 5: Set Up Environment

After picking a path, run the environment check. Only check what matters:

```bash
# All paths — Node.js (cần phiên bản 22 trở lên)
node -v
# Nếu chưa có: brew install node (macOS) hoặc tải tại https://nodejs.org

# All paths — HyperFrames CLI
npx hyperframes --version
# Nếu chưa có: npx hyperframes init first-project (tự cài khi chạy lần đầu)

# Paths that render video (make-a-video, short-form, trailer):
which ffmpeg || echo "⚠️  FFmpeg chưa cài — cần để xuất video MP4"
# macOS: brew install ffmpeg
# Windows: tải tại https://ffmpeg.org/download.html
# Linux: sudo apt install ffmpeg

# Chrome/Chromium (render path)
# macOS: ls "/Applications/Google Chrome.app" || echo "⚠️  Cài Chrome tại https://google.com/chrome"
# Linux: which google-chrome || which chromium-browser || echo "⚠️  Cài Chrome"
```

---

## Step 6: First Action

Each path has a natural first action. Don't ask again — just guide:

| Path | First action |
|------|-------------|
| make-a-video | Start Gate 1 interview: ask intent, audience, duration, aspect ratio |
| short-form | Ask for face-cam video file path, then measure duration with `ffprobe` |
| trailer | Ask for source video directory, then run `ffprobe` analysis loop |
| developer | Ask what they want to build, then suggest loading the relevant reference subset |

All paths: brand info from Step 2 feeds directly into Gate 3 (style intake) / composition authoring. Skip re-asking what the user already provided.

---

## Step 7: Kết thúc Project — Dọn dẹp (Project Cleanup)

**MANDATORY** khi user nói "xong", "kết thúc", "render xong", hoặc chuyển sang project khác:

1. **Tắt preview server** (localhost:3002) — server này chạy liên tục và KHÔNG tự tắt:
   ```bash
   kill $(lsof -ti:3002) 2>/dev/null && echo "✅ Server đã tắt" || echo "Server không chạy"
   ```
   Hoặc nhấn **Ctrl+C** trong terminal đang chạy `npx hyperframes preview`.

2. **Hỏi user** có muốn dọn file renders:
   > Bạn có muốn dọn file renders cũ để tiết kiệm ổ cứng không? (renders/*.mp4, renders/*.webm)

3. **Nếu user muốn dọn:**
   ```bash
   rm -rf renders/*.mp4 renders/*.webm
   echo "✅ Đã dọn renders"
   ```

4. **Nếu chuyển sang project mới** — quay lại Step 0 (kiểm tra môi trường + tắt server cũ).

**Tại sao phải tắt server?** `npx hyperframes preview` là server Node.js chạy liên tục trên port 3002. Nó **không tự tắt** sau khi render — tiếp tục tiêu thụ RAM/CPU cho đến khi `kill` hoặc Ctrl+C. Nhiều project = nhiều server = máy chậm dần.