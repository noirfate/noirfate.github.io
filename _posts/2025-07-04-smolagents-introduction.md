---
title: SmolAgents Introduction
layout: post
categories: llm
tags: llm
date: 2025-07-04 08:00
excerpt: SmolAgents Introduction
---

{:.table-of-content}
* TOC
{:toc}

# SmolAgents Introduction

## 引言
在人工智能快速发展的今天，AI Agent（智能体）已成为连接大语言模型能力与现实世界任务的重要桥梁。然而，现有的Agent框架往往过于复杂，学习成本高，部署困难。为了解决这些痛点，HuggingFace推出了Smolagents，它是一个简单、轻量、功能强大的`AI Agent`框架

## 特点
### 轻量
代码少，项目结构简单
### CodeAgent
`Thinking in Code`，与以往通过`json`调用工具不同，`CodeAgent`通过编写`python`代码来完成任务、调用工具，可实现多种工具的组合调用。国内知道创宇近期也推出了他们的Agent框架（AiPy），使用所谓`Python-Use`范式，比`CodeAgent`更进一步，不需要工具（虽然也支持MCP），所有一切都用`python`代码实现
- 支持多种大模型
    - InferenceClientModel: Uses Hugging Face’s Inference API to access models
    - TransformersModel: Runs models locally using the Transformers library
    - VLLMModel: Uses vLLM for fast inference with optimized serving
    - MLXModel: Optimized for Apple Silicon devices using MLX
    - LiteLLMModel: Provides access to hundreds of LLMs through LiteLLM
    - LiteLLMRouterModel: Distributes requests among multiple models
    - OpenAIServerModel: Provides access to any provider that implements an OpenAI-compatible API
    - AzureOpenAIServerModel: Uses Azure’s OpenAI service
    - AmazonBedrockServerModel: Connects to AWS Bedrock’s API
### 支持MCP
可为agent添加mcp服务，支持`stdio`、`http stream`和`sse`
### 多模态支持
可以发送多模态消息（需要大模型支持）
    - `vision_web_browser.py`：它实现了一个简单的大模型操作浏览器的代理，利用`helium`操作浏览器并截图发送给大模型
    - `default_tools.py`：在内置工具集里面实现了一个`SpeechToTextTool`的工具，调用`whisper`模型将语音转为文字
### 多智能体
支持集成多个子agent，主agent可像调用工具一样调用子agent，子agent中可以调用工具执行复杂任务，而不会干扰到主agent的会话历史记录
- 支持多种代码执行方式
    - local：本地执行
    - docker：在docker容器中执行
    - e2b：在e2b沙箱中执行
    - wasm：在wasm环境中执行（Pyodide + Deno）
### 观测支持
使用`Phoenix`和`OpenTelemetry`对大模型的执行进行观测
- ReAct推理框架
使用`ReAct`多步推理行动框架，将智能体的行为明确划分为“推理”（Reasoning）和“行动”（Acting）两个阶段，清晰地展现智能体在决策过程中的内部思考过程。在每一步中，智能体首先输出一个明确的“Thought”（思考过程），接着输出一个具体的“Action”（执行的动作），agent执行这个动作并返回“Observation”（观察结果），这一过程不断重复，通过交替的推理和行动过程逐步逼近最终答案
### 阶段性回顾
在agent执行过程中可配置阶段性回顾，每执行若干步骤之后，大模型会总结当前进展并重新规划，降低跑偏率

## 案例

### 集成MCP
在`mcp_client.py`中，`smolagents`将mcp转换为tool供agent使用，例如：
```python
with MCPClient(...) as mcp_tools:
    model = LiteLLMModel(**model_params)
    agent = CodeAgent(
        tools=mcp_tools,
        model=model,
        additional_authorized_imports=["*"]
    )
```

### 执行观测
- 运行`phoenix`服务
```shell
python -m phoenix.server.main serve
```
- 在代码中添加
```python
from phoenix.otel import register
from openinference.instrumentation.smolagents import SmolagentsInstrumentor

register()
SmolagentsInstrumentor().instrument()
```
- 观测
通过浏览器打开`phoenix`服务监听的端口即可查看执行记录
![](/assets/img/smolagents01.png)

### 开源深度研究
这个是利用`CodeAgent`对OpenAI深度研究的复现，官方称其在研究任务上具备与OpenAI相近的性能表现，在GAIA验证集上能够达到55%的pass@1准确率，而OpenAI深度研究的成绩为67%

运行`python app.py`，在界面中输入待研究的问题，开始研究
![](/assets/img/smolagents02.png)

### RAG
官方在文档中分析了传统RAG的局限以及代理式RAG（Agentic RAG）的长处

传统RAG的不足：
- 单次检索：如果初始检索结果不佳，则最终生成的内容质量也会受影响
- 查询与文档不匹配：用户查询（通常是问题）可能与包含答案的文档（通常是陈述）匹配度不佳
- 有限推理：简单的RAG流程无法实现多步推理或查询优化
- 上下文窗口限制：检索的文档必须适配模型的上下文窗口

代理式RAG的优势：
- 查询优化：Agent能够将用户问题转化为便于检索的查询
- 多次检索：Agent能够根据需要进行多次检索
- 基于检索推理：Agent能够分析综合从多个来源检索到的信息得出最终结论
- 自我改进：Agent能够评估检索结果并调整其方法

#### 本地RAG示例
在`example/local_rag`中实现了一个简单的本地`RAG`用例
- 收集文档
把文档放入`my_documents`文件夹中
- 构建RAG数据库
```shell
python rag_database_builder.py
```
- 运行集成RAG的Agent
```shell
python rag_tool.py
```
![](/assets/img/smolagents03.png)
