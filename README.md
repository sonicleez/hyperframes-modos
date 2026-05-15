# HyperFrames MODOS — AI Solution Production Skill

**by Modos Media** (tiền thân Media Ninety Eight)

Sản xuất nội dung media truyền thông global cho NE và các sản phẩm thuộc Ecosystem NE. Hiện tập trung vào **AI Solution Production**.

Liên hệ hợp tác: **info@Modos.space**

---

## Cài đặt trên Hermes Agent

### Cách 1: Từ GitHub repo (khuyên dùng)

```bash
hermes skills install https://github.com/<org>/hyperframes-modos/SKILL.md
```

Agent sẽ tự động:
- Tải SKILL.md + các file references/templates liên quan
- Đặt vào `~/.hermes/skills/hyperframes-modos/`
- Kích hoạt cho lần session tiếp theo

### Cách 2: Từ local (clone thủ công)

```bash
# Clone repo
git clone https://github.com/<org>/hyperframes-modos.git ~/.hermes/skills/hyperframes-modos

#Hoặc copy từ USB / shared drive
cp -r /path/to/hyperframes-modos ~/.hermes/skills/hyperframes-modos

# Reload skills trong session
hermes   # khởi động mới, skill tự detect
# Hoặc trong session đang chạy: /reload-skills
```

### Cách 3: Từ file .tar.gz

```bash
# Giải nén vào skills directory
mkdir -p ~/.hermes/skills
tar xzf hyperframes-modos.tar.gz -C ~/.hermes/skills/

# Verify
ls ~/.hermes/skills/hyperframes-modos/SKILL.md

# Reload
hermes  # hoặc /reload-skills trong session
```

### Tạo file .tar.gz để chia sẻ

```bash
cd ~/.hermes/skills
tar czf ~/hyperframes-modos.tar.gz hyperframes-modos/
# File output: ~/hyperframes-modos.tar.gz (~100-200KB)
```

---

## Cài đặt HyperFrames CLI (dependency)

```bash
# Cài Node.js nếu chưa có (cần >= 22)
brew install node    # macOS
# hoặc: https://nodejs.org

# Cài HyperFrames CLI framework skills
npx skills add heygen-com/hyperframes

# Cài FFmpeg (cần cho render)
brew install ffmpeg

# Verify
npx hyperframes doctor
```

---

## Cấu trúc skill

```
hyperframes-modos/
├── SKILL.md                          # Main skill — onboarding + rules + workflow
├── README.md                          # Setup & install guide (file này)
├── .gitignore
├── references/
│   ├── onboarding-paths.md            # Chi tiết 6 bước onboarding
│   ├── motion-philosophy.md           # 11 Laws, visual vocabulary
│   ├── render-contract.md             # 11 Render Contract rules
│   ├── make-a-video.md                # 8-gate production workflow
│   ├── short-form-playbook.md         # 9:16 vertical video
│   ├── caption-system.md              # Karaoke captions
│   ├── trailer-production.md          # Trailer từ clips
│   ├── house-style.md                 # Default motion + palettes
│   ├── visual-styles.md               # 8 named style presets
│   ├── interview-questions.md          # Gate 1-4 question bank
│   ├── style-intake.md                # Style interview flow
│   ├── storyboard-template.md         # Beat-by-beat template
│   ├── composition-scaffold.md        # Scoped-styles + IIFE boilerplate
│   ├── build-checklist.md             # Preflight + delivery gates
│   ├── beat-direction.md              # Rhythm + choreography verbs
│   ├── narration.md                   # Pacing, tone, script
│   ├── transitions.md                # Transition overview
│   ├── transitions/                   # 12 per-type guides
│   ├── palettes/                      # 9 palette files
│   ├── patterns.md                    # PiP, title cards, slideshow
│   ├── techniques.md                  # 11 visual techniques
│   ├── typography.md                  # Font pairing, discovery
│   ├── tts.md                         # Kokoro-82M TTS
│   ├── transcript-guide.md            # Whisper transcription
│   ├── audio-reactive.md              # Audio-reactive animation
│   ├── css-patterns.md                # CSS+GSAP markers
│   ├── dynamic-techniques.md          # Dynamic caption animation
│   ├── data-in-motion.md             # Data/stats patterns
│   ├── video-composition.md          # Video-medium rules
│   ├── frame-adapter-motion.md       # Framework motion principles
│   ├── catalog-intent-map.md         # Block mapping
│   ├── design-picker-external.md     # Visual picker page
│   ├── prompt-expansion-external.md  # Prompt expansion
│   ├── website-to-hyperframes.md     # URL → video
│   ├── remotion-to-hyperframes.md    # Migration guide
│   └── ...
├── templates/
│   ├── composition-template.html      # 16:9 landscape
│   ├── short-form-9-16-template.html # 9:16 vertical
│   ├── trailer-high-tempo.html        # 16:9 trailer
│   ├── sub-composition-template.html # Sub-comp wrapper
│   ├── meta.json                     # Project metadata
│   └── setup.sh                      # Community setup script
└── 64 files total, ~512KB
```

---

## Onboarding flow (người mới)

Khi invoke skill lần đầu, agent sẽ chạy 6 bước:

1. **Pick a Path** — chọn 1/4: make-a-video / short-form / trailer / developer
2. **Brand Identity** — hỏi brand guide, logo, colors, fonts, visual mood
3. **Template & Style** — chọn template + 1/8 visual style presets
4. **Load References** — chỉ load SKILL.md sections + references cần cho path
5. **Environment Check** — verify Node/FFmpeg/Chrome
6. **First Action** — vào Gate 1 interview hoặc ffprobe tùy path

---

## Tạo GitHub repo (publish)

```bash
# Push lên GitHub để install từ URL
cd ~/.hermes/skills/hyperframes-modos
git init
git add -A
git commit -m "feat: HyperFrames MODOS v1.0.0 — AI Solution Production skill"
gh repo create <org>/hyperframes-modos --public --source=. --push

# Agent khác cài bằng:
hermes skills install https://github.com/<org>/hyperframes-modos/SKILL.md
```

---

## License

MIT — Modos Media