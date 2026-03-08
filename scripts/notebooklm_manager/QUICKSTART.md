# NotebookLM Cookies 自动化管理 - 快速指南

## 🚀 5分钟快速上手

### 第一步：查看当前状态

```bash
cd ~/.openclaw/workspace/spatial_agi
bash scripts/notebooklm_cookies_manager.sh status
```

### 第二步：初始化备份

```bash
bash scripts/notebooklm_cookies_manager.sh backup
```

### 第三步：设置定时任务（可选）

```bash
# 编辑crontab
crontab -e

# 添加以下两行（复制自 scripts/notebooklm_manager/crontab_config.txt）：
0 * * * * /home/ropliu/.openclaw/workspace/spatial_agi/scripts/notebooklm_cookies_manager.sh auto >> /tmp/notebooklm_cookies.log 2>&1
0 2 * * * /home/ropliu/.openclaw/workspace/spatial_agi/scripts/notebooklm_cookies_manager.sh check && /home/ropliu/.openclaw/workspace/spatial_agi/scripts/notebooklm_cookies_manager.sh backup >> /tmp/notebooklm_cookies.log 2>&1
```

---

## 📋 常用命令

```bash
# 查看状态
bash scripts/notebooklm_cookies_manager.sh status

# 检测cookies
bash scripts/notebooklm_cookies_manager.sh check

# 自动管理（检测+恢复）
bash scripts/notebooklm_cookies_manager.sh auto

# 手动备份
bash scripts/notebooklm_cookies_manager.sh backup

# 从备份恢复
bash scripts/notebooklm_cookies_manager.sh restore

# 从浏览器刷新
bash scripts/notebooklm_cookies_manager.sh refresh
```

---

## 🔄 工作流程

### 正常情况（cookies有效）
```
1. 研究开始 → check ✅ → 使用NotebookLM
2. 定时任务 → check ✅ → backup（每天一次）
```

### Cookies失效
```
1. 研究开始 → check ❌ → restore ✅ → 使用NotebookLM
2. 定时任务 → check ❌ → restore ✅ → backup
```

### 完全失效（无有效备份）
```
1. 研究开始 → check ❌ → restore ❌ → 使用GLM WebReader
2. 手动刷新 → refresh → 从浏览器导出新cookies
```

---

## 🎯 集成到研究流程

### 方法1: 手动检查

```bash
# 在开始研究前
bash scripts/notebooklm_manager/check_before_research.sh

# 返回码:
# 0 - cookies有效
# 1 - cookies无效但已恢复
# 2 - cookies无效且无法恢复（使用备选方案）
```

### 方法2: 自动集成

在 `spatial-agi-research` skill中，paper-analysis会自动处理：
- ✅ 先尝试NotebookLM
- ❌ 失败后自动降级到GLM WebReader

---

## 🔍 故障排查

### 问题：cookies总是失效

**解决**:
```bash
# 1. 手动刷新cookies
bash scripts/notebooklm_cookies_manager.sh refresh

# 2. 立即备份
bash scripts/notebooklm_cookies_manager.sh backup

# 3. 查看备份列表
ls -lh ~/.notebooklm-mcp-cli/backups/
```

### 问题：找不到cookies文件

**解决**:
```bash
# 1. 检查路径
bash scripts/notebooklm_cookies_manager.sh status

# 2. 首次导出
bash scripts/notebooklm_cookies_manager.sh refresh
```

### 问题：定时任务不工作

**解决**:
```bash
# 1. 检查crontab
crontab -l

# 2. 查看日志
tail -20 /tmp/notebooklm_cookies.log

# 3. 手动测试
bash scripts/notebooklm_cookies_manager.sh auto
```

---

## 💡 最佳实践

1. **每天备份** - 定时任务已配置
2. **研究前检查** - 自动或手动
3. **及时刷新** - cookies失效时立即刷新
4. **监控日志** - 定期查看 /tmp/notebooklm_cookies.log

---

## 📞 获取帮助

```bash
# 查看完整文档
cat scripts/notebooklm_manager/README.md

# 查看帮助信息
bash scripts/notebooklm_cookies_manager.sh help
```

---

**维护者**: OpenClaw AI
**版本**: v1.0
**最后更新**: 2026-03-08
