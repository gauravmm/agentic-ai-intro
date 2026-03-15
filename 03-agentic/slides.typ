#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/tiaoma:0.3.0": qrcode
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


== Skills


#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: .5em, bottom: .5em),
      outset: (left: .5em, right: .5em),
      [
        *Skills* are portable descriptions of an ability.

        - break a problem into parts,
        - interact with a tool,
        - structure some output,
        - interpret some input, _etc._
      ],
    )

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
  The humanizer skill is a good example to show: it's a short text file that teaches the model a specific writing style. Skills compose well with the complexity ladder: write a skill for each rung, then chain them.
]

== AI-Driven AI Development

#grid(
  columns: (1fr, 1fr),
  gutter: 3em,
  align: top,
  [
    #v(1fr)
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: 1.0em, bottom: 1.0em),
      outset: (left: .3em, right: .3em),
      width: 100%,
      align(center, [
        If AI can *follow* a skill…

        …AI can *write* a skill.
      ]),
    )
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
  This is the slide where things get recursive and students usually laugh nervously. The key point: prompt engineering used to be a human skill. Now it's increasingly an AI task. Claude Code writing its own skills (like the ones we've been using this session) is a live example. Ask: "Who here has asked an AI to write a prompt for another AI?" — most hands go up.
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
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: 1.0em, bottom: 1.0em),
      outset: (left: .3em, right: .3em),
      width: 100%,
      align(center, [*Know when to stop vibing.* ]),
    )
    #v(1fr)
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
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: 1.0em, bottom: 1.0em),
      outset: (left: .3em, right: .3em),
      width: 100%,
      align(center, [
        The critic prompt is often *more important*\
        than the actor prompt.
      ]),
    )
    #v(1fr)
  ],
)


#speaker-note[
  This mirrors how senior engineers review junior code. The actor doesn't need to be perfect — it needs to be good enough for the critic to improve. In practice, you can use the same model with two different system prompts: one tasked with "write code" and one tasked with "find every flaw in this code." The critic's job is adversarial by design.
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
    #grid(
      columns: (auto, 1fr),
      align: horizon,
      gutter: (0.4em, 0.5em),
      [#box(
        fill: luma(210),
        stroke: (thickness: 0.4pt, paint: luma(100)),
        inset: (x: 0.6em, y: 0.4em),
        radius: 0.3em,
      )[*4*]],
      [Full multi-agent pipeline with tool use],

      [#box(
        fill: luma(220),
        stroke: (thickness: 0.4pt, paint: luma(100)),
        inset: (x: 0.6em, y: 0.4em),
        radius: 0.3em,
      )[*3*]],
      [Single agent with memory + tools],

      [#box(
        fill: luma(230),
        stroke: (thickness: 0.4pt, paint: luma(100)),
        inset: (x: 0.6em, y: 0.4em),
        radius: 0.3em,
      )[*2*]],
      [Chain of prompts with intermediate checks],

      [#box(
        fill: luma(240),
        stroke: (thickness: 0.4pt, paint: luma(100)),
        inset: (x: 0.6em, y: 0.4em),
        radius: 0.3em,
      )[*1*]],
      [Single well-crafted prompt],
    )

    #v(1em)
    - Errors at lower rungs are cheaper to fix.
    - Aggressively check consistency in layers.

    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: 1.0em, bottom: 1.0em),
      outset: (left: .3em, right: .3em),
      width: 100%,
      align(center)[
        *Match tool and problem complexity.*
      ],
    )
    #v(1fr)
  ],
)

#speaker-note[
  The ladder is about matching tool complexity to problem complexity. People tend to jump straight to "full agent pipeline" because it feels powerful — then spend days debugging subtle failures that a single-prompt solution would have avoided. Consistency checking at each rung is the key discipline: it's the difference between a reliable pipeline and an impressive demo that breaks in production.
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

    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: (top: 1.0em, bottom: 1.0em),
      outset: (left: .3em, right: .3em),
      width: 100%,
      align(center)[
        Evals are to AI what unit tests are to software. \
        *Without them, you're flying blind.*
      ],
    )
    #v(1fr)
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
    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: 0.8em,
      width: 100%,
      align(center, [

        *How much of the loop \
        do you hand over?*
      ]),
    )

    #v(1fr)
    - What is the *blast radius* of a mistake?
    - How *reversible* are the agent's actions?
    - How well can you *evaluate* the output?
    - Do you have *guardrails* in place?

    #v(1fr)
  ],
)

#speaker-note[
  This is the key architectural decision. "Blast radius" is a useful frame: deleting a file is low blast radius; sending an email to 10,000 customers is high. Reversibility is the other axis: you can undo a file edit, you cannot unsend an email. Most production systems today sit at "interactive" — the AI drafts, the human approves. Full autonomy is still rare outside of well-bounded tasks.

  Most production systems sit in the middle column today. Hands-off is compelling but requires a lot of investment in evals and guardrails — the cost of a mistake is higher when no human saw it coming. The session students are about to do (multi-agent triage bot) is firmly in the "interactive" column, with a hands-off component at the end. Point out that the same task can live at different levels depending on how much you've validated it.
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

      #text(font: "DejaVu Sans Mono", size: 0.6em)[
        https://github.com/\
        gauravmm/ai-tutorial-triage
      ]
    ],
    [
      #box(fill: white, inset: 1em)[
        #qrcode("https://github.com/gauravmm/ai-tutorial-triage", width: 5cm)
      ]
    ],
  )
]
