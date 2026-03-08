#!/bin/bash
# NotebookLM Cookies 备份脚本
# 用途：备份有效的cookies文件

set -e

COOKIES_FILE="${COOKIES_FILE:-$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.notebooklm-mcp-cli/backups}"
MAX_BACKUPS="${MAX_BACKUPS:-10}"

echo "💾 备份NotebookLM cookies..."
echo ""

# 检查cookies文件
if [ ! -f "$COOKIES_FILE" ]; then
    echo "❌ 错误: Cookies文件不存在"
    exit 1
fi

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 生成备份文件名（带时间戳）
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP_FILE="$BACKUP_DIR/notebooklm_cookies_$TIMESTAMP.json"

# 复制文件
cp "$COOKIES_FILE" "$BACKUP_FILE"

echo "✅ 备份成功"
echo "   源文件: $COOKIES_FILE"
echo "   备份位置: $BACKUP_FILE"

# 压缩备份（可选）
if command -v gzip &> /dev/null; then
    gzip "$BACKUP_FILE"
    echo "   压缩后: ${BACKUP_FILE}.gz"
    BACKUP_FILE="${BACKUP_FILE}.gz"
fi

# 清理旧备份（保留最新的N个）
echo ""
echo "🧹 清理旧备份..."

BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/notebooklm_cookies_* 2>/dev/null | wc -l)
if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    # 删除最旧的备份
    cd "$BACKUP_DIR"
    ls -1t notebooklm_cookies_* | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -f
    DELETED=$((BACKUP_COUNT - MAX_BACKUPS))
    echo "   已删除 $DELETED 个旧备份"
else
    echo "   当前备份数: $BACKUP_COUNT (无需清理)"
fi

# 显示当前备份列表
echo ""
echo "📋 当前备份列表:"
ls -lht "$BACKUP_DIR"/notebooklm_cookies_* 2>/dev/null | head -5 | awk '{print "   " $9 " (" $5 " bytes)"}'

echo ""
echo "✅ 备份完成"
