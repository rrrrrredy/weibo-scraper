#!/usr/bin/env bash
# setup.sh - First-use dependency check & install
# Usage: bash scripts/setup.sh

set -e

echo "🔍 Checking weibo-scraper dependencies..."

MISSING=0

# Check Python3
if ! command -v python3 &>/dev/null; then
  echo "❌ python3 not installed"
  exit 1
fi
echo "✅ python3"

# Check Playwright
echo ""
echo "--- Browser Automation ---"
if python3 -c "import playwright" &>/dev/null; then
  echo "✅ playwright (Python)"
else
  echo "⚠️  playwright not installed"
  echo "   Install: pip install playwright && playwright install chromium"
  MISSING=1
fi

# Check web search tool availability
echo ""
echo "--- Web Search ---"
echo "ℹ️  This skill requires a web search tool (Brave Search API, Bing, etc.)"
echo "   Set BRAVE_API_KEY or use any search tool that supports 'site:weibo.com' queries"

if [ "$MISSING" -eq 0 ]; then
  echo ""
  echo "✅ All dependencies ready"
else
  echo ""
  echo "⚠️  Some dependencies missing. Install them as shown above."
fi

echo "🎉 Setup complete"
