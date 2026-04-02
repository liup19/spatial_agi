# Spatial AGI Research - 论文列表

## 2026-04-02 研究的论文（精选5篇）

从arXiv最新论文（cs.CV, cs.RO, cs.AI）中筛选出5篇最相关论文。

### 1. OmniRoam: World Wandering via Long-Horizon Panoramic Video Generation - arXiv:2603.30045
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 全景视频生成, 长时域场景漫游, Omnipresent, Preview-Refine两阶段, 4K高分辨率, 视觉一致性
- **arXiv链接**: https://arxiv.org/abs/2603.30045
- **PDF链接**: https://arxiv.org/pdf/2603.30045
- **HTML链接**: https://arxiv.org/html/2603.30045v1
- **文档**: papers/2026-04-02_01_OmniRoam.md
- **文档行数**: 1,265行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 首个可控制全景视频生成框架，预览阶段快速生成概览，细化阶段时间扩展和空间上采样生成4K高分辨率视频，实现长视距、高保真度世界漫游
- **与Spatial AGI关系**: 全景表示是Spatial AGI理解360°环境的基础，两阶段框架（预览→细化）展示如何在长视距任务中平衡速度和质量，为沉浸式Spatial AGI提供高质量场景生成基础

### 2. Video Models Reason Early: Exploiting Plan Commitment for Maze Solving - arXiv:2603.30043
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 视频扩散模型, 早期计划承诺, 迷宫求解, ChEaP算法, Early Plan Commitment, 路径长度阈值
- **arXiv链接**: https://arxiv.org/abs/2603.30043
- **PDF链接**: https://arxiv.org/pdf/2603.30043
- **HTML链接**: https://arxiv.org/html/2603.30043v1
- **文档**: papers/2026-04-02_02_VideoModelsReasonEarly.md
- **文档行数**: 1,746行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 首次系统研究视频扩散模型的内部规划动力学，发现早期计划承诺现象（前10-15%步骤决定运动轨迹），路径长度主导难度（12步为失败阈值），提出ChEaP算法（3.3倍性能提升）
- **与Spatial AGI关系**: 揭示视频模型具备层次化推理能力（高层计划→细节优化），证明像素空间直接推理可行，为Spatial AGI的推理效率优化提供新范式（EPBS算法减少3.3倍计算）

### 3. Hybrid Framework for Robotic Manipulation: Integrating RL and LLMs - arXiv:2603.30022
- **相关性**: ⭐⭐⭐⭐
- **关键词**: RL+LLM混合框架, 三层架构, 高层任务规划, 低层精确控制, Sim-to-Real Transfer
- **arXiv链接**: https://arxiv.org/abs/2603.30022
- **PDF链接**: https://arxiv.org/pdf/2603.30022
- **HTML链接**: https://arxiv.org/html/2603.30022v1
- **文档**: papers/2026-04-02_03_HybridFrameworkRL_LLM.md
- **文档行数**: 2,450行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 提出三层混合架构（LLM规划层、协调层、RL执行层），LLM处理自然语言和高层推理，RL处理低层精确控制，任务完成时间减少33.5%，准确性和适应性分别提升18.1%和36.4%
- **与Spatial AGI关系**: 为Spatial AGI提供早期案例，展示如何将符号推理（LLM）与连续控制（RL）结合，Sim-to-Real Transfer是Spatial AGI实用化的关键挑战

### 4. HapCompass: A Rotational Haptic Device for Contact-Rich Robotic Teleoperation - arXiv:2603.30042
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 触觉感知, 方向性提示, 线性共振致动器, 旋转机械设计, 接触丰富操作, 遥操作, 模仿学习
- **arXiv链接**: https://arxiv.org/abs/2603.30042
- **PDF链接**: https://arxiv.org/pdf/2603.30042
- **HTML链接**: https://arxiv.org/html/2603.30042v1
- **文档**: papers/2026-04-02_04_HapCompass.md
- **文档行数**: 3,792行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 首个通过旋转单个LRA渲染2D方向性触觉提示的设备，低成本设计（<50美元），成功率提升、完成时间缩短、接触力降低，提高模仿学习数据质量（60%→90%成功率）
- **与Spatial AGI关系**: 触觉是Spatial AGI的第三大感知模态，方向性触觉信息对接触丰富操作至关重要，高质量模仿学习数据为Spatial AGI提供学习基础

### 5. Spatially-Aware Aggregation of Segmentation Uncertainty - arXiv:2603.29941
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 不确定性量化(UQ), 空间聚合策略, MOR/EDS/ENT, 元聚合(GMM-All), Out-of-Distribution检测, 失败检测
- **arXiv链接**: https://arxiv.org/abs/2603.29941
- **PDF链接**: https://arxiv.org/pdf/2603.29941
- **HTML链接**: https://arxiv.org/html/2603.29941v1
- **文档**: papers/2026-04-02_05_SpatiallyAwareAggregation.md
- **文档行数**: 1,112行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 首个系统性研究分割不确定性的空间聚合，提出三种空间聚合策略（MOR、EDS、ENT）和元聚合（GMM-All），在10个数据集上OoD和失败检测任务上显著优于全局平均聚合
- **与Spatial AGI关系**: 空间不确定性是Spatial AGI的核心挑战，不确定性感知的空间聚合为Spatial AGI提供鲁棒性基础，自动驾驶、机器人导航、AR、医疗成像等应用场景展示广泛适用性

---

**总文档行数**: 10,365行（平均2,073行/篇）
**分析方法**: 全部使用GLM WebReader（NotebookLM认证失效）
**执行时间**: 约20-30分钟（5个Subagent并行）

---

## 2026-04-01 研究的论文（精选5篇）

从204篇arXiv最新论文中筛选出5篇最相关论文。

### 1. GaussianGPT: Towards Autoregressive 3D Gaussian Scene Generation - arXiv:2603.26661
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 3D Gaussian Splatting, 自回归生成, 场景生成, 3D RoPE, 分离词汇表
- **arXiv链接**: https://arxiv.org/abs/2603.26661
- **PDF链接**: https://arxiv.org/pdf/2603.26661
- **HTML链接**: https://arxiv.org/html/2603.26661v1
- **文档**: papers/2026-04-01_01_GaussianGPT.md
- **文档行数**: 1,095行
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首次探索完全自回归的3D生成方法，突破依赖扩散或流匹配的主流范式，使用3D RoPE编码位置、分离词汇表设计、大场景外画验证
- **与Spatial AGI关系**: 3DGS是Spatial AGI的核心表示方法，自回归生成提供可控性和一致性

### 2. Make Geometry Matter for Spatial Reasoning - arXiv:2603.26639
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 几何推理, 空间推理, GeoSR框架, 掩蔽机制, 门控融合
- **arXiv链接**: https://arxiv.org/abs/2603.26639
- **PDF链接**: https://arxiv.org/pdf/2603.26639
- **HTML链接**: https://arxiv.org/html/2603.26639v1
- **文档**: papers/2026-04-01_01_MakeGeometryMatter.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 提出GeoSR框架，通过几何-解蔽掩蔽和几何-引导融合强制VLM利用几何信息而非依赖2D捷径，解决空间推理中的核心问题
- **与Spatial AGI关系**: 范式转变，从"如何注入几何信息"到"如何确保几何信息被利用"，几何作为可行动证据而非装饰

### 3. PerceptionComp: A Video Benchmark for Complex Perception-Centric Reasoning - arXiv:2603.26653
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 感知推理, 视频推理, 组合逻辑, 空间子条件, 时空推理
- **arXiv链接**: https://arxiv.org/abs/2603.26653
- **PDF链接**: https://arxiv.org/pdf/2603.26653
- **HTML链接**: https://arxiv.org/html/2603.26653v1
- **文档**: papers/2026-04-01_01_PerceptionComp.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首个感知中心、长时域组合视频推理基准，揭示60%失败归因于空间子条件，表明3D空间推理是关键瓶颈
- **与Spatial AGI关系**: 感知-推理耦合、重复证据收集、场景复杂度驱动、空间推理瓶颈识别

### 4. PoseDreamer: Scalable and Photorealistic Human Data Generation Pipeline with Diffusion Models - arXiv:2603.28763
- **相关性**: ⭐⭐⭐
- **关键词**: 人体网格估计, 扩散模型, 合成数据, 直接偏好优化, 挑战性样本
- **arXiv链接**: https://arxiv.org/abs/2603.28763
- **文档**: papers/2026-04-01_01_PoseDreamer.md
- **文档行数**: 749行
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 开发利用扩散模型生成大规模合成人体数据集的管道，使用DPO改善3D-2D一致性，基于模型的反馈课程生成优先考虑挑战性样本，生成50万张高质量图像
- **与Spatial AGI关系**: 生成模型可以经济实惠地替代昂贵的合成数据获取，合成数据具有独特价值（互补性）

### 5. SHOW3D: Capturing Scenes of 3D Hands and Objects in the Wild - arXiv:2603.28766
- **相关性**: ⭐⭐⭐
- **关键词**: 手-物体交互, 3D姿态估计, 多视图采集, 野外数据, 6DoF物体姿态
- **arXiv链接**: https://arxiv.org/abs/2603.28766
- **文档**: papers/2026-04-01_01_SHOW3D.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 第一个大规模野外手-物体交互3D数据集，包含430万帧同步多视图图像，具有3D手姿态、MANO网格、6DoF物体姿态和文本字幕
- **与Spatial AGI关系**: 精细操作需要3D空间理解，多视图融合提高标注质量，文本条件提供语义层次

---

## 2026-03-31 研究的论文（精选5篇）

从125篇arXiv最新论文中筛选出5篇最相关论文。

### 1. GaussianGPT: Towards Autoregressive 3D Gaussian Scene Generation - arXiv:2603.26661
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 3D Gaussian Splatting, 自回归生成, 场景生成, 3D RoPE, 分离词汇表
- **arXiv链接**: https://arxiv.org/abs/2603.26661
- **PDF链接**: https://arxiv.org/pdf/2603.26661
- **HTML链接**: https://arxiv.org/html/2603.26661v1
- **文档**: papers/2026-03-31_01_GaussianGPT.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首次探索完全自回归的3D生成方法，突破依赖扩散或流匹配的主流范式，使用3D RoPE编码位置、分离词汇表设计、大场景外画验证
- **与Spatial AGI关系**: 3DGS是Spatial AGI的核心表示方法，自回归生成提供可控性和一致性

### 2. Make Geometry Matter for Spatial Reasoning - arXiv:2603.26639
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 几何推理, 空间推理, GeoSR框架, 掩蔽机制, 门控融合
- **arXiv链接**: https://arxiv.org/abs/2603.26639
- **PDF链接**: https://arxiv.org/pdf/2603.26639
- **HTML链接**: https://arxiv.org/html/2603.26639v1
- **文档**: papers/2026-03-31_01_MakeGeometryMatter.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 提出GeoSR框架，通过几何-解蔽掩蔽和几何-引导融合强制VLM利用几何信息而非依赖2D捷径，解决空间推理中的核心问题
- **与Spatial AGI关系**: 范式转变，从"如何注入几何信息"到"如何确保几何信息被利用"，几何作为可行动证据而非装饰

### 3. PerceptionComp: A Video Benchmark for Complex Perception-Centric Reasoning - arXiv:2603.26653
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 感知推理, 视频推理, 组合逻辑, 空间子条件, 时空推理
- **arXiv链接**: https://arxiv.org/abs/2603.26653
- **PDF链接**: https://arxiv.org/pdf/2603.26653
- **HTML链接**: https://arxiv.org/html/2603.26653v1
- **文档**: papers/2026-03-31_01_PerceptionComp.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 首个感知中心、长时域组合视频推理基准，揭示60%失败归因于空间子条件，表明3D空间推理是关键瓶颈
- **与Spatial AGI关系**: 感知-推理耦合、重复证据收集、场景复杂度驱动、空间推理瓶颈识别

### 4. VLA-OPD: Bridging Offline SFT and Online RL for Vision-Language-Action Models - arXiv:2603.26666
- **相关性**: ⭐⭐⭐⭐
- **关键词**: VLA, 视觉-语言-动作, 在线策略蒸馏, Reverse-KL, 灾难性遗忘
- **arXiv链接**: https://arxiv.org/abs/2603.26666
- **PDF链接**: https://arxiv.org/pdf/2603.26666
- **HTML链接**: https://arxiv.org/html/2603.26666v1
- **文档**: papers/2026-03-31_01_VLA-OPD.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 提出在线策略蒸馏框架，使用Reverse-KL对齐将离线SFT和在线RL桥接，3倍样本效率提升，缓解灾难性遗忘
- **与Spatial AGI关系**: VLA统一架构与在线适应，Sim-to-Real Transfer挑战，具身经验与功能性知识表示

### 5. The Limits of Learning in Vision-Language Models for Embodied Tasks - arXiv:2603.26669
- **相关性**: ⭐⭐⭐⭐
- **关键词**: VLM, 具身任务, 功能性知识, 训练-部署Gap, 视觉偏差
- **arXiv链接**: https://arxiv.org/abs/2603.26669
- **PDF链接**: https://arxiv.org/pdf/2603.26669
- **文档**: papers/2026-03-31_01_TheLimitsofLearning.md
- **分析方法**: GLM WebReader（NotebookLM认证失效）
- **核心贡献**: 系统测试VLM在功能性任务上的表现，发现稳健缺陷是结构性的而非风格性的，揭示VLM的分布假设有边界，具身经验必要性
- **与Spatial AGI关系**: 具身经验与功能性知识表示，分布边界识别，Sim-to-Real Transfer，长期规划与短期适应

---
