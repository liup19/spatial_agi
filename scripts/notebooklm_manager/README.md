# NotebookLM Cookies 自动化管理器

## 📋 概述

这是一个完整的NotebookLM cookies自动化管理解决方案，包含：
- ✅ **自动检测** - 检测cookies是否有效
- ✅ **自动备份** - 定期备份有效的cookies
- ✅ **自动恢复** - 从备份自动恢复失效的cookies
- ✅ **手动刷新** - 从浏览器导出新cookies
- ✅ **集成到研究流程** - 在分析前自动检查

---

## 🚀 快速开始

### 1. 查看当前状态

```bash
cd ~/.openclaw/workspace/spatial_agi
bash scripts/notebooklm_cookies_manager.sh status
```

### 2. 检测cookies

```bash
bash scripts/notebooklm_cookies_manager.sh check
```

### 3. 备份cookies

```bash
bash scripts/notebooklm_cookies_manager.sh backup
```

### 4. 从备份恢复

```bash
bash scripts/notebooklm_cookies_manager.sh restore
```

### 5. 刷新cookies（从浏览器）

```bash
bash scripts/notebooklm_cookies_manager.sh refresh
```

### 6. 自动管理（推荐）

```bash
bash scripts/notebooklm_cookies_manager.sh auto
```

---

## 📁 文件结构

```
~/.openclaw/workspace/spatial_agi/
├── scripts/
│   ├── notebooklm_cookies_manager.sh          # 主入口（wrapper）
│   └── notebooklm_manager/
│       ├── notebooklm_cookies_manager.sh      # 主管理器
│       ├── check_cookies.sh                   # 检测脚本
│       ├── backup_cookies.sh                  # 备份脚本
│       ├── restore_cookies.sh                 # 恢复脚本
│       ├── refresh_cookies.sh                 # 刷新脚本
│       ├── check_before_research.sh           # 研究前检查
│       ├── crontab_config.txt                 # 定时任务配置
│       └── README.md                          # 本文档

~/.notebooklm-mcp-cli/
├── notebooklm.google.com_cookies.json         # 当前cookies
└── backups/                                    # 备份目录
    ├── notebooklm_cookies_20260308_080000.json.gz
    ├── notebooklm_cookies_20260307_080000.json.gz
    └── ...
```

---

## ⚙️ 配置定时任务

### 方法1: 使用crontab（推荐）

```bash
# 1. 编辑crontab
crontab -e

# 2. 添加以下内容（从 scripts/notebooklm_manager/crontab_config.txt 复制）
# 每小时检查并自动恢复
0 * * * * /home/ropliu/.openclaw/workspace/spatial_agi/scripts/notebooklm_cookies_manager.sh auto >> /tmp/notebooklm_cookies.log 2>&1

# 每天凌晨2点备份
0 2 * * * /home/ropliu/.openclaw/workspace/spatial_agi/scripts/notebooklm_cookies_manager.sh check && /home/ropliu/.openclaw/workspace/spatial_agi/scripts/notebooklm_cookies_manager.sh backup >> /tmp/notebooklm_cookies.log 2>&1

# 3. 保存并退出

# 4. 查看日志
tail -f /tmp/notebooklm_cookies.log
```

### 方法2: 使用OpenClaw cron（如果支持）

参考 `spatial-agi-research` skill的定时任务配置。

---

## 🔧 环境变量

可以通过环境变量自定义配置：

```bash
# Cookies文件路径（默认: ~/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json）
export COOKIES_FILE="/path/to/your/cookies.json"

# 备份目录（默认: ~/.notebooklm-mcp-cli/backups）
export BACKUP_DIR="/path/to/your/backups"

# 最大备份数量（默认: 10）
export MAX_BACKUPS=20
```

---

## 📊 使用场景

### 场景1: 研究前自动检查

在开始Spatial AGI研究前，自动检查cookies：

```bash
# 方法1: 直接调用
bash scripts/notebooklm_manager/check_before_research.sh

# 方法2: 在研究脚本中集成
if bash scripts/notebooklm_manager/check_before_research.sh; then
    echo "使用NotebookLM分析"
else
    echo "使用GLM WebReader备选方案"
fi
```

### 场景2: 定期维护

设置定时任务，自动维护cookies：

```bash
# 每小时检查一次
bash scripts/notebooklm_cookies_manager.sh auto
```

### 场景3: 手动刷新

当cookies失效且自动恢复失败时：

```bash
# 交互式刷新（会提示操作步骤）
bash scripts/notebooklm_cookies_manager.sh refresh
```

---

## 🔍 故障排查

### 问题1: Cookies总是失效

**可能原因**:
- Google账号安全策略（定期要求重新登录）
- Cookies导出时已过期
- 浏览器清理了cookies

**解决方案**:
1. 定期备份（每天自动备份）
2. 使用定时任务自动检查
3. 及时刷新cookies

### 问题2: 自动恢复失败

**可能原因**:
- 所有备份都已过期
- 备份文件损坏

**解决方案**:
1. 手动刷新cookies
2. 检查备份文件完整性
3. 增加备份频率

### 问题3: 找不到cookies文件

**可能原因**:
- 路径配置错误
- 首次使用，尚未导出cookies

**解决方案**:
```bash
# 检查当前路径配置
bash scripts/notebooklm_cookies_manager.sh status

# 首次导出cookies
bash scripts/notebooklm_cookies_manager.sh refresh
```

---

## 💡 最佳实践

### 1. 定期备份

```bash
# 设置定时任务，每天备份一次
0 2 * * * /path/to/notebooklm_cookies_manager.sh backup
```

### 2. 研究前检查

```bash
# 在研究脚本开头添加
bash scripts/notebooklm_manager/check_before_research.sh || echo "使用备选方案"
```

### 3. 监控日志

```bash
# 查看最近的操作日志
tail -20 /tmp/notebooklm_cookies.log
```

### 4. 定期清理

```bash
# 备份脚本会自动清理旧备份（保留最新的10个）
# 可以通过环境变量调整
export MAX_BACKUPS=20
```

---

## 🔐 安全建议

1. **备份文件权限**
   ```bash
   chmod 600 ~/.notebooklm-mcp-cli/backups/*.json.gz
   ```

2. **不要提交到Git**
   - cookies文件包含敏感信息
   - 已在.gitignore中排除

3. **定期更换**
   - 即使未失效，也建议每周刷新一次

---

## 📝 更新日志

### v1.0 (2026-03-08)
- ✅ 初始版本
- ✅ 检测、备份、恢复、刷新功能
- ✅ 自动化管理
- ✅ 集成到研究流程
- ✅ 定时任务支持

---

## 🤝 反馈和改进

如有问题或建议，请：
1. 在GitHub仓库创建issue
2. 或直接修改脚本并提交PR

---

**维护者**: OpenClaw AI
**最后更新**: 2026-03-08
