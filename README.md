# AI Workshop

Notes and slides for the hands-on Agentic AI workshop at the **NTU BMES Makerspace Hackathon**.
Presenter: Dr. Gaurav Manek, A\*STAR.

Slides and tasks were produced with the assistance of Claude Opus 4.6, Claude Haiku 4.5, OpenAI GPT-4.1, and OpenAI GPT-4o.

## Prerequisites

Before the workshop, each student should:

1. Create a [GitHub account](https://github.com/) with your `@*.edu.sg` email
2. Sign up for the [GitHub Education](https://github.com/education/students) promotion (free Codespaces + Copilot)
3. Form up in groups of 2-3

## Workshop Flow

### 1. Introduction ([01-introduction/](01-introduction/))

- What is a Large Language Model? (attention, mixture of experts, multimodal)
- Fundamental limits: tokens, billing, context windows
- What does it mean for an LLM to "know" something? (alignment, Chinese room, Wittgenstein's lion)
- How to write a prompt

### 2. Task: Label Design ([02-label-design/](02-label-design/))

Generate a medical device label for LUMENCO's consumables kit using Typst.

**Task:** Implement `labelgen.typ` to produce a label with ISO 7000 icons, a QR code, and a dashed cut line.

**Advanced:** Generate 1,000 unique labels with sequential serial numbers; add FDA CFR 21 Part 801 / UDI compliance.

**Discussion questions:**

- What was your agent's first action? Why?
- How did your agent handle missing resources?
- Did your agent ask for clarification? When?
- How did your agent verify its solution worked?

### 3. Agentic AI ([03-agentic/](03-agentic/))

- The agent loop: input → tool use → interaction → output
- Key concepts: agents, skills, tool use, MCP
- Common patterns: vibe coding, actor-critic, complexity ladder, test-driven development
- Human-in-the-loop models: autocomplete → interactive → hands-off

### 4. Task: Multiagent Triage Bot ([04-multiagent-triage/](04-multiagent-triage/))

Build two cooperating agents in Python:

- **`triage-bot`** — talks to patients, collects symptoms, and either schedules an appointment or directs them to the ER
- **`reporter-bot`** — reads a completed conversation log and extracts structured intake data (name, sex, age, symptoms, triage level)

**Discussion questions:**

- Can you break the bot's safety or liveness guarantees? How do you mitigate that?
- Does it try to use external tools on its own? Is that a risk?
- Did the triage tool ever fail validation? How does backpressure help?
- If we know we need to escalate, should we still gather details first?
