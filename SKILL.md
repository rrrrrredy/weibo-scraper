---
name: weibo-scraper
version: 1.0.0
description: "Weibo public content scraper (no login required). Uses web search + Playwright visitor cookie to fetch public posts. Supports user timeline and post content extraction. Triggers: check Weibo, scrape Weibo, Weibo user, read Weibo post, Weibo timeline, fetch Weibo content. Not for: login-required content (fans-only posts); large-scale batch scraping; non-Weibo platforms (use x-twitter-scraper for Twitter)."
tags: [weibo, scraper, social-media, content-extraction]
---

# weibo-scraper 1.0.0

No login required. Fetches public Weibo posts via web search + Playwright visitor cookie.

---

## ⚠️ Gotchas

⚠️ **Weibo ajax API returns -100 without login** → `https://m.weibo.cn/api/container/getIndex` etc. always return errno=-100 when not logged in. Do not attempt direct API calls.

⚠️ **Camoufox may fail to initialize** → Camoufox downloads browser binaries on first run, which can timeout in some network environments. Use standard Playwright instead.

⚠️ **CSS selector `.detail_wbtext_4CRf9` may change** → Weibo frontend updates class names periodically. When the selector fails, use a fallback: find the timestamp element in page HTML and read surrounding text blocks.

⚠️ **Search result ordering is not strictly chronological** → Web search results are ranked by relevance, not strict reverse-chronological order. For "absolute latest N posts", open the user's profile page and sort by timestamp manually.

⚠️ **Unlisted content is inaccessible** → Posts set to "followers only" cannot be fetched. If content appears empty or post count seems low, inform the user about potential visibility restrictions.

---

## 🛑 Hard Stop

- Same web search query fails more than **3 times** (empty results or errors) → Stop immediately, tell user: "Cannot locate this user via search. Please verify the Weibo username or provide the profile URL directly."
- Playwright fails to render content on **3 consecutive** URLs → Stop, inform user the CSS selector may have changed, awaiting manual update.

---

## First Use

Run the dependency check before first use:
```bash
bash scripts/setup.sh
```
> This skill depends on Playwright for browser automation and a web search tool.

---

## Tool Dependencies

| Tool | Purpose |
|------|---------|
| agent-browser (recommended) | Open Weibo pages with visitor cookie to read post content (auto-detects and uses when available) |
| Playwright | Fallback browser automation when agent-browser is not available |
| Web search (Bing/Brave/etc.) | Locate Weibo user UID and post URLs via `site:weibo.com` search |

---

## Workflow

### A. Fetch a User's Recent N Posts

**Step 1: Locate user UID**
```
Web search: @username site:weibo.com
→ Extract UID from weibo.com/u/<UID> format URL
→ If post URLs are found directly, skip to Step 3
```

**Step 2: Search for user's post list**
```
Web search: site:weibo.com/u/<UID>
→ Collect returned post URLs (typically 5-10)
```

**Step 3: Read post content**
```
Playwright: open post URL
→ Read CSS selector: .detail_wbtext_4CRf9
→ If selector fails: find timestamp element in page, read surrounding text blocks
→ Extract: post text + publish time (from page title or timestamp element)
```

**Step 4: Format output**
```
Sort by time (descending, based on publish time field)
Output format:
---
[time] Post content
(Images/video: [contains media, text shown above])
---
```

### B. Get User Profile Overview
```
Playwright: open https://weibo.com/u/<UID> or https://weibo.com/<username>
→ Read post list from page (visitor cookie mode, no login required)
→ Note: without login, visible posts are limited (typically 10-15)
```

---

## Output Format

```
User: @username (UID: XXXXXXXXXX)
Scraped at: YYYY-MM-DD HH:MM
---
1. [2026-04-06 10:30] Post content...
2. [2026-04-05 15:20] Post content...
...
Total: N posts fetched, M contain media (text only shown)
```

---


> 微博 API 技术笔记见 `references/weibo-api-notes.md`。

## Gotchas

⚠️ **未登录只能看公开帖子** → "仅粉丝可见"的内容无法获取，需要告知用户。
⚠️ **visitor cookie 有效期短** → 通常 1-2 小时过期，过期后需重新打开微博页面获取新 cookie。
⚠️ **用户主页帖子数量有限** → 未登录状态下通常只显示 10-15 条，无法获取完整历史。
⚠️ **搜索结果排序不精确** → 通过 web search `site:weibo.com` 间接获取，时间排序不保证准确。

---

## Changelog

- 1.0.0: Initial release. Web search + Playwright visitor cookie approach for public Weibo content scraping without login.
