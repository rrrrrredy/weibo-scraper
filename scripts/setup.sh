#!/usr/bin/env bash
# setup.sh - 首次使用依赖检测与安装
# Usage: bash scripts/setup.sh

set -e

echo "🔍 检测 weibo-scraper 依赖..."

MISSING=0

# 检测依赖 Skill: agent-browser（OpenClaw 预装）
echo ""
echo "--- Skill 依赖 ---"
if [ -f ~/.openclaw/skills/agent-browser/SKILL.md ] || [ -f /app/skills/agent-browser/SKILL.md ]; then
  echo "✅ agent-browser Skill 已安装"
else
  echo "❌ agent-browser Skill 未找到"
  echo "   安装方式: mtskills i agent-browser --target-dir ~/.openclaw/skills"
  echo "   （Friday 广场 ID: 1783，通常 OpenClaw 已预装）"
  MISSING=1
fi

# 检测依赖 Skill: catclaw-search（OpenClaw 预装）
if [ -f ~/.openclaw/skills/catclaw-search/SKILL.md ] || [ -f /app/skills/catclaw-search/SKILL.md ]; then
  echo "✅ catclaw-search Skill 已安装"
else
  echo "❌ catclaw-search Skill 未找到"
  echo "   catclaw-search 通常为 OpenClaw 预装 Skill，请检查 /app/skills/ 目录"
  MISSING=1
fi

if [ "$MISSING" -eq 0 ]; then
  echo ""
  echo "✅ 所有依赖已就绪（无 pip/npm 依赖）"
else
  echo ""
  echo "⚠️  部分依赖 Skill 缺失，请按上述提示安装"
fi

echo "🎉 setup 完成，可以正常使用 weibo-scraper"
