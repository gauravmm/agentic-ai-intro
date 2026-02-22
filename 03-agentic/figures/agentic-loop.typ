#import "@preview/cetz:0.3.4": canvas, draw

#align(center)[
  #canvas({
    import draw: *

    let g-fill = rgb("#c7d9c4") // sage green — loop nodes
    let g-strk = rgb("#6b9c71") // darker green — loop-back arrow
    let gr-fill = luma(220) // grey — entry / exit nodes
    let you-c = rgb("#c7793e") // orange — human-in-loop
    let loop-c = luma(160) // grey — dashed container

    let bw = 2.5 // box half-width
    let bh = 0.5 // box half-height
    let rx = bw + 0.65 // x of loop-back rail

    // vertical centres (y-up in CeTZ)
    let yp = 9.8 // Your prompt
    let yg = 7.1 // Gather context
    let ya = 5.4 // Take action
    let yv = 3.7 // Verify results
    let yd = 1.0 // Done

    // ── agentic loop container ──────────────────────────────────
    rect(
      (-bw - 0.45, yv - bh - 0.45),
      (bw + 0.45, yg + bh + 0.45),
      stroke: (paint: loop-c, dash: "dashed", thickness: 0.7pt),
      fill: luma(246),
      radius: 0.4,
    )
    content(
      (-bw / 2 - 0.2, yg + bh + .6),
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
