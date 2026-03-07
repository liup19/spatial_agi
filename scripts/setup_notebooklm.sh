#!/bin/bash
# NotebookLM配置脚本
# 用于后续安装Chrome并配置NotebookLM

set -e

echo "🔧 NotebookLM配置脚本"
echo "========================"
echo ""

# 检查conda环境
if ! conda env list | grep -q "spatial-agi"; then
    echo "❌ 错误: spatial-agi conda环境不存在"
    echo "请先运行今天的Spatial AGI研究流程"
    exit 1
fi

echo "步骤1: 安装Chromium浏览器"
echo "需要sudo权限，请输入密码:"
sudo apt update
sudo apt install chromium-browser -y

echo ""
echo "步骤2: 验证安装"
if which chromium-browser > /dev/null; then
    echo "✅ Chromium安装成功"
else
    echo "❌ Chromium安装失败"
    exit 1
fi

echo ""
echo "步骤3: 配置NotebookLM认证"
echo "即将打开Chromium浏览器进行NotebookLM登录"
echo "请在浏览器中:"
echo "1. 登录你的Google账号"
echo "2. 访问 https://notebooklm.google.com"
echo "3. 确保能够正常访问"
echo ""
read -p "按Enter键继续..."

# 激活conda环境并登录
source ~/miniconda3/bin/activate
conda activate spatial-agi

echo ""
echo "步骤4: 使用Chromium登录NotebookLM"
nlm login

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ NotebookLM配置成功！"
    echo ""
    echo "测试连接..."
    nlm notebook list
    
    echo ""
    echo "🎉 配置完成！"
    echo "现在你可以在后续的Spatial AGI研究中使用NotebookLM进行深度分析了。"
else
    echo ""
    echo "❌ NotebookLM登录失败"
    echo "请检查:"
    echo "1. 是否已登录Google账号"
    echo "2. 是否能够访问 https://notebooklm.google.com"
    echo "3. 网络连接是否正常"
fi
