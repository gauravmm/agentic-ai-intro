# Introduction

What AI means.

Paradox: AI won't make working easier, it will increase competition and make working harder.

Slopmerchant meme

Security issues.

Prereqs:

1. Create a [GitHub account](https://github.com/) with your @*.edu.sg email
2. Sign up for the [Education](https://github.com/education/students) promotion (free access to Codespaces and Copilot)
3. Form up in groups of 2--3.

## AI Basics

### What is AI?

### What is a LLM?

- Fancy autocomplete.
- Explain basic attention model.
  - This is ridicuously inefficient and takes way too long to train, but it works!
- Structure
  - Mixture of experts
  - Multimodal

Explain the fundamental limits:

- what is a token
  - <https://platform.openai.com/tokenizer>
- how is usage billed
  - token in
  - token out
  - storage
- context window
  - limit anxiety
  - compaction

#### What does it mean for an LLM to know?

1. Chinese room experiment (?)
2. Wittgensteins lion
3. Paperclip maximizer

Set of things that are obvious to you, or the standpoint you communicate from is not always obvious.

You need to evaluate your AI for **alignment**, especially for resistance to wandering off and doing absurd things.

### What is Agentic AI?

Examples:

- Show a real-world agentic AI example (e.g., GitHub Copilot, AutoGPT)

Explain the basic loop: input, tool, interaction, output

What is a:

- Agent
- Skill
- Tool use
- MCP

## Agent Patterns and Practice

### Patterns

Common patterns:

- Vibe coding
- AI Driven AI Development
- Actor-Critic
- Complexity Ladder
  - Consistency checking
- Test Driven Development

Skills are **transferrable descriptions of an ability**, typically how to break down a problem into subparts and solve them, or how to interact with a tool.

- Skill Examples
  - <https://github.com/blader/humanizer>
  - <https://github.com/jezweb/claude-skills>
  - <https://github.com/forrestchang/andrej-karpathy-skills>

### Using LLMs in Practice

- Human-in-the-loop model
  - Autocomplete
  - Interactive
  - Hands-off Development
    - PR Generation
    - Issue Triage
    - Site Reliability Engineering

- How to write a prompt
  - <https://developers.openai.com/api/docs/guides/prompt-engineering/>
  - <https://developers.openai.com/cookbook/examples/gpt-5/gpt-5_prompting_guide>
  - <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview>
  - Shockingly good (but unofficial) resource: <https://github.com/ThamJiaHe/claude-prompt-engineering-guide/blob/main/Claude-Prompt-Guide.md>
  - Why are you doing this yourself? Ask the AI!
    - AI can help generate prompts from examples.
