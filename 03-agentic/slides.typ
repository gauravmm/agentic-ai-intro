#import "@preview/touying:0.7.3": *
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
    institution: [TechWorks\@ROCK],
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


== Real-World Agents

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

    #v(0.5em)

    Other examples:
    - *Claude Code* and *Codex* for code
    - *Notion AI*: agentic assistant for your notes and docs

    #pause
  ],
  grid.cell(x: 1, y: 0, align: bottom, image("media/openclaw-logo-text-dark.png", width: 90%)),
  grid.cell(x: 1, y: 1)[
    - Personal AI agent
    - Runs on your machine; triggered via *messaging apps* \
      (WhatsApp, Telegram, Slack…)
    - Can run shell commands, browse the web, read/write files, send email
    - *Self-improving*: LLM writes and saves new skills for itself
    - Open marketplace for new skills and tools
    - MIT license, bring your own API key
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
    #let skill(repo, name, desc) = [
      #text(weight: "bold")[#repo\/#name] \
      #text(fill: luma(80), size: 0.85em)[#h(1em)#desc] \
    ]

    #skill("anthropics/skills", "pptx")[Create and edit PowerPoint presentations.]
    #skill("blader", "humanizer")[Rewrite AI-sounding text to remove common tells.]
    #skill("openclaw/skills", "agentchat")[Agent-to-agent chat and coordination.]
    #skill("openclaw/skills", "ask-a-human")[Crowdsource subjective decisions to real humans.]
    #skill("jezweb", "gemini-peer-review")[Get a rival model's second opinion on your code.]
    #skill("openclaw/skills", "slack")[Interact with humans & bots over Slack.]

    #v(0.5em)
    Thousands of skills are freely available!
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

== Human-in-the-Loop

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  align: top,
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[Autocomplete][Model *suggests*, human accepts or rejects on every keystroke.],
    label-item[Interactive][Back-and-forth; human *steers* each step.],
    label-item[Hands-off][Model handles long-running tasks; human *approves* the result.],
    label-item[Autonomous][Model runs *without oversight*; humans intervene only when something breaks.],
  ),

  [
    #v(1fr)

    The key design question for any agentic system:
    #lblock(inset: 0.8em, outset: 0pt)[
      #align(center)[

        *How much of the loop \
        do you hand over?*
      ]
    ]

    #v(1fr)
    - What is the *blast radius* of a mistake?
    - How *reversible* are the agent's actions?
    - How well can you *evaluate* the output?
    - Do you have *guardrails* in place?

    #v(1fr)
  ],
)

#speaker-note[
  - The key architectural decision
  - Blast radius: file delete (low) vs email 10K customers (high)
  - Reversibility: undo file edit, cannot unsend email
  - Most prod today: "interactive" (AI drafts, human approves)
  - Hands-off needs heavy eval + guardrail investment
  - Today's session = interactive, hands-off at the end
  - Same task can live at different levels depending on validation
]


#focus-slide[
  How much *control* \
  do you hand over?

  How much do you \
  *trust* the machine?
]
= Let's Get Started

#focus-slide[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    gutter: 2em,
    [
      Form your groups. \
      Open GitHub Codespaces \
      Let's build something.

      #text(font: "DejaVu Sans Mono", size: 1.6em)[
        manek.sg/agentic-4
      ]
    ],
    [
      #box(fill: white, inset: 1em)[
        #qrcode("https://manek.sg/agentic-4", width: 8cm)
      ]
    ],
  )
]
