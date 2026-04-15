# weibo-scraper

Weibo public content scraper — no login required.

> OpenClaw Skill — works with [OpenClaw](https://github.com/openclaw/openclaw) AI agents

## What It Does

Fetches public Weibo posts without needing a Weibo account. Uses web search to locate user profiles and post URLs, then opens pages via Playwright with a visitor cookie to extract post text and timestamps. Supports user timeline browsing and individual post content extraction.

## Quick Start

```bash
openclaw skill install weibo-scraper
# Or:
git clone https://github.com/rrrrrredy/weibo-scraper.git ~/.openclaw/skills/weibo-scraper
```

Run dependency setup on first use:
```bash
bash scripts/setup.sh
```

## Features

- **No login required**: visitor cookie mode for public content access
- **User timeline**: fetch a user's recent public posts (typically 10-15 visible)
- **Post extraction**: read full text content from individual post URLs
- **Web search integration**: locate user UIDs and post URLs via `site:weibo.com` queries
- **Fallback selectors**: handles CSS class name changes with alternative extraction methods
- **Hard stop protection**: auto-stops after 3 consecutive failures to prevent infinite retries

## Usage

Trigger with natural language:

- "查一下 @某用户 的微博"
- "看看这个微博用户最近发了什么"
- "抓取微博内容"
- "搜微博" / "微博动态"

## Project Structure

```
weibo-scraper/
├── SKILL.md                # Skill definition and workflow
├── scripts/
│   └── setup.sh            # Dependency setup script
├── references/
│   └── weibo-api-notes.md  # API notes and technical details
├── README.md
├── LICENSE
└── .gitignore
```

## Requirements

- OpenClaw agent runtime
- Playwright (installed via setup.sh)
- Web search tool (Bing/Brave/etc.)
- Upstream proxy for network access (configured in environment)

## License

[MIT](LICENSE)
