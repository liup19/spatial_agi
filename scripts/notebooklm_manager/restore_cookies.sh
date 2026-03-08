#!/bin/bash
# NotebookLM Cookies 恢复脚本
# 用途：从备份恢复cookies

set -e

COOKIES_FILE="${COOKIES_FILE:-$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.notebooklm-mcp-cli/backups}"
CONDA_ENV="spatial-agi"

echo "🔄 恢复NotebookLM cookies..."
echo ""

# 检查备份目录
if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ 错误: 备份目录不存在"
    echo "   路径: $BACKUP_DIR"
    exit 1
fi

# 查找最新的备份
LATEST_BACKUP=$(ls -1t "$BACKUP_DIR"/notebooklm_cookies_* 2>/dev/null | head -1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "❌ 错误: 未找到任何备份文件"
    exit 1
fi

echo "📦 找到最新备份:"
echo "   文件: $LATEST_BACKUP"
echo "   大小: $(du -h "$LATEST_BACKUP" | cut -f1)"
echo ""

# 如果是压缩文件，先解压
if [[ "$LATEST_BACKUP" == *.gz ]]; then
    echo "🔓 解压备份文件..."
    TEMP_FILE="/tmp/notebooklm_cookies_restore_$$.json"
    gunzip -c "$LATEST_BACKUP" > "$TEMP_FILE"
    RESTORE_FILE="$TEMP_FILE"
else
    RESTORE_FILE="$LATEST_BACKUP"
fi

# 备份当前文件（如果存在）
if [ -f "$COOKIES_FILE" ]; then
    CORRUPT_BACKUP="$BACKUP_DIR/corrupt_cookies_$(date '+%Y%m%d_%H%M%S').json"
    echo "💾 备份当前文件到:"
    echo "   $CORRUPT_BACKUP"
    cp "$COOKIES_FILE" "$CORRUPT_BACKUP"
fi

# 恢复文件
echo ""
echo "📋 恢复cookies..."
cp "$RESTORE_FILE" "$COOKIES_FILE"
echo "✅ 文件已恢复"

# 清理临时文件
if [ -n "$TEMP_FILE" ] && [ -f "$TEMP_FILE" ]; then
    rm "$TEMP_FILE"
fi

# 测试恢复的cookies
echo ""
echo "🧪 测试恢复的cookies..."

source ~/miniconda3/bin/activate
conda activate $CONDA_ENV

if nlm login --check 2>&1 | grep -q "Authentication valid"; then
    echo "✅ Cookies恢复成功"
    echo "   状态: 认证通过"
    exit 0
else
    echo "❌ 恢复失败: Cookies仍然无效"
    echo "   可能需要重新从浏览器导出cookies"
    exit 1
fi
