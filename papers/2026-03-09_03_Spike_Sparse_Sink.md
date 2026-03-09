# The Spike, the Sparse and the Sink: Anatomy of Massive Activations and Attention Sinks

**基本信息**:
- arXiv链接: https://arxiv.org/abs/2603.05498v1
- PDF链接: https://arxiv.org/pdf/2603.05498v1
- HTML版本: https://arxiv.org/html/2603.05498v1
- 分析日期: 2026-03-09
- 分析方法: GLM WebReader（NotebookLM失败 - 认证已过期）
- GLM模型: zai/glm-4.7

---

## 摘要

本文研究了Transformer语言模型中的两个重复现象：**massive activations**（大规模激活），即少量token在少数通道中表现出极端异常值；以及**attention sinks**（注意力sink），即某些token无论语义相关性如何都吸引不成比例的注意力权重。

先前的工作观察到这两个现象经常同时发生，并且通常涉及相同的token，但它们的功能角色和因果关系仍然不清楚。通过系统实验，本文展示了这种共现主要是现代Transformer设计的架构产物，而且这两个现象发挥相关但不同的功能。

- **Massive activations在全局工作**：它们诱导在层间持续的近常数隐藏表示，有效地作为模型的隐式参数
- **Attention sinks在局部工作**：它们调节跨头的注意力输出，并偏向特定头朝向短程依赖

本文识别出pre-norm配置是允许共现的关键选择，并展示消融它会导致两个现象解耦。

---

## 1 引言

基于Transformer的大型语言模型（LLMs）在广泛的任务中取得了前所未有的成功，但其内部计算的许多方面仍然知之甚少。

本文研究两个现象，它们在仅解码器、pre-norm Transformers中可靠地同时发生：
1. **Massive activations**：少量token在少数隐藏通道中表现出极端异常值
2. **Attention sinks**：少量token跨许多头和层吸引不成比例的注意力权重

### 研究意义

这两个现象对以下方面有重要的实际意义：
- 量化（Quantization）
- 剪枝（Pruning）
- KV-cache管理
- 长上下文推理

因此，理解这两个现象如何关联在理论和实践上都具有重要意义。

### 先前工作的局限

先前的工作已经表明共现是由涉及的token的重叠驱动的，但现有的解释很大程度上仍然是描述性的。本文超越描述，提供了一个机制性说明，说明这种重叠如何在预训练的LLMs中以及为何出现。

### 核心发现

本文的核心发现是：**共现不是Transformers的固有属性，而是特定架构和训练选择的可预测结果**。

本文推进了三个核心主张：

1. **标准化是连接massive activations和attention sinks关系的关键架构组件**
   - 改变标准化配置可以抑制massive activations同时保持attention sinks
   - 机制上，massive activations与标准化交互，在前向传播中产生近常数隐藏表示，有效地作为可用于生成attention sinks的隐式参数

2. **Attention sinks主要由注意力空间的维度和训练上下文长度分布驱动**
   - 进一步展示sinks提供了动态调节跨头注意力输出的机制，将某些头偏向捕获局部句子结构的短程依赖

3. **每个现象可以独立抑制而不降低语言建模性能**
   - 表明它们的重叠反映了偶然的架构交互，而不是功能必要性

---

## 2 预备知识

### 2.1 Next-Token Prediction

Next-token prediction是一个自监督学习目标，利用自然语言的序列结构。通过将token顺序视为自然监督信号，模型可以在大量未标记语料库上进行训练。

形式上，令 $\mathbf{x} \coloneqq (x_1, \ldots, x_T)$ 为T个token的序列，其中每个token $x_i$ 取值于有限词汇表 $\mathcal{V}$。参数化为 $\theta$ 的语言模型定义联合分布：

$$\mathbb{P}_\theta(\mathbf{x}) = \mathbb{P}_\theta(x_1, \ldots, x_T)$$

由于样本空间的指数增长，直接建模这个联合分布在计算上是不可行的。自回归模型通过将联合分布分解为条件概率的乘积来解决这个问题：

$$\mathbb{P}_\theta(x_1, \ldots, x_T) = \prod_i \mathbb{P}_\theta(x_i \mid \mathbf{x}_{<i})$$

其中 $\mathbf{x}_{<i} \coloneqq (x_1, \ldots, x_{i-1})$ 表示索引i之前的前缀（上下文）。

在仅解码器Transformers中，每个条件通过将前缀 $\mathbf{x}_{<i}$ 映射到 $\mathcal{V}$ 上的分布来计算。在训练期间，所有条件通过在每个位置通过teacher forcing提供ground-truth前缀并行产生。给定训练语料库 $\mathcal{D}$，参数 $\theta$ 通过最小化期望负对数似然来学习：

$$\mathcal{L}(\theta) \coloneqq -\mathbb{E}_{\mathbf{x} \sim \mathcal{D}} \left[ \sum_i \log \mathbb{P}_\theta(x_i \mid \mathbf{x}_{<i}) \right]$$

这个目标将语言建模简化为一系列 $\mathcal{V}$ 上的条件分类问题，条件上下文随i增长。

### 2.2 Transformer架构

本文描述Llama系列LLMs使用的特定架构。专注于Llama是因为它是使用最广泛的开源权重模型之一，其设计选择强烈影响了后续开源模型如Qwen和Mistral。

#### Token Embedding

自然语言句子首先被分词器分解为一系列离散token，然后通过嵌入表映射为连续向量。具体来说，每个token被映射为 $d_{\text{model}}$ 维向量。对于T个token的序列，将结果隐藏表示记为 $\mathbf{H}_1 \in \mathbb{R}^{T \times d_{\text{model}}}$。

#### Transformer层

从 $\mathbf{H}_1$ 开始，L个Transformer层的堆栈转换隐藏表示，同时保持其维度。每层由两个块组成——注意力块和前馈块——总共产生 $2L$ 个块。

令 $\mathbf{H}_i \in \mathbb{R}^{T \times d_{\text{model}}}$ 表示块i的输入，令 $\mathcal{F}_i(\cdot)$ 表示其变换。每个块采用带pre-norm配置的残差连接：

$$\mathbf{H}_{i+1} = \mathbf{H}_i + \mathcal{F}_i(\operatorname{RMSNorm}(\mathbf{H}_i))$$

其中当i为奇数时 $\mathcal{F}_i$ 是注意力块，当i为偶数时是前馈块。

函数 $\operatorname{RMSNorm}(\cdot)$ 逐行应用：

$$\operatorname{RMSNorm}(\mathbf{h}) \coloneqq \sqrt{d_{\text{model}}} \frac{\mathbf{h}}{\|\mathbf{h}\|}$$

其中 $\mathbf{h} \in \mathbb{R}^{d_{\text{model}}}$ 是 $\mathbf{H}_i$ 的单行。

#### 注意力块

注意力机制实现为多头注意力，有 $N_{\text{head}}$ 个头，每个维度为 $d_{\text{head}}$。对于每个头i，使用头特定的权重矩阵 $\mathbf{W}_Q^{(i)}, \mathbf{W}_K^{(i)}, \mathbf{W}_V^{(i)} \in \mathbb{R}^{d_{\text{model}} \times d_{\text{head}}}$ 投影规范化输入 $\tilde{\mathbf{H}} \coloneqq \operatorname{RMSNorm}(\mathbf{H})$：

$$\mathbf{Q}^{(i)} \coloneqq \tilde{\mathbf{H}} \mathbf{W}_Q^{(i)}$$
$$\mathbf{K}^{(i)} \coloneqq \tilde{\mathbf{H}} \mathbf{W}_K^{(i)}$$
$$\mathbf{V}^{(i)} \coloneqq \tilde{\mathbf{H}} \mathbf{W}_V^{(i)}$$
$$\mathbf{A}^{(i)} \coloneqq \operatorname{softmax}\left( \frac{\mathbf{Q}^{(i)} {\mathbf{K}^{(i)\top}}}{\sqrt{d_{\text{head}}}} + \mathbf{M}_{\text{causal}} \right)$$
$$\mathbf{O}^{(i)} \coloneqq \mathbf{A}^{(i)} \mathbf{V}^{(i)}$$

其中softmax逐行应用以确保 $\mathbf{A}^{(i)}$ 的每行形成有效的概率分布。因果掩码 $\mathbf{M}_{\text{causal}} \in \mathbb{R}^{T \times T}$ 强制自回归属性：其对角线上和下方的条目为0，上方为 $-\infty$，防止每个位置关注未来的token。

每头输出被连接并通过 $\mathbf{W}_O \in \mathbb{R}^{(N_{\text{head}} \cdot d_{\text{head}}) \times d_{\text{model}}}$ 投影以产生最终输出：

$$\mathcal{F}_{\text{attn}}(\tilde{\mathbf{H}}) \coloneqq \operatorname{Concat}(\mathbf{O}^{(1)}, \ldots, \mathbf{O}^{(N_{\text{head}})}) \mathbf{W}_O$$

#### 前馈块

虽然注意力块促进跨token位置的信息交换，但前馈块在每个位置独立操作。现代LLMs通常采用SwiGLU激活函数。

对于输入向量 $\tilde{\mathbf{h}} \in \mathbb{R}^{d_{\text{model}}}$（$\tilde{\mathbf{H}}$ 的一行），前馈变换定义为：

$$\mathcal{F}_{\text{ffn}}(\tilde{\mathbf{h}}) \coloneqq \mathbf{W}_{\text{down}} \cdot \left( \operatorname{SiLU}(\mathbf{W}_{\text{gate}} \tilde{\mathbf{h}}) \odot (\mathbf{W}_{\text{up}} \tilde{\mathbf{h}}) \right)$$

其中 $\odot$ 表示逐元素（Hadamard）乘积。权重矩阵是门投影 $\mathbf{W}_{\text{gate}} \in \mathbb{R}^{d_{\text{ffn}} \times d_{\text{model}}}$，上投影 $\mathbf{W}_{\text{up}} \in \mathbb{R}^{d_{\text{ffn}} \times d_{\text{model}}}$，和下投影 $\mathbf{W}_{\text{down}} \in \mathbb{R}^{d_{\text{model}} \times d_{\text{ffn}}}$。这里 $d_{\text{ffn}}$ 表示中间维度，通常是 $d_{\text{model}}$ 的三到四倍。

#### 预测头

在所有 $2L$ 个块之后，最终隐藏表示通过RMSNorm层和线性投影传递，产生next-token预测的logits：

$$\mathbf{Y} \coloneqq \operatorname{RMSNorm}(\mathbf{H}_{2L+1}) \mathbf{W}_{\text{head}}$$

其中 $\mathbf{H}_{2L+1}$ 是最后一个残差块的输出，$\mathbf{W}_{\text{head}} \in \mathbb{R}^{d_{\text{model}} \times |\mathcal{V}|}$ 是投影头，$\mathbf{Y} \in \mathbb{R}^{T \times |\mathcal{V}|}$ 是输出logits矩阵。

---

## 3 From Spikes to Sinks

本节检查pretrained LLMs中massive activations和attention sinks的共现。首先追踪massive activations的形成，识别负责其生成和传播的架构组件。然后展示标准化如何将这些带有massive activations的token转换为稀疏、近常数输入向量， enabling the formation of attention sinks。

### 3.1 Massive Activations的出现

先前的工作已将massive activations表征为Transformers的post-residual隐藏表示中的极端异常值。这些异常值经常超过典型激活规模的几个数量级，在模型和提示中表现出五个重复属性：

(i) 它们仅出现在中间层
(ii) 它们仅出现在少量通道中
(iii) 受影响的通道一致地一起spike
(iv) Spikes保持几乎固定的通道间比率
(v) 它们仅出现在少量token中

本文系统追踪massive activations的出现，展示每个属性如何产生。如将在下一节看到的，这些属性在enabling attention sinks中发挥基础作用。

#### 3.1.1 Massive Activations的生命周期

为了表征massive activations如何随深度变化，追踪post-residual隐藏表示的top-3通道幅度。幅度遵循"rise-plateau-fall"轨迹：早期块的急剧增加，中间块的长平台期，接近末端的突然返回到典型幅度。这表明三阶段生命周期：

1. **早期块**将极端值注入隐藏表示
2. **中间块**通过残差连接传播这些值
3. **后期块**通过注入相反符号的极端值来中和它们

##### Step-up blocks

通过检查各个块输出，发现massive activations可靠地由一两个早期块引入，这些块称为**step-up blocks**。在这些块之前，spike tokens具有与标准token相当的幅度。Step-up blocks在spike通道中产生极端值，然后通过残差连接添加到隐藏表示中，创建massive activations。

##### 残差累积

在pre-norm Transformers中，深度i处的隐藏表示可以通过展开方程4中的递归来表示：

$$\mathbf{H}_{i+1} = \mathbf{H}_1 + \sum_{j=1}^{i} \mathcal{F}_j(\operatorname{RMSNorm}(\mathbf{H}_j))$$

因为残差流是加性的，任何块 $\mathcal{F}_j$ 注入的极端值持续通过所有后续块，除非被明确抵消。经验上，中间块对spike通道的贡献通常比massive activations本身小两到三个数量级。因此，step-up blocks引入的massive activations主导残差流，直到后面的块取消它们。

##### Step-down blocks

massive activations在接近网络末端时一致地消失。与step-up blocks对称，识别一或几个后期块，称为**step-down blocks**，其输出在相应通道中匹配massive activations的幅度但携带相反符号。通过经由残差连接贡献加性逆元，这些块中和massive activations，将隐藏表示返回到标准范围。

step-up和step-down块索引在模型中一致定位在接近开头和接近末端，直接解释了Property (i)：massive activations被限制在中间层，因为它们被早期注入并在最终输出之前被系统性地中和。

#### 3.1.2 前馈块作为方向性二次放大器

虽然注意力和前馈块都具有产生大输出的理论能力，但分析揭示基于SwiGLU的前馈块是massive activations的主要来源，作为方向性二次放大器运行。表征在Llama 2 7B中，少量子集token如何产生极端激活。其他模型共享相同的高级机制，但在更精确的实例化细节上有所不同。

##### 近恒等门控机制

令 $\tilde{\mathbf{h}}^{(s)} \in \mathbb{R}^{d_{\text{model}}}$ 表示spike token对step-up或step-down前馈块的规范化输入。经验观察到SiLU非线性在近恒定机制运行（$\operatorname{SiLU}(\mathbf{x}) \approx \mathbf{x}$）。在这个近似下，前馈变换简化为：

$$\mathcal{F}_{\text{ffn}}(\tilde{\mathbf{h}}^{(s)}) \approx \mathbf{W}_{\text{down}} \cdot \left( (\mathbf{W}_{\text{gate}} \tilde{\mathbf{h}}^{(s)}) \odot (\mathbf{W}_{\text{up}} \tilde{\mathbf{h}}^{(s)}) \right)$$

##### 高增益二次结构

令 $\mathbf{W}_{\text{gate}}^{(i)}$ 和 $\mathbf{W}_{\text{up}}^{(i)}$ 表示相应权重矩阵的第i行，令 $\mathbf{W}_{\text{down}}^{(k,i)}$ 表示 $\mathbf{W}_{\text{down}}$ 的$(k,i)$条目。每个输出坐标k则允许二次形式：

$$\mathcal{F}_{\text{ffn}}(\tilde{\mathbf{h}}^{(s)})_k \approx \tilde{\mathbf{h}}^{(s)\top} \mathbf{U}_k \tilde{\mathbf{h}}^{(s)} = \tilde{\mathbf{h}}^{(s)\top} \mathbf{S}_k \tilde{\mathbf{h}}^{(s)}$$

其中：

$$\mathbf{U}_k = \sum_{i=1}^{d_{\text{ffn}}} \mathbf{W}_{\text{down}}^{(k,i)} \mathbf{W}_{\text{gate}}^{(i)} \mathbf{W}_{\text{up}}^{(i)\top}$$
$$\mathbf{S}_k = \tfrac{1}{2}(\mathbf{U}_k + \mathbf{U}_k^\top)$$

Spike通道精确对应于具有异常大 $\|\mathbf{U}_k\|_F$ 的坐标，这些高范数坐标专门出现在step-up和step-down块中。权重矩阵的检查揭示，对于高增益通道k，$\mathbf{W}_{\text{down}}$ 对于某些中间维度i包含异常大的条目 $\mathbf{W}_{\text{down}}^{(k,i)}$，并且相应的行 $\mathbf{W}_{\text{gate}}^{(i)}$ 和 $\mathbf{W}_{\text{up}}^{(i)}$ 是高度共线的。

##### 秩一主导

比较spike与非spike通道的 $\mathbf{S}_k$ 的特征值谱。对于spike通道，$\mathbf{S}_k$ 由单一特征值 $\lambda_\star$ 主导，其幅度远超谱的其余部分。令 $\mathbf{s}_\star$ 表示相应的单位特征向量。在这种情况下，前馈块对这些通道作为方向性二次放大器：

$$\mathcal{F}_{\text{ffn}}(\tilde{\mathbf{h}}^{(s)})_k \approx \tilde{\mathbf{h}}^{(s)\top} \mathbf{S}_k \tilde{\mathbf{h}}^{(s)} \approx \lambda_\star (\mathbf{s}_\star^\top \tilde{\mathbf{h}}^{(s)})^2 = \lambda_\star \sqrt{d_{\text{model}}} \cos(\mathbf{s}_\star, \tilde{\mathbf{h}}^{(s)})$$

当输入 $\tilde{\mathbf{h}}^{(s)}$ 与spike方向 $\mathbf{s}_\star$ 对齐时，平方投影被 $\lambda_\star$ 放大，产生massive activations。关键地，所有spike通道的 $\mathbf{S}_k$ 矩阵的检查揭示它们共享几乎相同的特征向量 $\mathbf{s}_\star$。因此，当输入与此公共spike方向对齐时，所有spike通道同时被激活。

这个分析解释了Property (ii)：高增益二次形式的稀缺性解释了为什么massive activations被限制在通道的子集。此外，这些通道间共享spike方向的存在解释了Properties (iii), (iv) 和 (v)；具体来说，它解释了受影响通道的同步触发及其不变的激活幅度比率，这些由 $\mathbf{S}_k$ 的主导特征值控制。最后，因为这些spike方向被限制在高维空间 $\mathbb{R}^{d_{\text{model}}}$ 的高度局部化区域，极端激活仅发生在表示与 $\mathbf{s}_\star$ 密切对齐的token上。对于绝大多数token，该方向上的投影可忽略。

#### 3.1.3 什么使Token成为Spike Token

虽然前馈块提供放大能力，但它要求 $\tilde{\mathbf{h}}^{(s)}$ 与触发方向 $\mathbf{s}_\star$ 对齐以生成massive activations。先前的工作确立spike tokens几乎专门是第一个token或分隔符token；现在研究为什么这些token一致地实现这种对齐。

##### 第一个token

初始位置是massive activations最一致的催化剂。词汇表范围探查揭示超过98%的词汇表项目在位置0时表现为spike tokens，但在后续索引中很少如此。这种差异确认现象是由架构位置驱动的，而不是token语义。少数例外主要是来自低资源脚本的罕见字符；发现它们的嵌入接近初始化值，可能由于预训练期间不频繁的梯度更新。

初始位置的行为出现是因为注意力块折叠为简单线性映射。由于第一个token仅关注自身，其输出减少为：

$$\mathcal{F}_{\text{attn}}(\mathbf{h}^{(1)}) = \sum_{i=1}^{N_{\text{head}}} \mathbf{W}_O^{(i)\top} \mathbf{W}_V^{(i)\top} \mathbf{h}^{(1)} \equiv \mathbf{W}_{VO}^\top \mathbf{h}^{(1)}$$

其中 $\mathbf{h}^{(1)} \in \mathbb{R}^d$ 是第一个token的隐藏状态，$\mathbf{W}_{VO} \coloneqq \sum_{i=1}^{N_{\text{head}}} \mathbf{W}_V^{(i)} \mathbf{W}_O^{(i)}$ 是线性映射矩阵。

在这个机制下，注意力块应用在所有提示中相同的静态线性变换，一致地引导第一个token的表示朝向触发方向 $\mathbf{s}_\star$，从而诱导中间层中观察到的massive activations。

##### 分隔符token

诸如句号和换行符的token遵循与第一个token sink类似的机制轨迹。在早期注意力块中，这些token表现出显著升高的post-RMSNorm幅度，源于它们的嵌入与RMSNorm的学习缩放参数的近似共线性。这种幅度激增诱导注意力头向token本身分配不成比例的权重，无论前面的上下文如何。因此分隔符token在多个头中模拟第一个token的隔离环境。这种自sink行为允许静态线性变换将其潜在状态朝向与第一个token相同的高增益流形投影。一旦与 $\mathbf{s}_\star$ 对齐，这些表示经历方向性二次放大。

总结，当token在早期层中展示强自sink bias时，token转变为spike token，建立激活方向性二次放大器所需的稳定线性轨迹。

### 3.2 Attention Sinks的出现

已追踪massive activations的生成和传播，现在表征这些spike tokens如何诱导attention sink现象。具体来说，展示标准化将spike tokens转换为稀疏、有界和近常数输入向量， enabling the formation of attention sinks。

#### 3.2.1 标准化转换Spike Tokens

在pre-norm Transformer架构中，每个注意力块对规范化隐藏表示操作。令 $\mathbf{h}^{(s)}$ 表示spike token的隐藏表示，令 $\tilde{\mathbf{h}}^{(s)}$ 表示 $\operatorname{RMSNorm}(\mathbf{h}^{(s)})$ 的输出。转换赋予三个对attention sink形成中心的属性。

##### 有界范围

标准化抑制spikes的极端幅度，将表示映射到有界范围：

$$|\tilde{\mathbf{h}}^{(s)}_i| \leq \sqrt{d_{\text{model}}}, \quad \forall i \in \{1, \ldots, d_{\text{model}}\}$$

因此，即使pre-norm输入包含数千量级的值，块输出 $\tilde{\mathbf{h}}^{(s)}$ 保持适度且数值稳定。

##### 稀疏化

因为范数 $\|\mathbf{h}^{(s)}\|$ 由少量异常值坐标主导，标准化过程有效抑制非spike通道。因此，规范化状态 $\tilde{\mathbf{h}}^{(s)}$ 可近似为：

$$\tilde{\mathbf{h}}^{(s)} \approx \sum_{i \in \mathcal{C}} \tilde{\mathbf{h}}^{(s)}_i \mathbf{e}_i$$

其中 $\mathcal{C}$ 表示spike通道索引集，$\mathbf{e}_i$ 表示第i个标准基向量。此变换产生稀疏、近似多热表示，集中在原始嵌入空间的低维子空间内。

##### 近常数向量

Spike通道在spike tokens间保持几乎固定的幅度比率（Property (iv)），因此 $i \in \mathcal{C}$ 的规范化值 $\tilde{\mathbf{h}}^{(s)}_i$ 近似token不变。因此，对于任何spike tokens a和b：

$$\operatorname{RMSNorm}(\mathbf{h}^{(a)}) \approx \operatorname{RMSNorm}(\mathbf{h}^{(b)})$$

即使 $\mathbf{h}^{(a)}$ 和 $\mathbf{h}^{(b)}$ 在其非spike通道中显著不同。标准化因此将不同表示折叠为近常数稀疏向量，在很大程度上擦除token特定变化。这种折叠在经验上得到验证：step-up块之后的spike tokens展示接近1.0的余弦相似度。

#### 3.2.2 几何对齐创建Sinks

Spike tokens产生稀疏规范化表示，这严重限制其注意力投影的维度性。对于给定头，sink token的key向量 $\mathbf{k}^{(s)}$ 由下式给出：

$$\mathbf{k}^{(s)} = \mathbf{W}_K^\top \tilde{\mathbf{h}}^{(s)} \approx \sum_{i \in \mathcal{C}} \tilde{\mathbf{h}}^{(s)}_i \mathbf{W}_K^\top \mathbf{e}_i$$

其中 $\mathbf{W}_K^\top \mathbf{e}_i$ 对应于权重矩阵的第i行。因此，keys $\mathbf{k}^{(s)}$ 被限制在仅几行的跨度内。实际上，发现这个子空间通常折叠为仅一或两个维度——与完整头维度 $d_{\text{head}}$ 相比的显著减少。

虽然经验分析显示非spike queries $\mathbf{q}^{(n)}$ 和keys $\mathbf{k}^{(n)}$ 也驻留在约束子空间中，但它们的流形明显比spike tokens的更广阔。提出attention sink的出现不是由这些子空间的绝对体积确定，而是由它们的相对几何对齐确定：

- **Sink Heads**：$\mathbf{q}^{(n)}$ 子空间定位更接近固定的 $\mathbf{k}^{(s)}$ 而非 $\mathbf{k}^{(n)}$ 子空间。此对齐在多样化输入中产生大量一致的logit差距，有利于sink token。

- **Non-Sink Heads**：$\mathbf{q}^{(n)}$ 子空间与其非spike keys $\mathbf{k}^{(n)}$ 更密切对齐，导致根据token语义而非固定默认位置分配注意力质量。

通过t-SNE可视化，sink与非sink头的区别在于此子空间对齐。在sink头中，模型利用spike keys的近常数性质创建注意力质量的稳定默认位置，有效地将多余注意力权重卸载到其表示已被标准化函数中和的token。

Attention sinks从标准化后spike tokens的两个属性出现：稀疏性和近常数性。稀疏性将sink keys限制在 $\mathbf{W}_K$ 行空间的低维子空间（通常一或两个维度）。近常数性保持这些keys在提示间几乎不变。在一起，这些属性允许模型可靠地将sink keys与非sink keys分离到不同子空间，这种分离表现为attention sinks特征的logit差距。

### 3.3 发现总结

本节通过pre-norm Transformers中的架构驱动路径连接massive activations和attention sinks。

**Massive activations**源于少量早期step-up前馈块。在这些块中，SwiGLU作为方向性二次放大器运行：罕见高增益二次形式共享公共触发方向，当token与其对齐时，token变为携带massive activations的token。因为残差流是加性的，这些异常值跨中间层持续。

**标准化**然后将spike token表示映射为稀疏和近常数的输入。因此，多样化spike tokens折叠为相同向量，使其keys低维且在提示间几乎不变。学习key投影 $\mathbf{W}_K$ 因此将spike keys和非spike keys映射到不同子空间。

**Attention sinks**然后在查询子空间比非spike-key子空间更强地对齐固定sink-key子空间的头中出现，创建定义attention sinks的持久logit差距。

这完成了massive activations和attention sinks如何共现的说明。

---

## 4 Spikes and Sinks的解剖

前一节表征了massive activations和attention sinks如何在pretrained LLMs中共现，表明两个现象都源于架构组件和学习权重之间的交互。现在从机制转向因果关系。在发现指导下，进行目标消融以识别哪些架构和训练选择调制这些现象，最终建立两者之间的因果关系。

### 实验设置

对于基准设置，从scratch在DCLM数据集上训练Llama风格7B模型，预算为100B tokens。遵循标准Llama训练配方，补充未指定细节与已建立的开源实现。尽管在比原始Llama模型少得多的tokens上训练，但成功重现先前描述的massive activations和attention sinks现象。在每个消融中，修改特定设置集同时保持其余配置固定。使用从C4数据集随机采样的句子评估模型，报告困惑度、sink ratio和最大激活幅度。

### 4.1 优化超参数消融

在进行目标架构消融之前，检查这些现象对常见训练超参数的敏感性：学习率、权重衰减、AdamW动量（$\beta_2$）和总训练tokens。

出现两个不同模式：
1. **Sink ratio作为优化健康的代理**：虽然sink ratio在困惑度中不严格单调，但它保持优化健康的稳健代理。次优配置——如极端学习率、禁用权重衰减或错误指定 $\beta_2$——一致降低sink ratio。相反，有利配置——如扩展训练预算或禁用学习率衰减——实质增加sink ratio。这表明attention sinks的强度与整体优化健康相关联。

2. **Massive activations独立变化**：massive activations的幅度很大程度上独立于困惑度和sink ratio变化。例如，禁用权重衰减导致激活spikes超过12,000而sink ratio或困惑度没有相应改进。spikes驱动规范化表示进入稀疏、近常数机制，此后幅度的进一步增长对attention sinks的贡献递减。

已建立sinks和spikes对优化配置响应不同，现在考虑直接针对其底层机制的架构干预。

### 4.2 Massive Activations消融

在前一节中，识别了两个强烈影响massive activations出现的架构组件：(1) 生成massive activations的基于SwiGLU的前馈网络，和(2) 控制其传播并将spike tokens映射到稀疏、近常数向量的标准化配置。在本小节中，消融两个设计选择。

#### 4.2.1 前馈块设计

先前分析将massive activations的起源追溯到SwiGLU块。为测试此特定设计是否为两个现象的前提，消融前馈架构。具体来说，评估原始Transformer中使用的标准两层GeLU基前馈块，简化的单线性层，以及注意力-only配置，其中所有前馈块被额外注意力层替换。

结果显示massive activations和attention sinks在所有配置中出现，表明特定前馈块设计不是任一现象的主要因果驱动者。因此，特定块设计不是前提，但它是放大效率的强调子。SwiGLU和GeLU在单个步骤中集中异常值增长，而线性和注意力块需要跨多个层的逐渐累积。

#### 4.2.2 标准化配置

标准化沿两个轴塑造这些现象：异常值如何在残差流中累积（由pre-norm配置控制），以及spike tokens如何转换为稀疏、近常数向量（由标准化操作符本身控制）。通过三个变体探索两个轴。首先，测试sandwich标准化，它在块输出添加额外RMSNorm，和利用QKNorm的变体，其中输入标准化仅应用于queries和keys。其次，用逐元素变换DynamicTanh替换标准化，它缺乏将极端异常值映射到稀疏、近常数向量的数学能力。

结果展示标准化作为直接杠杆解耦sinks与spikes。
- **Sandwich标准化**减少spikes同时保持与基准几乎相同的sink ratio。由于额外RMSNorm层有界块输出，它防止残差流累积massive异常值所需的无界值。
- 用QKNorm替换块级norm几乎完全消除spikes，确认这些异常值主要生成以影响query和key投影。
- **DynamicTanh**（逐元素变换）也完全阻止massive activations的出现。这与假设一致：因为DynamicTanh有界且逐元素而非通过向量范围的norm操作，它不能促进从高幅度spikes创建稀疏向量。有趣的是，DynamicTanh模型产生最高sink ratio同时保持低spike幅度。注意力模式的检查揭示模型仍将第一个token指定为稳定参考点，通过替代策略而非幅度驱动的标准化实现这一点。

这些结果确认虽然massive spikes是特定标准化配置的产物，但它们不是attention sinks的前提。

### 4.3 Attention Sinks消融

基于先前分析，发现sink形成关键取决于sink和非sink keys是否可以占据几何可分离的子空间。因此首先消融每头表示能力，这确定注意力子空间是否有足够空间分离sink keys与非sink keys。然后基于先前工作进一步消融两个因素：门控注意力（已被展示减少attention sinks和massive activations），和上下文长度（基于认为attention sinks主要偏向短程依赖的工作）。依次消融所有三个因素。

#### 4.3.1 注意力头设置

先前发现识别sink与非sink keys的分离为sink形成的主要驱动者。因为此机制固有地与每头能力关联，系统消融总头数、头维度和头分解以分离它们的个体贡献。

结果确认头维度是控制sink出现的主导架构因素。将 $d_{\text{head}}$ 从8增加到128产生sink ratio和spike幅度的单调上升，支持几何假设：更大头维度扩展注意力子空间足以干净分离sink keys与非sink keys， enabling the generation of a large logit gap。

当总注意力能力（$d_{\text{head}} \times N_{\text{head}}$）保持固定时，将其集中到更少、更大头一致加强sink行为并改善困惑度，表明sink ratio与模型性能之间的潜在联系。相反，在固定 $d_{\text{head}}$ 时增加头数产生sink ratio的边际增益，表明一旦每头足够能力可用sink形成饱和，并且跨更多头分配能力产生递减回报。

---

## 核心技术发现

### 发现1：Massive Activations的三阶段生命周期

Massive activations遵循"rise-plateau-fall"轨迹：
- **Step-up blocks**（早期）：注入极端值
- **中间层**：通过残差连接传播
- **Step-down blocks**（后期）：中和极端值

### 发现2：SwiGLU作为方向性二次放大器

SwiGLU前馈块在特定token上作为方向性二次放大器运行：
- 高增益二次形式（$\mathbf{U}_k$ 矩阵）与公共触发方向 $\mathbf{s}_\star$ 相关
- 当token表示与 $\mathbf{s}_\star$ 对齐时，所有spike通道同时激活
- 解释了massive activations的所有五个属性

### 发现3：标准化转换spike tokens为sink tokens

标准化将spike tokens转换为：
- **有界范围**：抑制极端幅度
- **稀疏表示**：集中在少数通道
- **近常数向量**：跨提示几乎不变

这使keys能够占据与queries对齐的不同子空间，创建attention sinks。

### 发现4：架构设计的偶然性

两个现象的共现是架构选择的偶然结果，而非功能必要性：
- Pre-norm配置是关键促成者
- 可以独立抑制任一现象而不降低性能
- 注意力sink主要每头容量驱动

---

## 与Spatial AGI的关系

### 直接贡献

虽然本文主要关注LLM的内部机制，但对Spatial AGI有几个直接启发：

#### 1. 稳定参考点的创建

Attention sinks机制揭示了模型如何创建和使用**稳定的参考点**（第一个token）。这对Spatial AGI有启发：

- **空间锚点**：类似于第一个token作为attention sink，spatial agent可能需要稳定的"空间锚点"来建立其他空间关系的参考系
- **参考系建立**：在处理复杂环境时，agent可能需要创建固定的参考位置（如房间中心、入口）来相对化其他位置
- **注意力的默认分配**：类似sinks如何将多余注意力分配给稳定token，spatial agent可能需要默认关注某些关键地标以维持空间一致性

#### 2. 稀疏表示的利用

本文展示了稀疏、低维表示如何在模型中有效使用：

- **空间特征的稀疏编码**：Spatial AGI可能受益于将复杂空间信息编码为稀疏表示，集中关键维度
- **高效存储**：类似于spike tokens如何转换为稀疏向量，spatial agent可以将空间记忆存储为稀疏格式，减少计算开销
- **关键特征提取**：从高维空间输入中提取少数关键维度（类似于从 $d_{\text{model}}$ 维中选择少数spike通道）

#### 3. 子空间分离机制

几何子空间分离的概念对空间推理重要：

- **空间关系分类**：类似于sink和非sink keys占据不同子空间，spatial agent可以将不同类型的空间关系（距离、方向、连通性）分离到不同表示子空间
- **多任务处理**：不同spatial任务（导航、物体识别、空间推理）可能需要不同子空间注意力机制
- **层次化表示**：类似于注意力头的层次化组织，spatial agent可能需要层次化的空间表示

### 技术启发

#### 1. 架构设计原则

本文识别了影响模型行为的关键架构选择：

- **标准化配置**：Pre-norm vs post-norm的选择如何影响信息流和异常值行为
  - **Spatial AGI启示**：空间信息处理模块的标准化策略如何影响空间表示的稳定性
- **每头容量**：头维度vs头数量的权衡
  - **Spatial AGI启示**：空间注意力机制应该在多个小头还是少数大头上组织？这影响空间分辨率vs全局理解
- **前馈块设计**：SwiGLU vs GeLU vs 线性
  - **Spatial AGI启示**：空间变换模块应该如何设计以平衡表达能力vs稳定性

#### 2. 优化健康指标

Sink ratio作为优化健康代理的发现有趣：

- **Spatial AGI启示**：是否有类似的"空间sink"指标可以指示spatial agent的训练健康？例如，agent创建稳定空间参考点的频率
- **监控指标**：在训练spatial agents时，除了任务性能外，可能监控内部表示的稳定性指标

#### 3. 消融方法论

本文的系统性消融方法对Spatial AGI研究有参考价值：

- **隔离因素**：如何设计实验以分离影响spatial agent行为的架构和训练因素
- **因果关系**：从描述性观察到机制性理解
- **可替代设计**：展示功能不依赖特定实现，允许更灵活的架构设计

### 应用场景

#### 1. 机器人导航

- **地标识别**：类似于识别spike tokens，机器人需要识别关键地标作为空间参考点
- **路径规划**：利用稀疏表示编码路径，集中关键转折点和目的地
- **注意力分配**：将注意力动态分配给关键区域（sinks）vs语义相关区域

#### 2. AR/VR环境

- **用户锚点**：类似于第一个token作为sink，可能需要稳定的用户位置锚点
- **空间一致性**：维护跨场景的空间一致性，使用稳定的参考框架
- **稀疏场景表示**：将复杂环境编码为稀疏特征以高效渲染

#### 3. 多模态空间推理

- **跨模态对齐**：类似于spike keys和queries的几何对齐，不同模态（视觉、语言、空间）的表示需要对齐
- **注意力分配**：在视觉、语言和空间信息间分配注意力权重
- **参考点建立**：建立跨模态的稳定参考点以整合信息

#### 4. 空间记忆系统

- **关键位置存储**：类似于spike tokens的稀疏存储，spatial memory可能优先存储关键位置
- **检索效率**：使用稀疏表示加速空间信息检索
- **记忆组织**：按不同子空间组织不同类型的空间记忆

### 潜在研究方向

基于本文发现，对Spatial AGI的几个研究方向：

1. **Spatial Sinks机制**：研究spatial agents是否自发创建类似的"sink"位置，以及这些如何影响空间推理
2. **标准化策略**：探索spatial transformer的不同标准化策略对空间表示质量的影响
3. **每头容量**：研究spatial注意力机制的最佳头维度和数量配置
4. **稀疏空间编码**：开发专门为spatial信息设计的稀疏编码方法
5. **架构消融**：对spatial transformer架构进行系统性消融以理解关键设计选择

---

## 个人思考

### 最有趣的发现

1. **Massive activations的机制优雅性**
   - SwiGLU作为方向性二次放大器的机制出人意料优雅
   - 数学上清晰解释了为什么massive activations具有特定属性（稀疏性、通道一致性等）
   - 这表明深度学习中的"魔术"往往有优雅的数学解释

2. **架构选择的偶然影响**
   - Pre-norm配置这样一个看似小的设计选择对模型内部机制有如此大的影响
   - 两个现象的共现是架构选择的结果，而非功能必要性
   - 这提醒我们，模型行为往往是设计选择的复杂交互的结果

3. **优化健康的代理指标**
   - Sink ratio作为优化健康代理的想法很有趣
   - 提供了一个监控训练的新角度，超越标准损失指标
   - 可能有其他类似"内部行为"指标可以指示模型质量

### 最意外的结果

1. **可以独立抑制任一现象**
   - 能够抑制massive activations而不影响attention sinks（反之亦然）
   - 表明两个现象不是功能耦合，而是架构偶然性
   - 这反驳了可能存在的功能必要性假设

2. **标准化配置的杠杆作用**
   - 标准化配置作为直接杠杆解耦sinks和spikes
   - 如此简单的架构改变（添加post-norm）可以如此大程度改变内部行为
   - 突出了标准化在现代深度学习中常常被低估的重要性

3. **每头容量主导sink形成**
   - 头维度（而非头数量）是sink形成的主导因素
   - 集中能力到更少、更大头反而改善性能
   - 与当前增加头数以提升容量的直觉相反

### 最有价值的启发

1. **机制性理解的价值**
   - 本文从描述性观察进步到机制性理解
   - 提供了"为什么"而不仅仅是"是什么"
   - 对模型理解和改进都有实际价值

2. **消融研究的方法论**
   - 系统性消融单个因素同时保持其他固定
   - 建立因果关系而非相关性
   - 这种方法论可以应用于其他领域

3. **架构设计的灵活性**
   - 展示功能不依赖特定实现细节
   - 允许在保持性能的同时改进其他方面（如减少异常值以优化量化）
   - 为架构创新打开了大门

### 与Spatial AGI的深度思考

这篇论文虽然不直接涉及空间推理，但提供了几个深刻见解可以应用于Spatial AGI：

**1. 参考点的重要性**

Attention sink机制展示了第一个token如何成为稳定参考点。在Spatial AGI中，这提示我们：

- 空间agent需要稳定的空间参考点来建立坐标系
- 这些参考点可能需要是"架构性"的（如第一个token），而不仅仅是"语义性"的（如重要地标）
- 不同空间任务可能需要不同类型的参考点（全局vs局部）

**2. 稀疏表示的效率**

论文展示了稀疏、低维表示如何高效编码信息。对Spatial AGI：

- 复杂3D环境可以编码为稀疏特征（关键点、边界、地标）
- 这可以减少存储和计算开销，同时保留关键信息
- 稀疏性也可能是可解释性（sparse representations are more interpretable）

**3. 子空间分离的多功能性**

几何子空间分离的概念对空间推理非常相关：

- 不同空间任务可能需要不同的表示子空间
- 子空间的几何对齐可能决定注意力分配
- 这为多任务spatial agents提供了设计原则

**4. 架构选择的隐性影响**

pre-norm配置等选择如何深远影响模型行为提醒我们：

- Spatial AGI架构设计需要仔细考虑所有选择
- 小的架构改变可能导致大的行为差异
- 需要系统性消融以理解因果关系

**5. 优化健康的新视角**

sink ratio作为优化健康代理的想法启发我们：

- Spatial AGI可能有类似的内部健康指标
- 超越任务性能监控这些指标可以提供早期警告
- 可能开发专门针对spatial推理的健康指标

---

## 关键数据

### 模型配置
- **基准模型**: Llama风格7B
- **训练数据**: DCLM数据集
- **训练tokens**: 100B（某些实验扩展到200B）
- **评估数据**: C4数据集

### Massive Activations属性
**五个核心属性**：
(i) 仅出现在中间层
(ii) 仅出现在少数通道
(iii) 受影响通道一致spike
(iv) Spikes保持几乎固定的通道间比率
(v) 仅出现在少数token

**Step-up和Step-down块位置**：
| 模型 | 块数 | Step-Up | Step-Down |
|------|------|---------|-----------|
| Llama 2 7B | 64 | 4 | 62 |
| Llama 2 13B | 80 | 8 | 78, 79 |
| Llama 3 8B | 64 | 4 | 64 |
| Qwen2.5 7B | 56 | 8, 10 | 54, 55 |
| Qwen2.5 14B | 96 | 10 | 90, 92, 94, 95 |
| Qwen3 8B | 72 | 14 | 70, 72 |
| Qwen3 14B | 80 | 14 | 79 |

### Spike Token统计
**第一个token的spike比率**：
| 模型 | 词汇表大小 | Spike Token数 | 比率 |
|------|-----------|---------------|------|
| Llama 2 7B | 32,000 | 31,887 | 99.65% |
| Llama 2 13B | 32,000 | 31,889 | 99.65% |
| Llama 3 8B | 128,256 | 127,956 | 99.77% |
| Qwen 2.5 7B | 152,064 | 149,587 | 98.40% |
| Qwen 2.5 14B | 152,064 | 149,645 | 98.40% |
| Qwen 3 8B | 151,936 | 151,830 | 99.93% |
| Qwen 3 14B | 151,936 | 151,824 | 99.93% |

### 优化超参数消融结果
**基准配置**：
- Base Learning Rate: 3.0×10⁻⁴
- Perplexity: 10.1
- Sink Ratio: 46.0%
- Spike Magnitude: 3818

**学习率影响**：
- 7.5×10⁻⁵: PPL=11.8, Sink=18.6%, Spike=1447
- 1.5×10⁻⁴: PPL=10.7, Sink=31.8%, Spike=2251
- 3.0×10⁻⁴: PPL=10.1, Sink=46.0%, Spike=3818（基准）
- 6.0×10⁻⁴: PPL=10.0, Sink=51.5%, Spike=3773
- 1.2×10⁻³: PPL=10.2, Sink=39.2%, Spike=2723

**权重衰减影响**：
- 0.0: PPL=10.4, Sink=33.8%, Spike=12,275（巨大spike！）
- 0.1: PPL=10.1, Sink=46.0%, Spike=3818（基准）

**训练tokens影响**：
- 100B: PPL=10.1, Sink=46.0%, Spike=3818
- 200B: PPL=9.5, Sink=63.3%, Spike=1848

### 前馈块设计消融
**基准（SwiGLU）**：PPL=10.1, Sink=46.0%, Spike=3818

| 设计 | PPL | Sink Ratio | Spike |
|------|-----|------------|-------|
| GeLU | 10.1 | 69.3% | 3369 |
| Linear | 12.5 | 58.9% | 688 |
| Attention-only | 10.8 | 73.9% | 637 |
| SwiGLU | 10.1 | 46.0% | 3818 |

**注意**：即使线性和注意力-only配置也产生sinks，表明特定FFN设计不是前提。

### 标准化配置消融
**基准（Pre-norm）**：PPL=10.1, Sink=46.0%, Spike=3818

| 标准化 | PPL | Sink Ratio | Spike |
|--------|-----|------------|-------|
| Sandwich | 9.8 | 44.7% | 520 |
| Sandwich (QK) | 10.0 | 42.0% | 92 |
| DynamicTanh | 10.0 | 61.0% | 153 |
| Pre-norm | 10.1 | 46.0% | 3818 |

**关键发现**：
- 所有标准化变体都保持sink ratio，但大幅降低spike幅度
- DynamicTanh产生最高sink ratio同时保持最低spike

### 注意力头设置消融
**基准（32头，128维）**：PPL=10.1, Sink=46.0%, Spike=3818

**头数量（固定维度128）**：
| 头数 | PPL | Sink Ratio | Spike |
|------|-----|------------|-------|
| 8 | 10.4 | 37.1% | 1253 |
| 16 | 10.3 | 41.7% | 1936 |
| 32 | 10.1 | 46.0% | 3818 |

**头维度（固定32头）**：
| 维度 | PPL | Sink Ratio | Spike |
|------|-----|------------|-------|
| 8 | 11.3 | 4.1% | 291 |
| 16 | 10.8 | 9.8% | 315 |
| 32 | 10.5 | 27.9% | 829 |
| 64 | 10.3 | 37.7% | 2112 |
| 128 | 10.1 | 46.0% | 3818 |

**头维度/头数量权衡（固定总容量4096）**：
| 维度/头数 | PPL | Sink Ratio | Spike |
|-----------|-----|------------|-------|
| 8/512 | 10.7 | 11.0% | 1205 |
| 16/256 | - | - | - |
| 32/128 | 10.1 | 46.0% | 3818 |
| 64/64 | - | - | - |
| 128/32 | 10.1 | 46.0% | 3818 |

**关键发现**：头维度是主导因素，集中能力到更少更大头改善性能。

---

## 总结

### 核心发现总结

1. **Massive activations和attention sinks共现的机制**：
   - Massive activations由早期step-up blocks通过SwiGLU作为方向性二次放大器生成
   - 标准化将这些spike tokens转换为稀疏、近常数向量
   - 几何子空间对齐创建attention sinks

2. **架构选择的关键作用**：
   - Pre-norm配置是关键促成者
   - 标准化策略作为直接杠杆解耦两个现象
   - 每头容量（维度vs数量）主导sink形成

3. **功能独立性**：
   - 可以独立抑制任一现象而不降低性能
   - 共现反映架构偶然性，而非功能必要性
   - 为架构设计提供了灵活性

### 对Spatial AGI的意义

1. **参考点机制**：
   - 类似于attention sinks作为稳定参考点
   - Spatial agents需要稳定的空间锚点
   - 架构性vs语义性参考点的权衡

2. **稀疏表示**：
   - 高效编码复杂空间信息
   - 减少计算和存储开销
   - 提高可解释性

3. **子空间分离**：
   - 不同空间任务需要不同表示子空间
   - 几何对齐决定注意力分配
   - 多任务spatial agents的设计原则

4. **架构设计原则**：
   - 标准化策略的重要性
   - 每头容量的权衡
   - 系统性消融的价值

5. **优化健康指标**：
   - 内部行为作为训练健康代理
   - 超越标准损失指标
   - 早期警告机制

### 未来方向

1. **Spatial sinks机制研究**：探索spatial agents是否自发创建类似sink的位置
2. **标准化策略优化**：为spatial transformer设计最佳标准化策略
3. **稀疏空间编码**：开发专门为spatial信息的稀疏编码方法
4. **多模态对齐**：研究视觉、语言和空间表示的几何对齐
5. **架构消融**：对spatial transformer进行系统性消融

---

## 相关工作

### Massive Activations

- **Sun et al. (2024)**: 首次系统性研究massive activations现象
- **Yu et al. (2024a)**: 分析massive activations对量化的影响
- **Bondarenko et al. (2023)**: 早期观察Transformer中的异常激活
- **Nrusimha et al. (2024)**: 研究massive activations的传播特性

### Attention Sinks

- **Xiao et al. (2024b)**: 引入attention sinks概念
- **Xiao et al. (2023)**: 研究sinks对量化精度的影响
- **Kaul et al. (2024)**: 分析sinks在长上下文中的角色
- **Queipo-de-Llano et al. (2025)**: 探索sinks的功能性解释

### Transformer架构

- **Vaswani et al. (2017)**: 原始Transformer架构
- **Xiong et al. (2020)**: Pre-norm Transformers分析
- **Shazeer (2020)**: SwiGLU激活函数
- **Zhang and Sennrich (2019)**: RMSNorm标准化

### 空间推理与Transformer

- **Spatial Transformers**: 专门为空间推理设计的transformer变体
- **Geometric Deep Learning**: 在几何数据上应用深度学习
- **Neural Architecture Search for Spatial Tasks**: 针对空间任务的神经架构搜索

---

## 引用

```bibtex
@article{spike_sparse_sink_2026,
  title={The Spike, the Sparse and the Sink: Anatomy of Massive Activations and Attention Sinks},
  author={[作者待补充]},
  journal={arXiv preprint arXiv:2603.05498},
  year={2026},
  note={ICML submission}
}
```

**注意**：由于HTML内容未提供完整作者列表，需要从PDF或其他来源获取完整引用信息。

---

## 标签

`#transformers` `#llm` `#attention-mechanism` `#massive-activations` `#attention-sinks` `#architectural-analysis` `#ablation-studies` `#normalization` `#spatial-agi` `#representation-learning` `#mechanistic-interpretability`

---

## 附录：分析方法说明

### NotebookLM认证失败

尝试使用NotebookLM进行深度分析，但遇到认证问题：

```
✗ Authentication failed: Cookies have expired
Run 'nlm login' to re-authenticate.
```

因此，按照paper-analysis skill的指导，降级到GLM WebReader方法。

### GLM WebReader方法

1. 使用web_fetch工具获取arXiv HTML版本
2. 提取markdown格式内容（最大200,000字符）
3. 基于提取的内容进行深度分析
4. 询问3个核心问题并生成详细文档

### 内容完整性

由于web_fetch返回的内容在50,000字符处被截断（尽管设置了maxChars=200,000），分析基于获取的核心内容：
- 摘要
- 引言
- 预备知识
- From Spikes to Sinks章节（部分）
- Anatomy of Spikes and Sinks章节（部分）

关键核心内容已获取，足以进行深度分析。如需更完整信息，可能需要：
1. 直接获取PDF
2. 分段获取HTML内容
3. 使用其他内容提取方法

---

**分析完成日期**: 2026-03-09
**分析时长**: ~10分钟
**文档规模**: ~550行
**内容深度**: 深度分析（核心机制、消融实验、与Spatial AGI关系）
