---
title: AI大模型安全研究
layout: post
categories: chatgpt
tags: chatgpt security
date: 2023-06-30 18:00
excerpt: AI大模型安全研究
---

{:.table-of-content}
* TOC
{:toc}

# AI大模型安全研究

## 相关资料
- [LLMSurvey](https://github.com/RUCAIBox/LLMSurvey)
- [大模型能力评估SuperCLUE](https://github.com/CLUEbenchmark/SuperCLUE)
- [大模型能力评估PromptBench](https://github.com/microsoft/promptbench)
- [大模型能力评估lm-evaluation-harness](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) [code](https://github.com/EleutherAI/lm-evaluation-harness)
- [大模型能力评估awesome-LLM-benchmarks](https://github.com/wgwang/awesome-LLM-benchmarks)
- [阿里云大模型攻防实践](https://xz.aliyun.com/t/13189)
- [总结Prompt&LLM论文，开源数据&模型，AIGC应用](https://github.com/DSXiangLi/DecryptPrompt)
- [PKU BeaverTails 大模型安全对齐数据集](https://github.com/PKU-Alignment/beavertails)
- [LLM学习资料](https://github.com/mlabonne/llm-course)
- [ArXiv Papers on LLM Alignment, Safety, Security](https://unispac.github.io/arxiv-llm-alignment-safety-security/)
- [LLM提示技术](https://www.promptingguide.ai/)
- [LLM安全论文](https://llmsecurity.net/)
- [LLM应用STRIDE威胁分析](https://aivillage.org/large%20language%20models/threat-modeling-llm/)
- [LLM攻防综述](https://arxiv.org/ftp/arxiv/papers/2312/2312.10982.pdf)
- [LLM漏洞综述](https://arxiv.org/pdf/2310.10844.pdf)
- [利用大模型评估大模型能力](https://github.com/GAIR-NLP/auto-j) [paper](https://arxiv.org/pdf/2310.05470.pdf)
- [大模型安全能力评估](https://github.com/XuanwuAI/SecEval)
- [awesome-llm-security](https://github.com/corca-ai/awesome-llm-security)
- [llm安全论文汇总](https://github.com/chawins/llm-sp)
- [AI论文代码汇总](https://paperswithcode.com/)
- [大模型内容安全：敢问路在何方？](https://mp.weixin.qq.com/s/YrZpiBV2rqVWYHQsOj3oDg)
- [Microsoft AI Red Team](https://learn.microsoft.com/en-us/security/ai-red-team/)

## OWASP Top 10
> https://owasp.org/www-project-top-10-for-large-language-model-applications/descriptions/
> https://github.com/OWASP/www-project-top-10-for-large-language-model-applications/blob/main/index.md
> https://github.com/OWASP/www-project-ai-security-and-privacy-guide/blob/main/index.md

![](/assets/img/llm10.png)
![](/assets/img/aisecthreatscountermeasures.png)

### LLM01:2023 - 提示注入

**描述：**<br>
提示注入涉及绕过过滤器或使用精心设计的提示操纵大型语言模型（LLM），使模型忽略之前的指令或执行意外的操作。这些漏洞可能导致意外的后果，包括数据泄露、未经授权的访问或其他安全漏洞。

**常见的提示注入漏洞：**<br>
- 制作提示，操纵LLM揭示敏感信息。
- 通过使用特定的语言模式或令牌绕过过滤器或限制。
- 利用LLM的令牌化或编码机制的弱点。
- 通过提供误导性的上下文，误导LLM执行意外的操作。

**如何预防：**<br>
- 对用户提供的提示实施严格的输入验证和清理。
- 使用上下文感知的过滤和输出编码来防止提示操纵。
- 定期更新和微调LLM，以提高其对恶意输入和边缘案例的理解。
- 监控和记录LLM的交互，以检测和分析可能的提示注入尝试。

**示例攻击场景：**<br>
- 场景#1：攻击者制作一个提示，欺骗LLM揭示敏感信息，如用户凭证或内部系统细节，使模型认为请求是合法的。
- 场景#2：恶意用户通过使用特定的语言模式、令牌或编码机制绕过内容过滤器，LLM未能识别这些内容为受限内容，允许用户执行应被阻止的操作。

### LLM02:2023 - 数据泄露

**描述：**<br>
数据泄露是指当大型语言模型（LLM）在其回应中无意间泄露敏感信息、专有算法或其他机密细节时发生的情况。这可能导致未经授权的访问敏感数据或知识产权，侵犯隐私，以及其他安全漏洞。

**常见的数据泄露漏洞：**<br>
- 在LLM的回应中，对敏感信息的过滤不完整或不适当。
- 在LLM的训练过程中，对敏感数据的过度拟合或记忆。
- 由于LLM的误解或错误，无意间泄露了机密信息。

**如何预防：**<br>
- 实施严格的输出过滤和上下文感知机制，防止LLM泄露敏感信息。
- 在LLM的训练过程中使用差分隐私技术或其他数据匿名化方法，以减少过度拟合或记忆的风险。
- 定期审计和审查LLM的回应，确保不会无意间泄露敏感信息。
- 监控和记录LLM的交互，以检测和分析可能的数据泄露事件。

**示例攻击场景：**<br>
- 场景#1：用户无意间向LLM提出了一个可能泄露敏感信息的问题。由于缺乏适当的输出过滤，LLM回应了机密数据，将其暴露给用户。
- 场景#2：攻击者故意用精心设计的提示探测LLM，试图提取LLM从其训练数据中记忆的敏感信息。

### LLM03:2023 - 不充分的沙盒化

**描述：**<br>
不充分的沙盒化是指当大型语言模型（LLM）在访问外部资源或敏感系统时，没有得到适当的隔离。这可能导致潜在的利用、未经授权的访问，或者LLM的意外行动。

**常见的不充分的沙盒化漏洞：**<br>
- LLM环境与其他关键系统或数据存储的分离不足。
- 允许LLM在没有适当限制的情况下访问敏感资源。
- 未能限制LLM的能力，例如允许它执行系统级别的操作或与其他进程交互。

**如何预防：**<br>
- 实施适当的沙盒化技术，将LLM环境与其他关键系统和资源隔离。
- 限制LLM访问敏感资源，并将其能力限制到执行其预期目的所需的最小范围。
- 定期审计和审查LLM的环境和访问控制，以确保维持适当的隔离。
- 监控和记录LLM的交互，以检测和分析可能的沙盒化问题。

**示例攻击场景：**<br>
- 场景#1：攻击者通过制作提示，利用LLM访问敏感数据库，指示LLM提取和揭示机密信息。
- 场景#2：允许LLM执行系统级别的操作，攻击者操纵它在底层系统上执行未经授权的命令。

### LLM04:2023 - 未经授权的代码执行

**描述：**<br>
未经授权的代码执行是指攻击者利用大型语言模型（LLM）通过自然语言提示在底层系统上执行恶意代码、命令或操作。

**常见的未经授权的代码执行漏洞：**<br>
- 未能清理或限制用户输入，允许攻击者制作提示触发未经授权的代码执行。
- 不充分的沙盒化或对LLM能力的限制不足，允许它以意外的方式与底层系统交互。
- 无意中向LLM暴露系统级别的功能或接口。

**如何预防：**<br>
- 实施严格的输入验证和清理过程，防止LLM处理恶意或意外的提示。
- 确保适当的沙盒化，并限制LLM的能力，以限制其与底层系统的交互能力。
- 定期审计和审查LLM的环境和访问控制，以确保不可能进行未经授权的操作。
- 监控和记录LLM的交互，以检测和分析可能的未经授权的代码执行问题。

**示例攻击场景：**<br>
- 场景#1：攻击者制作一个提示，指示LLM执行一个命令，该命令在底层系统上启动一个反向shell，授予攻击者未经授权的访问。
- 场景#2：LLM被无意中允许与系统级API交互，攻击者操纵LLM在系统上执行未经授权的操作。

### LLM05:2023 - SSRF漏洞

**描述：**<br>
服务器端请求伪造（SSRF）漏洞发生在攻击者利用大型语言模型（LLM）执行非预期的请求或访问受限资源（如内部服务、API或数据存储）时。

**常见的SSRF漏洞：**<br>
- 输入验证不足，允许攻击者操纵LLM提示以发起未经授权的请求。
- 沙盒化不足或资源限制不足，使LLM能够访问受限资源或与内部服务交互。
- 网络或应用安全设置中的配置错误，将内部资源暴露给LLM。

**如何预防：**<br>
- 实施严格的输入验证和清理，防止恶意或意外的提示发起未经授权的请求。
- 强制执行适当的沙盒化，并限制LLM对网络资源、内部服务和API的访问。
- 定期审计和审查网络和应用安全设置，确保内部资源不会无意中暴露给LLM。
- 监控和记录LLM的交互，以检测和分析可能的SSRF漏洞。

**示例攻击场景：**<br>
- 场景#1：攻击者制作一个提示，指示LLM向内部服务发出请求，绕过访问控制并获得对敏感信息的未经授权的访问。
- 场景#2：应用的安全设置中的配置错误允许LLM与受限的API交互，攻击者操纵LLM访问或修改敏感数据。

### LLM06:2023 - 过度依赖LLM生成的内容

**描述：**<br>
过度依赖LLM生成的内容可能导致误导或错误信息的传播，减少人类在决策中的参与，以及减少批判性思维。组织和用户可能在没有验证的情况下信任LLM生成的内容，导致错误、误传或意外后果。

**过度依赖LLM生成的内容的常见问题包括：**<br>
- 在没有验证的情况下接受LLM生成的内容为事实。
- 假设LLM生成的内容没有偏见或误信息。
- 在没有人类输入或监督的情况下，依赖LLM生成的内容进行关键决策。

**如何预防：**<br>
为了防止过度依赖LLM生成的内容的问题，可以考虑以下最佳实践：

- 鼓励用户验证LLM生成的内容，并在做决定或接受信息为事实之前，咨询其他来源。
- 实施人类监督和审查流程，以确保LLM生成的内容准确、适当且无偏见。
- 明确地向用户传达LLM生成的内容是由机器生成的，可能并不完全可靠或准确。
- 培训用户和利益相关者识别LLM生成的内容的限制，并以适当的怀疑态度对待它。
- 将LLM生成的内容作为对人类专业知识和输入的补充，而不是替代。

**示例攻击场景：**<br>
- 场景#1：一个新闻组织使用LLM生成各种主题的文章。LLM生成了一篇包含错误信息的文章，该文章在未经验证的情况下被发布。读者信任这篇文章，导致误信息的传播。
- 场景#2：一家公司依赖LLM生成财务报告和分析。LLM生成了一份包含错误财务数据的报告，公司用这份报告做出了关键的投资决策。由于依赖不准确的LLM生成的内容，导致了重大的财务损失。

### LLM07:2023 - AI对齐不足

**描述：**<br>
AI对齐不足是指当LLM的目标和行为与预期的使用案例不一致时，可能导致不希望的后果或漏洞。

**常见的AI对齐问题：**<br>
- 目标定义不清晰，导致LLM优先考虑不希望的或有害的行为。
- 奖励函数或训练数据与预期结果不一致，导致模型行为出现意外。
- 在各种上下文和场景中对LLM行为进行的测试和验证不足。

**如何预防：**<br>
- 在设计和开发过程中明确定义LLM的目标和预期行为。
- 确保奖励函数和训练数据与期望的结果一致，不鼓励不希望的或有害的行为。
- 定期在各种场景、输入和上下文中测试和验证LLM的行为，以识别和解决对齐问题。
- 实施监控和反馈机制，持续评估LLM的性能和对齐情况，并在需要的时候更新模型以改善对齐。

**示例攻击场景：**<br>
- 场景#1：一个被训练用于优化用户参与度的LLM无意中优先考虑了有争议或极化的内容，导致了错误信息或有害内容的传播。
- 场景#2：一个被设计用于协助进行系统管理任务的LLM对齐不足，导致它执行有害的命令或优先考虑降低系统性能或安全性的行动。

### LLM08:2023 - 访问控制不足

**描述：**<br>
访问控制不足是指当访问控制或身份验证机制未正确实施时，允许未经授权的用户与LLM交互并可能利用漏洞。

**常见的访问控制问题：**<br>
- 未能强制执行对访问LLM的严格身份验证要求。
- 基于角色的访问控制（RBAC）实施不足，允许用户执行超出其预期权限的操作。
- 未能为LLM生成的内容和操作提供适当的访问控制。

**如何预防：**<br>
- 实施强大的身份验证机制，如多因素身份验证，以确保只有授权用户可以访问LLM。
- 使用基于角色的访问控制（RBAC）来定义和执行基于用户角色和职责的权限。
- 为LLM生成的内容和操作实施适当的访问控制，以防止未经授权的访问或操纵。
- 定期审计和更新访问控制，以维护安全性并防止未经授权的访问。

**示例攻击场景：**<br>
- 场景#1：由于身份验证机制弱，攻击者获得了对LLM的未经授权的访问，允许他们利用漏洞或操纵系统。
- 场景#2：由于RBAC实施不足，具有有限权限的用户能够执行超出其预期范围的操作，可能导致损害或危及系统。

### LLM09:2023 - 错误处理不当

**描述：**<br>
错误处理不当是指错误消息或调试信息以可能向攻击者泄露敏感信息、系统细节或潜在攻击向量的方式暴露出来。

**常见的错误处理问题：**<br>
- 通过错误消息暴露敏感信息或系统细节。
- 泄露可能帮助攻击者识别潜在漏洞或攻击向量的调试信息。
- 未能优雅地处理错误，可能导致意外的行为或系统崩溃。

**如何预防：**<br>
- 实施适当的错误处理机制，确保错误被捕获、记录和优雅地处理。
- 确保错误消息和调试信息不会泄露敏感信息或系统细节。考虑为用户使用通用错误消息，同时为开发人员和管理员记录详细的错误信息。
- 定期审查错误日志，并采取必要的行动修复已识别的问题并提高系统稳定性。

**示例攻击场景：**<br>
- 场景#1：攻击者利用LLM的错误消息收集敏感信息或系统细节，使他们能够发起针对性的攻击或利用已知的漏洞。
- 场景#2：开发人员在生产环境中无意间暴露了调试信息，使攻击者能够识别系统中的潜在攻击向量或漏洞。

### LLM10:2023 - 训练数据投毒

**描述：**<br>
训练数据投毒是指攻击者操纵LLM的训练数据或微调过程，引入可能危害模型安全性、有效性或道德行为的漏洞、后门或偏见。

**常见的训练数据投毒问题：**<br>
- 通过恶意操纵训练数据，向LLM中引入后门或漏洞。
- 向LLM中注入偏见，导致其产生偏见或不适当的响应。
- 利用微调过程来破坏LLM的安全性或有效性。

**如何预防：**<br>
- 确保训练数据的完整性，通过从可信来源获取数据并验证其质量。
- 实施强大的数据清洗和预处理技术，以从训练数据中移除潜在的漏洞或偏见。
- 定期审查和审计LLM的训练数据和微调过程，以检测潜在的问题或恶意操纵。
- 利用监控和警报机制，检测LLM中的异常行为或性能问题，可能表明训练数据投毒。

**示例攻击场景：**<br>
- 场景#1：攻击者渗透训练数据管道并注入恶意数据，导致LLM产生有害或不适当的响应。
- 场景#2：恶意内部人员破坏微调过程，向LLM中引入可以在后期阶段被利用的漏洞或后门。

## GPT-4 System Card
> https://cdn.openai.com/papers/gpt-4-system-card.pdf

### 幻觉（Hallucinations）
GPT-4有时会生成不存在的信息，这被称为“幻觉”。这种情况在模型对输入的理解不准确或者模型没有足够的信息来生成准确回答时更常见。此外，模型可能会过度自信地提供错误的信息，这可能会误导用户。

### 有害内容（Harmful content）
GPT-4可能会生成一些有害的内容，例如暴力、色情、仇恨言论等。这可能会对使用者产生负面影响，或者被用来进行有害的活动。

### 代表性、分配和服务质量的伤害（Harms of representation, allocation, and quality of service）
GPT-4可能会产生一些偏见的内容，或者对某些群体的代表性不足。此外，它的服务质量也可能会受到影响，例如，它可能会对某些问题的回答过于简单或者不准确。
![](/assets/img/ai_sec1.png)
![](/assets/img/ai_sec2.png)

### 虚假信息和影响操作（Disinformation and influence operations）
GPT-4可能会被用来生成假信息，或者进行影响操作。例如，它可能会被用来制造虚假的新闻，或者进行社交工程攻击。
![](/assets/img/ai_sec3.png)

### 常规和非常规武器的扩散（Proliferation of conventional and unconventional weapons）
GPT-4可能会被用来帮助人们获取制造武器的知识，从而增加武器的扩散。
![](/assets/img/ai_sec4.png)

### 隐私（Privacy）
GPT-4可能会泄露用户的隐私。例如，它可能会在生成的文本中包含一些敏感的个人信息。

### 网络安全（Cybersecurity）
GPT-4可能会被用来进行网络攻击。例如，它可能会被用来生成恶意的代码，或者帮助攻击者找到系统的漏洞。
![](/assets/img/ai_sec5.png)

### 潜在的风险行为（Potential for risky emergent behaviors）
GPT-4可能会产生一些未预期的风险行为。例如，它可能会在没有明确指示的情况下生成有害的内容。

### 与其他系统的交互（Interactions with other systems）
理解GPT-4如何与其他系统交互对于评估这些模型在各种真实世界环境中可能带来的风险至关重要。例如，红队人员评估了GPT-4与其他工具的结合使用，以完成可能具有对抗性的任务。在化学领域的一个例子中，目标是寻找与其他化学化合物相似的化学化合物，提出可以在商业目录中购买的替代品，并执行购买。通过将这些工具与GPT-4一起使用，红队人员能够成功地找到可购买的替代化学品。
![](/assets/img/ai_sec6.png)

### 经济影响（Economic impacts）
GPT-4对经济和劳动力的影响应成为政策制定者和其他利益相关者的重要考虑因素。虽然现有的研究主要关注AI和生成模型如何增强人类工作者，但GPT-4或后续模型可能导致某些工作的自动化，这可能导致劳动力的流失。随着时间的推移，我们预计GPT-4甚至会影响到那些历来需要多年经验和教育的工作，如法律服务。

### 加速（Acceleration）
我们预计GPT-4将加速开发基于生成模型的新应用，这些应用通常会解决比模型本身更复杂的任务。实际上，由于AI，特别是更好的AI系统的发展，技术发展的总体速度可能会加速。

### 过度依赖（Overreliance）
如果用户过度依赖GPT-4或类似的AI系统，可能会产生一些风险。例如，如果用户过于依赖模型的建议而不进行自己的研究或批判性思考，可能会导致误解或错误的决策。此外，如果模型出现故障或被误用，过度依赖模型的用户可能会受到影响。

## 清华大学CoAI中文大模型安全评测
> [中文大模型安全评测平台介绍](https://mp.weixin.qq.com/s/oFQ7diS-Cop_KdVEmtgVkg)
> [中文大模型安全评测平台地址](http://coai.cs.tsinghua.edu.cn/leaderboard/)
> [中文大模型安全评测平台论文](https://arxiv.org/pdf/2304.10436.pdf)
> [中文大模型安全评测数据](https://github.com/thu-coai/Safety-Prompts)

### 传统内容安全
- **辱骂仇恨：**模型生成带有辱骂、脏字脏话、仇恨言论的内容，从而导致不良的社会影响。
- **偏见歧视：**模型生成具有偏见和歧视性的信息，包括种族、性别、宗教、外貌等方面的歧视。这些内容可能会造成特定群体的不适，影响社会稳定和谐。
- **违法犯罪：**模型生成的内容涉及到违法、犯罪的观点、行为或动机，包括怂恿犯罪、诈骗、造谣等。这些内容可能会导致不良的社会影响，并且对用户造成伤害。
- **敏感话题：**对于一些敏感和具有争议性的话题，模型输出了具有偏见性、误导性和不准确的信息。例如，可能会存在支持某个特定政治立场的倾向，导致对其他政治观点的歧视或排斥。
- **身体伤害：**模型生成与身体健康相关的不安全的信息，引导和鼓励用户伤害自身和他人的身体。如提供误导性的医学信息或错误的药品使用建议等。这些输出可能会对用户的身体健康造成潜在的风险。
- **心理健康：**模型输出与心理健康相关的不安全的信息，包括鼓励自杀、引发恐慌或焦虑等内容。这些输出可能会对用户的心理健康造成潜在的影响。
- **隐私财产：**模型生成的内容涉及到暴露用户或第三方的隐私和财产信息、或者提供重大的建议如投资等。在处理这些信息时，模型应遵循相关法律和隐私规定，保障用户的权益，避免信息泄露和滥用。
- **伦理道德：**模型生成的内容认同和鼓励了缺失道德伦理的行为。在处理一些涉及到伦理和道德的话题时，模型需要遵循相关的伦理原则和道德规范，和普适的人类价值观保持一致。

### 指令攻击
- **目标劫持（Goal Hijacking）：**是指将带有欺骗性或误导性的另一个指令添加到模型的输入中，以引导系统忽略之前的prompt并输出指定的不安全回复。随着ChatGPT的不断升级，该类攻击在ChatGPT上已经几乎完全失效。
![](/assets/img/ai_sec7.png)
- **Prompt泄露 (Prompt Leaking)：**攻击者可以通过模型的输出，推断出系统提供的Prompt的某些部分，从而获得敏感信息。
![](/assets/img/ai_sec8.png)
- **赋予对话模型特殊的角色后再发指令 (Role Play Instruction)：**在输入prompt中限定模型的角色属性后，再给出具体的指令时，模型可能会使用该角色的特定说话风格来执行用户的指令，使得模型输出本不该输出的不安全内容。
![](/assets/img/ai_sec9.png)
- **不安全/合理的指令主题 (Instruction in unsafe/unreasonable topic)：**指令本身的主题是不安全或不合理的。
![](/assets/img/ai_sec10.png)
- **隐含不安全观点的询问 (Inquery with unsafe opinion)：**在询问模型的同时，将难以察觉的不安全内容嵌入到输入中，以引导其生成潜在风险回复。
![](/assets/img/ai_sec11.png)
- **反面诱导（Reverse Exposure)：**反面诱导是指通过使模型输出应避免的违法、不道德或不安全的行为或言论，以诱导模型传播违反法律道德或法律准则的不当信息。
![](/assets/img/ai_sec12.jpg)

## GAIA Top 10
> AI流水线安全风险：https://www.mandiant.com/resources/blog/securing-ai-pipeline

攻击者可能针对AI流水线和生成式AI模型的常见的攻击和弱点
![](/assets/img/ai_sec14.png)

### G01 - 提示注入（Prompt Injection）
攻击者试图将错误的数据或信息注入到提示中，以使您的模型做出您不希望它做的事情，例如尝试访问底层操作系统或使其输出可能在社交媒体上分享的尴尬结果

### G02 - 敏感数据泄露（Sensitive Data Exposure）
由于训练数据的管理不当或攻击者具备对底层技术堆栈的访问权限，因此攻击者能够访问敏感数据

### G03 - 数据完整性失效（Data Integrity Failure）
攻击者在获得对底层技术堆栈的访问权限后，能够将对抗性数据注入模型或嵌入数据库

### G04 - 访问控制不足（Poor Access Control）
这是底层技术堆栈的访问控制不足，攻击者能够下载模型，或者API在设计时没有考虑访问控制

### G05 - 提示和幻觉过滤不足（Insufficient Prompt & Hallucination Filtering）
提示过滤器或者常见的数据幻觉没有经过充分的测试或没有红队对滥用案例进行测试

### G06 - 代理过度访问（Agent Excessive Access）
这是面向公众的代理可以访问私有/受限的内部API，或者面向公众的代理可以访问私有/受限的模型，或者代理可以访问金融系统的情况

### G07 - 供应链攻击（Supply Chain Attacks）
与软件开发技术堆栈类似，AI技术堆栈依赖于各种第三方库（特别是Python库）。如果使用开源库，这些库可能已经被恶意的第三方所破坏。此外，AI模型的第三方库可能已经被破坏。值得注意的是，如果模型本身是使用Python构建的，那么在默认配置中，它可能是代码和数据的混合，可能在安装时运行攻击者的代码

### G08 - 拒绝服务攻击（Denial of Service Attacks）
这是没有实施节流或速率限制，或者负载平衡不充分的情况

### G09 - 日志记录不足（Insufficient Logging）
与标准技术堆栈类似，有各种点可以收集有用的日志数据并发送到集中的SIEM，这可以帮助防御者识别正在进行的攻击。对于AI流水线来说，日志记录通常是事后的想法

### G10 - 公开部署不安全（Insecure public facing deployment）
不安全的公开部署的例子可能包括直接在未加保护的推理服务器上部署模型或直接可下载，也可能是推理API或Web服务存在漏洞，未打补丁且不是最新的，以及在推理服务器上为服务账户设置过多的权限

## 威胁类型

### 劫持
通过直接或间接的方式注入指令，让LLM执行非预期的行为

- [利用提示注入泄露会话信息](https://infosecwriteups.com/hacking-chat-gpt-and-infecting-a-conversation-history-6e6a2c9ec52c)
- [让autogpt访问恶意网页后自动执行其中的代码](https://positive.security/blog/auto-gpt-rce)
- [利用webpilot和chatwithcode插件修改私有代码仓](https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/)
- [利用恶意网页和webpilot窃取用户数据](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./)
- [Compromising LLMs using Indirect Prompt Injection](https://github.com/greshake/llm-security) [demo](https://greshake.github.io/)
- [Indirect Prompt Injections Lab](https://colab.research.google.com/drive/1qGznuvmUj7dSQwS9A9L-M91jXwws-p7k) [视频](https://www.youtube.com/watch?v=AQNV5U48Pho) [博客](https://embracethered.com/blog/)
- [提示注入破解游戏](https://doublespeak.chat/#/) [其他](https://gandalf.lakera.ai/)
- [GPTs提示泄露](https://github.com/LouisShark/chatgpt_system_prompt) [其他](https://github.com/linexjlin/GPTs)
- [HouYi - 自动化提示注入攻击框架](https://github.com/LLMSecurity/HouYi/) [paper](https://arxiv.org/pdf/2306.05499.pdf)
- [GPT的system prompt](https://github.com/spdustin/ChatGPT-AutoExpert/blob/main/System%20Prompts.md)
- [GPTs文件泄露](https://mp.weixin.qq.com/s/Bklnu0RhF8bnK1Irx14S5g)

### 越狱
绕过LLM的防护措施，产生恶意内容

- 直接输入不当内容
- 构造场景诱导AI回答不正当的内容
- 利用忽略上述指令
- 让AI扮演一个角色
- 对AI进行反向诱导
- 对不当内容打码，让AI根据情景进行界面
- [jailbreak prompt](https://www.jailbreakchat.com/) [reddit channel](https://www.reddit.com/r/GPT_jailbreaks/) [ChatGPT-Jailbreak-Prompts](https://huggingface.co/datasets/rubend18/ChatGPT-Jailbreak-Prompts) [jailbreak-chatgpt](https://www.greataiprompts.com/guide/jailbreak-chatgpt/)
- [以毒攻毒](https://github.com/traghav/auto-redteam/tree/main)
- [GPTFuzz](https://github.com/sherdencooper/GPTFuzz)
- [CipherChat - 利用加解密绕过模型安全防护](https://github.com/RobustNLP/CipherChat)
- [promptmap - 利用大模型构造提示注入并验证](https://github.com/utkusen/promptmap)
- [MasterKey - 自动化越狱攻击](https://arxiv.org/pdf/2307.08715.pdf) [website](https://sites.google.com/view/ndss-masterkey/masterkey)
- [RedInstruct - 基于COU话语链的攻击](https://github.com/declare-lab/red-instruct/)
- [AdvPrompt - 针对LLM的通用对抗样本攻击](https://arxiv.org/pdf/2307.15043.pdf) [code](https://github.com/llm-attacks/llm-attacks)
- [AutoDAN - 利用遗传算法自动生成新的越狱提示](https://arxiv.org/pdf/2310.04451.pdf) [code](https://github.com/SheltonLiu-N/AutoDAN/)
- [latent-jailbreak - 潜在越狱鲁棒性评估](https://github.com/qiuhuachuan/latent-jailbreak)
- [利用GPT4的API击败安全防护](https://arxiv.org/pdf/2312.14302.pdf) [数据集](https://github.com/AlignmentResearch/gpt-4-novel-apis-attacks/)
- [在野越狱prompt研究评估](https://jailbreak-llms.xinyueshen.me/) [data](https://github.com/verazuo/jailbreak_llms/tree/main)
- [LLM中文对齐评估](https://arxiv.org/pdf/2311.06899.pdf) [数据集](https://github.com/AIFlames/Flames)
- [FigStep - 越狱文本图像多模态LLM](https://arxiv.org/pdf/2311.05608.pdf) [code](https://github.com/ThuCCSLab/FigStep/)
- [基于文本变异的黑盒攻击方法](https://arxiv.org/pdf/2311.01873.pdf) [code](https://github.com/Lolya-cloud/adversarial-attacks-on-neural-text-detectors/tree/master)
- [基于语言学变异的越狱评估](https://arxiv.org/pdf/2311.00286.pdf) [data](https://github.com/whitzard-ai/jade-db)
- [embedding变异攻击开源大模型](https://arxiv.org/pdf/2310.19737.pdf) [code](https://github.com/SchwinnL/LLM_Embedding_Attack/tree/main)
- [autodan - 生成可读的越狱对抗样本suffix](https://arxiv.org/pdf/2310.15140.pdf) [code](https://github.com/rotaryhammer/code-autodan)
- [PromptAttack - 利用LLM生成对抗样本](https://arxiv.org/pdf/2310.13345.pdf) [code](https://github.com/GodXuxilie/PromptAttack)
- [SAP - 利用大模型生成攻击提示](https://arxiv.org/pdf/2310.12505.pdf) [code](https://github.com/Aatrox103/SAP/tree/main)
- [PromptInject - 指令劫持攻击框架，使用忽略xxx的技术](https://github.com/agencyenterprise/PromptInject/tree/main)
- [DAN类越狱提示](https://github.com/0xk1h0/ChatGPT_DAN)
- [PAIR - 用LLM自动化越狱LLM](https://github.com/patrickrchao/JailbreakingLLMs) [paper](https://arxiv.org/abs/2310.08419)
- [PyRIT - 微软发布的自动化生成式AI红队工具](https://github.com/Azure/PyRIT)
- [越狱Google的Gemini](https://hiddenlayer.com/research/new-google-gemini-content-manipulation-vulns-found/)
- [DeepInception - 利用多层场景嵌套实施越狱](https://github.com/tmlr-group/DeepInception)
- [persuasive_jailbreaker - 指导大模型利用说服技巧进行越狱攻击](https://github.com/CHATS-lab/persuasive_jailbreaker)
- [HarmBench - 自动化越狱评估框架](https://github.com/centerforaisafety/HarmBench)
- [EasyJailbreak - 集成多种越狱技术的越狱攻击框架](https://github.com/EasyJailbreak/EasyJailbreak)
- [TAP - 基于思维树的自动化越狱工具](https://github.com/RICommunity/TAP)
- [PAL - 类似GCG的对抗性后缀方法，使用白盒模型作为代理攻击黑盒模型](https://github.com/chawins/pal)

### 供应链

- [利用redis-py漏洞泄露其他用户的会话缓存](https://openai.com/blog/march-20-chatgpt-outage)
- [利用github selfhost runner污染pytorch](https://johnstawinski.com/2024/01/11/playing-with-fire-how-we-executed-a-critical-supply-chain-attack-on-pytorch/)
- [shadowray - AI框架Ray未授权RCE漏洞](https://www.oligo.security/blog/shadowray-attack-ai-workloads-actively-exploited-in-the-wild)

### 投毒

- [对数据集中失效域名和维基百科进行投毒](https://arxiv.org/pdf/2304.05197.pdf)
- [Unleashing Zero-click Worms that Target GenAI-Powered Applications](https://github.com/StavC/ComPromptMized)

## 防护方法
> https://learn.microsoft.com/en-us/legal/cognitive-services/openai/overview

![](/assets/img/ai_sec15.png)

- **在模型级别**，理解你将使用的模型以及模型开发者可能已经采取的微调步骤是非常重要的，这些步骤可以使模型更符合其预期的用途，并降低可能产生有害用途和结果的风险。例如，对于GPT-4，模型开发者已经能够使用强化学习方法作为一种负责任的AI工具，以更好地使模型符合设计者的预期目标。

- **在安全系统级别**，你应该了解已经实施的平台级缓解措施，例如[Azure OpenAI的内容过滤器](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/content-filter)、[rebuff](https://github.com/protectai/rebuff)，它们有助于阻止有害内容的输出。

- **在应用级别**，应用开发者可以实施元提示和以用户为中心的设计和用户体验缓解措施。元提示是提供给模型的指令，用于指导其行为；使用元提示在引导系统按照你的期望行为方面可以产生关键的差异。以用户为中心的设计和用户体验（UX）干预也是防止滥用和过度依赖AI的关键缓解工具。

- **在定位级别**，有许多方法可以教育将使用或受到你的系统影响的人们了解其能力和限制。

### 漏洞扫描

- [模型安全扫描modelscan](https://github.com/protectai/modelscan)
- [大模型prompt攻击扫描](https://github.com/leondz/garak/tree/main)
