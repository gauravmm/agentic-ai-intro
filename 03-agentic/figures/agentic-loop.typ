#import "@preview/cetz:0.3.4": canvas, draw

#align(center)[
  #canvas({
    let typst-rotate = rotate // save before draw shadows it
    import draw: *

    let g-fill = rgb("#c7d9c4") // sage green — loop nodes
    let g-strk = rgb("#6b9c71") // darker green — loop-back arrow
    let gr-fill = luma(220) // grey — entry / exit nodes
    let you-c = rgb("#c7793e") // orange — human-in-loop
    let loop-c = luma(160) // grey — dashed container

    let bw = 2.5 // box half-width
    let bh = 0.5 // box half-height
    let lx = 3.35 // left rail x (between "You" box right edge and loop container left edge)
    let lu = 8.5 // upper rail y (between loop container top and "Your prompt" bottom)

    // vertical centres (y-up in CeTZ)
    let yp = 9.8 // Your prompt
    let yg = 7.1 // Gather context
    let ya = 5.4 // Take action
    let yv = 3.7 // Verify results
    let yd = 1.0 // Done

    // ── agentic loop container ──────────────────────────────────
    rect(
      (-bw - 0.45, yv - bh - 0.9),
      (bw + 0.45, yg + bh + 0.9),
      stroke: (paint: loop-c, dash: "dashed", thickness: 0.7pt),
      fill: luma(246),
      radius: 0.4,
    )
    content(
      (-bw / 2 - 0.2, yg + bh + 1.1),
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

    // ── loop-back arrow (left rail: bottom of Verify → top of Gather) ──
    line(
      (0, yv - bh), // bottom of Verify Results
      (0, yv - bh - 0.3), // bottom of Verify Results
      (-lx + 0.6, yv - bh - 0.3), // exit left
      (-lx + 0.6, lu - 0.4), // up past loop container top
      (0, lu - 0.4), // right to above Gather Context
      (0, yg + bh), // down to top of Gather Context
      stroke: (paint: g-strk, thickness: 0.9pt),
      mark: (end: ">", fill: g-strk),
    )

    // ── "You" box (left side, rotated 90°) ───────────────────────
    let yx = -4.15
    let hyw = 0.5 // half-width  (narrow dimension)
    let hyh = 3.45 // half-height (tall dimension)

    rect(
      (yx - hyw, ya - hyh),
      (yx + hyw, ya + hyh),
      fill: rgb("#fff8f2"),
      radius: 0.25,
      stroke: (paint: you-c, dash: "dashed", thickness: 0.9pt),
    )
    content(
      (yx, ya),
      typst-rotate(-90deg, reflow: true)[
        #box(width: 8cm)[
          #align(center)[
            #text(size: 0.70em)[interrupt, steer, or add context]
          ]
        ]
      ],
    )

    // ── dashed orange arrow: You → Take action ───────────────────
    line(
      (yx + hyw, ya),
      (-bw - 0.4, ya),
      stroke: (paint: you-c, dash: "dashed", thickness: 0.9pt),
      mark: (end: ">", fill: you-c),
    )
  })
]
