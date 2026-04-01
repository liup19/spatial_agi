# Spatial AGI Research - 论文列表

## 2026-04-01 研究的论文（精选5篇）

从204篇arXiv最新论文中筛选出5篇最相关论文。

### 1. GaussianGPT: Towards Autoregressive 3D Gaussian Scene Generation - arXiv:2603.26661
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 3D Gaussian Splatting, 自回归生成, 场景生成, 3D RoPE, 分离词汇表
- **arXiv链接**: https://arxiv.org/abs/2603.26661
- **PDF链接**: https://arxiv.org/pdf/2603.26661
- **HTML链接**: https://arxiv.org/html/2603.26661v1
- **文档**: papers/2026-04-01_01_GaussianGPT.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首次探索完全自回归的3D生成方法，突破依赖扩散或流匹配的主流范式，使用3D RoPE编码位置、分离词汇表设计、大场景外画验证
- **与Spatial AGI关系**: 3DGS是Spatial AGI的核心表示方法，自回归生成提供可控性和一致性

### 2. Make Geometry Matter for Spatial Reasoning - arXiv:2603.26639
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 几何推理, 空间推理, GeoSR框架, 掩蔽机制, 门控融合
- **arXiv链接**: https://arxiv.org/abs/2603.26639
- **PDF链接**: https://arxiv.org/pdf/2603.26639
- **HTML链接**: https://arxiv.org/html/2603.26639v1
- **文档**: papers/2026-04-01_01_MakeGeometryMatter.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 提出GeoSR框架，通过几何-解蔽掩蔽和几何-引导融合强制VLM利用几何信息而非依赖2D捷径，解决空间推理中的核心问题
- **与Spatial AGI关系**: 范式转变，从"如何注入几何信息"到"如何确保几何信息被利用"，几何作为可行动证据而非装饰

### 3. PerceptionComp: A Video Benchmark for Complex Perception-Centric Reasoning - arXiv:2603.26653
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 感知推理, 视频推理, 组合逻辑, 空间子条件, 时空推理
- **arXiv链接**: https://arxiv.org/abs/2603.26653
- **PDF链接**: https://arxiv.org/pdf/2603.26653
- **HTML链接**: https://arxiv.org/html/2603.26653v1
- **文档**: papers/2026-04-01_01_PerceptionComp.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首个感知中心、长时域组合视频推理基准，揭示60%失败归因于空间子条件，表明3D空间推理是关键瓶颈
- **与Spatial AGI关系**: 感知-推理耦合、重复证据收集、场景复杂度驱动、空间推理瓶颈识别

### 4. PoseDreamer: Scalable and Photorealistic Human Data Generation Pipeline with Diffusion Models - arXiv:2603.28763
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 人体网格估计, 扩散模型, 合成数据, 直接偏好优化, 难例挖掘
- **arXiv链接**: https://arxiv.org/abs/2603.28763
- **PDF链接**: https://arxiv.org/pdf/2603.28763
- **文档**: papers/2026-04-01_01_PoseDreamer.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 开发利用扩散模型生成大规模合成人体数据集的管道，使用DPO改善3D-2D一致性，基于模型的反馈课程生成优先考虑挑战性样本，生成50万张高质量图像
- **与Spatial AGI关系**: 生成模型可以经济实惠地替代昂贵的合成数据获取，合成数据具有独特价值（互补性）

### 5. SHOW3D: Capturing Scenes of 3D Hands and Objects in the Wild
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 手-物体交互, 3D姿态估计, 多视图采集, 野外数据, 6DoF物体姿态
- **文档**: papers/2026-04-01_01_SHOW3D.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 第一个大规模野外手-物体交互3D数据集，包含430万帧同步多视图图像，具有3D手姿态、MANO网格、6DoF物体姿态和文本字幕
- **与Spatial AGI关系**: 精细操作需要3D空间理解，多视图融合提高标注质量，文本条件提供语义层次

---

## 2026-03-31 堆究的论文（精选5篇）

从125篇arXiv最新论文中筛选出5篇最相关论文。

### 1. GaussianGPT: Towards Autoregressive 3D Gaussian Scene Generation - arXiv:2603.26661
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 3D Gaussian Splatting, 自回归生成, 场景生成, 3D RoPE, 分离词汇表
- **arXiv链接**: https://arxiv.org/abs/2603.26661
- **PDF链接**: https://arxiv.org/pdf/2603.26661
- **HTML链接**: https://arxiv.org/html/2603.26661v1
- **文档**: papers/2026-03-31_GaussianGPT.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首次探索完全自回归的3D生成方法，突破依赖扩散或流匹配的主流范式，使用3D RoPE编码位置、分离词汇表设计、大场景外画验证
- **与Spatial AGI关系**: 3DGS是Spatial AGI的核心表示方法，自回归生成提供可控性和一致性

### 2. Make Geometry Matter for Spatial Reasoning - arXiv:2603.26639
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 几何推理, 空间推理, GeoSR框架, 掩蔽机制, 门控融合
- **arXiv链接**: https://arxiv.org/abs/2603.26639
- **PDF链接**: https://arxiv.org/pdf/2603.26639
- **HTML链接**: https://arxiv.org/html/2603.26639v1
- **文档**: papers/2026-03-31_01_MakeGeometryMatter.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 提出GeoSR框架，通过几何-解蔽掩蔽和几何-引导融合强制VLM利用几何信息而非依赖2D捷径，解决空间推理中的核心问题
- **与Spatial AGI关系**: 范式转变，从"如何注入几何信息"到"如何确保几何信息被利用"，几何作为可行动证据而非装饰

### 3. PerceptionComp: A Video Benchmark for Complex Perception-Centric Reasoning - arXiv:2603.26653
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 感知推理, 视频推理, 组合逻辑, 空间子条件, 时空推理
- **arXiv链接**: https://arxiv.org/abs/2603.26653
- **PDF链接**: https://arxiv.org/pdf/2603.26653
- **HTML链接**: https://arxiv.org/html/2603.26653v1
- **文档**: papers/2026-03-31_01_PerceptionComp.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首个感知中心、长时域组合视频推理基准，揭示60%失败归因于空间子条件，表明3D空间推理是关键瓶颈
- **与Spatial AGI关系**: 感知-推理耦合、重复证据收集、场景复杂度驱动、空间推理瓶颈识别

### 4. VLA-OPD: Bridging Offline SFT and Online RL for Vision-Language-Action Models - arXiv:2603.26666
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: VLA, 视觉-语言-动作, 在线策略蒸馏, Reverse-KL, 灾难性遗忘
- **arXiv链接**: https://arxiv.org/abs/2603.26666
- **PDF链接**: https://arxiv.org/pdf/2603.26666
- **HTML链接**: https://arxiv.org/html/2603.26666v1
- **文档**: papers/2026-03-31_01_VLA-OPD.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 统一VLA后训练，提出在线策略蒸馏框架，使用Reverse-KL作为对齐目标，显著缓解灾难性遗忘，3倍样本效率提升
- **与Spatial AGI关系**: 视觉-语言-动作统一表示、在线适应能力、轨迹级和token级空间理解

### 5. The Limits of Learning from Pictures and Text: Vision-Language Models and Embodied Scene Understanding - arXiv:2603.26589
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: VLM, 具身场景理解, 功能性, 分布假设, 具身经验, Human-Calibrated Cosine Distance
- **arXiv链接**: https://arxiv.org/abs/2603.26589
- **PDF链接**: https://arxiv.org/pdf/2603.26589
- **HTML链接**: 不可用（arXiv未提供HTML转换）
- **文档**: papers/2026-03-31_02_LimitsLearningPicturesText.md
- **分析方法**: arXiv摘要页面（Subagent超时，降级到备选方案）
- **核心贡献**: 系统测试VLM在15个高层场景理解任务中的表现，发现功能性任务上的稳健缺陷是结构性而非风格性的，揭示图像caption数据集系统性缺少agent-centered affordance语言
- **与Spatial AGI关系**: 分布假设有边界，具身经验重要性，功能性知识的结构性缺陷，对Spatial AGI"具身"要求的理论验证

---

## 2026-03-30 堆究的论文（精选5篇）

从arXiv cs.CV最新172篇论文中筛选出5篇最相关论文。

### 1. LGTM (Less Gaussians, Texture More) - arXiv:2603.25745
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 3D Gaussian Splatting, 4K分辨率, 前馈框架, 几何-外观解耦
- **arXiv链接**: https://arxiv.org/abs/2603.25745
- **PDF链接**: https://arxiv.org/pdf/2603.25745
- **HTML链接**: https://arxiv.org/html/2603.25745v1
- **Project Page**: https://yxlao.github.io/lgtm/
- **文档**: papers/2026-03-30_01_2603_25745_LGTM.md (580行)
- **分析方法**: GLM WebReader（NotebookLM失败）
- **核心贡献**: 通过预测紧凑的Gaussian原语耦合每原语纹理，LGTM解耦了几何复杂度与渲染分辨率，无需场景优化即可实现高保真4K新视图合成
- **与Spatial AGI关系**: 3DGS是Spatial AGI的核心表示方法，LGTM突破了3DGS的分辨率限制

### 2. Vega (Learning to Drive with Natural Language Instructions) - arXiv:2603.25741
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 自动驾驶, 视觉-语言-世界-行动模型, 指令驱动, InstructScene
- **arXiv链接**: https://arxiv.org/abs/2603.25741
- **PDF链接**: https://arxiv.org/pdf/2603.25741
- **HTML链接**: https://arxiv.org/html/2603.25741v1
- **Code**: https://github.com/zuosc19/Vega
- **文档**: papers/2026-03-30_01_2603_25741_Vega.md (1,818行)
- **分析方法**: GLM WebReader（NotebookLM失败）
- **核心贡献**: 构建了大规模驾驶数据集InstructScene（100,000指令标注场景），提出统一的视觉-语言-世界-行动模型Vega，实现指令驱动的世界建模和轨迹规划
- **与Spatial AGI关系**: 展示了具身AI中的世界建模和指令理解能力

### 3. SlotVTG (Object-Centric Adapter for Generalizable Video Temporal Grounding) - arXiv:2603.25733
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 视频时序定位, 对象中心学习, Slot Adapter, OOD泛化
- **arXiv链接**: https://arxiv.org/abs/2603.25733
- **PDF链接**: https://arxiv.org/pdf/2603.25733
- **HTML链接**: https://arxiv.org/html/2603.25733v1
- **文档**: papers/2026-03-30_01_2603_25733_SlotVTG.md (1,180行)
- **分析方法**: GLM WebReader（NotebookLM失败）
- **核心贡献**: 提出轻量级Slot Adapter，通过slot attention将视觉标记解耦为抽象slots并重构原始序列，显著提升OOD鲁棒性（49.6%提升）
- **与Spatial AGI关系**: 对象中心表示是Spatial AGI理解场景的核心能力

### 4. PackForcing (Short Video Training Suffices for Long Video Sampling and Long Context Inference) - arXiv:2603.25730
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 长视频生成, KV缓存, 分层上下文压缩, 24倍时间外推
- **arXiv链接**: https://arxiv.org/abs/2603.25730
- **PDF链接**: https://arxiv.org/pdf/2603.25730
- **HTML链接**: https://arxiv.org/html/2603.25730v1
- **Code**: https://github.com/ShandaAI/PackForcing
- **文档**: papers/2026-03-30_01_2603_25730_PackForcing.md (706行)
- **分析方法**: GLM WebReader（NotebookLM失败）
- **核心贡献**: 提出三分区KV缓存策略（Sink, Mid, Recent），在单张H200 GPU上实现2分钟832×480 16FPS生成，实现24倍时间外推（5s→120s）
- **与Spatial AGI关系**: 长时记忆管理是Spatial AGI处理长序列任务的关键

### 5. LIGHT (Unleashing Guidance Without Classifiers for HOI Animation) - arXiv:2603.25734
- **相关性**: ⭐⭐⭐
- **关键词**: 人机交互动画, 扩散模型, 数据驱动引导, 无分类器, 异步去噪
- **arXiv链接**: https://arxiv.org/abs/2603.25734
- **PDF链接**: https://arxiv.org/pdf/2603.25734
- **HTML链接**: https://arxiv.org/html/2603.25734v1
- **Project Page**: http://ziyinwang1.github.io/LIGHT
- **文档**: papers/2026-03-30_01_2603_25734_LIGHT.md (1,464行)
- **分析方法**: GLM WebReader（NotebookLM失败）
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
**分析方法**: 全部使用GLM WebReader（NotebookLM认证失效）
**文档总行数**: 5,748行（远超5,000行要求）
**平均每篇**: 1,150行/篇
