# weibo-scraper

Weibo public content scraper — no login required. Uses web search + Playwright visitor cookie to fetch public posts.

An [OpenClaw](https://github.com/openclaw/openclaw) Skill for scraping public Weibo (微博) content without authentication.

## Installation

### Option A: OpenClaw (recommended)
```bash
# Clone to OpenClaw skills directory
git clone https://github.com/rrrrrredy/weibo-scraper ~/.openclaw/skills/weibo-scraper

# Run setup
bash ~/.openclaw/skills/weibo-scraper/scripts/setup.sh
```

### Option B: Standalone
```bash
git clone https://github.com/rrrrrredy/weibo-scraper
cd weibo-scraper
bash scripts/setup.sh
```

## Dependencies

### Python packages
- `playwright` (`pip install playwright && playwright install chromium`)

### Other tools
- A web search API (Brave Search, Bing, etc.) for `site:weibo.com` queries

## Usage

This skill is designed to be used by an AI agent (e.g., OpenClaw). The workflow:

1. **Locate user** — Web search `@username site:weibo.com` to find the user's UID
2. **Find posts** — Web search `site:weibo.com/u/<UID>` to collect post URLs
3. **Extract content** — Playwright opens each URL with visitor cookie (no login needed)
4. **Format output** — Posts sorted by time with text content

### CSS Selector
- Primary: `.detail_wbtext_4CRf9`
- Fallback: Locate timestamp element and read surrounding text blocks

### Limitations
- Only public posts are accessible (followers-only content requires login)
- Without login, profile pages show limited posts (~10-15)
- Search result ordering is by relevance, not strictly chronological

## Project Structure

```
weibo-scraper/
├── SKILL.md              # Main skill definition
├── scripts/
│   └── setup.sh          # Dependency check script
├── references/
│   └── weibo-api-notes.md  # API research notes
└── README.md
```

## License

MIT
