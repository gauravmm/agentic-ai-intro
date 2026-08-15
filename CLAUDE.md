# CLAUDE.md - agentic-ai-tutorial

Workshop slide deck and hands-on tasks for the **NTU BMES Makerspace Hackathon** on Agentic AI.
Presenter: Dr. Gaurav Manek, A\*STAR.

---

## Repository structure

This repo holds **only the slide decks**. The hands-on tasks live in their own
GitHub repos and are linked from the top-level `README.md`.

```text
01-introduction/      Intro slides (slides.typ) + media assets
03-agentic/           Agentic AI concepts (slides.typ) + media/figures
common.typ            Shared slide helpers imported by both decks (--root ..)
.agents/skills/       Installed Claude Code skills (touying-author, typst-author)
```

The numbering has gaps (02, 04) because the workshop *flow* interleaves a
hands-on task after each slide deck; those tasks are external repos:

- `github.com/gauravmm/ai-tutorial-scraping-prescriptions` - task 2 (current)
- `github.com/gauravmm/ai-tutorial-eventbot-kittenclaw` - task 4, option A (event help desk)
- `github.com/gauravmm/ai-tutorial-triage-kittenclaw` - task 4, option B
- `github.com/gauravmm/ai-tutorial-labelgen` - older label-design task (retired)

Each slide module follows the same pattern:

- `README.md` - content outline (source of truth for *what* to cover)
- `slides.typ` - Typst source for the compiled slide deck
- `media/` - images, memes, diagrams used on slides

---

## Slides tech stack

Slides are written in **Typst** using the **Touying** presentation framework (`@preview/touying:0.6.1`) with the **metropolis** theme.

Two Claude Code skills are installed to assist:

- `touying-author` - Touying-specific APIs, slide structure, animations
- `typst-author` - general Typst language reference

### Heading levels

| Level | Touying meaning |
| ------- | ---------------- |
| `=` | New section (shows in progress bar / outline) |
| `==` | New slide with title |
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

### Animation in grids

`#pause` and `#meanwhile` are processed in **source order**, not grid-position order. In a 2×2 grid, the default source order is row-major: (0,0) → (0,1) → (1,0) → (1,1). This means you cannot use `#pause` in column 0 row 1 to delay column 1 row 0 - it comes too late in source order.

**Trick**: use `grid.cell(x:, y:)` to explicitly position cells, then write them in the source order that matches the desired animation sequence.

Example - reveal left column fully, then right column together:

```typst
#grid(
  columns: (1fr, 1fr), rows: (auto, auto), gutter: 1em,
  // Source order: top-left → bottom-left → top-right → bottom-right
  grid.cell(x: 0, y: 0)[left-top #pause #pause],
  grid.cell(x: 0, y: 1)[#meanwhile left-bottom #pause],
  grid.cell(x: 1, y: 0)[right-top],   // appears on subslide 3
  grid.cell(x: 1, y: 1)[right-bottom], // appears on subslide 3
)
```

`#meanwhile` rewinds to before the most recent `#pause`. The double `#pause` in the first cell creates an anchor two steps ahead; `#meanwhile` in the second cell steps back one, landing on subslide 2. Subsequent cells without any marker continue from wherever the counter sits.

### Fonts available on this system

Prefer: `DejaVu Sans Mono` (monospace), `DejaVu Sans` (sans-serif).
Variable fonts (`Ubuntu`, `Ubuntu Mono`) may render incorrectly - avoid.

---

## Workflow

1. Read `README.md` in the target module to understand the content scope.
2. Edit `slides.typ` - the README is the outline, the .typ file is the deliverable.
3. Images go in `media/`. Reference them as relative paths: `image("media/foo.jpg")`.
4. Compile from inside the module directory with `typst compile --root .. slides.typ` (the `--root ..` lets decks import the repo-root `common.typ` shared helpers).

---

## Content conventions

- **Presenter notes** should be written for the *speaker*, not the audience - include talking points, punchlines, and things to watch for.
- **Memes** are first-class slide content. Place them with `#align(center)[#image(...)]` or in a grid column alongside bullet points.
- **Slide density**: prefer one strong idea per slide; use `#pause` for progressive reveal rather than packing everything at once.
- **Prices and model data**: source from OpenRouter (`openrouter.ai/models`); include attribution and date.

---

## Module notes

### 01-introduction

- Full slide deck, essentially complete.
- Custom `aside` and `tok` macros defined here.
- Pricing table on the "How Usage Is Billed" slide - sourced from OpenRouter 2026-07-11.

### 03-agentic

- Slides cover: agent loop, common patterns (vibe coding, actor-critic, complexity ladder, TDD), human-in-the-loop models, real-world agents (Copilot Workspace, OpenClaw).
- Shares the `gblock` / `lblock` helpers with 01; `label-item` is local for cell-filling labelled rows.

### Hands-on tasks (external repos)

- Linked from the top-level `README.md`; not checked out here.
- Prescription scraping (`ai-tutorial-scraping-prescriptions`) is task 2; task 4 offers a choice of the event help desk (`ai-tutorial-eventbot-kittenclaw`) or multi-agent triage (`ai-tutorial-triage-kittenclaw`); `ai-tutorial-labelgen` is the retired label-design task.
