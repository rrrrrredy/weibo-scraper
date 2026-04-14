# Weibo API Notes

## Tested Approaches (Not Working Without Login)

### Weibo ajax API (no login)
- URL: `https://m.weibo.cn/api/container/getIndex?uid=<UID>&type=uid&value=<UID>`
- Result: errno=-100, requires login
- Conclusion: Do not use in no-login scenarios

### Camoufox headless
- Failure reason: Downloads browser binaries on initialization, network timeouts in restricted environments
- Conclusion: Use standard Playwright instead

## Working Approach

### Web search + Playwright (primary path)
- Use web search (Bing/Brave) to find Weibo post URLs
- Playwright opens the URL; visitor cookie is automatically set, no login needed
- CSS selector: `.detail_wbtext_4CRf9` (verified 2026-04, may change with frontend updates)
