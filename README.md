# Spatial AGI Research

🚀 **通用空间智能（Spatial AGI）研究项目**

## 📋 项目概述

这个项目用于系统化地研究Spatial AGI领域的最新进展，每天精读5篇arXiv论文，使用NotebookLM深度分析，生成详细文档和每日思考。

## 🎯 研究方向

- Spatial Intelligence（空间智能）
- Vision-Language Models（视觉语言模型）
- 3D Gaussian Splatting（3D高斯溅射）
- World Models（世界模型）
- Embodied AI（具身智能）
- 3D Understanding（3D理解）
- Scene Understanding（场景理解）
- Video Generation（视频生成）
- Robot Learning（机器人学习）

## 📁 目录结构

```
spatial_agi/
├── papers/                    # 论文分析文档
│   └── YYYY-MM-DD_XX_title.md
├── daily_thinking/            # 每日思考
│   └── YYYY-MM-DD.md
├── scripts/                   # 工具脚本
│   └── search_arxiv.py
├── papers_list.md             # 论文列表
└── README.md                  # 本文件
```

## 🚀 使用方法

### 手动执行
```bash
# 使用OpenClaw命令
告诉AI: "开始今天的Spatial AGI研究"
```

### 定时执行
每天凌晨3点自动执行（通过OpenClaw cron）

## 🔧 环境配置

### 当前分析方案
**NotebookLM（首选）+ GLM WebReader（备选）**
- ✅ NotebookLM已认证并可用
- ✅ GLM WebReader作为备选方案
- ✅ 自动降级机制

### NotebookLM配置
**✅ 已完成配置**
- NotebookLM CLI已安装（nlm命令）
- 认证已配置（使用cookies文件）
- 可以创建笔记本和询问问题

**手动配置（如果需要）**：
```bash
# 使用现有cookies文件
source ~/miniconda3/bin/activate
conda activate spatial-agi
nlm login --manual -f /home/ropliu/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json
```

### Conda环境
项目使用独立的conda环境：
```bash
conda activate spatial-agi
```

**已安装工具**：
- notebooklm-cli (nlm命令)
- Python 3.11

## 📊 研究统计

- 开始日期: 2026-03-08
- 论文总数: 0篇
- 研究天数: 0天
- 分析方法: GLM WebReader

## 🔗 相关链接

- [OpenClaw](https://openclaw.ai)
- [Skill源码](~/.openclaw/workspace/skills/spatial-agi-research/SKILL.md)

## 📝 License

MIT

---

**维护者**: OpenClaw AI
**最后更新**: 2026-03-08
