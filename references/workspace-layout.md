# HyperFrames Workspace Layout

A HyperFrames workspace contains one or more video projects, each in its own folder. Here's the standard structure.

## Workspace Root

```
my-workspace/
├── CLAUDE.md, AGENTS.md                    ← workspace docs (optional)
├── MOTION_PHILOSOPHY.md                    ← motion aesthetic guide (optional)
├── package.json, node_modules/              ← workspace tooling
├── assets/                                  ← shared brand assets (fonts, logos)
└── video-projects/                           ← one folder per video
    ├── my-first-video/
    ├── q3-launch-promo/
    └── product-demo/
```

## Single Project Structure

Each project under the workspace is self-contained:

```
my-first-video/
├── index.html              ← root composition entry point
├── compositions/           ← sub-compositions (loaded via data-composition-src)
│   ├── scene1-intro.html
│   ├── scene2-feature.html
│   └── components/         ← installed by `npx hyperframes add <component>`
├── assets/                 ← media files for this project
│   ├── video/
│   ├── audio/
│   ├── images/
│   └── transcripts/
├── renders/                ← render outputs (gitignored)
├── hyperframes.json         ← CLI config (registry URL, paths — relative)
├── meta.json               ← project metadata (id, name, dimensions, fps)
└── (optional) STORYBOARD.md, scripts/, etc.
```

### Key Files

| File | Purpose |
|------|---------|
| `index.html` | Root composition. The main entry point for the video. |
| `meta.json` | Project metadata: `id`, `name`, `width`, `height`, `fps`. |
| `hyperframes.json` | CLI configuration: registry URL, paths. All paths relative to project folder. |
| `compositions/` | Sub-compositions loaded by `data-composition-src`. |
| `assets/` | Project-local media. Brand assets that multiple projects need are duplicated per-project (not symlinked) for portability. |
| `renders/` | MP4 output directory. Gitignored. |

### meta.json Example

```json
{
  "id": "my-first-video",
  "name": "My First Video",
  "width": 1920,
  "height": 1080,
  "fps": 30
}
```

## Always Run CLI from Inside the Project Folder

```bash
cd video-projects/my-first-video
npx hyperframes lint
npx hyperframes preview
npx hyperframes render --quality standard --output renders/final.mp4
```

The CLI reads `hyperframes.json`/`meta.json` from the current directory and resolves `assets/`, `compositions/`, `renders/` relative to it. Running from the workspace root will fail.

## Adding a New Video Project

```bash
# Create project folder (kebab-case)
mkdir -p video-projects/my-new-video
cd video-projects/my-new-video

# Option A: Scaffold with CLI
npx hyperframes init

# Option B: Copy template from skill
npx hyperframes init my-new-video
cp ~/.hermes/skills/hyperframes-modos/templates/composition-template.html index.html

# Option C: Copy structure from sibling project
cp -r ../existing-project/{hyperframes.json,meta.json} .
# Edit meta.json for new id/name/dimensions
mkdir -p compositions assets renders

# Copy brand assets if needed
cp ../../assets/brand-tokens.css assets/
```

## Sub-compositions

Sub-compositions are HTML fragments loaded by the root composition:

```html
<!-- In index.html -->
<div data-composition-src="compositions/scene1-intro.html"></div>
<div data-composition-src="compositions/scene2-feature.html"></div>
```

Each sub-composition is a `<template>` element with its own IIFE and timeline registration. See `templates/sub-composition-template.html`.

## What Lives at Workspace Root

- **`package.json` + `node_modules/`** — Shared tooling (hyperframes CLI, linting)
- **`CLAUDE.md` / `AGENTS.md`** — AI agent instructions (optional)
- **`MOTION_PHILOSOPHY.md`** — Motion aesthetic guide (optional)
- **Shared assets/** — Brand assets (fonts, logos) duplicated per-project when needed

**Never** put `index.html`, `compositions/`, `renders/` directly at the workspace root. Always work from inside a project subfolder.