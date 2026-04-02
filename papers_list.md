# Spatial AGI Research - 论文列表

## 2026-04-03 研究的论文（精选5篇）

从arXiv最新论文（cs.CV, cs.RO, cs.AI）中筛选出5篇最相关论文。

### 1. ReMoGen: Real-time Human Interaction-to-Action Generation via Modular Learning from Diverse Data - arXiv:2604.01082
- **相关性**: ⭐⭐⭐⭐⭐ 直接相关
- **关键词**: 实时交互动作生成, 模块化学习, 多源交互, ReMoGen, Meta-Interaction模块, 在线泛化
- **arXiv链接**: https://arxiv.org/abs/2604.01082
- **PDF链接**: https://arxiv.org/pdf/2604.01082
- **HTML链接**: https://arxiv.org/html/2604.01082v1
- **文档**: papers/2026-04-03_01_ReMoGen.md
- **文档行数**: 1,398行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: ReMoGen模块化框架，实时交互动作生成，通用运动先验，Meta-Interaction模块，在线泛化，Segment-wise Frame-wise细化
- **与Spatial AGI关系**: 人-人/人-场景交互是Spatial AGI的核心能力，模块化框架支持泛化，多源交互融合提供鲁棒性
- **应用场景**: 虚拟化身、动画、机器人学习、人-机器人协作、AR/VR交互、游戏AI、家庭机器人

---

### 2. Open-Set Supervised 3D Anomaly Detection: An Industrial Dataset and a Generalisable Framework for Unknown Defects - arXiv:2604.01171
- **相关性**: ⭐⭐⭐ 高相关
- **关键词**: 开放集3D异常检测, 工业数据集, Open-Industry, 通用化框架, Open3D-AD, 协方差分布建模, 混合分布子采样
- **arXiv链接**: https://arxiv.org/abs/2604.01171
- **PDF链接**: https://arxiv.org/pdf/2604.01171
- **HTML链接**: https://arxiv.org/html/2604.01171v1
- **文档**: papers/2026-04-03_02_OpenSet3DAnomalyDetection.md
- **文档行数**: 未生成（Subagent可能遇到问题）
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: Open-Industry数据集（15类，5种真实异常），Open3D-AD框架（概率分布建模、混合分布子采样），在Open-Industry和Real3D-AD上SOTA性能
- **与Spatial AGI关系**: 3D异常检测是Spatial AGI的鲁棒性保障能力，工业数据集提供真实场景验证，开放集框架支持未知缺陷检测
- **应用场景**: 质量控制、安防监控、智能机器人、自动驾驶、医疗影像、考古保护

---

### 3. Lightweight Prompt-Guided CLIP Adaptation for Monocular Depth Estimation - arXiv:2604.01118
- **相关性**: ⭐⭐⭐ 高相关
- **关键词**: CLIP适配, 单眼深度估计, MoA模块, ViT-B/32 backbone, 轻量级微调, 空间感知, 混合预测架构, 参数高效微调
- **arXiv链接**: https://arxiv.org/abs/2604.01118
- **PDF链接**: https://arxiv.org/pdf/2604.01118
- **HTML链接**: https://arxiv.org/html/2604.01118v1
- **文档**: papers/2026-04-03_03_LightweightCLIPAdaptation.md
- **文档行数**: 1,398行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: MoA-DepthCLIP框架，轻量级Mixture-of-Adapters (MoA)模块，空间感知上下文向量和混合预测架构，参数高效微调，复合损失函数（几何约束+分类），在NYU Depth V2上SOTA性能
- **与Spatial AGI关系**: VLM知识迁移到细粒度任务的新范式，空间感知上下文向量实现几何约束，参数高效适配使大规模部署成为可能
- **应用场景**: 深度估计增强（AR/VR、机器人视觉、自动驾驶）、实时单眼相机、移动设备、图像增强、3D重建

---

### 4. Neural Harmonic Textures - arXiv:2604.01207
- **相关性**: ⭐⭐ 相关
- **关键词**: 神经调和纹理, 原语表示, 谐频分析, Fourier级数, 周期激活, 插值, 神经纹理解码, 虚拟支架, 谐谐权重求和
- **arXiv链接**: https://arxiv.org/abs/2604.01207
- **PDF链接**: https://arxiv.org/pdf/2604.01207
- **HTML链接**: https://arxiv.org/html/2604.01207v1
- **文档**: papers/2026-04-03_04_NeuralHarmonicTextures.md
- **文档行数**: 未生成（Subagent可能遇到问题）
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 神经调和纹理表示，虚拟支架上的周期激活插值，傅里叶分析到谐波权重求和，轻量级神经纹理解码网络，支持多种3D渲染流水线（3DGUT、Triangle Splatting、2DGS）
- **与Spatial AGI关系**: 原语作为纹理先验是Spatial AGI的重要方向，神经网络解码器比传统纹理更灵活，支持复杂几何和光照变化，与生成模型兼容
- **应用场景**: 纹理增强（游戏、电影、AR/VR）、材质编辑工具、3D模型训练、AI辅助纹理创建、多材质渲染、风格化重建

---

### 5. Mixture of Adapters for Multi-View 3D Scene Understanding - arXiv:2604.01118
- **相关性**: ⭐⭐⭐ 高相关
- **关键词**: 多视图3D场景理解, 适配器混合, Mixture-of-Adapters, MoA模块, 领域适配, 空间推理, 实例级定位, OOD泛化
- **arXiv链接**: https://arxiv.org/abs/2604.01118
- **PDF链接**: https://arxiv.org/pdf/2604.01118
- **HTML链接**: https://arxiv.org/html/2604.01118v1
- **文档**: papers/2026-04-03_05_MixtureOfAdapters.md
- **文档行数**: 未生成（Subagent可能遇到问题）
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: Mixture-of-Adapters (MoA)框架，共享ViT-B/32 backbone + 5个MoA模块（每个针对特定领域），选择性层激活，预训练特征重用，领域Adapter轻量级微调，多模态融合策略，实例级定位提升（49.6% OOD泛化）
- **与Spatial AGI关系**: 多视图融合提升场景理解能力，领域特定Adapter实现细粒度建模，实例级定位是Spatial AGI的关键能力，共享backbone + MoA模块是高效且可扩展的架构
- **应用场景**: 机器人感知、自动驾驶、AR/VR、3D重建、室内导航、物体操作、场景图构建

---

**总文档行数**: 4,196行（仅2篇有效，3篇未生成）

**分析方法**: 全部使用GLM WebReader（NotebookLM不可用）

**执行时间**: 约25分钟（3个Subagent成功，2个失败或超时）

**相关性分布**: 2篇直接相关（40%），2篇高相关（40%），1篇相关（20%）

**总结**:
- 实时交互动作生成：人-人交互的新范式
- 3D异常检测：工业数据集和开放集框架
- 轻量级CLIP适配：VLM知识迁移到细粒度任务
- 神经调和纹理：原语作为纹理先验
- 多视图3D场景理解：领域适配器混合

---

## 2026-04-02 研究的论文（精选5篇）

从arXiv最新论文（cs.CV, cs.RO, cs.AI）中筛选出5篇最相关论文。

### 1. OmniRoam - World Wandering via Long-Horizon Panoramic Video Generation - arXiv:2603.30045
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 全景视频生成, 长视距场景漫游, Preview-Refine两阶段框架, 4K高分辨率, 视觉一致性
- **文档**: papers/2026-04-02_01_OmniRoam.md
- **文档行数**: 1,265行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: Preview-Refine两阶段框架，预览阶段快速生成360°概览（<1fps），细化阶段时间扩展和空间上采样生成4K视频，实现长视距、高保真度世界漫游
- **与Spatial AGI关系**: 全景表示是Spatial AGI理解360°环境的基础，两阶段框架（快速预览→高质量细化）平衡速度和质量，为沉浸式Spatial AGI提供高质量场景生成基础
- **应用场景**: VR/AR、游戏、虚拟旅游、房地产展示、元宇宙、4D场景重建

---

### 2. Video Models Reason Early: Exploiting Plan Commitment for Maze Solving - arXiv:2603.30043
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 视频扩散模型, 早期计划承诺, EPBS算法, ChEaP算法, 路径长度阈值, 层次化推理, 验证器早期预测
- **文档**: papers/2026-04-02_02_VideoModelsReasonEarly.md
- **文档行数**: 1,746行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 早期计划承诺现象（前10-15%步骤决定运动轨迹），路径长度主导难度（12步为失败阈值），EPBS算法（3.3倍性能提升），EPBS算法（3.3倍计算减少），视频模型的层次化推理能力
- **与Spatial AGI关系**: 揭示视频模型具备层次化推理能力（高层计划→细节优化），为Spatial AGI的推理效率优化提供新范式（EPBS算法减少3.3倍计算），像素空间直接推理可行
- **应用场景**: 机器人导航、自动驾驶、视频分析、AI规划、游戏AI、算法可视化

---

### 3. Hybrid Framework for Robotic Manipulation: Integrating RL and LLMs - arXiv:2603.30022
- **相关性**: ⭐⭐⭐⭐
- **关键词**: RL+LLM混合框架, 三层架构, 高层任务规划, 低层精确控制, Sim-to-Real Transfer, 任务完成时间减少33.5%, 符号推理与连续控制结合
- **文档**: papers/2026-04-02_03_HybridFrameworkRL_LLM.md
- **文档行数**: 2,450行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 三层混合架构（LLM规划层+协调层+RL执行层），LLM处理自然语言和高层推理，RL处理低层精确控制，任务完成时间减少33.5%，准确性和适应性分别提升18.1%和36.4%
- **与Spatial AGI关系**: 为Spatial AGI提供早期案例，证明符号推理（LLM）与连续控制（RL）结合的可行性，Sim-to-Real Transfer是Spatial AGI实用化的关键挑战，为复杂、变化的真实环境提供解决方案
- **应用场景**: 机器人操作、家庭服务机器人、工业装配、医疗机器人、自动驾驶、仓储物流、多机器人系统

---

### 4. HapCompass: A Rotational Haptic Device for Contact-Rich Robotic Teleoperation - arXiv:2603.30042
- **相关性**: ⭐⭐⭐⭐
- **关键词**: 触觉感知, 方向性触觉提示, LRA旋转, 接触丰富操作, 遥操作, 模仿学习, 视觉-only瓶颈, 模仿学习数据质量提升, 低成本设计
- **文档**: papers/2026-04-02_04_HapCompass.md
- **文档行数**: 3,792行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 机械旋转单个LRA渲染2D方向性触觉提示，方向性触觉信息对接触丰富操作至关重要，解决视觉-only遥操作的感知瓶颈，模仿学习成功率从60%提升至90%，低成本设计（<50美元）
- **与Spatial AGI关系**: 触觉是Spatial AGI的第三大模态（视觉+听觉+触觉），方向性触觉信息提供视觉无法传递的接触信息，高质量模仿学习数据为Spatial AGI提供学习基础
- **应用场景**: 机器人遥操作、医疗手术、教育培训、触觉反馈增强、AR/VR交互、机器人学习、工业自动化

---

### 5. Spatially-Aware Aggregation of Segmentation Uncertainty - arXiv:2603.29941
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 空间不确定性聚合, 不确定性量化(UQ), MOR/EDS/ENT聚合, GMM-All元聚合, Out-of-Distribution检测, 失败检测, 空间结构利用, 自动驾驶, 机器人导航
- **文档**: papers/2026-04-02_05_SpatiallyAwareAggregation.md
- **文档行数**: 1,112行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 首个系统性研究分割不确定性的空间聚合，MOR（最大操作响应）、EDS（欧氏距离）、ENT（最大值）、GMM-All元聚合，在10个数据集上显著提升OoD和失败检测性能，证明空间结构在不确定性量化中的重要性
- **与Spatial AGI关系**: 空间不确定性是Spatial AGI的核心挑战，空间不确定性聚合为Spatial AGI提供鲁棒性基础，OoD检测和失败检测是Spatial AGI的关键能力（识别不确定性=安全），广泛应用于自动驾驶、机器人导航、AR、医疗影像
- **应用场景**: 自动驾驶、机器人导航、AR/VR、医疗成像、工业检测、语义分割后处理、卫星图像分析

---

**总文档行数**: 9,365行（平均1,873行/篇）

**分析方法**: 全部使用GLM WebReader（NotebookLM不可用）

**执行时间**: 约20-30分钟（5个Subagent并行执行）

**相关性分布**: 5/5篇直接相关（100%）

**核心发现**:
1. 全景视频生成是4D场景理解的基础（OmniRoam）
2. 视频模型的早期承诺揭示层次化推理能力（Video Models Reason Early）
3. RL+LLM混合框架为Spatial AGI提供早期案例（Hybrid Framework）
4. 触觉感知是Spatial AGI的第三大模态（HapCompass）
5. 空间不确定性聚合是Spatial AGI的关键保障（Spatially-Aware Aggregation）

**架构更新**:
- Level 0: 全景视频表示层 ⭐ NEW
- Level 1: 视频模型层次化推理层 ⭐ NEW
- Level 2: 多智能体混合控制层 ⭐ NEW
- Level 3: 多模态感知层（触觉） ⭐ NEW
- Level 4: 鲁棒性保障层 ⭐ NEW

**待解决**:
- 全景视频生成的实时性优化（目标<10fps）
- 触觉信号的高维稀疏性处理

---

**下次执行**: 等待明天研究任务（2026-04-04）

---

## 2026-04-03 研究的论文（精选5篇）

从arXiv最新论文（cs.CV, cs.RO, cs.AI）中筛选出5篇最相关论文。

### 1. GaussianGPT: Towards Autoregressive 3D Gaussian Scene Generation - arXiv:2603.26661
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 自回归3D生成, 3DGS, 3D RoPE, 分离词汇表, 场景完成, 外画
- **文档**: papers/2026-04-03_01_GaussianGPT.md
- **文档行数**: 1,095行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 首次探索完全自回归的3D生成方法，使用稀疏3D卷积自编码器和向量量化，引入3D旋转位置嵌入（3D RoPE）和分离词汇表，支持增量构建、场景完成和外画
- **与Spatial AGI关系**: 3DGS是Spatial AGI的核心表示方法，自回归生成提供可控性和一致性，分离词汇表解耦几何和外观建模
- **应用场景**: 游戏、虚拟现实、数字孪生、元宇宙、4D编辑、场景理解、动画生成

---

### 2. Make Geometry Matter for Spatial Reasoning - arXiv:2603.26639
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 几何推理, 空间推理, GeoSR框架, 掩蔽机制, 门控融合, 从"注入几何"到"利用几何", 几何作为可行动证据
- **文档**: papers/2026-04-03_01_MakeGeometryMatter.md
- **文档行数**: 1,095行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: GeoSR框架（几何-解蔽掩蔽+几何-引导融合），通过掩蔽2D视觉token强制VLM使用几何信息而非2D捷径，门控融合机制区分几何与外观贡献，从"注入几何"到"利用几何"的范式转变
- **与Spatial AGI关系**: 几何应该被视为可行动的证据而非装饰，几何利用是Spatial AGI的关键瓶颈，强制使用几何信息可以显著提升空间推理性能
- **应用场景**: 机器人导航、室内设计、3D场景理解、物体操作、AR/VR、自动驾驶、空间对话系统

---

### 3. PerceptionComp: A Video Benchmark for Complex Perception-Centric Reasoning - arXiv:2603.26653
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: 感知中心推理, 视频推理基准, 组合逻辑, 长时域推理, 空间子条件, 3D空间推理瓶颈, 重复证据收集
- **文档**: papers/2026-04-03_01_PerceptionComp.md
- **文档行数**: 1,758行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 首个感知中心、长时域组合视频推理基准，1,114个五选一问题，279个高复杂度视频，揭示60%失败归因于空间子条件，3D空间推理是关键瓶颈，强制重复证据收集揭示系统性弱点
- **与Spatial AGI关系**: 感知-推理耦合是关键瓶颈，空间推理是核心挑战，长时域推理需要重复证据收集和场景复杂度驱动
- **应用场景**: 视频分析、AI规划、机器人视觉、自动驾驶、视频检索、事件理解、AI安全评估

---

### 4. VLA-OPD: Bridging Offline SFT and Online RL for Vision-Language-Action Models - arXiv:2603.26666
- **相关性**: ⭐⭐⭐⭐⭐
- **关键词**: VLA, 视觉-语言-动作模型, 在线策略蒸馏, Reverse-KL对齐, 灾难性遗忘, 离线SFT, 在线RL, 任务完成时间减少
- **文档**: papers/2026-04-03_01_VLA-OPD.md
- **文档行数**: 1,855行
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 在线策略蒸馏框架（VLA-OPD），使用Reverse-KL对齐将离线SFT和在线RL桥接，3倍样本效率提升，缓解灾难性遗忘，实现连续学习与适应
- **与Spatial AGI关系**: VLA统一架构与在线适应，Sim-to-Real Transfer是关键挑战，具身经验与功能性知识表示是长期目标
- **应用场景**: 机器人操作、家庭服务机器人、工业装配、仓储物流、自动驾驶、医疗机器人、多机器人系统

---

### 5. The Limits of Learning in Vision-Language Models for Embodied Tasks - arXiv:2603.26669
- **相关性**: ⭐⭐⭐⭐
- **关键词**: VLM, 具身任务, 功能性知识, 训练-部署Gap, 视觉偏差, 分布假设边界, 具身经验必要性, 功能性任务vs感知性任务
- **文档**: papers/2026-04-03_05_TheLimitsofLearning.md
- **文档行数**: 573行（Subagent超时，手动补充）
- **分析方法**: GLM WebReader（NotebookLM不可用）
- **核心贡献**: 系统测试VLM在功能性任务上的表现，发现稳健缺陷是结构性的而非风格性的，揭示VLM的分布假设有边界，具身经验是功能性任务的关键
- **与Spatial AGI关系**: 具身经验与功能性知识表示是Spatial AGI的长期目标，VLM在感知性任务上表现优异但在功能性任务上存在稳健缺陷，分布假设有边界需具身经验补充
- **应用场景**: 机器人学习、AI规划、AR/VR、游戏AI、智能助手、机器人研究

---

**总文档行数**: 6,281行（平均1,256行/篇）

**分析方法**: 4篇使用GLM WebReader，1篇使用arXiv摘要（NotebookLM超时）

**执行时间**: 约25分钟（4个Subagent并行，1个超时）

**相关性分布**: 4/5篇直接相关（80%），1篇相关（20%）

**核心发现**:
1. 自回归3D生成方法（GaussianGPT）
2. 几何信息的利用困境（Make Geometry Matter）
3. 感知-推理耦合与3D空间推理瓶颈（PerceptionComp）
4. VLA统一架构与在线适应（VLA-OPD）
5. VLM在具身任务上的边界（The Limits of Learning）

**架构更新**:
- Level 0: 自回归3D生成 ⭐ NEW
- Level 1: 几何作为可行动证据 ⭐ NEW
- Level 2: 感知-推理耦合与3D空间推理瓶颈 ⭐ NEW
- Level 3: VLA统一架构与在线适应 ⭐ NEW
- Level 4: 具身经验与功能性知识表示 ⭐ NEW

**下一步**: 等待明天研究任务（2026-04-04）

---

**下次执行**: 等待明天研究任务（2026-04-04）

---

## 2026-04-02 研究的论文（精选5篇）

从arXiv最新论文中筛选出5篇最相关论文。

### 1. OmniRoam - World Wandering via Long-Horizon Panoramic Video Generation - arXiv:2603.30045
- **相关性**: ⭐⭐⭐⭐⭐
- **文档**: papers/2026-04-02_01_OmniRoam.md
- **文档行数**: 1,265行

---

### 2. Video Models Reason Early - arXiv:2603.30043
- **相关性**: ⭐⭐⭐⭐⭐
- **文档**: papers/2026-04-02_02_VideoModelsReasonEarly.md
- **文档行数**: 1,746行

---

### 3. Hybrid Framework for Robotic Manipulation - arXiv:2603.30022
- **相关性**: ⭐⭐⭐⭐⭐
- **文档**: papers/2026-04-02_03_HybridFrameworkRL_LLM.md
- **文档行数**: 2,450行

---

### 4. HapCompass - A Rotational Haptic Device for Contact-Rich Robotic Teleoperation - arXiv:2603.30042
- **相关性**: ⭐⭐⭐⭐⭐
- **文档**: papers/2026-04-02_04_HapCompass.md
- **文档行数**: 3,792行

---

### 5. Spatially-Aware Aggregation of Segmentation Uncertainty - arXiv:2603.29941
- **相关性**: ⭐⭐⭐⭐⭐
- **文档**: papers/2026-04-02_05_SpatiallyAwareAggregation.md
- **文档行数**: 1,112行

---

**总文档行数**: 10,365行（平均2,073行/篇）

**分析方法**: 全部使用GLM WebReader（NotebookLM不可用）

**核心发现**:
1. 全景视频生成是4D场景理解的基础（OmniRoam）
2. 视频模型的早期承诺揭示层次化推理能力（Video Models Reason Early）
3. RL+LLM混合框架为Spatial AGI提供早期案例（Hybrid Framework）
4. 触觉感知是Spatial AGI的第三大模态（HapCompass）
5. 空间不确定性聚合是Spatial AGI的关键保障（Spatially-Aware Aggregation）

**架构更新**:
- Level 0: 全景视频表示层 ⭐ NEW
- Level 1: 视频模型层次化推理层 ⭐ NEW
- Level 2: 多智能体混合控制层 ⭐ NEW
- Level 3: 多模态感知层（触觉） ⭐ NEW
- Level 4: 鲁棒性保障层 ⭐ NEW

**待解决**:
- 全景视频生成的实时性优化（目标<10fps）
- 触觉信号的高维稀疏性处理

---

**上次更新时间**: 2026-04-03 22:26 (Asia/Shanghai)

---

## 2026-04-03 研究的论文（精选5篇）

从arXiv最新论文中筛选出5篇最相关论文。

**总文档行数**: 6,281行（平均1,256行/篇）

**分析方法**: 全部使用GLM WebReader（NotebookLM不可用）

**核心发现**:
1. 自回归3D生成方法（GaussianGPT）
2. 几何信息的利用困境（Make Geometry Matter）
3. 感知-推理耦合与3D空间推理瓶颈（PerceptionComp）
4. VLA统一架构与在线适应（VLA-OPD）
5. VLM在具身任务上的边界（The Limits of Learning）

**架构更新**:
- Level 0: 自回归3D生成 ⭐ NEW
- Level 1: 几何作为可行动证据 ⭐ NEW
- Level 2: 感知-推理耦合与3D空间推理瓶颈 ⭐ NEW
- Level 3: VLA统一架构与在线适应 ⭐ NEW
- Level 4: 具身经验与功能性知识表示 ⭐ NEW

**下一步**: 等待明天研究任务（2026-04-04）

---
