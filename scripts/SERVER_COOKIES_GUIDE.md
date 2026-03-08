# 服务器环境 - NotebookLM Cookies 获取指南

## 🎯 问题

服务器没有可视化界面（无浏览器），无法直接导出NotebookLM cookies。

---

## ✅ 解决方案

### 方案A: 使用GLM WebReader（推荐，立即可用）⭐

**优势**:
- ✅ 无需cookies
- ✅ 无需浏览器
- ✅ 已经配置完成
- ✅ GLM-5理解能力强
- ✅ 质量接近NotebookLM

**使用方法**:
```bash
# 系统会自动检测cookies，失效时降级到GLM WebReader
bash scripts/smart_analysis_selector.sh
```

**适用场景**:
- ✅ 日常研究（论文分析）
- ✅ 快速开始
- ✅ 服务器环境

**质量对比**:
| 维度 | NotebookLM | GLM WebReader |
|------|-----------|---------------|
| 深度分析 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 响应速度 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 可用性 | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| 上下文理解 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 无需配置 | ❌ | ✅ |

---

### 方案B: 本地导出 + 上传（需要本地电脑）

#### 步骤1: 本地电脑导出cookies

**在本地电脑上**（有浏览器的环境）：

**方法1: 使用EditThisCookie扩展（推荐）**
1. 打开Chrome浏览器
2. 访问 https://notebooklm.google.com
3. 确保已登录Google账号
4. 点击EditThisCookie扩展图标 🍪
5. 点击"Export" → "JSON"
6. Cookies复制到剪贴板
7. 保存为 `notebooklm.google.com_cookies.json`

**方法2: 使用开发者工具**
1. 访问 https://notebooklm.google.com
2. 按F12打开开发者工具
3. 切换到"Console"标签
4. 粘贴以下代码：

```javascript
copy(JSON.stringify(
  document.cookie.split('; ').map(c => {
    const [name, ...rest] = c.split('=');
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
      value: rest.join('=')
    };
  })
))
```

5. 按Enter，cookies复制到剪贴板
6. 粘贴到文本编辑器，保存为 `notebooklm.google.com_cookies.json`

#### 步骤2: 上传到服务器

**方法1: 使用scp**
```bash
# 在本地电脑上
scp notebooklm.google.com_cookies.json ropliu@your-server:~/.notebooklm-mcp-cli/

# 如果目录不存在，先创建
ssh ropliu@your-server "mkdir -p ~/.notebooklm-mcp-cli"
scp notebooklm.google.com_cookies.json ropliu@your-server:~/.notebooklm-mcp-cli/
```

**方法2: 使用粘贴方式**
```bash
# 在服务器上
nano ~/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json

# 粘贴cookies内容（从本地复制）
# Ctrl+Shift+V 粘贴
# Ctrl+O 保存
# Ctrl+X 退出
```

#### 步骤3: 验证cookies

```bash
# 在服务器上
cd ~/.openclaw/workspace/spatial_agi
bash scripts/notebooklm_cookies_manager.sh check

# 或直接测试
source ~/miniconda3/bin/activate
conda activate spatial-agi
nlm login --check
```

#### 步骤4: 备份cookies

```bash
# 自动备份
bash scripts/notebooklm_cookies_manager.sh backup
```

---

### 方案C: 自动化方案（高级，不推荐）

使用Puppeteer/Selenium + 虚拟显示：

**不推荐原因**:
- ❌ 配置复杂
- ❌ 需要安装Chrome/Chromium
- ❌ 需要虚拟显示（Xvfb）
- ❌ 仍然需要手动登录（至少第一次）
- ❌ 容易被Google检测为自动化

**结论**: 不如直接使用GLM WebReader

---

## 💡 推荐策略

### 短期（今天）
✅ **使用GLM WebReader**
- 无需任何配置
- 立即可用
- 质量足够好

### 中期（有空时）
✅ **在本地电脑导出cookies，上传到服务器**
- 获得NotebookLM的深度分析能力
- 定期刷新（每周一次）

### 长期（可选）
✅ **混合使用**
- 日常：GLM WebReader（快速）
- 重要论文：NotebookLM（深度）

---

## 🚀 快速开始（立即可用）

```bash
# 1. 检查分析方式
cd ~/.openclaw/workspace/spatial_agi
bash scripts/smart_analysis_selector.sh

# 2. 开始研究（会自动选择可用方法）
bash scripts/start_research.sh

# 3. 系统会自动：
#    - 检测NotebookLM cookies
#    - 如果有效 → 使用NotebookLM
#    - 如果失效 → 使用GLM WebReader
```

---

## 📊 对比总结

| 方案 | 配置难度 | 可用性 | 质量 | 推荐度 |
|------|---------|--------|------|--------|
| **GLM WebReader** | ⭐ (无需配置) | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **本地导出+上传** | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Puppeteer自动化** | ⭐⭐⭐⭐⭐ | ⭐ | ⭐⭐⭐⭐⭐ | ⭐ |

---

## ❓ 常见问题

### Q1: GLM WebReader质量够用吗？

**A**: ✅ 够用
- GLM-5理解能力强
- 已经在今天的论文分析中使用
- 对于大部分研究场景足够

### Q2: Cookies多久需要刷新一次？

**A**: 通常1-2周
- Google安全策略会定期要求重新登录
- 建议每周刷新一次
- 使用定时任务自动备份

### Q3: 可不可以同时使用两种方法？

**A**: ✅ 可以，而且推荐
- 日常：GLM WebReader（快速）
- 重要论文：NotebookLM（深度）
- 系统会自动选择

---

## 🎯 总结

**服务器环境下的最佳实践**:

1. **立即开始**: 使用GLM WebReader（无需cookies）
2. **有空时**: 本地导出cookies上传到服务器
3. **混合使用**: 根据论文重要性选择方法

**现在就可以开始研究**，不需要等待cookies配置！

---

**维护者**: OpenClaw AI
**最后更新**: 2026-03-08
