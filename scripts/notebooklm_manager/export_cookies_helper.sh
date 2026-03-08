#!/bin/bash
# NotebookLM Cookies 导出助手
# 提供详细的浏览器导出步骤

cat << 'EOF'
╔════════════════════════════════════════════════════════════╗
║  🍪 NotebookLM Cookies 导出助手                           ║
╚════════════════════════════════════════════════════════════╝

📍 目标文件: ~/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌐 方法1: Chrome浏览器 + EditThisCookie扩展（推荐）

步骤1: 安装扩展
   1. 打开Chrome
   2. 访问: https://chrome.google.com/webstore/
   3. 搜索: "EditThisCookie"
   4. 点击"添加到Chrome"

步骤2: 访问NotebookLM
   1. 访问: https://notebooklm.google.com
   2. 确保已登录Google账号
   3. 确保页面加载完成

步骤3: 导出Cookies
   1. 点击浏览器右上角的EditThisCookie图标（🍪）
   2. 点击"Export"按钮
   3. 选择"JSON"格式
   4. Cookies会自动复制到剪贴板

步骤4: 保存文件
   1. 打开终端
   2. 运行: nano ~/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json
   3. 粘贴内容（Ctrl+Shift+V）
   4. 保存（Ctrl+O, Enter）
   5. 退出（Ctrl+X）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌐 方法2: Firefox浏览器 + Cookie Editor扩展

步骤1: 安装扩展
   1. 打开Firefox
   2. 访问: https://addons.mozilla.org/
   3. 搜索: "Cookie Editor"
   4. 点击"添加到Firefox"

步骤2-4: 同方法1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌐 方法3: 手动导出（无需扩展）

步骤1: 打开开发者工具
   1. 访问: https://notebooklm.google.com
   2. 按F12（或右键 > 检查）

步骤2: 查看Cookies
   1. 切换到"Application"标签（Chrome）
      或"存储"标签（Firefox）
   2. 展开左侧的"Cookies"
   3. 点击"https://notebooklm.google.com"

步骤3: 复制Cookies
   1. 在控制台（Console）输入以下代码：

   copy(JSON.stringify(
     document.cookie.split('; ').map(c => {
       const [name, ...rest] = c.split('=');
       const value = rest.join('=');
       return {
         domain: ".google.com",
         expirationDate: Math.floor(Date.now()/1000) + 31536000,
         hostOnly: false,
         httpOnly: false,
         name: name,
         path: "/",
         sameSite: "no_restriction",
         secure: true,
         session: false,
         storeId: "1",
         value: value
       };
     })
   ))

   2. 按Enter
   3. Cookies已复制到剪贴板

步骤4: 保存文件（同方法1步骤4）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 提示

1. 确保导出的是JSON数组格式，以 [ 开头，以 ] 结尾
2. 每个cookie对象应包含: name, value, domain, path等字段
3. 文件大小通常在5-10KB左右
4. 如果文件很大（>20KB），可能包含多余的cookies

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

echo ""
echo "按Enter键继续..."
read

# 等待用户完成
echo ""
echo "⏳ 等待你完成cookies导出..."
echo ""
read -p "完成导出后，按Enter键继续..." -r

# 检查文件
COOKIES_FILE="$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json"

if [ ! -f "$COOKIES_FILE" ]; then
    echo ""
    echo "❌ 未找到cookies文件"
    echo "   预期路径: $COOKIES_FILE"
    echo ""
    echo "请确保:"
    echo "1. 文件已保存到正确路径"
    echo "2. 文件名正确（包括 .json 扩展名）"
    exit 1
fi

# 验证文件内容
FILE_SIZE=$(stat -c%s "$COOKIES_FILE" 2>/dev/null || stat -f%z "$COOKIES_FILE")
echo ""
echo "✅ 检测到cookies文件"
echo "   路径: $COOKIES_FILE"
echo "   大小: $FILE_SIZE bytes"

# 检查JSON格式
if ! python3 -c "import json; json.load(open('$COOKIES_FILE'))" 2>/dev/null; then
    echo ""
    echo "❌ 文件格式错误"
    echo "   请确保文件是有效的JSON格式"
    exit 1
fi

echo "   格式: ✅ 有效的JSON"

# 测试cookies
echo ""
echo "🧪 测试cookies..."

source ~/miniconda3/bin/activate
conda activate spatial-agi

if nlm login --manual -f "$COOKIES_FILE" 2>&1 | grep -q "Successfully authenticated"; then
    echo ""
    echo "✅ Cookies刷新成功！"
    echo ""
    
    # 自动备份
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [ -f "$SCRIPT_DIR/notebooklm_cookies_manager.sh" ]; then
        echo "💾 自动备份cookies..."
        bash "$SCRIPT_DIR/notebooklm_cookies_manager.sh" backup
    fi
    
    echo ""
    echo "🎉 可以使用NotebookLM了！"
    exit 0
else
    echo ""
    echo "❌ Cookies验证失败"
    echo ""
    echo "可能的原因:"
    echo "1. 未正确登录NotebookLM"
    echo "2. Cookies格式不正确"
    echo "3. 缺少必要的cookies字段"
    echo ""
    echo "请重新尝试导出"
    exit 1
fi
