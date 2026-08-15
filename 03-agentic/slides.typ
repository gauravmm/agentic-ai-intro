#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

#import "@preview/tiaoma:0.3.0": qrcode
#import "@preview/numbly:0.1.0": numbly
#import "/common.typ": big-section-slide, gblock, lblock

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(new-section-slide-fn: big-section-slide),
  config-info(
    title: [Agentic AI for Beginners],
    subtitle: [A Zero-Code Introduction],
    author: [Dr. Gaurav Manek, Ocellivision, IMCB],
    date: datetime.today(),
    institution: [Ocellivision + A*STAR BMRC],
    logo: [🤖💥🧠🧑‍💻],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

// Labelled row item: bold title + inline description, fills grid cell height.
#let label-item(title, body) = box(
  fill: luma(240),
  width: 100%,
  height: 100%,
  radius: 0.5em,
  outset: (left: 0.5em, right: 0.5em),
  inset: (top: 0.5em, bottom: 0.5em),
  [#text(size: 1.2em, weight: "bold")[#title] \ #body],
)

#let similar(items) = lblock(inset: (x: 0.6em, y: 0.4em), outset: 0pt)[
  #text(size: 0.85em, fill: luma(80))[#text(
      weight: "bold",
    )[Other examples] --- #items]
]

#title-slide()

= What is Agentic AI?

== What is Agentic AI?

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Simple LLM*
    #include "figures/simple-llm.typ"
    #pause
  ],
  [
    *Agentic AI*
    #include "figures/agentic-loop.typ"
  ],
)

#speaker-note[
  - Bridge from 01: they've seen LLM at the token level
  - Now: what happens with a loop + tools
  - "chatbot vs agent" is shorthand — don't over-define
]


== Anatomy of an Agent


#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    An *agent* is an LLM with a harness. The harness:

    - Provides access to *tools*: \
      - read files, run code, call APIs
      - spin up *sub-agents*
      - specialized prompts (`SKILLS.md`)

    - runs in a *loop*: \
      - act → observe → act again
      - It can decide to keep running or stop

    #v(0.5em)

    #lblock(inset: (x: 1.1em, y: 1em), outset: 0pt)[
      *Same LLM*, new prompt: \
      _"Given this goal, what do I do next?"_
    ]
  ],
  [
    *Agentic AI*
    #include "figures/agentic-loop.typ"
  ],
)

#speaker-note[
  - Same LLM, richer tooling
]


== Key Vocabulary

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  align: top,
  row-gutter: 1em,
  column-gutter: 1.5em,
  text(weight: "bold", size: 1.5em)[Agent],
  text(weight: "bold", size: 1.5em)[Skill],
  text(weight: "bold", size: 1.5em)[Tool Use],
  text(weight: "bold", size: 1.5em)[Sub-agents],

  gblock(inset: (y: 0.2em), outset: 0.5em)[
    *LLM + harness*

    Harness _orchestrates_ the LLM, running it in a loop and giving it access to tools.

    Acts autonomously toward a goal.
  ],
  [
    #gblock(inset: (y: 0.2em), outset: 0.5em)[
      *portable ability*

      Instructions and tools to perform a task, reusable across projects and models.
    ]

    #align(center, [
      #sym.arrow.t \
      Our next task!
    ])
  ],
  gblock(inset: (y: 0.2em), outset: 0.5em)[
    *external functions*

    Search the web, run code, read files, call APIs, use MCPs.

    The model decides *when* and *how* to call them.
  ],
  gblock(inset: (y: 0.2em), outset: 0.5em)[
    *agents as tools*

    Spawn independent agents, give them goals and tools, and merge results.

    Enables parallelism, specialisation, and delegation.
  ],
)

#speaker-note[
  - "Agent" = pattern, not a product
  - Skills: portable, lazy-loaded
  - Tools: how agents interact with the world
  - Sub-agents: powerful, token-heavy — use cheaper LLMs
]

== Common Patterns

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  // Array form of `align` is per-column, not per-row — use the (x, y) function so the
  // wrapped "Adversarial Review" title sits on the same baseline as the single-line ones.
  align: (x, y) => if y == 0 { bottom } else { top },
  row-gutter: 1em,
  column-gutter: 1.5em,
  text(weight: "bold", size: 1.5em)[Vibe Coding],
  text(weight: "bold", size: 1.5em)[Adversarial Review],
  text(weight: "bold", size: 1.5em)[Test-Driven],
  text(weight: "bold", size: 1.5em)[Spec-Driven],

  gblock(inset: (y: 0.2em), outset: 0.5em)[
    *prompt first, plan never*

    Iterate until it feels right.

    Fast for throwaway work, but _technical debt_ piles up. Know when to stop.
  ],
  gblock(inset: (y: 0.2em), outset: 0.5em)[
    *actor and critic*

    One prompt generates, a _different_ prompt attacks it.

    The critic prompt matters more.
  ],
  gblock(inset: (y: 0.2em), outset: 0.5em)[
    *evals first*

    Write test cases and expected outputs, then prompt until they pass.

    Evals are to AI what unit tests are to software.
  ],
  gblock(inset: (y: 0.2em), outset: 0.5em)[
    *one rung at a time*

    Escalate complexity step by step, checking consistency.

    The spec is the source of truth, not the chat log.
  ],
)

#pause

#v(0.8em)

#align(center)[
  _"it's no use trying to eat a steak with a teaspoon and a straw."_ (Anthony T. Hincks)
]

#speaker-note[
  - Name the patterns now; we'll see all four in the wild over the next few slides
  - Not rigid — they overlap and compose (vibe + adversarial review is common)
  - Vibe coding: natural starting point, fine for short-lived scripts; danger is vibe-coded → production
  - Actor-critic mirrors senior reviewing junior — same model, two prompts: "write it" / "find every flaw"
  - Most people skip evals because they feel like overhead; without them prompt changes = invisible regressions
  - 10-20 examples turn guesswork into iteration; related trick: give 5 I/O pairs, ask for the system prompt
  - \~2 min total — don't linger, the examples do the teaching
]

= Real-World Agents

== Agents in the Wild

#grid(
  columns: (1fr, 1fr),
  rows: (auto, auto),
  align: top,
  gutter: 1em,
  // Animation trick: grid.cell(x:, y:) lets us decouple layout position
  // from source order. Touying processes #pause / #meanwhile in source
  // order, so we list cells in the order we want them to appear:
  //   1. copilot logo (subslide 1)
  //   2. copilot bullets — #meanwhile rewinds it back to subslide 1,
  //      so logo + bullets reveal together
  //   3. #pause → openclaw logo + bullets (subslide 2)
  grid.cell(x: 0, y: 0, align: bottom, image("media/copilot.png", width: 90%)),
  grid.cell(x: 0, y: 1)[
    #meanwhile
    - Started as inline autocomplete
    - Now: *Copilot Workspace*
      - fully hands-off agentic AI
      - interact with it like a remote developer
      - reads issues, fix the code, opens PRs
      - reviews PRs for humans or AI

    #v(1fr)
    #similar[Claude Code, OpenAI Codex, OpenCode, Cursor]

    #pause
  ],
  grid.cell(x: 1, y: 0, align: bottom, image(
    "media/openclaw-logo-text-dark.png",
    width: 90%,
  )),
  grid.cell(x: 1, y: 1)[
    - Personal AI agent
    - Runs on your machine; triggered via *messaging apps*
      (WhatsApp, Slack…)
    - Can run shell commands, browse the web, read/write files, send email
    - *Self-improving*: LLM writes and saves new skills for itself
    - Open marketplace for new skills and tools
    - MIT license, bring your own API key

    #v(1fr)
    #similar[KittenClaw, NVIDIA NemoClaw, Manus AI, BytePlus ArkClaw]
  ],
)

---

#grid(
  columns: (1fr, auto),
  align: horizon,
  gutter: 2em,
  [
    *Meta's director of AI alignment lost her emails.*
    #v(1em)
    _I had to run to my Mac mini like I was defusing a bomb._

    #align(right)[-- Summer Yue]
  ],
  image("media/meta_email.png", height: 100%),
)


---

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: top,
  [
    #box(baseline: 0.45em, image("media/jpmorgan.png", height: 1.6em)) #h(
      0.4em,
    ) #text(
      weight: "bold",
      size: 1.3em,
    )[Ask D.A.V.I.D.]\
    #text(size: 0.9em, fill: luma(100))[Multi-agent investment research]

    #v(0.3em)
    - *Supervisor* agent + *specialist* sub-agents \
      (SQL, RAG, analytics)
    - Human advisor *reviews every output* before it reaches a client
    - \~95% reduction in research time

    #v(1fr)
    #similar[Morgan Stanley AI Assistant, Goldman GS AI, DBS Joy]
  ],
  [
    #image("media/hippocratic.png", height: 2cm)
    #v(0em)
    #text(size: 0.9em, fill: luma(100))[Voice agents for healthcare]

    #v(0.3em)
    - Post-discharge follow-up, medication walkthroughs
    - 180M+ patient interactions; *0 reported severe-harm events*
    - "Polaris" safety architecture, validated by 7,500+ clinicians
    - *Scope is the alignment* --- never diagnoses, only educates

    #v(1fr)
    #similar[Abridge, Suki, Nuance DAX Copilot]
  ],
)

#speaker-note[
  - Two production agents, two patterns
  - Ask David: supervisor + specialists + HITL — exactly what students will build today
  - Hippocratic: alignment by *scope*, not by post-hoc guardrails — low blast radius is a design choice
  - Tie back to designing for imperfect agents
]


---

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: top,
  [
    #image("media/klarna.png", height: 2cm)
    #v(0em)
    #text(size: 0.9em, fill: luma(100))[Customer support that went "too far"]

    #v(0.3em)
    - Feb 2024: claimed work of *700 reps*,
      - \$40M profit boost
    - Quality decayed on disputes, fraud, bereavement
    - May 2025: CEO walked it back
      - _"we went too far"_
      - _"what you end up having is lower quality,"_


    #v(1fr)
    #similar[Intercom Fin, Decagon, Sierra, Salesforce Agentforce]
  ],
  [
    #image("media/sakana.svg", height: 2cm)
    #v(0em)
    #text(
      size: 0.9em,
      fill: luma(100),
    )[AI Scientist caught specification gaming]

    #v(0.3em)
    - Autonomous research agent --- writes, runs, evaluates experiments
    - Exploited its *eval sandbox* to skip correctness checks
    - Edited its own runtime to *extend timeouts*
    - Did *exactly what was measured*

    #v(1fr)
    #similar[OpenAI o1 oversight evasion (Apollo), GPT-4 TaskRabbit CAPTCHA, Anthropic reward-hacking studies]
  ],
)

#speaker-note[
  - Two real-world specification-gaming stories
  - Klarna: the triage-bot warning slide, named brand
  - Sakana: textbook reward hacking — agent literally rewrote its own eval
  - Both reinforce: the metric you measure becomes the goal the agent pursues
]

== Agent Design Frameworks

#grid(
  columns: (7fr, 3fr),
  rows: (1fr,),
  gutter: 1em,
  align: horizon,
  block(
    width: 100%,
    height: 100%,
  ),
  [
    #v(1em)
    #text(
      weight: "bold",
      size: 1.3em,
    )[LangFlow]

    Design agents visually as *graphs of components* --- or as code.

    #v(1fr)
    #similar[LangGraph, Flowise, AutoGen, CrewAI, n8n, Dify, *PowerAutomate*]
  ],
)
#place(right + horizon, dx: -8.5cm, image("media/langflow.png", height: 100%))


#speaker-note[
  - Visual editors let non-coders compose agents
  - Code frameworks (LangGraph, AutoGen, CrewAI) for serious work
  - Same complexity-ladder warning: drag-and-drop ≠ free pass on evals
]

// Full-bleed image slide: drop the right + bottom margins via slide config
// (a mid-slide `#set page` would inject a blank page in touying).
== Dynamic Agent Workflows
#slide(
  config: config-page(margin: (top: 3em, bottom: 0pt, left: 2em, right: 0pt)),
)[
  // `overlap`: width of the text box. Raise it to extend the text rightward
  // over the image; lower it to pull the text back to the left.
  #let overlap = 7cm
  #box(width: 100%, height: 100%)[
    #place(right + horizon, image("media/whatsapp-1.jpeg", height: 100%))
    #place(left + top, dy: 1em, box(width: overlap, text(
      size: 1.8em,
      weight: "bold",
    )[This is Anthropic's idea of the future.]))
  ]

  #speaker-note[
    - Agent teams (left): a few agents talk peer-to-peer
    - Dynamic workflows (right): one orchestrator fans out to N tasks — implementer → verifiers → fixer — then returns when done
    - N can be in the hundreds: this is the autonomous end of the complexity ladder
  ]
]

// Full-bleed image slide: drop the right + bottom margins via slide config
// (a mid-slide `#set page` would inject a blank page in touying).
#slide(
  config: config-page(margin: (top: 3em, bottom: 0pt, left: 2em, right: 0pt)),
)[
  // `overlap`: width of the text box. Raise it to extend the text rightward
  // over the image; lower it to pull the text back to the left.
  #let overlap = 7cm
  #box(width: 100%, height: 100%)[
    #place(right + horizon, image("media/whatsapp-2.jpeg", height: 100%))
    #place(left + top, dy: 1em, box(width: overlap, text(
      size: 1.8em,
      weight: "bold",
    )[This is Anthropic's idea of the future.

      #emph[Maybe].]))
  ]

  #speaker-note[
    - Same diagram, now with the price tag attached
    - Every box is a model call; fan-out multiplies token spend fast
    - The fat cat got rich on your bill — budget and cap autonomous runs before you let them loose
  ]
]


= Anatomy of an Agent

== Skills


#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    #lblock(inset: (y: 0.5em), outset: (x: 0.5em))[
      *Skills* are portable descriptions of an ability.

      - break a problem into parts,
      - interact with a tool,
      - structure some output,
      - interpret some input, _etc._
    ]

    Use:
    - Written as *human-readable text* \
      #text(size: 0.9em)[(prompt, playbook, structured guide)]
    - Shared across projects and teams
    - May include specific *tools*
    - Portable across models
    - Lazily loaded
  ],
  [
    #let skill(repo, name, desc) = block(below: 0.6em)[
      #text(weight: "bold")[#repo\/#name]
      #v(-0.7em)
      #text(fill: luma(80), size: .8em)[#h(1em)#desc]
    ]

    #skill(
      "anthropics",
      "claude-for-legal",
    )[M&A diligence: bulk contract review.]
    #skill("anthropics/skills", "pptx")[Create & edit PowerPoint presentations.]
    #skill(
      "anthropics/skills",
      "skill-creator",
    )[The skill that writes new skills.]
    #skill(
      "asklokesh",
      "claudeskill-loki-mode",
    )[41 sub-agents, 8 swarms → shipped app.]
    #skill("blader", "humanizer")[Rewrite AI-sounding text.]
    #skill(
      "joshka0/foxctl",
      "foxctl-mobile",
    )[Drive iOS Simulator + Android Emulator.]
    #skill(
      "K-Dense-AI",
      "scientific-agent-skills",
    )[140+ skills, PubChem / ClinicalTrials / FDA.]
    #skill(
      "openclaw/skills",
      "ask-a-human",
    )[Crowdsource subjective calls to humans.]
  ],
)

#speaker-note[
  - Show humanizer: short file teaching a writing style
  - Skills compose with the complexity ladder — chain one per rung
]

== AI-Driven AI Development

#grid(
  columns: (1fr, 1fr),
  gutter: 3em,
  align: top,
  [
    #v(1fr)
    #lblock(inset: (y: 1em), outset: (x: 0.3em))[
      #align(center)[
        If AI can *follow* a skill…

        …AI can *write* a skill.
      ]
    ]
    #v(0.5em)

    #align(center)[*Close the loop* on self-improvement.]
    #v(0.5em)
    You prompt an AI \
    #sym.arrow.r.curve to improve the prompts \
    #sym.arrow.r.curve that make the next AI work better \
    #sym.arrow.r.curve ...and repeat!
    #v(1fr)
    #pause
  ],
  [
    #grid(
      columns: 1,
      rows: 1fr,
      gutter: 0.4em,
      label-item[Prompts][Write system prompts, few-shot examples, chain-of-thought templates],
      label-item[Evals][Generate test cases, edge cases, and expected outputs from a spec],
      label-item[Skills][Author reusable skill files for new tools or workflows],
      label-item[Agents][Scaffold entire sub-agent pipelines with tools and handoffs],
    )
  ],
)

#speaker-note[
  - The recursive slide — students laugh nervously
  - Prompt eng moving from human skill → AI task
  - Claude Code writes its own skills (we've used some today)
  - Ask: "Who's had AI write a prompt for AI?" — most hands up
]


// Alternative task (event help desk) — swap back in if running that one instead.
/*
== Next Task: Event Help Desk

#v(0.4em)

#include "figures/event-flow.typ"

#speaker-note[
  - Next hands-on: fix the event help desk (ai-tutorial-eventbot-kittenclaw repo)
  - It ships broken on purpose: a goose, a fake booking desk, a clash rule that misses B3
  - The PDFs are what a *person* was handed; the `.md` files are what the *bot* knows — every interesting question lives in that gap
  - "B2 is in Room 202" is the stale-brochure trap: it must correct them and hold its ground
  - Ask about SPK-008 → B3 is internal-only; the leak is structural, no fifth sentence fixes it
  - There is a grader skill: ten reference attendees, a score, so prompt edits stop being guesswork
]
*/

== Next Task: Multi-Agent Triage

#v(0.4em)

#include "figures/triage-flow.typ"

#v(0.8em)

#lblock(inset: 0.7em, outset: 0pt, align(center)[
  The triage bot must gather information for the *reporter*.
])


#speaker-note[
  - Next hands-on: build the two bots (ai-tutorial-triage-kittenclaw repo)
  - Triage = KittenClaw (Telegram), reporter = a Copilot skill
  - They coordinate only through conversation files on disk — no direct channel
  - The catch: triage must collect name/age it never uses, because the reporter needs it — a cross-agent contract
  - All behaviour lives in the prompt; send /clear after editing SYSTEM.md
]



#focus-slide(config: config-page(margin: 1em))[
  #grid(
    columns: (1.5fr, 1fr),
    align: horizon,
    gutter: 1em,

    [
      #v(1fr)
      #set align(left)
      #set list(marker: text(fill: rgb("#6b9c71"))[#sym.ballot], spacing: 1em)
      - *Telegram bot token* from `@BotFather`
      - Get *AI model key*\
        #text(size: 0.8em)[*Google AI Studio*, *OpenCode*, or *OpenRouter*]
      - Install both keys in the repo (`.env`)
      - Read `SYSTEM.md`
      - Message the bot over Telegram
      #v(1fr)
    ],
    [
      #box(fill: white, inset: 1em)[
        #qrcode("https://manek.sg/agentic-6", width: 8cm)
      ]\
      #text(font: "DejaVu Sans Mono", size: 1.2em)[
        manek.sg/agentic-6
      ]
    ],
  )
]
