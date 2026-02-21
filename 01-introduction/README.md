# Introduction

Prereqs:

1. Create a [GitHub account](https://github.com/) with your @*.edu.sg email
2. Sign up for the [Education](https://github.com/education/students) promotion (free access to Codespaces and Copilot)
3. Form up in groups of 2--3.

## AI Basics

What AI means.

Paradox: AI won't make working easier, it will increase competition and make working harder.

Slopmerchant meme

Security issues.

### What is a Large Language Model?

- Type of AI
- Fancy autocomplete.
- Explain basic attention model.
  - This is ridicuously inefficient and takes way too long to train, but it works!
- Structure
  - Mixture of experts
  - Multimodal

#### Fundamental limits

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

### How to write a prompt

- <https://developers.openai.com/api/docs/guides/prompt-engineering/>
- <https://developers.openai.com/cookbook/examples/gpt-5/gpt-5_prompting_guide>
- <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview>
- Shockingly good (but unofficial) resource: <https://github.com/ThamJiaHe/claude-prompt-engineering-guide/blob/main/Claude-Prompt-Guide.md>
- Why are you doing this yourself? Ask the AI!
  - AI can help generate prompts from examples.
