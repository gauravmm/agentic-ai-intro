# AI Workshop

Notes and slides for the hands-on Agentic AI workshop at the **NTU BMES Makerspace Hackathon**.
Presenter: Dr. Gaurav Manek, A\*STAR.

Slides and tasks were produced with the assistance of a wide range of AI models, including most of Anthropic's Claude family and OpenAI's GPT family.

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

### 2. Task: Prescription Scraping ([02-prescription-scraping/](02-prescription-scraping/))

Use an AI agent to extract eyeglass prescription data from a folder of plain-text files — exported by four different optical clinic systems, each with its own layout and quirks — and consolidate it into a single clean CSV.

**Task:** Produce `prescriptions.csv` (one row per prescription) with the required columns. Watch for the traps: multiple prescriptions per file (previous vs. current), monocular vs. binocular PD, clinical noise, and `DS`/`N/A` markers that should become empty cells.

**Check your work:** `python check.py` runs four levels of validation (structure, value sanity, aggregate checksums, per-source breakdown).

**Advanced:** Annotate each sentence of your final prompt with the failure mode it guards against; make the prompt robust to malformed files via sentinel values.

**Discussion questions:**

- What was your agent's first action? Why?
- How did your agent handle the missing resources? Did it ask permission to access the hinted library?
- Did your agent ask for clarification? When?
- How did your agent verify its solution worked?

### 3. Agentic AI ([03-agentic/](03-agentic/))

- The agent loop: input → tool use → interaction → output
- Key concepts: agents, skills, tool use, MCP
- Common patterns: vibe coding, actor-critic, complexity ladder, test-driven development
- Human-in-the-loop models: autocomplete → interactive → hands-off

### 4. Task: Multiagent Triage Bot ([04-multiagent-triage/](04-multiagent-triage/))

Patients message a Telegram chatbot with their symptoms. Build two cooperating agents:

- **`triage-bot`** — KittenClaw, the Telegram bot in this repo. Its behaviour lives in `SYSTEM.md`. Edit the prompt so it collects symptoms, triages (minor/moderate → schedule an appointment; severe → escalate to the ER), and closes every call with `schedule_appointment`, `escalate`, or `no_further_action`.
- **`reporter-bot`** — a GitHub Copilot skill (`.agents/skills/reporter-bot/`) that reads finished conversations and writes structured intake reports (name, sex, age, symptoms, triage level) to `reports/`.

The catch: the triage bot must gather information it does not itself need (name, age) because the *reporter* needs it.

**Discussion questions:**

- **Liveness:** can you get the bot to schedule an appointment that was not needed?
- **Safety:** can you get it to miss an emergency that should have been escalated? How would you mitigate that?
- **Communication:** does it always tell the patient *when* the appointment is?
- **Validation:** what happens on an invalid date? `schedule_appointment` rejects bad input — how does this "backpressure" help?
- **Tools:** should a triage bot be allowed to browse the web or run other tools? What's the risk?
- **Escalation:** if you already know you'll escalate, should you still gather details first?
