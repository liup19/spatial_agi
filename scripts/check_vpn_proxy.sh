#!/bin/bash
# VPN代理状态检查脚本

echo "🔍 VPN代理状态检查"
echo "================================"
echo ""

# 1. 环境变量
echo "1️⃣  环境变量代理配置:"
echo "   HTTP_PROXY: ${HTTP_PROXY:-❌ 未设置}"
echo "   HTTPS_PROXY: ${HTTPS_PROXY:-❌ 未设置}"
echo "   ALL_PROXY: ${ALL_PROXY:-❌ 未设置}"
echo ""

# 2. 测试HTTP代理
echo "2️⃣  HTTP代理 (7890端口):"
if timeout 5 curl -x http://127.0.0.1:7890 -s -o /dev/null -w "   ✅ 工作正常 (状态码: %{http_code})\n" https://www.google.com 2>&1; then
    HTTP_PROXY_OK=1
else
    echo "   ❌ 连接失败"
    HTTP_PROXY_OK=0
fi
echo ""

# 3. 测试SOCKS5代理
echo "3️⃣  SOCKS5代理 (1080端口):"
if timeout 5 curl -x socks5://127.0.0.1:1080 -s -o /dev/null -w "   ✅ 工作正常 (状态码: %{http_code})\n" https://www.google.com 2>&1; then
    SOCKS5_PROXY_OK=1
else
    echo "   ❌ 连接失败"
    SOCKS5_PROXY_OK=0
fi
echo ""

# 4. 测试直接访问
echo "4️⃣  直接访问Google:"
if timeout 10 curl -s -o /dev/null -w "   ✅ 成功 (状态码: %{http_code}, 耗时: %{time_total}s)\n" https://www.google.com 2>&1; then
    DIRECT_OK=1
else
    echo "   ❌ 失败"
    DIRECT_OK=0
fi
echo ""

# 5. 测试NotebookLM访问
echo "5️⃣  访问NotebookLM:"
if timeout 10 curl -s -o /dev/null -w "   ✅ 成功 (状态码: %{http_code}, 耗时: %{time_total}s)\n" https://notebooklm.google.com 2>&1; then
    NOTEBOOKLM_OK=1
else
    echo "   ❌ 失败"
    NOTEBOOKLM_OK=0
fi
echo ""

# 6. 总结
echo "📊 总结:"
echo "================================"
if [ $HTTP_PROXY_OK -eq 1 ]; then
    echo "✅ HTTP代理: 可用 (推荐用于NotebookLM)"
else
    echo "❌ HTTP代理: 不可用"
fi

if [ $SOCKS5_PROXY_OK -eq 1 ]; then
    echo "✅ SOCKS5代理: 可用"
else
    echo "⚠️  SOCKS5代理: 不可用"
fi

if [ $NOTEBOOKLM_OK -eq 1 ]; then
    echo "✅ NotebookLM: 可访问"
else
    echo "❌ NotebookLM: 不可访问"
fi
echo ""

# 7. 建议
echo "💡 建议:"
if [ $HTTP_PROXY_OK -eq 1 ]; then
    echo "   代理状态良好，可以使用NotebookLM"
    echo ""
    echo "   如果NotebookLM CLI需要配置代理，运行:"
    echo "   export NOTEBOOKLM_PROXY=\"http://127.0.0.1:7890\""
elif [ $SOCKS5_PROXY_OK -eq 1 ]; then
    echo "   可以使用SOCKS5代理"
    echo "   export NOTEBOOKLM_PROXY=\"socks5://127.0.0.1:1080\""
else
    echo "   ❌ 代理不可用，请检查VPN是否启动"
fi
