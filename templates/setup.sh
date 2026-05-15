#!/usr/bin/env bash
# hyperframes-modos-setup.sh
# One-command setup: installs HyperFrames CLI + copies unified skill templates
# Usage: curl -sL https://raw.githubusercontent.com/USER/hyperframes-modos/main/setup.sh | bash
# Or:   bash setup.sh

set -euo pipefail

echo "================================================"
echo "  HyperFrames Unified — Community Setup Script"
echo "================================================"

# Check Node.js
if ! command -v node &>/dev/null; then
  echo "ERROR: Node.js >= 22 is required. Install from https://nodejs.org"
  exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 22 ]; then
  echo "WARNING: Node.js >= 22 recommended (you have $(node -v)). Some features may not work."
fi

# Check FFmpeg
if ! command -v ffmpeg &>/dev/null; then
  echo "WARNING: FFmpeg not found. Install it for video rendering:"
  echo "  macOS:  brew install ffmpeg"
  echo "  Ubuntu: sudo apt install ffmpeg"
  echo "  Windows: https://ffmpeg.org/download.html"
fi

# Check Chrome/Chromium
if ! command -v google-chrome &>/dev/null && ! command -v chromium &>/dev/null && ! command -v chromium-browser &>/dev/null; then
  echo "WARNING: Chrome/Chromium not found in PATH. HyperFrames uses headless Chrome for rendering."
  echo "  Install Google Chrome or Chromium for rendering support."
fi

# Install HyperFrames CLI
echo ""
echo "Installing HyperFrames CLI..."
npm install -g @hyperframes/cli 2>/dev/null || npx hyperframes --version

# Install framework skills (for AI agents)
echo ""
echo "Installing HyperFrames skills for AI agents..."
npx skills add heygen-com/hyperframes

# Create project
echo ""
echo "================================================"
echo "  Setup complete!"
echo "================================================"
echo ""
echo "Quick start:"
echo "  mkdir my-video && cd my-video"
echo "  npx hyperframes init"
echo "  npx hyperframes preview"
echo ""
echo "Create from template (16:9 landscape):"
echo "  cp ~/.hermes/skills/hyperframes-modos/templates/composition-template.html index.html"
echo "  npx hyperframes preview"
echo ""
echo "Create from template (9:16 short-form):"
echo "  cp ~/.hermes/skills/hyperframes-modos/templates/short-form-9-16-template.html index.html"
echo "  npx hyperframes preview"
echo ""
echo "Useful commands:"
echo "  npx hyperframes lint          # Check composition structure"
echo "  npx hyperframes validate     # Runtime check (headless Chrome)"
echo "  npx hyperframes inspect       # Visual layout check"
echo "  npx hyperframes render        # Render MP4"
echo "  npx hyperframes render --quality draft  # Fast preview render"
echo "  npx hyperframes catalog      # Browse blocks & components"
echo "  npx hyperframes add <name>    # Install a block"
echo "  npx hyperframes transcribe <file>  # Whisper word-level timestamps"
echo "  npx hyperframes tts           # Text-to-speech"
echo ""
echo "Skill documentation:"
echo "  ~/.hermes/skills/hyperframes-modos/SKILL.md"
echo "  ~/.hermes/skills/hyperframes-modos/references/"
echo ""
echo "Happy video making! 🎬"