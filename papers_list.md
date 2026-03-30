# Spatial AGI Research - 论文列表

## 2026-03-30 研究的论文（精选5篇）

从arXiv cs.CV最新172篇论文中筛选出5篇最相关论文。

### 1. LGTM (Less Gaussians, Texture More) - arXiv:2603.25745
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 3D Gaussian Splatting, 4K分辨率, 前馈框架, 纹理解耦
- **arXiv链接**: https://arxiv.org/abs/2603.25745
- **PDF链接**: https://arxiv.org/pdf/2603.25745
- **HTML链接**: https://arxiv.org/html/2603.25745v1
- **Project Page**: https://yxlao.github.io/lgtm/
- **核心贡献**: 通过预测紧凑的Gaussian原语耦合每原语纹理，LGTM解耦了几何复杂度与渲染分辨率，无需场景优化即可实现高保真4K新视图合成
- **与Spatial AGI关系**: 3DGS是Spatial AGI的核心表示方法，LGTM突破了3DGS的分辨率限制

### 2. Vega (Learning to Drive with Natural Language Instructions) - arXiv:2603.25741
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 自动驾驶, 视觉-语言-世界-行动模型, 指令驱动, InstructScene
- **arXiv链接**: https://arxiv.org/abs/2603.25741
- **PDF链接**: https://arxiv.org/pdf/2603.25741
- **HTML链接**: https://arxiv.org/html/2603.25741v1
- **Code**: https://github.com/zuosc19/Vega
- **核心贡献**: 构建了大规模驾驶数据集InstructScene（100,000场景），提出统一的视觉-语言-世界-行动模型Vega，实现指令驱动的世界建模和轨迹规划
- **与Spatial AGI关系**: 展示了具身AI中的世界建模和指令理解能力

### 3. SlotVTG (Object-Centric Adapter for Video Temporal Grounding) - arXiv:2603.25733
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 视频时序定位, 对象中心学习, Slot Adapter, OOD泛化
- **arXiv链接**: https://arxiv.org/abs/2603.25733
- **PDF链接**: https://arxiv.org/pdf/2603.25733
- **HTML链接**: https://arxiv.org/html/2603.25733v1
- **核心贡献**: 提出轻量级Slot Adapter，通过slot attention将视觉标记解耦为抽象slots并重构原始序列，显著提升OOD鲁棒性（49.6%提升）
- **与Spatial AGI关系**: 对象中心表示是Spatial AGI理解场景的核心能力

### 4. PackForcing (Short Video Training Suffices for Long Video) - arXiv:2603.25730
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 长视频生成, KV缓存, 分层上下文压缩, 24倍时间外推
- **arXiv链接**: https://arxiv.org/abs/2603.25730
- **PDF链接**: https://arxiv.org/pdf/2603.25730
- **HTML链接**: https://arxiv.org/html/2603.25730v1
- **Code**: https://github.com/ShandaAI/PackForcing
- **核心贡献**: 提出三分区KV缓存策略（Sink, Mid, Recent），在单张H200 GPU上实现2分钟832x480 16FPS生成，实现24倍时间外推（5s→120s）
- **与Spatial AGI关系**: 长时记忆管理是Spatial AGI处理长序列任务的关键

### 5. LIGHT (Unleashing Guidance Without Classifiers for HOI Animation) - arXiv:2603.25734
- **相关性**: ⭐⭐⭐
- **关键词**: 人机交互动画, 扩散模型, 数据驱动引导, 无分类器, 异步去噪
- **arXiv链接**: https://arxiv.org/abs/2603.25734
- **PDF链接**: https://arxiv.org/pdf/2603.25734
- **HTML链接**: https://arxiv.org/html/2603.25734v1
- **Project Page**: http://ziyinwang1.github.io/LIGHT
- **核心贡献**: 提出LIGHT框架，通过将表示分解为模态特定组件并分配个性化噪声水平和异步去噪调度，实现无需辅助分类器的数据驱动引导
- **与Spatial AGI关系**: 展示了具身AI中交互式动画生成的数据驱动方法

---

## 筛选标准

本次筛选使用以下标准：
1. **相关性**: 与Spatial AGI直接相关（3D表示、具身AI、世界建模、对象中心表示）
2. **创新性**: 提出新的方法或见解
3. **影响力**: 来自知名机构或作者
4. **时效性**: 最新发表（2026-03-26）

---

## 相关性分析

- **3D表示** (1篇): LGTM
- **具身AI** (2篇): Vega, LIGHT
- **对象中心表示** (1篇): SlotVTG
- **长时记忆管理** (1篇): PackForcing

---

**生成时间**: 2026-03-30 09:35
**搜索来源**: arXiv cs.CV (172篇)
**筛选方法**: 人工筛选 + 相关性评分
