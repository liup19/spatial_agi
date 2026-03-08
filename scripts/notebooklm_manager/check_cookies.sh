#!/bin/bash
# NotebookLM Cookies 检测脚本
# 用途：检测cookies是否有效

set -e

COOKIES_FILE="${COOKIES_FILE:-$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json}"
CONDA_ENV="spatial-agi"

echo "🔍 检测NotebookLM cookies状态..."
echo ""

# 检查cookies文件是否存在
if [ ! -f "$COOKIES_FILE" ]; then
    echo "❌ 错误: Cookies文件不存在"
    echo "   路径: $COOKIES_FILE"
    exit 1
fi

# 检查文件大小
FILE_SIZE=$(stat -f%z "$COOKIES_FILE" 2>/dev/null || stat -c%s "$COOKIES_FILE" 2>/dev/null)
if [ "$FILE_SIZE" -lt 100 ]; then
    echo "❌ 错误: Cookies文件太小（可能已损坏）"
    echo "   大小: $FILE_SIZE bytes"
    exit 1
fi

echo "✅ Cookies文件存在"
echo "   路径: $COOKIES_FILE"
echo "   大小: $FILE_SIZE bytes"
echo ""

# 激活conda环境并检测
source ~/miniconda3/bin/activate
conda activate $CONDA_ENV

# 尝试登录检测
if nlm login --check 2>&1 | grep -q "Authentication valid"; then
    echo "✅ Cookies有效"
    echo "   状态: 认证通过"
    exit 0
else
    echo "❌ Cookies已失效"
    echo "   状态: 需要刷新"
    exit 1
fi
