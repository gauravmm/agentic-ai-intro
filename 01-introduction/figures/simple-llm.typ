#import "@preview/cetz:0.3.4": canvas, draw

#align(center)[
  #canvas({
    import draw: *

    let gr-fill = luma(220) // grey — entry / exit nodes
    let g-fill = rgb("#c7d9c4") // sage green — inference node

    let bw = 2.5 // box half-width
    let bh = 0.5 // box half-height

    // vertical centres match agentic-loop outer range for side-by-side alignment
    let yp = 9.8 // Your prompt
    let yi = 5.4 // Inference
    let yd = 1.0 // Done

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
    arr(yp, yi)
    node(yi, [Inference], fill: g-fill)
    arr(yi, yd)
    node(yd, [Done])
  })
]
