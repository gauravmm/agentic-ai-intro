#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

#import "@preview/tiaoma:0.3.0": qrcode
#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Agentic AI for Beginners],
    subtitle: [A Zero-Code Introduction],
    author: [Dr. Gaurav Manek, Ocellivision, IMCB],
    date: datetime.today(),
    institution: [Ocellivision + TechWorks\@ROCK],
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

#let gblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: luma(235),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]

#let lblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: white,
  stroke: 0.5pt + luma(220),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]

#let similar(items) = lblock(inset: (x: 0.6em, y: 0.4em), outset: 0pt)[
  #text(size: 0.85em, fill: luma(80))[#text(weight: "bold")[Other examples] --- #items]
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
  grid.cell(x: 1, y: 0, align: bottom, image("media/openclaw-logo-text-dark.png", width: 90%)),
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
    #box(baseline: 0.45em, image("media/jpmorgan.png", height: 1.6em)) #h(0.4em) #text(
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
    #text(size: 0.9em, fill: luma(100))[AI Scientist caught specification gaming]

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
    #similar[LangGraph, Flowise, AutoGen, CrewAI, n8n, Dify, LlamaIndex Workflows\
      #only("2-")[ *PowerAutomate*]~]
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

== Self-Evolving Swarms

#grid(
  columns: (1.4fr, 1fr),
  gutter: 1.2em,
  align: horizon,
  [
    *Swarming*: a new bet on where frontier capability comes from.
    - Not one giant model, but a *swarm of smartphone-grade models* working together.
    - The swarm thinks, verifies, and rewrites itself
    - The problem is recursively broken down and argued in smaller and smaller blocks instead of one big forward pass.
    - Typically reach _hundreds_ of agents per query.
    - They call this _Causal discovery + self-evolution_.

    #v(0.5em)
    #gblock[
      *The wager:* many small models that argue and audit each other vs workflows of expensive models.
    ]
  ],
  [
    #block(stroke: 0.5pt + luma(180), radius: 0.3em, clip: true, outset: 0.4em, fill: rgb("#FAFCFE"), image(
      "media/apodex.png",
      width: 100%,
    ))
    #place(bottom + right)[
      #text(size: 0.7em, fill: luma(110))[apodex.com --- _Apodex 1.0_, 2026]
    ]
  ],
)

#speaker-note[
  - This is speculative — a "coming strategy", not a shipped consensus
  - Contrast with the Anthropic "fan-out one big model" picture two slides back
  - Apodex's pitch: structural certainty, not statistical — output is auditable/traceable
  - Open question for the room: does many-small-models-arguing actually beat one-big-model? Nobody knows yet
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

    #skill("anthropics", "claude-for-legal")[M&A diligence: bulk contract review.]
    #skill("anthropics/skills", "pptx")[Create & edit PowerPoint presentations.]
    #skill("anthropics/skills", "skill-creator")[The skill that writes new skills.]
    #skill("asklokesh", "claudeskill-loki-mode")[41 sub-agents, 8 swarms → shipped app.]
    #skill("blader", "humanizer")[Rewrite AI-sounding text.]
    #skill("joshka0/foxctl", "foxctl-mobile")[Drive iOS Simulator + Android Emulator.]
    #skill("K-Dense-AI", "scientific-agent-skills")[140+ skills, PubChem / ClinicalTrials / FDA.]
    #skill("openclaw/skills", "ask-a-human")[Crowdsource subjective calls to humans.]
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


= Agent Patterns and Practice

== Common Patterns

// Numbered pattern list; pass highlight: int (1-5) to emphasise one item, none for all equal.
#let pattern-list(highlight: none) = {
  let items = (
    ([Vibe Coding], [Iterate fast; prompt first; fix later]),
    ([Actor-Critic], [One model generates; another evaluates]),
    ([Complexity Ladder], [Escalate task complexity step-by-step; check consistency at each rung]),
    ([Test-Driven Development], [Write tests first; work to pass them]),
  )
  v(.5fr)
  for (i, item) in items.enumerate() {
    let n = i + 1
    let dimmed = highlight != none and highlight != n
    let body-color = if dimmed { luma(180) } else { luma(80) }
    let title-color = if dimmed { luma(160) } else { black }
    [#n. #text(weight: "bold", size: 1.2em, fill: title-color, item.at(0)) \
      #text(fill: body-color, size: 0.9em, item.at(1))

    ]
  }
  v(1fr)
}


#grid(
  columns: (12cm, 1fr),
  gutter: 1em,
  align: top,
  [
    #pattern-list()
  ],
  [
    #pause
    #v(1fr)
    #lblock(inset: (x: 1.1em, y: 1em), outset: 0pt)[
      _"It's no use trying to eat a steak with a teaspoon and a straw."_

      #align(right)[— Anthony T. Hincks]
    ]
    #align(center, [
      Choose the *right* tool for each job.
    ])
    #v(1em)
    #align(center, [
      Industry best-practices evolve quickly. \
      *Follow them closely!*
    ])
    #v(1fr)
  ],
)

#speaker-note[
  - Not rigid; overlap and compose (vibe + actor-critic common)
  - Goal: name patterns so students recognise + discuss
  - \~30s here before going into each
]

== Vibe Coding

#grid(
  columns: (12cm, 1fr),
  gutter: 1em,
  align: top,
  [
    #pattern-list(highlight: 1)
  ],
  [
    #v(1fr)
    #text(weight: "bold")[What it is:]
    - Prompt first, plan never
    - Iterate until it feels right
    - Let the AI fill in the details

    #text(weight: "bold")[Works well when:]
    - Prototyping or exploring an idea
    - The task is small and throwaway
    - Speed $>>$ correctness

    Accumulates *technical debt* very fast because neither you nor the AI understands everything.
    #v(1fr)
    #lblock(inset: (y: 1em), outset: (x: 0.3em))[
      #align(center)[*Know when to stop vibing.*]
    ]
    #v(1fr)
  ],
)

#speaker-note[
  - Natural starting point; works for short-lived scripts
  - Danger: vibe-coded → production
  - Plausible code with subtle bugs you can't catch
  - Vibe → rigorous: actor-critic + TDD
]

== Actor-Critic

#grid(
  columns: (12cm, 1fr),
  gutter: 1em,
  align: top,
  [
    #pattern-list(highlight: 2)
  ],
  [
    #v(1fr)
    #text(weight: "bold")[Actor]
    - Generates output: code, a plan, a draft
    - Optimises for *plausibility*
    - Fast, creative, sometimes wrong

    #text(weight: "bold")[Critic]
    - Evaluates the actor's output
    - A *different prompt* with a different objective
    - Optimises for *correctness* / *safety* / *style*

    #v(1fr)
    #lblock(inset: (y: 1em), outset: (x: 0.3em))[
      #align(center)[
        The critic prompt is often *more important*\
        than the actor prompt.
      ]
    ]
    #v(1fr)
  ],
)


#speaker-note[
  - Mirrors senior reviewing junior
  - Actor: good enough for critic to improve, not perfect
  - Same model, two prompts: "write code" / "find every flaw"
  - Critic is adversarial by design
]

== The Complexity Ladder

#grid(
  columns: (12cm, 1fr),
  gutter: 1em,
  align: top,
  [
    #pattern-list(highlight: 3)
  ],
  [
    #v(1fr)
    Start simple, *add complexity in stages*.
    #v(0.5em)
    #let rung(n, shade) = box(
      fill: luma(shade),
      stroke: 0.4pt + luma(100),
      inset: (x: 0.6em, y: 0.4em),
      radius: 0.3em,
    )[*#n*]
    #grid(
      columns: (auto, 1fr),
      align: horizon,
      gutter: (0.4em, 0.5em),
      rung(4, 210), [Full multi-agent pipeline with tool use],
      rung(3, 220), [Single agent with memory + tools],
      rung(2, 230), [Chain of prompts with intermediate checks],
      rung(1, 240), [Single well-crafted prompt],
    )

    #v(1em)
    - Errors at lower rungs are cheaper to fix.
    - Aggressively check consistency in layers.

    #lblock(inset: (y: 1em), outset: (x: 0.3em))[
      #align(center)[
        *Match tool and problem complexity.*
      ]
    ]
    #v(1fr)
  ],
)

#speaker-note[
  - Match tool complexity to problem complexity
  - People jump to "full pipeline" → days debugging
  - Single-prompt would often have worked
  - Consistency checking at each rung = the discipline
]

== Test-Driven Development

#grid(
  columns: (12cm, 1fr),
  gutter: 1em,
  align: top,
  [
    #pattern-list(highlight: 4)
  ],
  [
    #v(1fr)
    *Classic TDD:*
    + Write a failing test
    + Implement until it passes
    + Refactor → Repeat

    *AI TDD:*
    + Prompt-engineer *evals* \
      (test cases, expected outputs)
    + Prompt-engineer until they pass
    + Refactor → Repeat

    #v(0.5em)

    #lblock(inset: (y: 1em), outset: (x: 0.3em))[
      #align(center)[
        Evals are to AI what unit tests are to software. \
        *Without them, you're flying blind.*
      ]
    ]
    #v(1fr)
  ],
)

#speaker-note[
  - Most skip evals — feels like overhead
  - Without them: prompt changes = invisible regressions
  - 10–20 examples transform guesswork → iteration
  - Related: "prompt from examples" — 5 I/O pairs → ask for the system prompt
]

== Next Task: Multi-Agent Triage

#v(0.4em)

#include "figures/triage-flow.typ"

#v(0.8em)

#lblock(inset: 0.7em, outset: 0pt, align(center)[
  The triage bot must gather information for the *reporter*.
])


#speaker-note[
  - Next hands-on: build the two bots in 04-multiagent-triage
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
        #text(size: 0.8em)[*Google AI Studio* or *OpenRouter*]
      - Install both keys in the repo (`.env`)
      - Read `SYSTEM.md`
      - Message the bot over Telegram
      #v(1fr)
    ],
    [
      #box(fill: white, inset: 1em)[
        #qrcode("https://manek.sg/agentic-4", width: 8cm)
      ]\
      #text(font: "DejaVu Sans Mono", size: 1.2em)[
        manek.sg/agentic-4
      ]
    ],
  )
]
