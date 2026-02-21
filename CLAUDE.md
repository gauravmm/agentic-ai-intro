# CLAUDE.md — agentic-ai-tutorial

Workshop slide deck and hands-on tasks for the **NTU BMES Makerspace Hackathon** on Agentic AI.
Presenter: Dr. Gaurav Manek, A\*STAR.

---

## Repository structure

```
01-introduction/      Intro slides (slides.typ) + media assets
02-label-design/      Hands-on task: generate a medical device label (Typst)
03-agentic/           Agentic AI concepts (slides in progress)
04-multiagent-triage/ Hands-on task: multi-agent triage bot (Python)
.agents/skills/       Installed Claude Code skills (touying-author, typst-author)
```

Each module follows the same pattern:
- `README.md` — content outline / exercise brief (source of truth for *what* to cover)
- `slides.typ` — Typst source for the compiled slide deck
- `media/` — images, memes, diagrams used on slides

---

## Slides tech stack

Slides are written in **Typst** using the **Touying** presentation framework (`@preview/touying:0.6.1`) with the **metropolis** theme.

Two Claude Code skills are installed to assist:
- `touying-author` — Touying-specific APIs, slide structure, animations
- `typst-author` — general Typst language reference

### Heading levels

| Level | Touying meaning |
|-------|----------------|
| `=`   | New section (shows in progress bar / outline) |
| `==`  | New slide with title |
| `---` | New slide without title |

Add `<touying:hidden>` to suppress a section from the outline/progress bar.

### Established macros (defined at top of each `slides.typ`)

```typst
// Grey box with bold title + centered body; height: 100% (fills grid cell)
#let aside(title, body) = ...

// Inline token highlight for the tokenizer visualization
#let tok-colors = (...)
#let tok(n, content) = ...   // n cycles through 4 pastel colours
```

### Common patterns

```typst
// Speaker notes (hidden unless presenter mode)
#speaker-note[...]

// Pause animation
#pause

// Two-column layout
#grid(columns: (1fr, 1fr), gutter: 1em, [...], [...])

// Meme / full-bleed image slide
#align(center)[
  #image("media/filename.jpg", height: 78%)
]

// Focus (dark highlight) slide
#focus-slide[Big statement here.]
```

### Fonts available on this system

Prefer: `DejaVu Sans Mono` (monospace), `DejaVu Sans` (sans-serif).
Variable fonts (`Ubuntu`, `Ubuntu Mono`) may render incorrectly — avoid.

---

## Workflow

1. Read `README.md` in the target module to understand the content scope.
2. Edit `slides.typ` — the README is the outline, the .typ file is the deliverable.
3. Images go in `media/`. Reference them as relative paths: `image("media/foo.jpg")`.
4. Compile with `typst compile slides.typ` from inside the module directory.

---

## Content conventions

- **Presenter notes** should be written for the *speaker*, not the audience — include talking points, punchlines, and things to watch for.
- **Memes** are first-class slide content. Place them with `#align(center)[#image(...)]` or in a grid column alongside bullet points.
- **Slide density**: prefer one strong idea per slide; use `#pause` for progressive reveal rather than packing everything at once.
- **Prices and model data**: source from OpenRouter (`openrouter.ai/models`); include attribution and date.

---

## Module notes

### 01-introduction
- Full slide deck, essentially complete.
- Custom `aside` and `tok` macros defined here.
- Pricing table on the "How Usage Is Billed" slide — sourced from OpenRouter 2026-02-21.

### 02-label-design
- Task lives in `task/` (git submodule). Students complete `labelgen.typ`.
- Requirements: medical device label, ISO 7000 icons, QR code, dashed cut line.
- Advanced: 1 000 unique labels with sequential serial numbers; FDA CFR 21 Part 801 / UDI compliance.

### 03-agentic
- Slides not yet written. README covers: agent loop, common patterns (vibe coding, actor-critic, complexity ladder), human-in-the-loop models.

### 04-multiagent-triage
- Python task in `task/` with a `.venv`. Students build a multi-agent triage bot.
- Discussion focus: escalation, backpressure, external tool use, validation.
