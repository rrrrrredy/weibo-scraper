# 微博 API 踩坑记录

## 已测试不可用的路径

### 微博 ajax API（未登录）
- URL：`https://m.weibo.cn/api/container/getIndex?uid=<UID>&type=uid&value=<UID>`
- 结果：errno=-100，需登录
- 结论：不要在无登录场景使用

### opencli weibo
- 要求：Chrome extension relay（用户手动 Attach Tab）
- 沙箱：无法使用
- 结论：仅在用户有 Chrome 插件且 Attach Tab 时可用

### Camoufox headless
- 失败原因：初始化时访问 github.com/releases 下载浏览器二进制，沙箱出口 IP 不稳定导致超时
- 结论：沙箱环境不可用

## 已验证可用的路径

### catclaw-search + agent-browser（主路径）
- catclaw-search 搜索 bing，找到微博帖子 URL
- agent-browser 打开 URL，visitor cookie 自动注入，无需登录
- CSS selector: `.detail_wbtext_4CRf9`（2026-04 验证可用，可能随版本更新失效）
