#!/bin/bash
# Spatial AGI Research - 智能启动脚本
# 自动检测并选择最佳分析方法

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🚀 Spatial AGI Research - 智能启动"
echo "===================================="
echo ""

# 1. 检查conda环境
echo "1️⃣  检查环境..."
if ! conda env list | grep -q "^spatial-agi "; then
    echo "❌ spatial-agi环境不存在"
    echo "   请先运行环境配置"
    exit 1
fi
echo "   ✅ Conda环境: spatial-agi"

# 2. 检查代理
echo ""
echo "2️⃣  检查代理..."
if [ -n "$HTTP_PROXY" ] || [ -n "$HTTPS_PROXY" ]; then
    echo "   ✅ 代理已配置: ${HTTP_PROXY:-$HTTPS_PROXY}"
else
    echo "   ⚠️  代理未配置（可能影响访问）"
fi

# 3. 检查分析方法
echo ""
echo "3️⃣  选择分析方法..."

source ~/miniconda3/bin/activate
conda activate spatial-agi

COOKIES_FILE="$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json"

if [ -f "$COOKIES_FILE" ]; then
    # 测试cookies有效性
    if timeout 10 nlm login --check 2>&1 | grep -q "Authentication valid"; then
        echo "   ✅ NotebookLM: 可用"
        echo "   ✅ GLM WebReader: 可用（备选）"
        echo ""
        echo "📊 分析方法: NotebookLM（首选）+ GLM WebReader（备选）"
        ANALYSIS_METHOD="notebooklm"
    else
        echo "   ⚠️  NotebookLM: Cookies已失效"
        echo "   ✅ GLM WebReader: 可用"
        echo ""
        echo "📊 分析方法: GLM WebReader（NotebookLM cookies已失效）"
        ANALYSIS_METHOD="glm_webreader"
    fi
else
    echo "   ❌ NotebookLM: Cookies不存在"
    echo "   ✅ GLM WebReader: 可用"
    echo ""
    echo "📊 分析方法: GLM WebReader（NotebookLM未配置）"
    ANALYSIS_METHOD="glm_webreader"
fi

# 4. 询问是否继续
echo ""
echo "4️⃣  准备就绪"
echo ""
read -p "开始今天的Spatial AGI研究？(y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "❌ 已取消"
    exit 0
fi

# 5. 开始研究
echo ""
echo "🚀 启动研究流程..."
echo ""

# 调用主研究脚本
if [ -f "$ROOT_DIR/scripts/run_research.sh" ]; then
    export ANALYSIS_METHOD
    bash "$ROOT_DIR/scripts/run_research.sh"
else
    echo "❌ 错误: 研究脚本不存在"
    echo "   预期路径: $ROOT_DIR/scripts/run_research.sh"
    exit 1
fi
