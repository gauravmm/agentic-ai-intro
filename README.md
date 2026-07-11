# AI Workshop

Slides for the hands-on **Agentic AI** workshop.
Presenter: Dr. Gaurav Manek, A\*STAR.

This repo holds the **slide decks only**. Each hands-on task lives in its own
repo — see [Task repos](#task-repos) below.

Slides and tasks were produced with the assistance of a wide range of AI models,
including most of Anthropic's Claude family and OpenAI's GPT family.

## Where this has been run

This workshop has been delivered to:

- **NTU BMES** — Makerspace Hackathon, [16 Mar 2026](https://gauravmanek.com/lectures/2026/ntu-bmes-workshop/)
- **TechWorks@ROCK, A\*STAR** — the "Agentic AI for Beginners" series: [4 Apr](https://gauravmanek.com/lectures/2026/astar-workshop-1/), [12 May](https://gauravmanek.com/lectures/2026/astar-workshop-2/), [22 Jun](https://gauravmanek.com/lectures/2026/astar-workshop-4/) 2026.
- **MedTech Catapult / DxDHub** — [special session](https://gauravmanek.com/lectures/2026/astar-workshop-3/) (13 May 2026)
- **A\*STAR BMRC HQ** and related units

See the full [talks & workshops list](https://gauravmanek.com/lectures/) for details, including the intermediate [Build Your Own Agent](https://gauravmanek.com/lectures/2026/astar-intermediate-1/) follow-up.

## Prerequisites

Before the workshop, each student should:

1. Create a [GitHub account](https://github.com/).
2. Sign up for the [GitHub Copilot Free Tier](https://github.com/features/copilot/plans).
3. Form up in groups of 2-3

## Workshop Flow

### 1. Introduction ([01-introduction/](01-introduction/))

- What is a Large Language Model? (attention, mixture of experts, multimodal)
- Fundamental limits: tokens, billing, context windows
- What does it mean for an LLM to "know" something? (alignment, Chinese room, Wittgenstein's lion)
- How to write a prompt

### 2. Task — Data Extraction

**The kind of task:** a *non-interactive* agent job. Point an agent at a pile of messy, heterogeneous inputs — files exported by several different systems, each with its own layout and quirks — and ask it to produce one clean, structured output. You write the prompt; the agent runs to completion on its own. This exercises prompt robustness, handling missing resources and tools, edge cases, and — crucially — how the agent *verifies* its own work.

**Current task:** [ai-tutorial-scraping-prescriptions](https://github.com/gauravmm/ai-tutorial-scraping-prescriptions) — extract eyeglass prescription data from four clinics' plain-text exports into a single clean `prescriptions.csv`, then validate with `python check.py`. Watch for the traps: multiple prescriptions per file, monocular vs. binocular PD, clinical noise, `DS`/`N/A` markers that should become empty cells. *(Swap in a dataset closer to each group's domain.)*

**Discussion questions:**

- What was your agent's first action? Why?
- How did it handle missing resources — did it ask permission to reach for a hinted tool or library?
- Did it ask for clarification? When?
- How did it verify its solution worked — and did it verify at all before you handed it the checker?

### 3. Agentic AI ([03-agentic/](03-agentic/))

- The agent loop: input → tool use → interaction → output
- Key concepts: agents, skills, tool use, MCP
- Common patterns: vibe coding, actor-critic, complexity ladder, test-driven development
- Human-in-the-loop models: autocomplete → interactive → hands-off

### 4. Task — Interactive Use

**The kind of task:** a *multi-turn, human-in-the-loop* system, often with more than one agent. The agent holds a conversation, calls tools that have real side effects, and coordinates with other agents through a shared medium rather than a direct channel. This exercises liveness vs. safety guarantees, validation and "backpressure," cross-agent contracts (one agent gathering information another needs), and the risk of giving a conversational agent open-ended tool access.

**Current task:** [ai-tutorial-triage-kittenclaw](https://github.com/gauravmm/ai-tutorial-triage-kittenclaw) — a Telegram triage bot (KittenClaw) that collects symptoms and either schedules an appointment or escalates to the ER, plus a reporter agent that writes structured intake reports from the finished conversation. The catch: triage must gather details (name, age) it never uses itself, because the *reporter* needs them. *(Swap in a scenario closer to each group's domain.)*

**Discussion questions:**

- **Liveness:** can you get the agent to take an action that wasn't warranted?
- **Safety:** can you get it to miss a case that should have been escalated? How would you mitigate that?
- **Communication:** does it always tell the user the outcome and the details that matter?
- **Validation:** what happens on invalid input? How does rejecting bad input ("backpressure") catch bugs early?
- **Tools:** should a conversational agent be allowed to browse the web or run other tools? What's the risk?
- **Contracts:** when one agent must collect information for another, how do you keep that contract from silently breaking?

## Task repos

The hands-on tasks are separate repos so students can clone / fork them directly:

| Task | Repo | Status |
|------|------|--------|
| Prescription scraping | [ai-tutorial-scraping-prescriptions](https://github.com/gauravmm/ai-tutorial-scraping-prescriptions) | Current |
| Multiagent triage bot (via KittenClaw) | [ai-tutorial-triage-kittenclaw](https://github.com/gauravmm/ai-tutorial-triage-kittenclaw) | Current |
| ~~Medical device label generator~~ | [ai-tutorial-labelgen](https://github.com/gauravmm/ai-tutorial-labelgen) | Retired — earlier label-design task |
| ~~Multiagent triage (via GitHub Copilot Chat)~~ | [ai-tutorial-triage](https://github.com/gauravmm/ai-tutorial-triage) | Retired — superseded by KittenClaw |
