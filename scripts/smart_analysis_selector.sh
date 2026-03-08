#!/bin/bash
# Spatial AGI Research - 智能分析方法选择
# 自动检测NotebookLM cookies，失效时降级到GLM WebReader

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
COOKIES_FILE="$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json"

echo "🔬 Spatial AGI Research - 分析方法选择"
echo "=========================================="
echo ""

# 检查conda环境
if ! conda env list | grep -q "^spatial-agi "; then
    echo "❌ 错误: spatial-agi conda环境不存在"
    echo "   请先运行环境配置"
    exit 1
fi

# 激活环境
source ~/miniconda3/bin/activate
conda activate spatial-agi

# 检查cookies文件
if [ ! -f "$COOKIES_FILE" ]; then
    echo "⚠️  Cookies文件不存在"
    echo ""
    echo "📊 使用分析方法: GLM WebReader"
    echo "   ✅ 优势: 无需cookies，立即可用"
    echo "   ✅ 质量: GLM-5理解能力强"
    echo ""
    echo "ANALYSIS_METHOD=glm_webreader"
    exit 0
fi

# 测试cookies有效性
echo "📋 检测NotebookLM cookies状态..."
if timeout 10 nlm login --check 2>&1 | grep -q "Authentication valid"; then
    echo ""
    echo "✅ Cookies有效"
    echo ""
    echo "📊 使用分析方法: NotebookLM"
    echo "   ✅ 优势: 深度分析，可交互笔记本"
    echo ""
    echo "ANALYSIS_METHOD=notebooklm"
    exit 0
else
    echo ""
    echo "❌ Cookies已失效"
    echo ""
    echo "📊 使用分析方法: GLM WebReader（自动降级）"
    echo "   ✅ 优势: 无需cookies，立即可用"
    echo "   ✅ 质量: GLM-5理解能力强"
    echo ""
    echo "💡 提示: 稍后可以刷新cookies以使用NotebookLM"
    echo "   bash $ROOT_DIR/scripts/notebooklm_cookies_manager.sh refresh"
    echo ""
    echo "ANALYSIS_METHOD=glm_webreader"
    exit 0
fi
