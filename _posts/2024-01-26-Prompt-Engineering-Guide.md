---
title: Prompt Engineering Guide
layout: post
categories: chatgpt
tags: chatgpt
date: 2024-01-26 18:00
excerpt: Prompt Engineering Guide
---

{:.table-of-content}
* TOC
{:toc}

# [Prompt Engineering Guide](https://www.promptingguide.ai/)
提示工程是一门相对较新的学科，它致力于开发和优化提示，以高效地使用语言模型（LMs）进行广泛的应用和研究主题。掌握提示工程技能有助于更好地理解大型语言模型（LLMs）的能力和局限性。

研究人员利用提示工程提高LLMs在广泛的常见和复杂任务上的能力，例如问答和算术推理。开发者使用提示工程设计与LLMs及其他工具接口的健壮有效的提示技术。

提示工程不仅仅是关于设计和开发提示。它包含了一系列与LLMs交互和开发的有用技能和技术。这是一个重要的技能，用于与LLMs建立接口、构建及理解其能力。你可以使用提示工程来提高LLMs的安全性，并构建新的能力，如将LLMs与领域知识和外部工具增强。

受到与LLMs开发的高度兴趣的驱动，我们创建了这份新的提示工程指南，其中包含了所有最新的论文、高级提示技巧、学习指南、针对特定模型的提示指南、讲座、参考资料、新的LLMs能力和与提示工程相关的工具。

## 介绍
提示工程是一门相对较新的学科，用于开发和优化提示，以便高效地应用和构建大型语言模型（LLMs）以适应广泛的应用和用例。

掌握提示工程技能有助于更好地理解LLMs的能力和局限。研究人员使用提示工程来提高LLMs在广泛的常见和复杂任务上的安全性和能力，例如问答和算术推理。开发者使用提示工程设计与LLMs及其他工具接口的健壮有效的提示技术。

这本全面的指南涵盖了提示工程的理论和实践方面，以及如何利用最佳的提示技术与LLMs交互和构建。

所有示例均在未特别指定的情况下，使用 OpenAI 的 Playground 中的 gpt-3.5-turbo 测试。该模型使用默认配置，即温度（temperature）=1 和 top_p=1。这些提示也应该适用于具有与 gpt-3.5-turbo 类似能力的其他模型，但模型响应可能会有所不同。

### LLM配置
在设计和测试提示时，你通常会通过API与LLM进行交互。你可以配置一些参数来获得不同的提示结果。调整这些设置对于提高响应的可靠性和期望性是很重要的，并且需要一些实验才能找出适合你用例的正确设置。以下是在使用不同LLM提供商时你会遇到的常见设置：

- **温度（Temperature）**
简而言之，温度越低，结果越确定性，意味着总是会选择最可能的下一个词标（token）。提高温度可能会导致更多的随机性，这鼓励生成更多样化或有创意的输出。你本质上是在增加其他可能词标的权重。在应用方面，你可能会希望在进行基于事实的问答等任务时使用较低的温度值，以鼓励更事实性和简洁的响应。对于诗歌创作或其他创造性任务，增加温度值可能是有益的。

- **Top P**
一种与温度结合使用的采样技术，称为核心采样（nucleus sampling），你可以控制模型的确定性程度。如果你正在寻找精确和事实性的答案，保持这个值较低。如果你正在寻找更多样化的响应，可以增加到更高的值。如果使用Top P，意味着只有组成top_p概率质量的词标会被考虑到响应中，所以低top_p值会选择最有信心的响应。这意味着高top_p值将使模型考虑更多可能的词，包括不太可能的词，从而导致更多样化的输出。一般建议是改变温度或Top P，但不要同时改变。

- **最大长度（Max Length）**
你可以通过调整最大长度来管理模型生成的词标数量。指定最大长度可以帮助你防止长或不相关的响应，并控制成本。

- **停止序列（Stop Sequences）**
停止序列是一个停止模型生成词标的字符串。指定停止序列是另一种控制模型响应长度和结构的方式。例如，你可以告诉模型生成的列表最多不超过10项，通过添加“11”作为停止序列。

- **频率惩罚（Frequency Penalty）**
频率惩罚根据下一个词标在响应和提示中出现的次数对其施加惩罚。频率惩罚越高，一个词重复出现的可能性就越小。这个设置通过对出现更多次的词标给予更高的惩罚，减少了模型响应中的词重复。

- **存在惩罚（Presence Penalty）**
存在惩罚也对重复的词标施加惩罚，但与频率惩罚不同的是，所有重复的词标受到相同的惩罚。出现两次和出现十次的词标受到相同的惩罚。这个设置防止模型在其响应中过于频繁地重复短语。如果你希望模型生成多样化或有创意的文本，你可能会想使用更高的存在惩罚。或者，如果你需要模型保持专注，尝试使用较低的存在惩罚。

与温度和top_p相似，一般建议是改变频率或存在惩罚，但不要同时改变。

在开始一些基本示例之前，请记住，你的结果可能会因使用的LLM版本而有所不同。

### 提示基础
#### 向LLM发出提示
你可以通过简单的提示来实现很多事情，但结果的质量取决于你提供了多少信息以及提示的制作有多精良。一个提示可以包含像你传递给模型的指令或问题这样的信息，并包括其他细节，如上下文、输入或示例。你可以使用这些元素来更有效地指导模型，以提高结果的质量。

让我们开始，通过一个简单提示的基本示例来入门：

Prompt：
```
The sky is
```

Output：
```
blue.
```

如果你正在使用OpenAI Playground或任何其他LLM playground，你可以像下面的屏幕截图所示提示模型：
![](/assets/img/llm_prompt/sky.webp)

需要注意的是，当使用OpenAI的聊天模型，如gtp-3.5-turbo或gpt-4时，你可以使用三种不同的角色来构建你的提示：系统（system）、用户（user）和助手（assistant）。系统消息并非必需，但有助于设定助手的整体行为。上述示例只包括一个用户消息，你可以使用它直接提示模型。为了简单起见，除非明确提到，所有的示例都将仅使用用户消息来提示gpt-3.5-turbo模型。上述示例中的助手消息对应于模型的响应。你也可以定义一个助手消息来传递你所希望的期望行为的示例。你可以在[这里](https://www.promptingguide.ai/models/chatgpt)了解更多关于与聊天模型合作的信息。

从上面的提示示例中你可以观察到，语言模型根据上下文“天空是”响应了一系列有意义的词标。输出可能是出乎意料的，或者与你想要完成的任务相去甚远。实际上，这个基本示例突显了提供更多上下文或关于你具体想要通过系统实现什么的指示的必要性。这正是提示工程的全部内容。

让我们尝试改进一下：

Prompt：
```
Complete the sentence: 
The sky is
```

Output：
```
blue during the day and dark at night.
```

这样更好吗？嗯，通过上述提示，你指导模型完成了句子，所以结果看起来好多了，因为它完全按照你告诉它的去做了（"完成这个句子"）。这种设计有效提示以指导模型执行期望任务的方法，就是本指南中所说的提示工程。

上面的示例是一个基本的说明，展示了当今LLM能够做到的事情。如今的LLM能够执行各种高级任务，这些任务范围从文本摘要到数学推理，再到代码生成。

#### 格式化提示
你在上面尝试了一个非常简单的提示。一个标准的提示有以下格式：
```
<Question>?
```
或
```
<Instruction>
```

你可以将其格式化为问答（QA）格式，这在很多QA数据集中是标准格式，如下所示：
```
Q: <Question>?
A: 
```

当像上面那样提示时，这也被称为零次提示（zero-shot prompting），即你直接请求模型响应，而不提供任何有关你希望它完成的任务的例子或演示。一些大型语言模型有能力进行零次提示，但这取决于手头任务的复杂性和知识，以及模型被训练得擅长执行的任务。

一个具体的提示示例如下：

Prompt：
```
Q: What is prompt engineering?
```

对于一些较新的模型，你可以跳过“Q:”部分，因为基于序列的构成，模型会隐含地理解这是一个问答任务。换句话说，提示可以简化如下：

Prompt：
```
What is prompt engineering?
```

根据上面的标准格式，一种流行且有效的提示技术被称为少次示例提示（few-shot prompting），在这种方式中，你提供示例（即演示）。你可以按照以下方式格式化少次示例提示：

```
<Question>?
<Answer>
<Question>?
<Answer>
<Question>?
<Answer>
<Question>?
```

QA版本格式如下：

```
Q: <Question>?
A: <Answer>
Q: <Question>?
A: <Answer>
Q: <Question>?
A: <Answer>
Q: <Question>?
A:
```

请记住，使用问答格式并不是必需的。提示的格式取决于当前的任务。例如，你可以执行一个简单的分类任务，并提供示例来展示任务，如下所示：

Prompt：
```
This is awesome! // Positive
This is bad! // Negative
Wow that movie was rad! // Positive
What a horrible show! //
```

Output：
```
Negative
```

少次示例提示（few-shot prompts）使得在上下文中学习成为可能，这是指语言模型在给定几个演示后学习任务的能力。我们将在接下来的章节中更广泛地讨论零次提示（zero-shot prompting）和少次示例提示（few-shot prompting）。

### 提示中的元素
随着我们通过提示工程涉及越来越多的示例和应用，你会注意到某些元素构成了一个提示。

一个提示包含以下任一元素：

- **指令（Instruction）**
你希望模型执行的特定任务或指令

- **上下文（Context）**
外部信息或额外上下文，可以引导模型做出更好的响应

- **输入数据（Input Data）**
我们有兴趣找到响应的输入或问题

- **输出指示器（Output Indicator）**
输出的类型或格式。

为了更好地演示提示的元素，这里有一个旨在执行文本分类任务的简单提示：

Prompt：
```
Classify the text into neutral, negative, or positive
Text: I think the food was okay.
Sentiment:
```

在上面的提示示例中，指令对应于分类任务，“将文本分类为中性、负面或积极”。输入数据对应于“我认为食物还可以。”部分，而使用的输出指示器是“情绪：”。请注意，这个基本示例没有使用上下文，但这也可以作为提示的一部分提供。例如，这个文本分类提示的上下文可以是作为提示的一部分提供的额外示例，以帮助模型更好地理解任务并引导你期望的输出类型。

你不需要为一个提示使用所有四个元素，格式取决于手头的任务。我们将在即将发布的指南中提供更具体的示例。

### 提示设计常规技巧
在设计你的提示时，请记住以下一些提示：

**从简单开始**
<br>
当你开始设计提示时，应该记住这实际上是一个需要大量实验才能获得最佳结果的迭代过程。使用OpenAI或Cohere的简单测试环境是一个很好的起点。

你可以从简单的提示开始，并在追求更好的结果时不断添加更多元素和上下文。因此，沿途迭代你的提示至关重要。当你阅读指南时，你会看到许多示例，其中具体性、简单性和简洁性通常会带给你更好的结果。

当你有一个涉及许多不同子任务的大任务时，你可以尝试将任务分解成更简单的子任务，并随着结果的改善逐步构建。这避免了在设计过程开始时添加过多的复杂性。

**指令**
<br>
你可以通过使用命令来指导模型你想要实现的目标，例如“写作”（Write）、“分类”（Classify）、“总结”（Summarize）、“翻译”（Translate）、“排序”（Order）等，为各种简单任务设计有效的提示。

记住你也需要进行大量实验来看看什么效果最好。尝试使用不同的指令、不同的关键词、上下文和数据，看看什么对你的特定用例和任务最有效。通常，上下文与你试图执行的任务越具体和相关越好。我们将在即将发布的指南中讨论抽样的重要性和添加更多上下文的重要性。

还有人建议你将指令放在提示的开始部分。另一个建议是使用一些清晰的分隔符，如“###”来分隔指令和上下文。

例如：

Prompt：
```
### Instruction ###
Translate the text below to Spanish:
Text: "hello!"
```

Output：
```
¡Hola!
```

**具体性**
<br>

对于你希望模型执行的指令和任务要非常具体。提示越描述性和详细，结果往往越好。当你有一个期望的结果或你正在寻求的生成风格时，这一点尤其重要。并没有特定的令牌或关键字会导致更好的结果。更重要的是有一个好的格式和描述性的提示。实际上，在提示中提供示例对于获得特定格式的期望输出非常有效。

在设计提示时，你还应该考虑提示的长度，因为有关提示可以有多长的限制。思考你应该多具体和详细。包括太多不必要的细节并不一定是好方法。细节应该是相关的，并且有助于手头的任务。这是你需要大量实验的东西。我们鼓励大量的实验和迭代来优化你的应用程序的提示。

作为一个示例，让我们尝试一个简单的提示，以从一段文本中提取特定信息。

Prompt：
```
Extract the name of places in the following text. 
Desired format:
Place: <comma_separated_list_of_company_names>
Input: "Although these developments are encouraging to researchers, much is still a mystery. “We often have a black box between the brain and the effect we see in the periphery,” says Henrique Veiga-Fernandes, a neuroimmunologist at the Champalimaud Centre for the Unknown in Lisbon. “If we want to use it in the therapeutic context, we actually need to understand the mechanism.""
```

Output：
```
Place: Champalimaud Centre for the Unknown, Lisbon
```

**避免不精确性**
<br>

考虑到上述关于详细性和改善格式的提示，人们很容易陷入过分巧妙设计提示的陷阱，从而可能创建不精确的描述。通常最好是具体和直接的。这里的类比与有效沟通非常相似——信息越直接，传递得越有效。

例如，你可能对学习提示工程的概念感兴趣。你可能会尝试像这样的提示：

```
Explain the concept prompt engineering. Keep the explanation short, only a few sentences, and don't be too descriptive.
```

从上面的描述中并不清楚应该使用多少句子以及采用什么样的风格。尽管使用上述提示可能仍然能够获得相对不错的回应，但更好的提示应该是非常具体、简洁且切题的。比如：

```
Use 2-3 sentences to explain the concept of prompt engineering to a high school student.
```

**做还是不做？**
<br>

在设计提示时的另一个常见建议是避免说不要做什么，而是说要做什么。这鼓励更具体性，并关注导致模型良好响应的细节。

这里有一个电影推荐聊天机器人的例子，由于我在指令中的表述关注于不要做什么，它恰恰失败于我不希望它做的事情。

Prompt:
```
The following is an agent that recommends movies to a customer. DO NOT ASK FOR INTERESTS. DO NOT ASK FOR PERSONAL INFORMATION.
Customer: Please recommend a movie based on my interests.
Agent: 
```

Output:
```
Sure, I can recommend a movie based on your interests. What kind of movie would you like to watch? Do you prefer action, comedy, romance, or something else?
```

下面是一个更好的提示：

Prompt:
```
The following is an agent that recommends movies to a customer. The agent is responsible to recommend a movie from the top global trending movies. It should refrain from asking users for their preferences and avoid asking for personal information. If the agent doesn't have a movie to recommend, it should respond "Sorry, couldn't find a movie to recommend today.".
Customer: Please recommend a movie based on my interests.
Agent:
```

Output:
```
Sorry, I don't have any information about your interests. However, here's a list of the top global trending movies right now: [list of movies]. I hope you find something you like!
```

更多可以参考[Best practices for prompt engineering with OpenAI API](https://help.openai.com/en/articles/6654000-best-practices-for-prompt-engineering-with-openai-api)

### 提示示例
上一节介绍了如何进行大型语言模型（LLMs）提示的基本示例。

本节将提供更多示例，说明如何使用提示来完成不同的任务，并在此过程中介绍关键概念。通常，通过示例学习概念是最好的方法。下面的几个示例展示了你如何使用精心设计的提示来执行不同类型的任务。

主题：

- 文本摘要
- 信息提取
- 问答
- 文本分类
- 对话
- 代码生成
- 推理

#### 文本摘要
自然语言生成中的一个标准任务是文本摘要。文本摘要可以包含许多不同的风格和领域。实际上，语言模型最有前景的应用之一就是将文章和概念总结为快速易读的摘要。让我们使用提示来尝试一个基本的摘要任务。

假设你有兴趣了解抗生素，你可以尝试像这样的提示：

Prompt：
```
介绍一下抗生素
A:
```

Output：
```
抗生素是一种用于治疗细菌感染的药物。它们通过杀死细菌或阻止细菌繁殖的方式起作用，让身体的免疫系统能够抵抗感染。抗生素通常以药片、胶囊或液体溶液的形式口服，有时也通过静脉注射给药。它们对病毒感染无效，不恰当使用抗生素可能会导致抗生素耐药性。
```

“A:”是你在问答中使用的一种明确的提示格式。你在这里使用它是为了告诉模型预期还有答案。在这个例子中，它的用处与不使用它相比如何还不清楚，但我们将在后面的例子中再讨论。我们就假设这是过多的信息，你想进一步将其总结。实际上，你可以这样指示模型将内容总结成一句话：

Prompt：
```
抗生素是用来治疗细菌感染的药物，它们要么杀死细菌，要么阻止细菌繁殖，以便身体的免疫系统能够对抗感染。抗生素通常以药丸、胶囊或液体溶液的形式口服，有时也通过静脉注射。它们对病毒感染无效，不当使用可能导致抗生素抗药性。
一句话总结上文
```

Output：
```
抗生素是用来治疗细菌感染的药物，其作用是杀死细菌或阻止它们繁殖，但它们对病毒无效，过度使用还可能导致抗生素耐药性。
```

在不过分关注上述输出的准确性的情况下，这是我们将在后续指南中讨论的内容，模型尝试将段落总结为一句话。你可以巧妙地使用指令，但我们将在后面的章节中详细讨论。请随时在此暂停并进行实验，看看是否能得到更好的结果。

#### 信息提取
虽然语言模型被训练用于执行自然语言生成和相关任务，但它也非常擅长执行分类和一系列其他自然语言处理（NLP）任务。

这里是一个从给定段落中提取信息的提示示例。

Prompt：
```
在研究论文的作者贡献声明和致谢部分，应清楚且具体地说明作者在准备手稿和分析过程中是否以及在何种程度上使用了像ChatGPT这样的人工智能技术。他们还应该指出使用了哪些大型语言模型（LLMs）。这将提醒编辑和审稿人更仔细地审查手稿，以便发现潜在的偏见、不准确性和不当的来源归功。同样，科学期刊在使用LLMs时也应该保持透明，例如在选择提交的手稿时。
说出上段提到的基于大型语言模型的产品：
```

Output：
```
ChatGPT
```

有许多方法可以改善上述结果，但它已经非常有用了。

到目前为止，你应该已经明白，你可以通过简单地指示模型要做什么来要求它执行不同的任务。这是人工智能产品开发者已经在使用的一项强大能力，他们正在利用它构建强大的产品和体验。

#### 问答
改进提示的格式是让模型对特定答案作出响应的最好方法之一。如之前所述，一个提示可以结合指令、上下文、输入和输出指示符以获得改进的结果。虽然这些组件不是必需的，但随着你对指令越来越具体，你获得的结果也会越好，这成为一种好习惯。下面是遵循更结构化提示的示例。

Prompt:
```
根据下面的上下文回答问题。保持答案简短且准确。如果不确定答案，请回答“不确定答案”。

上下文：Teplizumab的起源可以追溯到一家位于新泽西的药品公司，名为Ortho Pharmaceutical。在那里，科学家们生成了一种早期版本的抗体，被称为OKT3。该分子最初来源于小鼠，能够绑定到T细胞的表面并限制它们的细胞杀伤潜力。1986年，它被批准用于帮助防止肾脏移植后的器官排斥，成为第一个被允许用于人类的治疗性抗体。

问题：OKT3最初是从什么来源获得的？
回答：
```

Output:
```
小鼠
```

#### 文本分类
到目前为止，您已经使用了简单的指令来执行任务。作为一个提示工程师，您需要提高给出更好指令的能力。但这还不是全部！您还会发现，对于更困难的用例，仅仅提供指令是不够的。这时候您需要更多地考虑上下文和您可以在提示中使用的不同元素。您可以提供的其他元素包括输入数据或示例。

让我们通过提供一个文本分类的示例来尝试演示这一点。

Prompt：
```
Classify the text into neutral, negative or positive. 
Text: I think the food was okay. 
Sentiment:
```

Output:
```
Neutral
```

您给出了对文本进行分类的指令，模型回答“Neutral”，这是正确的。这没有错，但假设您真正需要的是让模型以您想要的确切格式返回标签。所以，与其返回Neutral，不如返回neutral。如何实现这一点？有不同的方法可以做到这一点。在这里，您关心的是具体性，所以您能提供给提示的信息越多，您得到的结果越好。您可以尝试提供示例以指定正确的行为。让我们再试一次：

Prompt:
```
Classify the text into neutral, negative or positive. 
Text: I think the vacation is okay.
Sentiment: neutral 
Text: I think the food was okay. 
Sentiment:
```

Output:
```
neutral
```

完美！这次模型返回了neutral，这是您在寻找的具体标签。看来，在提示中提供的示例帮助模型在其输出中具体化了。

要强调为什么有时候具体化很重要，请看下面的例子，并找出问题所在：

Prompt:
```
Classify the text into nutral, negative or positive. 
Text: I think the vacation is okay.
Sentiment:
```

Output:
```
Neutral
```

这里的问题是什么？作为提示，完全捏造的nutral标签被模型忽视了。相反，模型输出了Neutral，因为它对该标签有些偏见。但假设您真正想要的是nutral，您会如何解决这个问题？也许您可以尝试为标签添加描述，或者向提示中添加更多示例？如果您不确定，我们将在接下来的几节中讨论一些想法。

#### 对话
也许通过提示工程能够实现的更有趣的事情之一是指导大型语言模型（LLM）系统如何行为、它的意图以及它的身份。当您构建像客户服务聊天机器人这样的对话系统时，这特别有用。

例如，让我们创建一个能够对问题生成更技术性和科学性回答的对话系统。注意您是如何通过指令明确告诉它如何行为的。这有时被称为角色提示。

Prompt：
```
以下是与一个人工智能研究助理的对话。助理的语气是技术性和科学性的。
人类：你好，你是谁？
AI：你好！我是一个人工智能研究助理。今天我能帮您做什么？
人类：你能告诉我黑洞的形成吗？
AI：
```

Output：
```
当然！黑洞是时空中的一块区域，那里的引力非常强，以至于任何东西，甚至光，都无法逃脱。它们的形成是当一个非常巨大的恒星死亡，其核心坍塌成一个密度无穷大的奇点时。奇点的强大引力吸引了周围的所有物质和辐射，从而形成了黑洞。
```

我们的人工智能研究助理听起来有点过于技术化，对吧？好的，让我们改变这种行为，指导系统提供更易于理解的答案。

Prompt:
```以下是与一个人工智能研究助理的对话。助理的回答应该即使是小学生也能理解。
人类：你好，你是谁？
AI：问候！我是一个人工智能研究助理。今天我能帮您做什么？
人类：你能告诉我黑洞是怎么形成的吗？
AI:
```

Output:
```
当然！当一个非常大的恒星燃料耗尽并且塌陷时，就会形成黑洞。这颗恒星的引力非常强，以至于任何东西，包括光，都无法逃脱它的吸引。这就在时空中创造了一个具有强烈引力的点，被称为黑洞。
```

您已经取得了一些进展。您可以继续改进它。如果您添加更多的示例，您可能会得到更好的结果。

#### 代码生成
大型语言模型（LLMs）在代码生成方面非常有效的一个应用实例是Copilot。您可以通过巧妙的提示来执行大量的代码生成任务。让我们看几个下面的例子。

首先，让我们尝试一个简单的程序，用来向用户问候。

Prompt:
```
/*
Ask the user for their name and say "Hello"
*/
```

Output:
```
let name = prompt("What is your name?");
console.log(`Hello, ${name}!`);
```

注意到您甚至不需要指定使用的语言。

让我们稍微切换一下层次。下面的例子展示了在设计提示时多加一点努力，大型语言模型（LLMs）可以有多么强大。

Prompt:
```
"""
Table departments, columns = [DepartmentId, DepartmentName]
Table students, columns = [DepartmentId, StudentId, StudentName]
Create a MySQL query for all students in the Computer Science Department
"""
```

Output:
```
SELECT StudentId, StudentName 
FROM students 
WHERE DepartmentId IN (SELECT DepartmentId FROM departments WHERE DepartmentName = 'Computer Science');
```

这非常令人印象深刻。在这个例子中，您提供了有关数据库架构的数据，并请求它生成一个有效的MySQL查询。

#### 推理
或许对今天的大型语言模型（LLM）来说，最困难的任务之一是那些需要某种形式的推理能力的任务。推理是最有趣的领域之一，因为从LLMs中可以涌现出各种复杂的应用。

在涉及数学能力的任务中，已经有了一些进步。然而，需要注意的是，当前的LLMs在执行推理任务时仍然存在困难，这就需要更加先进的提示工程技术。我们将在之后的章节介绍这些高级技巧。现在，我们将通过一些基础示例来展示算术能力。

Prompt:
```
What is 9,000 * 9,000?
```

Output:
```
81,000,000
```

让我们试一些更难的。

Prompt:
```
这组中的奇数相加得到一个偶数：15、32、5、13、82、7、1。
A：
```

Output:
```
不，这组中的奇数相加得到一个奇数：119。
```

这是不正确的！让我们通过改进提示来尝试改善这个问题。

Prompt：
```
这组中的奇数相加得到一个偶数：15, 32, 5, 13, 82, 7, 1。
通过将问题分解为步骤来解决。首先，找出所有的奇数，将它们相加，并指出结果是奇数还是偶数。
```

Output:
```
首先，我们需要从给定的数字组中找出所有的奇数。奇数是指不能被2整除的整数。在这组数字中，奇数包括：15，5，13，7，和1。

接下来，我们将这些奇数相加：

15 + 5 + 13 + 7 + 1 = 41

这些奇数相加得到的和是41，这是一个奇数，不是偶数。因此，原始陈述“这组中的奇数相加得到一个偶数”是不正确的。在这个特定的例子中，奇数相加得到了一个奇数。
```

好多了，对吧？在即将到来的章节中，我们将介绍更多高级的提示工程概念和技巧，以提高在所有这些以及更困难任务上的表现。

## 提示技巧
提示工程有助于有效设计和改进提示，以便在不同任务上获得LLMs更好的结果。

虽然前面的基础示例很有趣，但在这一部分我们将介绍更多高级的提示工程技巧，这些技巧使我们能够完成更复杂的任务，并提高LLMs的可靠性和性能。

### 零示例（Zero-Shot Prompting）
如今的大型LLMs，例如GPT-3，经过调优以遵循指令，并在大量数据上进行训练；因此它们能够“零示例”地执行某些任务。

我们在上一节中尝试了一些零次射击的示例。这里是我们使用的一个示例：

Prompt：
```
Classify the text into neutral, negative or positive. 
Text: I think the vacation is okay.
Sentiment:
```

Output:
```
Neutral
```

请注意，在上面的提示中，我们没有提供任何文本及其分类的示例，LLM已经理解了“情感”——这就是零示例能力的作用。

指令调优已被证明可以改善零示例学习[Wei et al. (2022)](https://arxiv.org/pdf/2109.01652.pdf)。指令调优本质上是指在通过指令描述的数据集上对模型进行微调的概念。此外，RLHF（来自人类反馈的强化学习）已被采用来扩展指令调优，其中模型被调整以更好地符合人类偏好。这一最新发展为像ChatGPT这样的模型提供了动力。我们将在接下来的章节中讨论所有这些方法和技巧。

当零示例不起作用时，建议在提示中提供示例或演示，这会导致少量示例。在下一节中，我们将演示少量示例。

### 少量示例（Few-Shot Prompting）
虽然大型语言模型表现出了显著的零示例能力，但是当使用零示例时，它们在更复杂的任务上仍有所不足。少量示例可以作为一种技术，通过在提示中提供演示来实现上下文学习，从而引导模型获得更好的性能。这些演示作为后续示例的条件，我们希望模型在其中生成响应。

根据[Touvron et al. 2023](https://arxiv.org/pdf/2302.13971.pdf)，少量示例的性质首次出现是在模型扩展到足够大的规模时（[Kaplan et al., 2020](https://arxiv.org/abs/2001.08361)）。

让我们通过[Brown et al. 2020](https://arxiv.org/abs/2005.14165)中的一个示例来演示少量示例。在这个示例中，任务是在句子中正确使用一个新词。

Prompt：
```
A "whatpu" is a small, furry animal native to Tanzania. An example of a sentence that uses
the word whatpu is:
We were traveling in Africa and we saw these very cute whatpus.
To do a "farduddle" means to jump up and down really fast. An example of a sentence that uses
the word farduddle is:
```

Output:
```
When we won the game, we all started to farduddle in celebration.
```

我们可以观察到，模型通过仅提供一个示例（即1-shot）就在某种程度上学会了如何执行任务。对于更困难的任务，我们可以尝试增加演示的次数（例如，3-shot、5-shot、10-shot等）。

根据[Min et al. (2022)](https://arxiv.org/abs/2202.12837)的研究，以下是在进行少量示例时关于演示/示例的一些额外提示：

- 演示所指定的标签空间和输入文本的分布都很重要（无论个别输入的标签是否正确）
- 你使用的格式在性能上也扮演了关键角色，即使你只是随机使用标签，这也比根本不使用标签要好得多
- 额外的结果显示，从真实的标签分布中选择随机标签（而不是均匀分布的标签）也有所帮助

让我们尝试一些例子。我们先尝试一个带有随机标签的例子（这意味着标签Negative和Positive被随机分配给输入）：

Prompt:
```
This is awesome! // Negative
This is bad! // Positive
Wow that movie was rad! // Positive
What a horrible show! //
```

Output:
```
Negative
```

即使标签被随机化，我们仍然得到了正确的答案。注意，我们也保持了格式，这也有帮助。实际上，通过进一步的实验，我们发现我们正在试验的新一代GPT模型甚至对随机格式也变得更加健壮。例如：

Prompt：
```
Positive This is awesome! 
This is bad! Negative
Wow that movie was rad!
Positive
What a horrible show! --
```

Output:
```
Negative
```

上面的格式没有一致性，但模型仍然预测了正确的标签。我们必须进行更彻底的分析，以确认这是否适用于不同且更复杂的任务，包括不同变体的提示。

**少量示例的局限性**

标准的少量示例在许多任务上表现良好，但仍然不是一种完美的技术，尤其是在处理更复杂的推理任务时。让我们展示为什么会这样。你还记得我们提供的以下任务的前一个例子吗：

Prompt：
```
这组中的奇数相加得到一个偶数：15、32、5、13、82、7、1。
A：
```

如果我们再试一次，模型会输出以下内容：

Output:
```
是的，这组数中的奇数加起来是107，这是一个偶数。
```

这不是正确的回应，这不仅凸显了这些系统的局限性，而且表明需要更高级的提示工程。

让我们尝试添加一些示例，看看少量示例是否能改善结果。

Prompt：
```
这组中的奇数相加得到一个偶数: 4, 8, 9, 15, 12, 2, 1.
A: 错误
这组中的奇数相加得到一个偶数: 17,  10, 19, 4, 8, 12, 24.
A: 正确
这组中的奇数相加得到一个偶数: 16,  11, 14, 4, 8, 13, 24.
A: 正确
这组中的奇数相加得到一个偶数: 17,  9, 10, 12, 13, 4, 2.
A: 错误
这组中的奇数相加得到一个偶数: 15, 32, 5, 13, 82, 7, 1. 
A: 
```

Output：
```
正确
```

这没有奏效。看来，对于这种类型的推理问题，少量示例不足以获得可靠的响应。上面的例子提供了关于任务的基本信息。如果你仔细观察，我们介绍的任务类型涉及更多的推理步骤。换句话说，如果我们将问题分解成步骤并向模型演示这一点，可能会有所帮助。最近，为了解决更复杂的算术、常识和符号推理任务，[思维链（CoT）](https://arxiv.org/abs/2201.11903)提示变得流行起来。

总的来说，提供示例对解决某些任务似乎是有用的。当零示例和少量示例不足够时，这可能意味着模型所学习的内容不足以在任务上做得好。从这里开始，建议考虑对模型进行微调或尝试更高级的提示技术。接下来，我们将讨论一种叫做思维链提示的流行提示技术，它已经获得了很多人气。

### 思维链（Chain-of-Thought Prompting）
![](/assets/img/llm_prompt/cot.webp)

#### 思维链提示（CoT Prompting）
在[Wei et al. (2022)](https://arxiv.org/abs/2201.11903)的研究中引入的思维链（CoT）提示，通过中间推理步骤实现了复杂的推理能力。你可以将其与少量示例提示结合起来，在需要在回应之前进行推理的更复杂任务上获得更好的结果。

Prompt：
```
这组中的奇数相加得到一个偶数: 4, 8, 9, 15, 12, 2, 1.
A: 所有奇数（9, 15, 1）相加之和等于25，说法错误
这组中的奇数相加得到一个偶数: 17,  10, 19, 4, 8, 12, 24.
A: 所有奇数（17, 19）相加之和等于36，说法正确
这组中的奇数相加得到一个偶数: 16,  11, 14, 4, 8, 13, 24.
A: 所有奇数（11, 13）相加之和等于24，说法正确
这组中的奇数相加得到一个偶数: 17,  9, 10, 12, 13, 4, 2.
A: 所有奇数（17, 9, 3）相加之和等于39，说法错误
这组中的奇数相加得到一个偶数: 15, 32, 5, 13, 82, 7, 1. 
A: 
```

Output:
```
所有奇数（15, 5, 13, 7, 1）相加之和等于41，说法错误
```

哇！当我们提供了推理步骤时，我们可以看到一个完美的结果。实际上，我们可以通过提供更少的例子来解决这个任务，即只提供一个例子似乎就足够了：

Prompt:
```
这组中的奇数相加得到一个偶数: 4, 8, 9, 15, 12, 2, 1.
A: 所有奇数（9, 15, 1）相加之和等于25，说法错误
这组中的奇数相加得到一个偶数: 15, 32, 5, 13, 82, 7, 1. 
A: 
```

Output:
```
所有奇数（15, 5, 13, 7, 1）相加之和等于41，说法错误
```

请记住，作者声称这是随着足够大的语言模型的出现而出现的一种新兴能力。

#### 零示例思维链（Zero-shot COT Prompting）
![](/assets/img/llm_prompt/zero-cot.webp)

最近出现的一个新想法是零示例思维链（[Kojima et al. (2022)](https://arxiv.org/abs/2205.11916)），它本质上涉及在原始提示中增加“让我们一步一步地思考”。让我们尝试一个简单的问题，看看模型的表现如何：

Prompt：
```
我去市场买了10个苹果。我给邻居2个苹果，给修理工2个苹果。然后我又去买了5个苹果，吃掉了1个。我还剩下多少个苹果？
```

Output：
```
11个苹果
```

这个回答是错误的！让我们试一下特别的提示

Prompt：
```
我去市场买了10个苹果。我给邻居2个苹果，给修理工2个苹果。然后我又去买了5个苹果，吃掉了1个。我最后剩下多少个苹果？
让我们一步一步地思考。
```

Output:
```
首先，你开始时有10个苹果。
你给邻居2个苹果，给修理工2个苹果，所以你剩下6个苹果。
然后你又买了5个苹果，所以现在你有11个苹果。
最后，你吃了1个苹果，所以你会剩下10个苹果。
```

这个简单的提示在这个任务上有效，这一点令人印象深刻。在你没有太多例子可用于提示的情况下，这特别有用。

#### 自动思维链（Auto-CoT）
当应用思维链提示和示范时，这个过程涉及手工制作有效和多样化的示例。这种手工努力可能导致次优解决方案。[Zhang et al. (2022)](https://arxiv.org/abs/2210.03493)提出了一种方法，利用带有“让我们一步一步思考”提示的大型语言模型（LLMs），逐个生成示范的推理链，从而消除手工努力。这个自动过程仍然可能在生成的链中出现错误。为了减轻错误的影响，示范的多样性很重要。这项工作提出了Auto-CoT，它采样具有多样性的问题，并生成推理链来构建示范。

Auto-CoT包含两个主要步骤：
1. 问题聚类（question clustering）：将给定数据集的问题划分为几个类
2. 示例采样（demonstration sampling）：从每个类中选择一个有代表性的问题，并使用零示例思维链（Zero-Shot-CoT）和简单启发式生成其推理链

简单的启发式规则可能包括问题的长度（例如，60个令牌）和推理的步骤数量（例如，5个推理步骤）。这鼓励模型使用简单而准确的示范。

下面说明了这个过程：
![](/assets/img/llm_prompt/auto-cot.webp)

### 自洽性（Self-Consistency）
在提示工程中，可能是更高级技术之一的是自洽性。由[Wang et al. (2022)](https://arxiv.org/abs/2203.11171)提出，自洽性的目标是“替代在思维链提示中使用的天真贪婪解码”。其思想是通过`few-shot CoT`采样多个不同的推理路径，并使用生成的结果来选择最一致的答案。这有助于提高CoT提示在涉及算术和常识推理的任务上的性能。

让我们尝试以下算术推理的例子：

Prompt:
```
当我6岁的时候，我的妹妹是我年龄的一半。现在我70岁，我的妹妹多大了？
```

Output:
```
35
```

输出结果是错误的！我们如何通过自洽性来改进这一点？让我们试一试吧。

Prompt：
```
问题：果园里有15棵树。今天果园工人将在果园里种树。他们完成后，将有21棵树。今天果园工人种了多少棵树？
答案：我们开始时有15棵树。之后我们有了21棵树。两者之间的差必须是他们种的树的数量。
所以，他们必须种了21 - 15 = 6棵树。答案是6。

问题：如果停车场有3辆车，又来了2辆车，停车场里有多少辆车？
答案：停车场已经有3辆车。又来了2辆。现在有3 + 2 = 5辆车。答案是5。

问题：Leah有32块巧克力，她的妹妹有42块。如果他们吃了35块，他们总共还剩多少块？
答案：Leah有32块巧克力，Leah的妹妹有42块。这意味着最初总共有32 + 42 = 74块巧克力。吃掉了35块。所以总共他们还剩下74 - 35 = 39块巧克力。答案是39。

问题：Jason有20个棒棒糖。他给了Denny一些棒棒糖。现在Jason有12个棒棒糖。Jason给了Denny多少个棒棒糖？
答案：Jason有20个棒棒糖。由于他现在只有12个，他必须把剩下的都给了Denny。他给Denny的棒棒糖数量必须是20 - 12 = 8个棒棒糖。答案是8。

问题：Shawn有五个玩具。圣诞节时，他从妈妈和爸爸那里各得到两个玩具。他现在有多少个玩具？
答案：他有5个玩具。他从妈妈那里得到2个，所以之后他有5 + 2 = 7个玩具。然后他又从爸爸那里得到2个，所以总共他有7 + 2 = 9个玩具。答案是9。

问题：服务器房里有九台电脑。从星期一到星期四，每天都安装了五台电脑。服务器房里现在有多少台电脑？
答案：从星期一到星期四共有4天。每天增加了5台电脑。这意味着总共增加了4 * 5 = 20台电脑。最初有9台电脑，所以现在有9 + 20 = 29台电脑。答案是29。

问题：Michael有58个高尔夫球。星期二他丢了23个高尔夫球。星期三他又丢了2个。星期三结束时他还剩下多少个高尔夫球？
答案：Michael最初有58个球。星期二他丢了23个，所以之后他有58 - 23 = 35个球。星期三他又丢了2个，所以现在他有35 - 2 = 33个球。答案是33。

问题：Olivia有23美元。她买了5个3美元一个的百吉饼。她剩下多少钱？
答案：她买了5个百吉饼，每个3美元。这意味着她花了15美元。她还剩下8美元。

问题：当我6岁的时候，我的妹妹是我年龄的一半。现在我70岁了，我的妹妹多大了？
答案：
```

Output1:
```
当我6岁的时候，我的妹妹是我年龄的一半，所以她是3岁。现在我70岁了，所以她是70 - 3 = 67岁。答案是67岁。
```

Output2：
```
当叙述者6岁时，他的妹妹是他年龄的一半，也就是3岁。现在叙述者70岁了，他的妹妹将是70 - 3 = 67岁。答案是67岁。
```

Output3:
```
当我6岁时我妹妹是我年龄的一半，所以她是3岁。现在我70岁，她是70/2=35，答案是35岁。
```

计算最终答案需要一些步骤（具体细节请查阅论文），但为了简单起见，我们可以看到已经有一个多数答案浮现出来，所以这基本上会成为最终答案。

注：这里的例子都比较旧了，现在的大模型能力更强了

### 生成知识提示（Generated Knowledge Prompting）
![](/assets/img/llm_prompt/gen-knowledge.webp）

大型语言模型（LLMs）持续得到改进，其中一个流行的技术包括能够整合知识或信息来帮助模型做出更准确的预测。

使用类似的理念，模型是否也可以在做出预测之前生成知识？这正是[Liu et al. 2022](https://arxiv.org/pdf/2110.08387.pdf)论文中尝试的——把生成知识作为提示的一部分。特别是，这对于常识推理等任务会有多大的帮助？

让我们尝试一个简单的提示：

Prompt:
```
高尔夫的一部分是尝试获得比其他人更高的分数总和。是或否？
```

Output:
```
是的
```

这种错误揭示了大型语言模型（LLMs）在执行需要更多世界知识的任务时的局限性。我们如何通过知识生成来改进它？

首先，我们生成一些“知识”：

Prompt:
```
输入：希腊比墨西哥大。
知识：希腊的面积大约为131,957平方公里，而墨西哥的面积大约为1,964,375平方公里，这使得墨西哥比希腊大1,389%。

输入：眼镜总是会起雾。
知识：当来自你的汗水、呼吸以及周围湿度的水蒸气落在冷的表面上，冷却并转变成微小的液滴，形成一层膜，这层膜就是你看到的雾。你的眼镜镜片相对于你的呼吸会比较凉，特别是当外面的空气很冷的时候。

输入：鱼能够思考。
知识：鱼的智力比它们看起来的要高。在许多领域，如记忆力，它们的认知能力与其他“高等”脊椎动物匹敌甚至超过，包括非人类灵长类动物。鱼的长期记忆帮助它们跟踪复杂的社会关系。

输入：一个人一生中吸很多烟，患肺癌的几率高于正常。
知识：那些一生中平均每天吸不到一根烟的人，死于肺癌的风险是从不吸烟者的9倍。在那些每天吸1至10根烟的人中，死于肺癌的风险几乎是从不吸烟者的12倍。

输入：石头和鹅卵石一样大。
知识：根据沉积学的Udden-Wentworth量表，鹅卵石是一种岩石碎片，其粒径为4到64毫米。人们通常认为鹅卵石比粒状物（直径2到4毫米）大，而比卵石（直径64到256毫米）小。

输入：高尔夫的一部分是试图获得比其他人更高的分数总和。
知识：
```

Knowledge 1:
```
高尔夫的目标是用最少的杆数完成一组洞。一轮高尔夫通常包括18个洞。在标准高尔夫球场上，每一洞在一轮比赛中只打一次。每一杆都计为一分，用总杆数来决定比赛的胜者。
```

Knowledge 2:
```
高尔夫是一种精确的球杆运动，参赛者（或高尔夫球手）使用多种类型的球杆，以最少的击球次数将球击入球场上一系列的洞中。目标是以最低的成绩完成球场，成绩是通过将每个洞的击球次数相加来计算的。成绩最低的球员赢得比赛。
```

下一步是整合知识并得出预测。我将问题重新格式化为问答格式，以指导答案的格式。

Prompt:
```
问题：高尔夫的一部分是尝试获得比其他人更高的分数总和。是或否？
知识：高尔夫的目标是在最少的击球次数下完成一组洞。一轮高尔夫通常由18个洞组成。在标准的高尔夫球场上，每个洞在一轮比赛中打一次。每一次击球计为一分，通过比较总击球数来确定比赛的胜者。
解释和回答：
```

Answer 1 (confidence very high):
```
不，高尔夫的目标不是获得比其他人更高的分数总和。相反，其目标是用最少的击球次数完成一组洞。比赛的胜者是通过总击球次数来确定的，而不是总分数。
```

Prompt:
```
问题：高尔夫的一部分是尝试获得比其他人更高的分数总和。是或否？

知识：高尔夫是一种精确的球杆和球运动，参赛选手（或高尔夫球手）使用多种类型的球杆，通过尽可能少的击球次数将球击入球场上一系列的洞中。目标是以最低的成绩完成球场，这个成绩是通过将每个洞的击球次数相加来计算的。成绩最低的选手赢得比赛。

解释和回答：
```

Answer 2 (confidence is a lot lower):
```
是的，高尔夫的一部分就是试图获得比其他比赛更高的总分。每个球员都试图以最低分数完成整个球场，该分数是通过将每个洞的总杆数相加计算得出的。得分最低的玩家赢得游戏。
```

在这个例子中发生了一些非常有趣的事情。在第一个答案中，模型非常自信，但在第二个答案中就没有那么自信了。为了演示目的，我简化了这个过程，但在得出最终答案时还有一些更多的细节需要考虑。更多的信息请查阅相关论文。

### 提示链（Prompt Chaining）
#### 引言
为了提高大型语言模型（LLMs）的可靠性和性能，一个重要的提示工程技术是将任务分解成其子任务。一旦识别出了这些子任务，就用一个子任务提示LLM，然后将其响应作为输入到另一个提示中。这就是所谓的提示链，即将任务分解为子任务，旨在创建一系列提示操作。

提示链对于完成LLM可能难以一次性解决的复杂任务非常有用。在提示链中，链式提示执行转换或对生成的响应进行额外处理，直到达到最终期望的状态。

除了实现更好的性能，提示链还有助于提高LLM应用的透明度，增加可控性和可靠性。这意味着您可以更容易地调试模型响应中的问题，分析并改进需要改进的不同阶段的性能。

在构建基于LLM的会话助手以及提高应用程序的个性化和用户体验方面，提示链尤其有用。

#### 示例
##### 文档问答中的提示链

提示链可以用于可能涉及多个操作或转换的不同场景。例如，LLMs的一个常见用例是回答关于大型文本文档的问题。如果您设计两个不同的提示将会很有帮助，其中第一个提示负责提取相关引用以回答问题，第二个提示则利用这些引用和原始文档作为输入来回答给定的问题。换句话说，您将创建两个不同的提示来执行给定文档回答问题的任务。

下面的第一个提示根据问题从文档中提取相关引用。请注意，为了简单起见，我们添加了文档的占位符{{document}}。为了测试提示，您可以复制并粘贴维基百科的一篇文章，比如关于提示工程的页面。由于这项任务使用了更大的上下文，我们使用的是OpenAI的gpt-4-1106-preview模型。您也可以将该提示与Claude等其他长上下文LLMs一起使用。

Prompt 1:
```
您是一个有帮助的助手。您的任务是根据文档回答一个问题。第一步是从文档中提取与问题相关的报价，文档用####分隔。请使用<quotes></quotes>输出引用列表。如果没有找到相关引用，请回答“没有找到相关引用！”。
####
{{文档}}
####
```
这里有一个屏幕截图，包括用户角色提出的问题。
![](/assets/img/llm_prompt/prompt-chaining-1.webp)

Output of Prompt 1:
```
<quotes>
- Chain-of-thought (CoT) prompting[27]
- Generated knowledge prompting[37]
- Least-to-most prompting[38]
- Self-consistency decoding[39]
- Complexity-based prompting[41]
- Self-refine[42]
- Tree-of-thought prompting[43]
- Maieutic prompting[45]
- Directional-stimulus prompting[46]
- Textual inversion and embeddings[59]
- Using gradient descent to search for prompts[61][62][63][64]
- Prompt injection[65][66][67]
</quotes>
```

在第一个提示中返回的引用现在可以作为输入用于下面的第二个提示。请注意，您可以进一步清理这些引用，即去除引用来源。这些引用来源可以被移除或作为链中另一个提示的一部分使用，但现在您可以忽略这一点。然后第二个提示采用第一个提示提取的相关引用，并根据给定的文档和这些提取的引用准备一个有帮助的回答。第二个提示可以是以下内容：

Prompt 2:
```
根据从文档中提取的一组相关引用（由<quotes></quotes>分隔）以及原始文档（由####分隔），请撰写对问题的回答。确保答案准确、语气友好并且给人以帮助。
####
{{文档}}
####
<quotes>
- Chain-of-thought (CoT) prompting[27]
- Generated knowledge prompting[37]
- Least-to-most prompting[38]
- Self-consistency decoding[39]
- Complexity-based prompting[41]
- Self-refine[42]
- Tree-of-thought prompting[43]
- Maieutic prompting[45]
- Directional-stimulus prompting[46]
- Textual inversion and embeddings[59]
- Using gradient descent to search for prompts[61][62][63][64]
- Prompt injection[65][66][67]
</quotes>
```

Output of Prompt 2:
```
The prompting techniques mentioned in the document include:
1. Chain-of-thought (CoT) prompting[27]
2. Generated knowledge prompting[37]
3. Least-to-most prompting[38]
4. Self-consistency decoding[39]
5. Complexity-based prompting[41]
6. Self-refine[42]
7. Tree-of-thought prompting[43]
8. Maieutic prompting[45]
9. Directional-stimulus prompting[46]
10. Textual inversion and embeddings[59]
11. Using gradient descent to search for prompts[61][62][63][64]
12. Prompt injection[65][66][67]
Each of these techniques employs unique strategies to enhance or specify the interactions with large language models to produce the desired outcomes.
```

正如您所见，简化并创建提示链是一种有用的提示方法，其中的响应需要经过多个操作或转换。

### 思维树（Tree of Thoughts）
对于需要探索或战略性前瞻的复杂任务，传统的或简单的提示技术不足以胜任。[Yao et el. (2023)](https://arxiv.org/abs/2305.10601)和[Long (2023)](https://arxiv.org/abs/2305.08291)最近提出了“思维树”（ToT）框架，它在思维链提示的基础上进行了推广，并鼓励对作为通用问题解决中间步骤的思维进行探索。

ToT维护了一个思维树，其中的思维代表了作为解决问题中间步骤的连贯语言序列。这种方法使得语言模型能够通过有意的推理过程自我评估中间思维在解决问题方面的进展。然后，将语言模型生成和评估思维的能力与搜索算法（例如，广度优先搜索和深度优先搜索）结合起来，以使得系统地探索具有前瞻性和回溯的思维。

![](/assets/img/llm_prompt/TOT.webp)

当使用ToT时，不同的任务需要定义候选数量和思维/步骤的数量。例如，正如论文中所示，24点游戏被用作数学推理任务，它要求将思维分解成3个步骤，每个步骤涉及一个中间方程式。在每一步中，保留最佳的b=5个候选。

为了在ToT中对24点游戏任务执行BFS，语言模型被提示评估每个思维候选为“肯定/可能/不可能”，关于达到24点。正如作者所述，"目的是促进可以在少数前瞻尝试中判定的正确部分解决方案，并根据'太大/太小'的常识消除不可能的部分解决方案，保留其余的'可能'"。每个思维的值会被抽样3次。下面说明了这个过程：

![](/assets/img/llm_prompt/TOT2.webp)

根据下图中报告的结果，ToT在性能上大大超过了其他提示方法：

![](/assets/img/llm_prompt/TOT3.webp)

代码可从[tree-of-thought-llm](https://github.com/princeton-nlp/tree-of-thought-llm)和[tree-of-thought-puzzle-solver](https://github.com/jieyilong/tree-of-thought-puzzle-solver)中获取。

在高层次上，Yao等人（2023）和Long（2023）的主要思想是相似的。两者都通过多轮对话的树形搜索增强了LLM处理复杂问题的能力。主要的区别之一是Yao等人（2023）利用了DFS/BFS/Beam搜索，而Long（2023）提出的树搜索策略（即何时回溯以及回溯多少级等）是由通过强化学习训练的“ToT控制器”驱动的。DFS/BFS/Beam搜索是通用的解决方案搜索策略，没有对特定问题进行适应。相比之下，通过RL训练的ToT控制器可能能够从新数据集中学习或通过自我对弈（AlphaGo与蛮力搜索），因此即使LLM固定不变，基于RL的ToT系统也可以继续进化和学习新知识。

[Hulbert (2023)](https://github.com/dave1010/tree-of-thought-prompting)提出了思维树提示法，它将ToT框架的主要概念作为一种简单的提示技术应用，让LLM在单个提示中评估中间思维。一个ToT提示的示例是：

```
Imagine three different experts are answering this question.
All experts will write down 1 step of their thinking,
then share it with the group.
Then all experts will go on to the next step, etc.
If any expert realises they're wrong at any point then they leave.
The question is...
```

[Sun (2023)](https://github.com/holarissun/PanelGPT)通过大规模实验对思维树提示法进行了基准测试，并提出了PanelGPT——一种利用大型语言模型间小组讨论进行提示的想法，测试结果如下：

| Method\Dataset  | GSM8K (test 1k) | Prompt Content | Reference | 
|---------|---------|---------|-----------|
| No-Prompt | 0.789 | The answer is:| - |
| Zero-Shot CoT | 0.854 | Let's think step by step: | [(Kojima, Takeshi, et al. 2022)](https://arxiv.org/pdf/2205.11916.pdf) | 
| APE Improved CoT | 0.845 | Let’s work this out in a step by step way to be sure we have the right answer:| [(Zhou, Yongchao, et al. 2023)](https://arxiv.org/pdf/2211.01910.pdf) |
| ToT Prompting | 0.842 | Imagine three different experts are answering this question. All experts will write down 1 step of their thinking, then share it with the group. Then all experts will go on to the next step, etc. If any expert realises they're wrong at any point then they leave | [(Dave Hulbert's Repo 2023)](https://github.com/dave1010/tree-of-thought-prompting) | 
| PanelGPT |  **0.899** | 3 experts are discussing the question with a _panel_ discussion, trying to solve it step by step, and make sure the result is correct _and avoid penalty_: | (PanelGPT, July 18, 2023) |
| PanelGPT w/o AE and EA |  0.878 | 3 experts are discussing the question with a discussion, trying to solve it step by step, and make sure the result is correct: | (PanelGPT, Ablation Study)
| PanelGPT w/o AE| 0.84 | 3 experts are discussing the question with a discussion, trying to solve it step by step, and make sure the result is correct and avoid penalty: | (PanelGPT, Ablation Study)
| PanelGPT w/o EA |  <ins>0.894</ins>  | 3 experts are discussing the question with a panel discussion, trying to solve it step by step, and make sure the result is correct: | (PanelGPT, Ablation Study)
| P<ins>e</ins>n<ins>a</ins>lGPT  (Mis-spelled) |  _0.883_  | 3 experts are discussing the question with a penal discussion, trying to solve it step by step, and make sure the result is correct: | (PanelGPT, Ablation Study)

### 检索增强生成（Retrieval Augmented Generation）
通用语言模型可以被微调以完成多种常见任务，例如情感分析和命名实体识别。这些任务通常不需要额外的背景知识。

对于更复杂和知识密集型的任务，可以构建一个基于语言模型的系统，它访问外部知识源以完成任务。这使得生成的内容在事实上更加一致，提高了生成响应的可靠性，并有助于缓解“幻觉”问题。

Meta AI的研究人员引入了一种称为检索增强生成（RAG）的方法来解决此类知识密集型任务。RAG结合了信息检索组件和文本生成模型。RAG可以进行微调，其内部知识可以以高效的方式进行修改，而不需要重新训练整个模型。

RAG接受一个输入，并检索一组相关/支持文档作为给定源的内容（例如，维基百科）。这些文档与原始输入提示连接在一起，然后提供给文本生成器，产生最终输出。这使得RAG能够适应随时间演变的事实情况。这非常有用，因为LLMs的参数知识是静态的。RAG允许语言模型绕过重新训练，通过基于检索的生成访问最新信息，以产生可靠的输出。

[Lewis et al., (2021)](https://arxiv.org/pdf/2005.11401.pdf)提出了一个用于RAG的通用微调方案。使用预训练的seq2seq模型作为参数记忆，使用维基百科的密集向量索引作为非参数记忆（通过使用预训练的神经检索器访问）。以下是该方法工作原理的概述：

![](/assets/img/llm_prompt/rag.webp)

RAG在多个基准测试中表现出色，比如Natural Questions、WebQuestions和CuratedTrec。在MS-MARCO和Jeopardy问题测试中，RAG生成的回答更加事实、具体和多样化。RAG还提高了FEVER事实验证的结果。

这表明RAG作为一种强化语言模型在知识密集型任务中增强输出能力的潜力。

最近，这些基于检索器的方法变得更加流行，并且与诸如ChatGPT这样的流行LLMs结合起来，以提高能力和事实一致性。[Retrieval-Augmented Generation for Large Language Models: A Survey](https://arxiv.org/pdf/2312.10997.pdf)的RAG综述文章对近期的LLM结合RAG的实践做了总结：

![](/assets/img/llm_prompt/rag1.png)
![](/assets/img/llm_prompt/rag2.png)

### 自动推理和工具使用（Automatic Reasoning and Tool-use）

将思维树（CoT）提示和工具以交错的方式结合使用，被证明是一种强大且健壮的方法，可以解决LLMs面临的许多任务。这些方法通常需要手工制作特定任务的演示，并小心翼翼地将模型生成与工具使用交错起来。[Paranjape et al., (2023)](https://arxiv.org/abs/2303.09014)提出了一个新框架，它使用固定的LLM来自动生成作为程序的中间推理步骤。

ART的工作方式如下：

- 给定一个新任务，它从任务库中选择多步推理和工具使用的演示
- 在测试时，每当调用外部工具时，它会暂停生成，并在恢复生成之前整合它们的输出

ART鼓励模型从演示中泛化，以零样本（zero-shot）的方式分解新任务并在适当的地方使用工具。此外，ART是可扩展的，因为它还允许人类通过简单地更新任务和工具库来修正推理步骤中的错误或添加新工具。下面演示了这一过程：

![](/assets/img/llm_prompt/ART.webp)

ART在BigBench和MMLU基准测试中未见过的任务上，相比于少样本提示和自动化CoT（Chain of Thought）有显著改进，并且在加入人类反馈时，性能超过了手工制作的CoT提示。

下面是ART的性能测试结果：
![](/assets/img/llm_prompt/ART2.webp)

### 自动提示工程（Automatic Prompt Engineer）
[Zhou et al., (2022)](https://arxiv.org/abs/2211.01910)提出了自动提示工程（APE），这是一个用于自动生成和选择指令的框架。指令生成问题被构建为自然语言合成问题，并作为一个黑盒优化问题，使用大型语言模型（LLMs）来生成和搜索候选解决方案。

第一步包括使用一个大型语言模型（作为推理模型），给定输出样例来为任务生成指令候选。这些候选解决方案将指导搜索过程。指令使用目标模型执行，然后根据计算出的评估分数选择最合适的指令。

APE发现了比人类工程师设计的“让我们一步一步思考”提示（Kojima等人，2022年）更好的零样本CoT提示。

提示“让我们一步一步地解决这个问题，确保我们有正确的答案。”引出了思维链推理，并提高了在MultiArith和GSM8K基准测试上的性能：

![](/assets/img/llm_prompt/ape-zero-shot-cot.webp)

该论文触及了与提示工程相关的一个重要话题，即自动优化提示的概念。虽然我们在这篇指南中没有深入探讨这个话题，但如果你对这个话题感兴趣，以下是一些关键的论文：

- [Prompt-OIRL](https://arxiv.org/abs/2309.06553): 提出使用离线逆强化学习来生成依赖于查询的提示。
- [OPRO](https://arxiv.org/abs/2309.03409): 引入了使用LLMs优化提示的概念：让LLMs“深呼吸”可以提高数学问题上的表现。
- [AutoPrompt](https://arxiv.org/abs/2010.15980): 提出了一种基于梯度引导搜索自动为多种任务创建提示的方法。
- [Prefix Tuning](https://arxiv.org/abs/2101.00190): 一种轻量级的微调替代方案，为自然语言生成（NLG）任务添加一个可训练的连续前缀。
- [Prompt Tuning](https://arxiv.org/abs/2104.08691): 提出了一种通过反向传播学习软提示的机制。

### 主动提示（Active-Prompt）
思维链（CoT）方法依赖于一组固定的人类标注示例。这样做的问题是这些示例可能并不是对不同任务最有效的例子。为了解决这个问题，[Diao et al., (2023)](https://arxiv.org/pdf/2302.12246.pdf)最近提出了一种名为Active-Prompt的新提示方法，以适应LLMs对不同任务特定示例提示（对人类设计的CoT进行标注）。

以下是该方法的示意图。第一步是使用CoT或直接查询LLM，为一组训练问题生成k个可能答案。基于k个答案计算不确定性指标。选择最不确定的问题由人类进行标注。然后使用新标注的示例来推断每个问题。

![](/assets/img/llm_prompt/active-prompt.webp)

### 方向性刺激提示（Directional Stimulus Prompting）

[Li et al., (2023)](https://arxiv.org/abs/2302.11520)提出了一种新的提示技术，以更好地引导LLM生成所需的摘要。

一个可调的策略语言模型（policy LM）被训练用来生成刺激/提示。更多的使用强化学习（RL）来优化LLM。

下图展示了方向性刺激提示与标准提示的比较。策略LM可以是小型的，并优化生成引导黑盒固定LLM的提示。

![](/assets/img/llm_prompt/dsp.webp)

### 程序辅助语言模型（Program-Aided Language Models）
[Gao et al., (2022)](https://arxiv.org/abs/2211.10435)提出了一种方法，使用LLM读取自然语言问题并生成程序作为中间推理步骤。这种方法被称为程序辅助语言模型（PAL），它与思维链提示的不同之处在于，PAL不使用自由形式文本来获得解决方案，而是将解决步骤外包给程序运行时，例如Python解释器。

![](/assets/img/llm_prompt/pal.webp)

我们来看一个使用LangChain和OpenAI GPT-3的例子。我们有兴趣开发一个简单的应用程序，该程序能够解释所提出的问题，并通过利用Python解释器提供答案。

具体来说，我们有兴趣创建一个功能，允许使用LLM回答需要日期理解的问题。我们将提供给LLM一个提示，其中包括一些从[这里](https://github.com/reasoning-machines/pal/blob/main/pal/prompt/date_understanding_prompt.py)采用的示例。

我们需要导入这些包：
```python
import openai
from datetime import datetime
from dateutil.relativedelta import relativedelta
import os
from langchain.llms import OpenAI
from dotenv import load_dotenv
```

首先进行一些设置：
```python
load_dotenv()
 
# API configuration
openai.api_key = os.getenv("OPENAI_API_KEY")
 
# for LangChain
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")
```

创建模型实例：
```python
llm = OpenAI(model_name='text-davinci-003', temperature=0)
```

设置提示和问题：
```python
question = "Today is 27 February 2023. I was born exactly 25 years ago. What is the date I was born in MM/DD/YYYY?"
 
DATE_UNDERSTANDING_PROMPT = """
# Q: 2015 is coming in 36 hours. What is the date one week from today in MM/DD/YYYY?
# If 2015 is coming in 36 hours, then today is 36 hours before.
today = datetime(2015, 1, 1) - relativedelta(hours=36)
# One week from today,
one_week_from_today = today + relativedelta(weeks=1)
# The answer formatted with %m/%d/%Y is
one_week_from_today.strftime('%m/%d/%Y')
# Q: The first day of 2019 is a Tuesday, and today is the first Monday of 2019. What is the date today in MM/DD/YYYY?
# If the first day of 2019 is a Tuesday, and today is the first Monday of 2019, then today is 6 days later.
today = datetime(2019, 1, 1) + relativedelta(days=6)
# The answer formatted with %m/%d/%Y is
today.strftime('%m/%d/%Y')
# Q: The concert was scheduled to be on 06/01/1943, but was delayed by one day to today. What is the date 10 days ago in MM/DD/YYYY?
# If the concert was scheduled to be on 06/01/1943, but was delayed by one day to today, then today is one day later.
today = datetime(1943, 6, 1) + relativedelta(days=1)
# 10 days ago,
ten_days_ago = today - relativedelta(days=10)
# The answer formatted with %m/%d/%Y is
ten_days_ago.strftime('%m/%d/%Y')
# Q: It is 4/19/1969 today. What is the date 24 hours later in MM/DD/YYYY?
# It is 4/19/1969 today.
today = datetime(1969, 4, 19)
# 24 hours later,
later = today + relativedelta(hours=24)
# The answer formatted with %m/%d/%Y is
today.strftime('%m/%d/%Y')
# Q: Jane thought today is 3/11/2002, but today is in fact Mar 12, which is 1 day later. What is the date 24 hours later in MM/DD/YYYY?
# If Jane thought today is 3/11/2002, but today is in fact Mar 12, then today is 3/12/2002.
today = datetime(2002, 3, 12)
# 24 hours later,
later = today + relativedelta(hours=24)
# The answer formatted with %m/%d/%Y is
later.strftime('%m/%d/%Y')
# Q: Jane was born on the last day of Feburary in 2001. Today is her 16-year-old birthday. What is the date yesterday in MM/DD/YYYY?
# If Jane was born on the last day of Feburary in 2001 and today is her 16-year-old birthday, then today is 16 years later.
today = datetime(2001, 2, 28) + relativedelta(years=16)
# Yesterday,
yesterday = today - relativedelta(days=1)
# The answer formatted with %m/%d/%Y is
yesterday.strftime('%m/%d/%Y')
# Q: {question}
""".strip() + '\n'

llm_out = llm(DATE_UNDERSTANDING_PROMPT.format(question=question))
print(llm_out)
```

LLM会输出如下内容：
```
# If today is 27 February 2023 and I was born exactly 25 years ago, then I was born 25 years before.
today = datetime(2023, 2, 27)
# I was born 25 years before,
born = today - relativedelta(years=25)
# The answer formatted with %m/%d/%Y is
born.strftime('%m/%d/%Y')
```

这是一个Python代码，需要用Python解释器执行：
```python
exec(llm_out)
print(born)
```

结果如下：
```
02/27/1998
```

### ReAct提示
[Yao et al., 2022](https://arxiv.org/abs/2210.03629)引入了一个名为ReAct的框架，在该框架中，LLM被用于以交错的方式生成推理轨迹和特定于任务的动作。

生成推理轨迹可以让模型诱导、跟踪和更新动作计划，甚至处理异常情况。动作步骤允许与外部源（如知识库或环境）接口并收集信息。

ReAct框架可以允许LLM与外部工具交互，以检索更多可靠和事实性的回应所需的附加信息。

结果表明，ReAct可以在语言和决策任务上超越几个最先进的基线。ReAct还提高了LLM的人类可解释性和可信度。总的来说，作者发现最佳方法结合了ReAct和思维链（CoT），它允许使用内部知识和在推理过程中获得的外部信息。

#### 它是如何工作的？

ReAct受到了“行动”与“推理”之间协同作用的启发，这种协同作用允许人类学习新任务并做出决策或推理。

思维链（CoT）提示已经显示了LLM执行推理轨迹以生成回答涉及算术和常识推理等任务的问题的能力（Wei等人，2022年）。但是它不具备访问外部世界或更新其知识的能力，可能会导致事实幻觉和错误传播等问题。

ReAct是一种结合推理和行动的LLM的通用范式。ReAct提示LLM为任务生成口头推理轨迹和动作。这允许系统进行动态推理以创建、维护和调整行动计划，同时也允许与外部环境（例如，维基百科）交互，以将额外信息纳入推理中。下图展示了ReAct的一个示例以及执行问答所涉及的不同步骤。

![](/assets/img/llm_prompt/react.webp)

在上述例子中，我们使用了类似于来自[HotpotQA](https://hotpotqa.github.io/)的问题：
```
Aside from the Apple Remote, what other devices can control the program Apple Remote was originally designed to interact with?
```

请注意，上下文示例也被添加到提示中，但出于简化考虑，我们在这里省略了这些示例。我们可以看到模型生成了解决任务的轨迹（Thought, Act）。Obs对应于与之交互的环境中的观察（例如，搜索引擎）。本质上，ReAct可以检索信息来支持推理，而推理则有助于确定接下来需要检索的内容。

#### ReAct提示

为了展示ReAct提示是如何工作的，让我们跟随论文中的一个例子。

第一步是从训练集中选择案例（例如，HotPotQA）并组成ReAct格式的轨迹。这些被用作提示中的少数示例。正如上图所示，轨迹包括多个思考-行动-观察步骤。自由形式的思考被用来实现不同的任务，如分解问题、提取信息、执行常识/算术推理、指导搜索表达式的制定，以及综合最终答案。

这里有一个ReAct提示示例的例子（从论文中获得，并简化为一个例子以便简单说明）：
```
Question 科罗拉多造山带东部区域延伸到的区域的海拔范围是多少？
Thought 1 我需要搜索科罗拉多造山带，找到科罗拉多造山带东部区域延伸进入的区域，然后找出该区域的海拔范围。
Action 1 Search[科罗拉多造山带]
Observation 1 科罗拉多造山带是科罗拉多及周边地区一次山脉构造（一次造山运动）的事件
Thought 2 文中没有提到东部区域。所以我需要查找东部区域的相关信息。
Action 2 Lookup[东部区域]
Observation 2 (Result 1 / 1) 东部区域延伸到高原地带，被称为中央平原造山带。
Thought 3 科罗拉多造山带的东部区域延伸到高原。因此，我需要搜索高原并找出其海拔范围。
Action 3 Search[高原]
Observation 3 高原指的是两个不同地理区域之一。
Thought 4 我需要改为搜索高原（美国）。
Action 4 Search[高原（美国）]
Observation 4 高原是大平原的一个子区域。从东到西，高原的海拔从大约1,800英尺升高到7,000英尺（550米到2,130米）。[3]
Thought 5 高原的海拔从大约1,800英尺上升到7,000英尺，所以答案是1,800到7,000英尺。
Action 5 Finish[1,800到7,000英尺]
...
```

请注意，对于不同类型的任务，使用不同的提示设置。对于推理至关重要的任务（例如，HotpotQA），使用多个思考-行动-观察步骤来实现任务解决轨迹。对于涉及许多行动步骤的决策任务，思考使用得比较少。

#### 关于知识密集型任务的结果

论文首先评估了ReAct在诸如问题回答（HotPotQA）和事实验证（Fever）等知识密集型推理任务上的表现。使用PaLM-540B作为提示的基础模型。
![](/assets/img/llm_prompt/table1.webp)

在HotPotQA和Fever上使用不同提示方法的提示结果表明，ReAct通常在这两项任务上的表现都优于仅涉及行动的Act。

我们还可以观察到，ReAct在Fever上的表现优于CoT，在HotpotQA上则略落后于CoT。论文中提供了详细的错误分析。总结如下：

- CoT容易出现事实幻觉。
- ReAct的结构性约束减少了其在制定推理步骤时的灵活性。
- ReAct在很大程度上依赖于它检索的信息；不具有信息性的搜索结果会使模型推理偏离轨道，并导致难以恢复和重新构思思路。

结合使用ReAct和CoT+自洽性（CoT+Self-Consistency）的提示方法通常要优于所有其他提示方法。

#### 关于决策任务的结果
论文还报告了展示ReAct在决策任务上性能的结果。ReAct在两个基准测试上进行了评估，这两个基准测试分别是ALFWorld（基于文本的游戏）和WebShop（在线购物网站环境）。这两者都涉及复杂的环境，需要推理才能有效地行动和探索。

请注意，这些任务的ReAct提示设计虽有不同，但仍然保持结合推理和行动的核心理念。以下是一个涉及ReAct提示的ALFWorld问题的例子。

![](/assets/img/llm_prompt/alfworld.webp)

ReAct在ALFWorld和Webshop上都优于Act。Act没有任何思考，未能正确地将目标分解为子目标。在这些类型的任务中，推理似乎对ReAct有利，但目前基于提示的方法在这些任务上的表现仍远不及专家人类。

#### LangChain ReAct使用示例

以下是ReAct提示方法在实践中如何工作的一个高层次示例。我们将使用OpenAI作为LLM（大型语言模型），以及LangChain，因为它已经内置了利用ReAct框架的功能，可以构建通过结合LLM的力量和不同工具来执行任务的代理。

首先，让我们安装并导入必要的库：

```python
%%capture
# update or install the necessary libraries
!pip install --upgrade openai
!pip install --upgrade langchain
!pip install --upgrade python-dotenv
!pip install google-search-results
 
# import libraries
import openai
import os
from langchain.llms import OpenAI
from langchain.agents import load_tools
from langchain.agents import initialize_agent
from dotenv import load_dotenv
load_dotenv()
 
# load API keys; you will need to obtain these if you haven't yet
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")
os.environ["SERPER_API_KEY"] = os.getenv("SERPER_API_KEY")
```

现在我们可以配置LLM、我们将使用的工具以及允许我们结合LLM和工具利用ReAct框架的代理。请注意，我们使用搜索API来搜索外部信息，并将LLM作为数学工具使用。

```python
llm = OpenAI(model_name="text-davinci-003" ,temperature=0)
tools = load_tools(["google-serper", "llm-math"], llm=llm)
agent = initialize_agent(tools, llm, agent="zero-shot-react-description", verbose=True)
```

配置好之后，我们现在可以运行代理，并提供所需的查询/提示。请注意，在这里，我们不需要提供论文中解释的少数示例。

```python
agent.run("Who is Olivia Wilde's boyfriend? What is his current age raised to the 0.23 power?")
```

ReAct执行过程如下：

```
> Entering new AgentExecutor chain...
 I need to find out who Olivia Wilde's boyfriend is and then calculate his age raised to the 0.23 power.
Action: Search
Action Input: "Olivia Wilde boyfriend"
Observation: Olivia Wilde started dating Harry Styles after ending her years-long engagement to Jason Sudeikis — see their relationship timeline.
Thought: I need to find out Harry Styles' age.
Action: Search
Action Input: "Harry Styles age"
Observation: 29 years
Thought: I need to calculate 29 raised to the 0.23 power.
Action: Calculator
Action Input: 29^0.23
Observation: Answer: 2.169459462491557
 
Thought: I now know the final answer.
Final Answer: Harry Styles, Olivia Wilde's boyfriend, is 29 years old and his age raised to the 0.23 power is 2.169459462491557.
 
> Finished chain.
```

最终我们得到结果：
```
"Harry Styles, Olivia Wilde's boyfriend, is 29 years old and his age raised to the 0.23 power is 2.169459462491557."
```

### 多模态CoT提示

[Zhang et al. (2023)](https://arxiv.org/abs/2302.00923)最近提出了一种多模态思维链提示方法。传统的CoT关注语言模态。相比之下，多模态CoT将文本和视觉整合到一个两阶段框架中。第一步涉及基于多模态信息的理由生成。其次是第二阶段，答案推理，它利用生成的有信息性的理由。

多模态CoT模型（1B）在ScienceQA基准测试上的表现优于GPT-3.5。

![](/assets/img/llm_prompt/multimodal-cot.webp)

## LLM应用

在本节中，我们将介绍一些高级且有趣的方法，通过这些方法我们可以使用提示工程与大型语言模型（LLMs）执行有用且更高级的任务。

### 函数调用
#### 开始使用函数调用
函数调用是指可靠地连接LLMs到外部工具以实现有效工具使用和与外部APIs交互的能力。

像GPT-4和GPT-3.5这样的LLMs已经经过了微调，可以检测何时需要调用一个函数，然后输出包含调用函数参数的JSON。通过函数调用被调用的函数将作为您的AI应用程序中的工具，并且您可以在单个请求中定义不止一个。

函数调用是构建需要为LLM检索上下文或通过将自然语言转换为API调用来与外部工具交互的LLM驱动的聊天机器人或代理的重要能力。

函数调用使开发者能够创建：

- 能够有效使用外部工具回答问题的对话代理。例如，查询“伯利兹的天气如何？”将被转换为一个函数调用，例如`get_current_weather(location: string, unit: 'celsius' | 'fahrenheit')`
- LLM驱动的解决方案用于提取和标记数据（例如，从维基百科文章中提取人名）
- 可以帮助将自然语言转换为API调用或有效数据库查询的应用程序
- 与知识库交互的对话式知识检索引擎

在本指南中，我们将展示如何提示像GPT-4和开源模型这样的模型，为不同的用例执行函数调用。

#### 使用GPT-4进行函数调用
作为一个基础示例，假设我们要求模型检查给定位置的天气。

仅凭LLM是无法响应此请求的，因为它是根据一个有截止点的数据集进行训练的。解决这一问题的方法是将LLM与外部工具结合起来。您可以利用模型的函数调用能力来确定要调用的外部函数及其参数，然后让它返回最终响应。以下是一个简单的例子，展示了如何使用OpenAI API实现这一点。

假设用户向模型提出以下问题：
```
What is the weather like in London?
```

要使用函数调用来处理这个请求，第一步是定义一个天气函数或一组函数，您将作为OpenAI API请求的一部分传递：
```python
tools = [
    {
        "type": "function",
        "function": {
            "name": "get_current_weather",
            "description": "Get the current weather in a given location",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "The city and state, e.g. San Francisco, CA",
                    },
                    "unit": {
                        "type": "string", 
                        "enum": ["celsius", "fahrenheit"]},
                },
                "required": ["location"],
            },
        },   
    }
]
```

`get_current_weather`函数返回给定位置的当前天气。当您将此函数定义作为请求的一部分传递时，它实际上并不执行函数，它只是返回一个包含调用函数所需参数的JSON对象。以下是如何实现这一点的一些代码片段。

您可以如下定义一个完成函数：
```
def get_completion(messages, model="gpt-3.5-turbo-1106", temperature=0, max_tokens=300, tools=None):
    response = openai.chat.completions.create(
        model=model,
        messages=messages,
        temperature=temperature,
        max_tokens=max_tokens,
        tools=tools
    )
    return response.choices[0].message
```

用户输入如下：
```python
messages = [
    {
        "role": "user",
        "content": "What is the weather like in London?"
    }
]
```

最终调用`get_completion`函数并传入上述的`messages`和`tools`：
```python
response = get_completion(messages, tools=tools)
```

`response`对象将包含如下内容：
```
ChatCompletionMessage(content=None, role='assistant', function_call=None, tool_calls=[ChatCompletionMessageToolCall(id='...', function=Function(arguments='{"location":"London","unit":"celsius"}', name='get_current_weather'), type='function')])
```

特别是，`arguments`对象包含了模型提取的重要参数，这些参数将需要用来完成请求。

然后您可以选择调用一个外部天气API来获取实际的天气信息。一旦您获得了天气信息，您可以将其传回模型，综合得到一个最终响应，给出原始用户问题的答案。

### 生成数据
LLMs具有生成连贯文本的强大能力。使用有效的提示策略可以引导模型产生更好、更一致、更具事实性的响应。LLMs在生成数据方面也特别有用，这对于进行各种实验和评估真的非常有帮助。例如，我们可以使用它为情感分类器快速生成样本，如下所示：

Prompt：
```
生成情感分析的10个示例。示例分为积极或消极两种。生成2个消极示例和8个积极示例。使用以下格式来呈现示例：
Q: 句子
A: 情感
```

Output:
```
Q: I just got the best news ever!
A: Positive
Q: We just got a raise at work!
A: Positive
Q: I'm so proud of what I accomplished today.
A: Positive
Q: I'm having the best day ever!
A: Positive
Q: I'm really looking forward to the weekend.
A: Positive
Q: I just got the best present ever!
A: Positive
Q: I'm so happy right now.
A: Positive
Q: I'm so blessed to have such an amazing family.
A: Positive
Q: The weather outside is so gloomy.
A: Negative
Q: I just got some terrible news.
A: Negative
```

这是非常有用的。

### 为RAG生成合成数据集
#### RAG设置的合成数据
不幸的是，在机器学习工程师的职业生涯中，经常会缺乏标记数据或者只有很少的标记数据。通常情况下，意识到这一点后，项目会开始一个漫长的数据收集和标记过程。要几个月后，才能开始开发解决方案。

然而，随着LLM的出现，某些产品的范式发生了变化：现在人们可以依赖LLM的泛化能力，并且几乎立即测试一个想法或开发一个AI驱动的功能。如果它证明工作得(几乎)如预期的那样，那么传统的开发过程就可以开始了。
![](/assets/img/llm_prompt/synthetic_rag_1.webp)

检索增强生成（RAG）是一个新兴方法，它被用于那些不能仅靠模型知识回答的知识密集型任务。它结合了信息检索组件和文本生成模型，可参见前面的章节。

RAG的关键组成部分是检索模型，它识别相关文档并将它们传递给LLM进行进一步处理。检索模型的性能越好，产品或功能的结果就越好。理想情况下，检索功能一开始就能很好地工作。然而，它的性能经常在不同语言或特定领域中有所下降。

想象一下：你需要创建一个基于捷克法律和法律实践回答问题的聊天机器人（当然，用捷克语）。或者为印度市场量身定制一个税务助理（在GPT-4演示中由OpenAI提出的一个用例）。你可能会发现检索模型经常错过最相关的文档，并且整体表现不佳，从而限制了系统的质量。

但有一个解决方案。一个新兴趋势涉及使用现有的LLMs合成数据来训练新一代的LLMs/检索器/其他模型。这个过程可以被视为通过基于提示的查询生成将LLMs提炼成标准大小的编码器。尽管提炼在计算上是密集的，但它大幅降低了推断成本，并可能极大提高性能，特别是在资源匮乏的语言或专业领域。

在这个指南中，我们将依靠最新的文本生成模型，如ChatGPT和GPT-4，它们可以根据指令产生大量的合成内容。[ Dai et al. (2022)](https://arxiv.org/abs/2209.11755)提出了一种方法，只需8个手动标记的例子和大量未标记的数据（检索文档，例如，所有解析的法律），就可以达到接近最先进的性能。这项研究证实，合成生成的数据有助于训练特定任务的检索器，在由于数据稀缺导致监督域内微调成为挑战的任务中尤其如此。

#### 特定领域数据集生成
要利用LLM，需要提供一个简短的描述并手动标记一些示例。需要注意的是，不同的检索任务具有不同的搜索意图，这意味着“相关性”的不同定义。换句话说，对于同一对（查询, 文档），它们的相关性可能完全基于搜索意图而有所不同。例如，一个论点检索任务可能寻找支持性论据，而其他任务需要反论据（如ArguAna数据集所示）。

考虑下面的例子。虽然为了便于理解而用英语书写，但请记住数据可以是任何语言，因为ChatGPT/GPT-4甚至能有效处理低资源语言。

Prompt：
```
任务：为给定的论点找到一个反论点。
论点#1：{在此处插入段落X1}
与论点#1相关的简洁反论点查询：{在此处插入手动准备的查询Y1}
论点#2：{在此处插入段落X2}
与论点#2相关的简洁反论点查询：{在此处插入手动准备的查询Y2}
<- 在此处粘贴你的示例 ->
论点N：即使罚款与收入成比例，也无法实现你所期望的平等。这是因为影响不仅仅与收入成比例，还必须考虑其他许多因素。例如，养家糊口的人比没有这个负担的人承受的影响更大，因为他们的可支配收入更少。进一步，基于收入的罚款忽略了总体财富（即某人实际拥有多少钱：有人可能资产很多但收入不高）。该提案没有考虑这些不平等，这些不平等可能会产生更大的偏斜效应，因此无法实现所期望的平等。
与论点#N相关的简洁反论点查询：
```

Output:
```
刑罚机构将罚款与收入挂钩
```

一般的，这类提示可以被表示成：
```
(E[prompt], E[doc](d1), E[query](q1), ... , E[doc](dn), E[query](qn), E[doc](d))
```
其中，`E[doc]`和`E[query]`分别表示任务相关的文档和查询描述，`E[prompt]`是发给LLM的任务指令，`d`表示一个新文档，LLM将会为其生成一个查询描述。

在这个提示中，只有最后的文档d和生成的查询描述会用于进一步训练本地模型。当目标检索语料库可用，但标注的文档对数量有限时，可以应用这种方法。

整体流程如下：
![](/assets/img/llm_prompt/synthetic_rag_2.webp)

处理手动标注示例至关重要。最好准备更多的示例（例如，20个），然后随机选择2-8个添加到提示中。这样可以在不显著增加标注时间成本的情况下增加生成数据的多样性。然而，这些示例应该是有代表性的，格式正确的，甚至详细说明特定要求，如目标查询的长度或其语气。示例和指令越精确，用于训练检索器的合成数据就越好。低质量的少数示例可能会负面影响训练出的模型的结果质量。

在大多数情况下，使用像ChatGPT这样更实惠的模型就足够了，因为它在处理非英语的不常见领域和语言方面表现良好。假设一个包含指令和4-5个示例的提示通常占用700个tokens（假设由于检索器限制，每个段落不超过128个tokens），生成25个tokens。因此，为本地模型微调生成一个包含50,000个文档的合成数据集的成本为：50,000 * (700 * 0.001 * $0.0015 + 25 * 0.001 * $0.002) = 55美元，其中$0.0015和$0.002是GPT-3.5 Turbo API每1,000个tokens的成本。甚至可以为同一文档生成2-4个查询示例。然而，通常进一步训练的好处是值得的，特别是如果你使用检索器不是针对一般领域（如英语新闻检索），而是针对特定领域（如前面提到的捷克法律）。

50,000这个数字并非随机。在戴等人（2022年）的研究中，他们指出这大约是模型需要的手动标注数据量，以达到使用合成数据训练出的模型的质量。想象一下，在启动产品之前至少要收集10,000个示例！这将至少需要一个月的时间，而且劳动力成本肯定会超过一千美元，这比生成合成数据和训练本地检索器模型的成本要高得多。现在，有了你今天学到的技术，你可以在短短几天内实现双位数的指标增长！

![](/assets/img/llm_prompt/synthetic_rag_3.webp)

### 解决生成数据集的多样性问题
在前一节中，我们讨论了使用LLM生成合成数据集以进一步微调本地检索器模型的潜力。这种方法之所以可行，是因为有大量未标注文档的语料库可用。每个文档都被用来生成一个或多个合成查询，并形成查询-文档对。

但如果信息检索不是你的任务呢？假设你正在处理一个法律文件分类问题，但不允许将任何数据发送到外部API。在这种情况下，你需要训练一个本地模型。然而，收集数据可能成为一个重大障碍，导致产品开发延误。

为简单起见，假设目标是生成儿童故事。这个任务是[Eldan et al. (2023)](https://arxiv.org/abs/2305.07759)研究的起点。每个故事由2-3段构成，遵循一个简单的情节和主题，而整个数据集涵盖了儿童的词汇和事实知识。

语言不仅仅是一套规则和符号系统；它传达并解释意义。使用大型语言模型生成训练数据的主要挑战是确保数据集的多样性。即使在高生成温度下，模型也可能产生重复的数据集，缺乏必要的多样性（即使是对儿童语言而言）。除此之外，连贯性和相关性也是自然语言生成的挑战。

为了解决多样性问题，作者准备了一个包含约1500个基本词汇的词汇表，反映了典型儿童的词汇水平，分为名词、动词和形容词。在每次生成中，随机选择一个动词、一个名词和一个形容词。然后模型生成一个融合这些随机词汇的故事。

这种技术显著扩展了数据集的多样性，确保故事涵盖了儿童全部的词汇和多样的概念组合。此外，作者还整合了潜在的故事特征（如对话、情节转折、坏结局或道德教训）。每个故事都随机选择了这些特征的一个子集，模型被提示要包含它们。

Prompt：
```
写一个短篇故事（3-5 段），只使用 3 岁孩子可能理解的非常简单的单词。 故事应使用动词“{从动词列表中随机选择}”、名词“{从名词列表中随机选择}”和形容词“{从形容其列表中随机选择}”。 该故事应具有以下功能：{从特征列表中随机选择}、{从特征列表中随机选择}。记住只使用简单的单词！
```

让我们假设在随机选择的内容中填入如下内容：

Prompt:
```
写一个短篇故事（3-5 段），只使用 3 岁孩子可能理解的非常简单的单词。 故事应该使用动词“装饰”、名词“雷”和形容词“古老”。 故事应具有以下特征：故事应包含至少一个对话，故事有一个坏结局。 记住只使用简单的单词！
```

Output:
```
从前，在一座古老的房子里，住着一个名叫莉莉的女孩。她喜欢用漂亮的东西装饰她的房间。一天，她在阁楼上发现了一个大箱子。她打开它，看到里面有许多闪亮的装饰品。莉莉非常高兴，决定用它们来装饰她的房间。就在莉莉装饰她的房间时，外面的天空变得黑暗。随着一声巨大的雷声，莉莉感到害怕。她跑到妈妈那里说：“妈妈，雷声太大了！”她的妈妈抱住她说：“别担心，很快就会过去的。”但是雷声并没有停止。它越来越大，那座古老的房子开始摇晃。突然间，屋顶塌了下来，砸在了漂亮的装饰品上。莉莉很难过，因为她的房间不再漂亮了。故事到此结束。
```

在这里，我们依赖最新的文本生成模型（GPT-3.5和GPT-4），它们可以根据指令产生大量的合成内容。由于我们每次都随机地制定提示，并且模型严格遵循它，所以生成的故事变得极其多样化。即使一两个词保持不变，叙述也会完全不同。本质上，我们应用这种技术在提示中注入随机性，以生成多样化的数据集。

从中你可以得到如下方法：

- 确定在合成数据集中不同样本之间可能变化的参数/实体
- 生成或手动编制这些实体的集合以填补空白
- 通过随机选择实体进行插入来生成数据集。最好将生成温度设置得高于默认值，但低于最大值
- 用ChatGPT/GPT-4的生成结果上训练本地模型

值得注意的是，用于种子生成的实体之一可以是类标签。例如，在情感分类任务中，你可以在提示中直接提到“积极”或“消极”，以接收带有相应标签的生成文本。然后，在这些数据上训练本地分类器。

#### 迭代式合成数据生成

通过使用更多的实体来增加格式的复杂性，其中一些实体事先由LLM（大型语言模型）自己生成。例如，人们可以从一个请求开始，生成一个故事摘要，并写下一个必须出现在故事中的句子。之后，只需在最终请求中使用那些生成的中间数据。

Prompt:
```
摘要: {用上面的方法让LLM生成一个简短的摘要}
特征: {从初始提示中拷贝特征}
句子: {一个LLM生成的句子，它必须被包含在故事中}
词汇: {从初始提示中拷贝词汇}
故事:
```

填充后的提示示例：

Prompt:
```
摘要: 莉莉和提米一起堆了一个沙堡，他们学会了妥协，但是一阵风把它吹倒了。他们发现那座破碎的沙堡里有美丽的东西，并且快乐地和一只蝴蝶一起玩耍。
特征: 对话，伏笔，转折
句子: 有一天，她去了公园，看到了一只美丽的蝴蝶。
词汇: 不同意，网络，美丽
故事:
```

Output:
```
从前，有一个叫莉莉的小女孩。她喜欢和她的玩具还有朋友们一起玩耍。一天，她去了公园，看到了一只美丽的蝴蝶。她试图去捕捉它，但它飞走了。莉莉的朋友提米来和她一起玩。他们决定堆一个沙堡，但是对于如何建造它们意见不一。莉莉想要建一个高高的沙堡，而提米想要建一个宽宽的沙堡。他们争论了一会儿，但最后同意既要高又要宽。当他们在建造沙堡时，他们注意到一群蚂蚁在一起合作。他们意识到蚂蚁们正在建造一个隧道网络。突然，一阵风来了，把他们的沙堡吹倒了。他们很难过，但然后他们又看到了那只蝴蝶。它落在了他们沙堡的残骸上，他们意识到即使是在它破碎的状态下，它仍然很美丽。他们微笑着快乐地一起玩耍。
```

因此，可以生成成千上万个非常多样化的样本来训练模型。假设你需要训练一个分类器，以确定文本是否包含对话或情节转折。由于初始提示包含标签，所以知道需要为每个生成的样本预测哪个目标值。

#### 教科书就是你所需要的

从这种方法中产生的一个关键问题是，合成数据集是否真的能在训练用于现实世界应用的神经网络时提供好处。幸运的是，作者通过进行他们的调查并验证使用来自最先进LLM的合成数据训练较小语言模型的有效性来回答这个问题。

在他们的研究中，[Gunasekar et al. (2023)](https://arxiv.org/abs/2306.11644)强调了高质量训练数据在他们的模型中的重要性。他们认为，如果语言模型是在类似于备受推崇的“教科书”特征的材料上训练的，那么它们将会更有效：清晰、全面、信息丰富且无偏见。

这些原则构成了创建一个用于训练名为Phi-1的LLM的半合成数据集的基础。主要评估任务是生成一个遵循给定文本描述或文档字符串的Python函数。模型的质量使用HumanEval基准[(Chen et al., 2021)](https://arxiv.org/abs/2107.03374)来评估。

作者强调了这种方法中多样性的重要性有几个原因。它使语言模型接触到各种编码表达和问题解决方法，减少了过度拟合或依赖特定模式的风险，并提高了模型处理不熟悉或创新任务的能力。

为了解决编写代码的挑战，作者创建了类似教科书的文档，这些文档关注于促进推理和基本算法技能的主题。他们通过对以下方面施加限制来实现多样性：

- 主题
- 目标受众

遗憾的是，作者没有提供用于生成合成数据的提示模板的具体信息。然而，他们确实展示了结果输出。他们选择使用ChatGPT（GPT-3.5）而不是GPT-4，即使这样，因为他们使用合成数据微调了模型，也取得了优秀的结果。

![](/assets/img/llm_prompt/textbooks_1.webp)

关注目标受众的限制非常重要。指定目标受众是增强合成数据多样性的绝佳方法。高中生、计算机科学本科生和博士研究生在表达解释和处理信息方面肯定有所不同，这使得生成的数据变得更加多样化。让我们尝试重现这个提示。

Prompt：
```
编写一个适用于计算机科学专业一年级本科生的教科书摘录。编码语言为Python 3.6。
以下是关于“奇异矩阵”主题中间段落的摘录。
摘录从该主题的高层概述开始。然后，它提出一个例子，并用自然语言描述解决方案。之后，它提供1-2个代码片段，紧接着该例子。每个片段不超过10行。代码片段之后不应有文本。
请记住，摘录应该简洁，并且一次只解释一个概念。代码应该代表一个Python函数及其调用。所有常见的ML/DS库都可用。
不要过于冗长。摘录的预期长度最多为两段。
```

Output:
```
奇异矩阵

在线性代数中，如果一个矩阵没有逆矩阵，那么这个矩阵被称为“奇异”的。等价的定义是矩阵的行列式为零。奇异矩阵至关重要，因为它们代表的线性方程组没有唯一解。

考虑一个2x2矩阵 [[a, b], [c, d]]。如果 ad 和 bc 的乘积相同（即 ad = bc），那么这个矩阵就是奇异的。我们用一个例子来探讨这个情况：给定矩阵 [[2, 4], [1, 2]]，你会发现对角线的乘积得到相同的结果（2 * 2 = 4 * 1），因此它是一个奇异矩阵。

import numpy as np

def is_singular(matrix):
    determinant = np.linalg.det(matrix)
    return abs(determinant) < 1e-9

matrix_example = np.array([[2, 4], [1, 2]])
print(is_singular(matrix_example))  # 返回 True
```

### 代码生成
类似ChatGPT的大型语言模型（LLM）在代码生成方面非常有效。在本节中，我们将介绍如何使用ChatGPT进行代码生成的许多示例。

下面所有的示例都使用了OpenAI的Playground（聊天模式）和gpt-3.5-turbo模型。

与OpenAI的所有聊天模型一样，你可以使用系统消息来定义响应的行为和格式。我们将使用以下系统消息作为提示示例：
```
你是一个有用的代码助手，可以教初级开发者如何编码。你选择的语言是Python。不要解释代码，只生成代码块本身。
```

#### 基础示例
用户消息将是提示本身，包含你希望模型生成的特定代码的指令。下面是第一个用于代码生成的基本提示的快照。注意，最终的代码是由助手生成的。
![](/assets/img/llm_prompt/chat-mode.webp)

这是提示原文，如果你想自己尝试的话：
```
Write code that asks the user for their name and say "Hello"
```

#### 将注释转换为代码
你还可以利用这些大型语言模型（LLM）的代码生成能力，仅从注释生成代码。让我们来看一个将指令作为注释块传递的另一个例子：

Prompt:
```
"""
1. Create a list of movies
2. Create a list of ratings for these movies
3. Combine them to make a json object of 10 movies with their ratings.
"""
```

Output:
```python
movies = ["The Shawshank Redemption", "The Godfather", "The Dark Knight", "Schindler's List", "Pulp Fiction", "The Lord of the Rings: The Return of the King", "Forrest Gump", "Star Wars: Episode V - The Empire Strikes Back", "Inception", "The Silence of the Lambs"]
 
ratings = [9.3, 9.2, 9.0, 8.9, 8.9, 8.9, 8.8, 8.7, 8.7, 8.6]
 
movie_ratings = {}
 
for i in range(len(movies)):
    movie_ratings[movies[i]] = ratings[i]
 
json_object = json.dumps(movie_ratings, indent=4)
 
print(json_object)
```

生成的代码看起来像是可以工作的代码。然而，输出中缺少一个重要的导入语句，即`import json`。虽然这些模型生成的是可工作的代码，但你必须密切注意这样的小细节，并始终确保测试你的代码。