#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Hands-on with Agentic AI],
    subtitle: [Agentic AI],
    author: [Dr. Gaurav Manek, A*STAR],
    date: datetime.today(),
    institution: [NTU BMES Makerspace Hackathon Workshop],
    logo: [🤖💥🧠🧑‍💻],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

// Grey box with bold title + centered body; height: 100% (fills grid cell)
#let aside(title, body) = box(
  fill: luma(240),
  width: 100%,
  height: 100%,
  radius: 0.5em,
  inset: 0.5em,
  grid(
    rows: (2em, 1fr),
    align: horizon,
    text(weight: "bold", size: 1.5em)[#title],
    body,
  ),
)

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
  Bridge from module 01: they've already seen how LLMs work at the token level. Now the question is what happens when you give one a loop and some tools. The distinction "chatbot vs agent" is a useful shorthand — don't get bogged down in definitions.
]


== What is Agentic AI?


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

    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (left: 1.1em, right: 1.1em, top: 1.0em, bottom: 1.0em),
      width: 100%,
      [
        *Same LLM*, new prompt: \
        _"Given this goal, what do I do next?"_
      ],
    )
  ],
  [
    *Agentic AI*
    #include "figures/agentic-loop.typ"
  ],
)

#speaker-note[Emphasize that the LLM is the same, the tooling is a lot more rich.]


== Key Vocabulary

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (auto, auto),
  align: top,
  row-gutter: 1em,
  column-gutter: 1em,
  text(weight: "bold", size: 1.5em)[Agent],
  text(weight: "bold", size: 1.5em)[Skill],
  text(weight: "bold", size: 1.5em)[Tool Use],
  text(weight: "bold", size: 1.5em)[Sub-agents],

  box(fill: luma(230), outset: 0.5em, inset: (top: 0.2em, bottom: 0.2em), radius: 0.5em)[
    *LLM + harness*

    Harness _orchestrates_ the LLM, running it in a loop and giving it access to tools.

    Acts autonomously toward a goal — reads, decides, acts, observes, repeats.

    #pause
  ],
  [
    #box(fill: luma(230), outset: 0.5em, inset: (top: 0.2em, bottom: 0.2em), radius: 0.5em)[
      *portable ability*

      Instructions and tools to perform a task, reusable across projects and models.
    ]

    #pause

    #align(center, [
      #sym.arrow.t \
      Our next task!
    ])

    #pause
  ],
  box(fill: luma(230), outset: 0.5em, inset: (top: 0.2em, bottom: 0.2em), radius: 0.5em)[
    *external functions*

    Search the web, run code, read files, call APIs, use MCPs.

    The model decides *when* and *how* to call them.

    #pause
  ],
  box(fill: luma(230), outset: 0.5em, inset: (top: 0.2em, bottom: 0.2em), radius: 0.5em)[
    *agents as tools*

    Spawn independent agents,\give them goals and tools, and merge results.

    Enables parallelism, specialisation, and delegation.

  ],
)

#speaker-note[
  Emphasise that "agent" is not a special product, it's a *pattern*.
  Skills are portable and lazy-loaded.
  Tools are the way agents interact with the world.
  Sub-agents are very powerful, but chew through tokens very quickly. Common to use cheaper LLMs for sub-agents.
]


== Real-World Agents

#grid(
  columns: (1fr, 1fr),
  rows: (auto, auto),
  align: top,
  gutter: 1em,
  // Source order controls animation; x/y controls layout position.
  // Sequence: copilot logo → copilot bullets → openclaw logo + bullets.
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

    *Claude Code* is currently the market leader

    *AutoGPT* is an open-source alternative

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


== Skills

*Skills* are transferable descriptions of an ability — how to break a problem into parts, or how to interact with a tool.

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    - Captured as *text* (a prompt, a playbook, a structured guide)
    - Can be shared across projects and teams
    - Work with any model that understands the context
    - The `.agents/skills/` directory in this repo has two: `touying-author` and `typst-author`
  ],
  [
    *Community skill libraries:*

    #v(0.3em)

    #text(font: "DejaVu Sans Mono", size: 0.85em)[github.com/blader/humanizer]

    #text(font: "DejaVu Sans Mono", size: 0.85em)[github.com/jezweb/claude-skills]

    #text(font: "DejaVu Sans Mono", size: 0.85em)[github.com/forrestchang/\ andrej-karpathy-skills]

    #v(0.5em)
    #text(fill: luma(80), size: 0.9em)[Skills are prompt engineering made portable. \
      Share them like libraries.]
  ],
)

#speaker-note[
  Point out the skills already in this repo — the students have been using them indirectly. The humanizer skill is a good example to show: it's a short text file that teaches the model a specific writing style. Skills compose well with the complexity ladder: write a skill for each rung, then chain them. The ecosystem is young; there's no standard package manager yet, but that's coming.
]

== AI-Driven AI Development

#[
  Use AI to write the prompts, evals, and scaffolding for other AI
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
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (left: 1.1em, right: 1.1em, top: 1.0em, bottom: 1.0em),
      width: 100%,
      [
        _"It's no use trying to eat a steak with a teaspoon and a straw."_

        #align(right)[— Anthony T. Hincks]
      ],
    )
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
  These aren't rigid categories — they overlap and compose. Vibe coding + actor-critic is a common combo. The point is to name the patterns so students can recognise them in the wild and talk about them precisely. Spend ~30 seconds here before going into each.
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
    *What it is:*
    - Prompt first, plan never
    - Iterate until it feels right
    - Let the AI fill in the details

    *Works well when:*
    - Prototyping or exploring an idea
    - The task is small and throwaway
    - Speed $>>$ correctness

    Accumulates *technical debt* very fast because neither you nor the AI understands everything.
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: 1.0em, bottom: 1.0em),
      outset: (left: .3em, right: .3em),
      width: 100%,
      align(center, [*Know when to stop vibing.* ]),
    )
  ],
)

#speaker-note[
  This is the most natural way people start using AI for code, and it *does* work for short-lived scripts. The danger is when vibe-coded systems make it into production. The AI can generate plausible-looking code that has subtle bugs, and you can't catch them if you never understood the logic. The transition from "vibe" to "rigorous" is where actor-critic and TDD come in.
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
    *What it is:*
    - Prompt first, plan never
    - Iterate until it feels right
    - Let the AI fill in the details

    *Works well when:*
    - Prototyping or exploring an idea
    - The task is small and throwaway
    - Speed $>>$ correctness

    Accumulates *technical debt* very fast because neither you nor the AI understands everything.
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: 1.0em, bottom: 1.0em),
      outset: (left: .3em, right: .3em),
      width: 100%,
      align(center, [*Know when to stop vibing.* ]),
    )
  ],
)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    #text(weight: "bold", size: 1.5em)[Actor]

    - Generates output: code, a plan, a draft
    - Optimises for *plausibility*
    - Fast, creative, sometimes wrong

    #v(1em)

    The loop: \
    #align(center)[
      *Actor* #sym.arrow.r *Critic* #sym.arrow.r feedback #sym.arrow.r *Actor*
    ]
  ],
  [
    #text(weight: "bold", size: 1.5em)[Critic]

    - Evaluates the actor's output
    - A *different prompt* (or model) with a different objective
    - Optimises for *correctness* / *safety* / *style*

    #v(0.5em)

    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: 0.8em,
      width: 100%,
    )[
      The critic prompt is often *more important* than the actor prompt.
    ]
  ],
)

#speaker-note[
  This mirrors how senior engineers review junior code. The actor doesn't need to be perfect — it needs to be good enough for the critic to improve. In practice, you can use the same model with two different system prompts: one tasked with "write code" and one tasked with "find every flaw in this code." The critic's job is adversarial by design.
]

== The Complexity Ladder

#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  align: top,
  [
    Start simple. Add complexity only when the simpler approach fails.

    #v(0.5em)

    #grid(
      columns: (auto, 1fr),
      gutter: (0.4em, 0.5em),
      [#box(fill: luma(190), inset: (x: 0.6em, y: 0.4em), radius: 0.3em)[*4*]],
      [Full multi-agent pipeline with tool use],

      [#box(fill: luma(210), inset: (x: 0.6em, y: 0.4em), radius: 0.3em)[*3*]], [Single agent with memory + tools],
      [#box(fill: luma(225), inset: (x: 0.6em, y: 0.4em), radius: 0.3em)[*2*]],
      [Chain of prompts with intermediate checks],

      [#box(fill: luma(240), inset: (x: 0.6em, y: 0.4em), radius: 0.3em)[*1*]], [Single well-crafted prompt],
    )

    #v(0.5em)

    At *each rung*: verify output before climbing higher.
  ],
  aside[Consistency checking][
    #align(left)[
      After each step, ask: \
      _"Does this still make sense?"_

      #v(0.5em)

      Use a critic, a test suite, or a human spot-check.

      #v(0.5em)

      Errors caught at rung 2 cost much less than errors caught at rung 4.
    ]
  ],
)

#speaker-note[
  The ladder is about matching tool complexity to problem complexity. People tend to jump straight to "full agent pipeline" because it feels powerful — then spend days debugging subtle failures that a single-prompt solution would have avoided. Consistency checking at each rung is the key discipline: it's the difference between a reliable pipeline and an impressive demo that breaks in production.
]

== Test-Driven Development

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    *Classic TDD:*

    + Write a failing test
    + Implement until it passes
    + Refactor
    + Repeat

    #v(0.5em)

    The test is the *specification*. \
    Code is just the mechanism to satisfy it.
  ],
  [
    *AI TDD:*

    + Write *evals* (test cases, expected outputs)
    + Prompt-engineer until they pass
    + Refactor the prompt
    + Repeat

    #v(0.5em)

    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: 0.8em,
      width: 100%,
    )[
      Evals are to AI what unit tests are to software. \
      *Without them, you're flying blind.*
    ]
  ],
)

#speaker-note[
  Most people skip evals entirely because writing them feels like overhead. But without evals, prompt changes are invisible regressions — you fix one thing and break three others with no way to know. Even a small eval set (10-20 examples) transforms prompt engineering from guesswork into iteration. "Prompt from examples" is a related technique: give the model 5 example input-output pairs and ask it to write the system prompt.
]

#focus-slide[
  How much *control* \
  do you hand over?

  How much do you \
  *trust* the machine?
]

== Human-in-the-Loop

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    The more autonomous the agent, the *higher the risk* — and the *higher the reward*.

    #v(0.5em)

    The key design question for any agentic system:

    #v(0.3em)

    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: 0.8em,
      width: 100%,
    )[
      *How much of the loop \
      do you hand over?*
    ]
  ],
  [
    Things to consider:

    - What is the *blast radius* of a mistake?
    - How *reversible* are the agent's actions?
    - How well can you *evaluate* the output?
    - Do you have *guardrails* in place?

    #v(0.5em)

    Low-stakes + reversible → hand over more. \
    High-stakes + irreversible → keep human in the loop.
  ],
)

#speaker-note[
  This is the key architectural decision. "Blast radius" is a useful frame: deleting a file is low blast radius; sending an email to 10,000 customers is high. Reversibility is the other axis: you can undo a file edit, you cannot unsend an email. Most production systems today sit at "interactive" — the AI drafts, the human approves. Full autonomy is still rare outside of well-bounded tasks.
]

== Levels of Automation

#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (auto, 1fr),
  gutter: 0.8em,
  align(center)[*Autocomplete*], align(center)[*Interactive*], align(center)[*Hands-off*],
  aside[Autocomplete][
    #align(left)[
      Model *suggests*, human accepts or rejects.

      #v(0.3em)

      - Copilot inline completion
      - AI-assisted writing
      - Code review suggestions

      #v(0.3em)

      Human stays in control at every keystroke.
    ]
  ],
  aside[Interactive][
    #align(left)[
      Back-and-forth; human *steers* each step.

      #v(0.3em)

      - This workshop
      - Pair-programming with AI
      - Guided code generation

      #v(0.3em)

      Human reviews each action before it runs.
    ]
  ],
  aside[Hands-off][
    #align(left)[
      Model runs autonomously; human *reviews* the result.

      #v(0.3em)

      - PR generation
      - Issue triage
      - Site reliability alerts

      #v(0.3em)

      Requires strong evals and guardrails.
    ]
  ],
)

#speaker-note[
  Most production systems sit in the middle column today. Hands-off is compelling but requires a lot of investment in evals and guardrails — the cost of a mistake is higher when no human saw it coming. The session students are about to do (multi-agent triage bot) is firmly in the "interactive" column, with a hands-off component at the end. Point out that the same task can live at different levels depending on how much you've validated it.
]

#focus-slide[
  The question isn't whether to use agents.

  It's how much of the loop \
  to hand over.
]
