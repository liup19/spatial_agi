# Spatial AGI Research - Paper Screening (2026-03-17)

## 已读取论文列表

1. **Visual-ERM: Reward Modeling for Visual Equivalence** (arXiv:2603.13224)
   - 相关领域: Vision-to-Code, Reward Models
   - 核心贡献: Visual Equivalence Reward Model (V-ERM)
   - 相关度: ★★★★★☆ (高度相关)

2. **StEvo-Bench: Evaluating State Evolution in Video World Models** (arXiv:2603.13215)
   - 相关领域: Video World Models, State Evolution
   - 核心贡献: StEvo-Bench基准测试视频世界模型能否解耦状态演化与观察
   - 相关度: ★★★★★★ (高度相关)

3. **WSGG: World Scene Graph Generation from Monocular Videos** (arXiv:2603.13185)
   - 相关领域: World Scene Graphs, 3D Scene Understanding
   - 核心贡献: WSGG任务，从单目视频生成时空世界场景图
   - 相关度: ★★★★★★ (高度相关)

4. **f-CBM: Towards Faithful Multimodal Concept Bottleneck Models** (arXiv:2603.13163)
   - 相关领域: Concept Bottleneck Models, XAI Interpretability
   - 核心贡献: Faithful CBM框架，可微分泄漏损失+KAN预测层
   - 相关度: ★★★☆☆☆ (中等相关)

5. **Diffusion-Based Feature Denoising for Robust Brain Tumor Classification** (arXiv:2603.13182)
   - 相关领域: Medical Image Classification, Adversarial Robustness
   - 核心贡献: NNMF特征提取+扩散模型防御
   - 相关度: ★★☆☆☆☆（低相关度 - 主要关注医学图像分类）

## 筛选结果（前5篇）

基于Spatial AGI研究目标（3D空间理解、视觉推理、世界模型、VLM空间智能、机器人任务规划），选择5篇最相关的论文：

### ✅ 已选5篇论文

1. **StEvo-Bench** (arXiv:2603.13215) ⭐⭐⭐⭐⭐⭐
   - **研究重点**: 视频世界模型的状态演化能力
   - **核心问题**: 视频世界模型能否在观察中断时正确演化世界状态
   - **与Spatial AGI关系**: 直接测试世界模型的核心能力——状态持久性、物理合理性、一致性
   - **关键技术**: 
     * 观察-解耦控制（遮挡、关灯、相机移开）
     * 自动化验证器（基于VLM的检查）
     * 225任务，6个演化类别

2. **WSGG** (arXiv:2603.13185) ⭐⭐⭐⭐⭐⭐
   - **研究重点**: 从单目视频生成时空世界场景图
   - **核心问题**: 传统VidSGG是帧中心的，物体离开相机视野就消失
   - **与Spatial AGI关系**: 提供世界中心的3D场景表示和持久性
   - **关键技术**:
     * ActionGenome4D数据集（4D场景+关系标注）
     * 三种方法：PWG（持久世界图）、MWAE（掩码世界编码器）、4DST（4D场景转换器）
     * 3D空间推理：持久对象记忆、跨视图检索、双向时序自注意力

3. **Visual-ERM** (arXiv:2603.13224) ⭐⭐⭐⭐⭐
   - **研究重点**: Vision-to-Code任务的奖励模型
   - **核心问题**: 如何为结构化视觉-语言模型提供细粒度、可解释、任务无关的反馈
   - **与Spatial AGI关系**: 为Vision-to-Code提供鲁棒评估和可解释的奖励信号
   - **关键技术**:
     * Visual Equivalence Reward Model (V-ERM)
     * 提供细粒度、可解释的反馈
     * 任务无关的奖励建模

4. **OmniStream** (昨天已分析) ⭐⭐⭐⭐⭐
   - **研究重点**: 统一流式视觉骨干网络
   - **核心问题**: 如何统一处理感知、重建和行动
   - **与Spatial AGI关系**: 提供统一的流式视觉表示用于多种任务

5. **Spatial-TTT** (昨天已分析) ⭐⭐⭐⭐⭐
   - **研究重点**: 测试时训练空间智能
   - **核心问题**: 如何在线适应和记住空间模式
   - **与Spatial AGI关系**: 实现流式空间智能的自适应机制

## 备选论文

**f-CBM** (arXiv:2603.13163) ⭐⭐⭐
   - 虽然关注概念瓶颈模型的可靠性，但更偏向于NLP的可解释性，与Spatial AGI的直接关联较弱
   - 可作为备选，如果需要补充可解释性相关工作

## 论文多样性

已选5篇论文涵盖：
- ✅ 视频世界模型的状态演化（StEvo-Bench）
- ✅ 3D场景图生成（WSGG）
- ✅ Vision-to-Code奖励建模（Visual-ERM）
- ✅ 统一流式视觉（OmniStream - 昨天）
- ✅ 测试时训练空间智能（Spatial-TTT - 昨天）

**覆盖领域**：
1. 世界模型与状态演化
2. 3D场景表示与持久性
3. 视觉-语言模型的可解释性与奖励
4. 流式视觉统一
5. 在线自适应机制

## 下一步

将启动5个Subagents并行分析这5篇论文：
1. StEvo-Bench
2. WSGG
3. Visual-ERM
4. OmniStream（已有分析，可能跳过或快速验证）
5. Spatial-TTT（已有分析，可能跳过或快速验证）

**分析方法**：GLM WebReader（NotebookLM认证失效）
**目标**：每篇至少500行深度分析
