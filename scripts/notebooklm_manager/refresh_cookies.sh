#!/bin/bash
# NotebookLM Cookies 刷新脚本
# 用途：从浏览器自动导出新cookies

set -e

COOKIES_FILE="${COOKIES_FILE:-$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.notebooklm-mcp-cli/backups}"
CONDA_ENV="spatial-agi"

echo "🔄 刷新NotebookLM cookies..."
echo ""

# 方法1: 尝试从Chrome自动导出（如果安装了Chrome cookies扩展）
if command -v google-chrome &> /dev/null || command -v chromium-browser &> /dev/null; then
    echo "💡 检测到Chrome/Chromium浏览器"
    echo ""
    echo "方法1: 使用浏览器扩展自动导出"
    echo "----------------------------------------"
    echo "1. 打开Chrome浏览器"
    echo "2. 访问 https://notebooklm.google.com"
    echo "3. 确保已登录Google账号"
    echo "4. 使用扩展导出cookies（如EditThisCookie）"
    echo "5. 保存为: $COOKIES_FILE"
    echo ""
fi

# 方法2: 使用Firefox（如果安装了）
if command -v firefox &> /dev/null; then
    echo "方法2: 使用Firefox手动导出"
    echo "----------------------------------------"
    echo "1. 打开Firefox浏览器"
    echo "2. 访问 https://notebooklm.google.com"
    echo "3. 确保已登录Google账号"
    echo "4. 使用开发者工具 > 存储 > Cookies"
    echo "5. 导出为JSON格式"
    echo ""
fi

# 方法3: 手动指导
echo "方法3: 手动导出（推荐）"
echo "----------------------------------------"
echo "1. 打开浏览器（Chrome/Firefox/Edge）"
echo "2. 访问 https://notebooklm.google.com"
echo "3. 确保已登录Google账号"
echo "4. 按F12打开开发者工具"
echo "5. 切换到'Application'或'存储'标签"
echo "6. 找到 Cookies > https://notebooklm.google.com"
echo "7. 使用扩展或手动复制cookies"
echo ""
echo "推荐扩展:"
echo "  - EditThisCookie (Chrome)"
echo "  - Cookie Editor (Firefox)"
echo "  - Cookie-Editor (Edge)"
echo ""

# 提供自动等待机制
echo "----------------------------------------"
echo "⏳ 我会等待你完成导出..."
echo ""

read -p "完成导出后按Enter继续..."

# 检查文件是否存在
if [ ! -f "$COOKIES_FILE" ]; then
    echo ""
    echo "❌ 错误: 未找到cookies文件"
    echo "   预期路径: $COOKIES_FILE"
    echo ""
    echo "请确保:"
    echo "1. 已正确导出cookies"
    echo "2. 文件保存在正确路径"
    echo "3. 文件格式为JSON"
    exit 1
fi

echo ""
echo "✅ 检测到cookies文件"
echo "   路径: $COOKIES_FILE"
echo "   大小: $(du -h "$COOKIES_FILE" | cut -f1)"
echo ""

# 测试新cookies
echo "🧪 测试新cookies..."

source ~/miniconda3/bin/activate
conda activate $CONDA_ENV

if nlm login --manual -f "$COOKIES_FILE" 2>&1 | grep -q "Successfully authenticated"; then
    echo "✅ Cookies刷新成功"
    echo ""
    
    # 自动备份
    echo "💾 自动备份新cookies..."
    bash "$(dirname "$0")/backup_cookies.sh"
    
    exit 0
else
    echo "❌ 刷新失败: Cookies无效"
    echo ""
    echo "可能的原因:"
    echo "1. 未正确登录NotebookLM"
    echo "2. Cookies格式不正确"
    echo "3. Cookies已过期（导出太慢）"
    echo ""
    echo "请重新尝试导出"
    exit 1
fi
