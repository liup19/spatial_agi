#!/bin/bash
# Spatial AGI Research - NotebookLM Cookies 自动检查和恢复
# 在研究流程开始前自动调用

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANAGER_SCRIPT="$SCRIPT_DIR/notebooklm_cookies_manager.sh"

echo "🔬 Spatial AGI Research - NotebookLM 准备检查"
echo "================================================"
echo ""

# 检查管理器是否存在
if [ ! -f "$MANAGER_SCRIPT" ]; then
    echo "❌ 错误: NotebookLM管理器未安装"
    echo "   预期路径: $MANAGER_SCRIPT"
    exit 1
fi

# 自动检查和恢复
echo "📋 步骤1: 检测cookies状态..."
if bash "$MANAGER_SCRIPT" check 2>/dev/null; then
    echo ""
    echo "✅ Cookies有效，可以使用NotebookLM进行分析"
    echo ""
    
    # 询问是否备份
    read -p "是否备份当前cookies？(y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "$MANAGER_SCRIPT" backup
    fi
    
    exit 0
fi

echo ""
echo "⚠️  Cookies已失效"
echo ""

# 尝试自动恢复
echo "📋 步骤2: 尝试从备份恢复..."
if bash "$MANAGER_SCRIPT" restore 2>/dev/null; then
    echo ""
    echo "✅ 恢复成功，可以使用NotebookLM进行分析"
    exit 0
fi

echo ""
echo "❌ 自动恢复失败"
echo ""

# 询问是否手动刷新
read -p "是否手动刷新cookies？(y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$MANAGER_SCRIPT" refresh
    exit $?
fi

echo ""
echo "ℹ️  将使用GLM WebReader作为备选方案"
echo "   分析方法: web_fetch工具"
echo ""
echo "💡 提示: 稍后可以运行以下命令刷新cookies:"
echo "   bash $MANAGER_SCRIPT refresh"
echo ""

exit 2  # 返回2表示使用备选方案
