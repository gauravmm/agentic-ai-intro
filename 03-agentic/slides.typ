#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/cetz:0.3.4": canvas, draw

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
    Simple LLM
  ],
  [
    Agent Loop


  ],
)

#speaker-note[
  Bridge from module 01: they've already seen how LLMs work at the token level. Now the question is what happens when you give one a loop and some tools. The distinction "chatbot vs agent" is a useful shorthand — don't get bogged down in definitions; the loop slide next will make it concrete.
]


== What is Agentic AI?

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    A *chatbot* answers a question.

    An *agent* takes actions to reach a goal.

    #v(0.5em)

    - The model can *use tools*: read files, run code, call APIs
    - It runs in a *loop*: act → observe → act again
    - It keeps going until the goal is met — or it gives up

    #v(0.5em)

    #pause

    Same underlying LLM. \
    Very different *behaviour*.
  ],
  box(
    fill: luma(1000),
    stroke: luma(220),
    radius: 0.5em,
    inset: (left: 1.1em, right: 1.1em, top: 1.5em, bottom: 1.5em),
    width: 100%,
    [
      #text(weight: "bold", size: 1.5em)[The key shift]

      #v(0.5em)

      From: _"what is the answer?"_

      To: _"what should I *do* next?"_
    ],
  ),
)

#speaker-note[
  Bridge from module 01: they've already seen how LLMs work at the token level. Now the question is what happens when you give one a loop and some tools. The distinction "chatbot vs agent" is a useful shorthand — don't get bogged down in definitions; the loop slide next will make it concrete.
]

== The Agentic Loop

#align(center)[
  #canvas({
    import draw: *

    let g-fill = rgb("#c7d9c4") // sage green — loop nodes
    let g-strk = rgb("#6b9c71") // darker green — loop-back arrow
    let gr-fill = luma(220) // grey — entry / exit nodes
    let you-c = rgb("#c7793e") // orange — human-in-loop
    let loop-c = luma(160) // grey — dashed container

    let bw = 1.8 // box half-width
    let bh = 0.33 // box half-height
    let rx = bw + 0.65 // x of loop-back rail

    // vertical centres (y-up in CeTZ)
    let yp = 8.8 // Your prompt
    let yg = 7.1 // Gather context
    let ya = 5.4 // Take action
    let yv = 3.7 // Verify results
    let yd = 2.0 // Done

    // ── agentic loop container ──────────────────────────────────
    rect(
      (-bw - 0.45, yv - bh - 0.45),
      (bw + 0.45, yg + bh + 0.70),
      stroke: (paint: loop-c, dash: "dashed", thickness: 0.7pt),
      fill: luma(246),
      radius: 0.4,
    )
    content(
      (0, yg + bh + 0.52),
      text(size: 0.72em, fill: luma(110))[agentic loop],
    )

    // ── helper: node box ────────────────────────────────────────
    let node(y, lbl, fill: gr-fill) = {
      rect((-bw, y - bh), (bw, y + bh), fill: fill, radius: 0.26, stroke: (paint: luma(150), thickness: 0.7pt))
      content((0, y), text(size: 0.83em)[#lbl])
    }

    // ── helper: down arrow ──────────────────────────────────────
    let arr(y1, y2) = line(
      (0, y1 - bh),
      (0, y2 + bh),
      mark: (end: ">", fill: luma(50)),
      stroke: (paint: luma(50), thickness: 0.8pt),
    )

    // ── nodes ───────────────────────────────────────────────────
    node(yp, [Your prompt])
    arr(yp, yg)
    node(yg, [Gather context], fill: g-fill)
    arr(yg, ya)
    node(ya, [Take action], fill: g-fill)
    arr(ya, yv)
    node(yv, [Verify results], fill: g-fill)
    arr(yv, yd)
    node(yd, [Done])

    // ── loop-back arrow (right rail: Verify → Gather) ───────────
    line(
      (bw, yv),
      (rx, yv),
      (rx, yg),
      (bw, yg),
      stroke: (paint: g-strk, thickness: 0.9pt),
      mark: (end: ">", fill: g-strk),
    )

    // ── "You" box (left, aligned with Take action) ───────────────
    let yx = -4.0
    rect(
      (yx - 1.45, ya - 0.48),
      (yx + 1.45, ya + 0.48),
      fill: luma(255),
      radius: 0.22,
      stroke: (paint: you-c, dash: "dashed", thickness: 0.9pt),
    )
    content((yx, ya + 0.14), text(size: 0.70em)[You: interrupt, steer,])
    content((yx, ya - 0.17), text(size: 0.70em)[or add context])

    // ── dashed orange arrow: You → Take action ───────────────────
    line(
      (yx + 1.45, ya),
      (-bw, ya),
      stroke: (paint: you-c, dash: "dashed", thickness: 0.9pt),
      mark: (end: ">", fill: you-c),
    )
  })
]

#speaker-note[
  The agentic loop from the outside: gather context (read files, search the web), take action (write code, call tools), verify results (run tests, check output). The dashed orange path is where the human steps in — interrupt to steer, add missing context, or correct a wrong turn. The model loops until it reaches "Done" or the human intervenes.
]

== Real-World Examples

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    #text(weight: "bold", size: 1.5em)[GitHub Copilot]

    - Started as inline *autocomplete*
    - Now: *Copilot Workspace* — takes an issue, writes code, opens a PR
    - Loop: reads repo → plans changes → edits files → runs tests → iterates

    #v(0.5em)

    #text(weight: "bold", size: 1.5em)[AutoGPT / open-source agents]

    - Early (2023) demos: autonomous web browsing, task execution
    - Showed the potential — and the failure modes
  ],
  [
    #text(weight: "bold", size: 1.5em)[Claude Code]

    - What we're using *right now*
    - Reads your codebase, writes and edits files, runs commands
    - You are already inside an agent loop

    #v(0.5em)

    #box(
      fill: luma(1000),
      stroke: luma(220),
      radius: 0.5em,
      inset: 0.8em,
      width: 100%,
    )[
      *The pattern is the same everywhere.* \
      The details differ.
    ]
  ],
)

#speaker-note[
  Point out that students are literally inside Claude Code right now — this is a nice moment to make the abstract concrete. AutoGPT is worth mentioning as a cautionary tale: impressive demos, but unreliable in practice because it had no backpressure or consistency checking. We'll cover those patterns shortly.
]

== Key Vocabulary

#grid(
  columns: (1fr, 1fr),
  rows: (1fr, 1fr),
  gutter: 0.8em,
  aside[Agent][
    An LLM + a loop + tools. \
    Acts autonomously toward a goal — reads, decides, acts, observes, repeats.
  ],
  aside[Skill][
    A *transferable description of an ability*: how to break a problem into parts, or how to interact with a tool. \
    Reusable across projects and models.
  ],

  aside[Tool Use][
    The model calls *external functions*: search the web, run code, read files, call APIs. \
    The model decides *when* and *how* to call them.
  ],
  aside[MCP][
    *Model Context Protocol* — a standard interface for connecting tools to models. \
    Define once, plug into any MCP-compatible model.
  ],
)

#speaker-note[
  MCP analogy: it's the USB-C of AI tooling. Before MCP, every model had its own tool format; MCP standardises the contract. Skills are prompt engineering made portable — think of them like npm packages for agent behaviour. Emphasise that "agent" is not a special product, it's a *pattern*.
]

= Agent Patterns and Practice

== Common Patterns

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    + *Vibe Coding* \
      #text(fill: luma(80), size: 0.9em)[Iterate fast; prompt first; fix later]

    #v(0.3em)

    + *AI-Driven AI Development* \
      #text(fill: luma(80), size: 0.9em)[Use AI to write the prompts, evals, and scaffolding for other AI]

    #v(0.3em)

    + *Actor-Critic* \
      #text(fill: luma(80), size: 0.9em)[One model generates; another evaluates]
  ],
  [
    #v(0.15em)
    + *Complexity Ladder* \
      #text(fill: luma(80), size: 0.9em)[Escalate task complexity step-by-step; check consistency at each rung]

    #v(0.3em)

    + *Test-Driven Development* \
      #text(fill: luma(80), size: 0.9em)[Write evals first; prompt-engineer to pass them]
  ],
)

#speaker-note[
  These aren't rigid categories — they overlap and compose. Vibe coding + actor-critic is a common combo. The point is to name the patterns so students can recognise them in the wild and talk about them precisely. Spend ~30 seconds here before going into each.
]

== Vibe Coding

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    *What it is:*

    - Prompt first, plan never
    - Iterate until it feels right
    - Let the AI fill in the details

    #v(0.5em)

    Works well when:
    - Prototyping or exploring an idea
    - The task is small and throwaway
    - Speed matters more than correctness

    #pause
  ],
  aside[The trap][
    #align(left)[
      Fast to start. \
      Hard to finish.

      #v(0.5em)

      Vibe-coded systems accumulate *technical debt* faster than hand-written ones — because neither you nor the AI fully understands the whole.

      #v(0.5em)

      *Know when to stop vibing.*
    ]
  ],
)

#speaker-note[
  This is the most natural way people start using AI for code, and it *does* work for short-lived scripts. The danger is when vibe-coded systems make it into production. The AI can generate plausible-looking code that has subtle bugs, and you can't catch them if you never understood the logic. The transition from "vibe" to "rigorous" is where actor-critic and TDD come in.
]

== Actor-Critic

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
  Most people skip evals entirely because writing them feels like overhead. But without evals, prompt changes are invisible regressions — you fix one thing and break three others with no way to know. Even a small eval set (10–20 examples) transforms prompt engineering from guesswork into iteration. "Prompt from examples" is a related technique: give the model 5 example input-output pairs and ask it to write the system prompt.
]

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

= Using LLMs in Practice

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
