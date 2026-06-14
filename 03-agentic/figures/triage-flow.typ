#import "@preview/cetz:0.3.4": canvas, draw

#let diagram = canvas(length: 1cm, {
  import draw: *

  let g-fill = rgb("#c7d9c4") // sage green — the LLM agents
  let g-strk = rgb("#6b9c71")
  let gr-fill = luma(226) // grey — human endpoints
  let arr-c = luma(60)

  // one accent colour per patient / their trace
  let acc = (rgb("#3b7dd8"), rgb("#d98a1e"), rgb("#8e5bb5"))

  // ── geometry ────────────────────────────────────────────────
  let ahw = 1.45 // agent / nurse half width
  let ahh = 1.0 // agent / nurse half height
  let phw = 0.92 // patient half width
  let phh = 0.68
  let thw = 1.0 // trace half width
  let thh = 0.76

  let xPat = 0
  let xTri = 4.3
  let xTrc = 8.6
  let xRep = 12.9
  let xNur = 17.6

  let ys = (1.85, 0, -1.85) // three stacked rows
  let trihh = 2.3 // triage block spans all three rows

  let bnode(x, y, hw, hh, body, fill: gr-fill, strk: luma(150), radius: 0.2) = {
    rect(
      (x - hw, y - hh),
      (x + hw, y + hh),
      fill: fill,
      radius: radius,
      stroke: (paint: strk, thickness: 0.8pt),
    )
    content((x, y), body)
  }

  let glabel(x, txt) = content(
    (x, 0),
    box(fill: white, inset: (x: 2pt, y: 0pt))[#text(size: 0.58em, fill: luma(70))[#txt]],
  )

  // ── arrows (drawn first, nodes sit on top) ──────────────────
  for i in range(3) {
    // chat: back-and-forth turns, each line angled slightly down
    let xL = xPat + phw
    let xR = xTri - ahw
    let nseg = 4
    let step = 0.17
    let yTop = ys.at(i) + nseg * step / 2
    for j in range(nseg) {
      let xa = if calc.even(j) { xL } else { xR }
      let xb = if calc.even(j) { xR } else { xL }
      line(
        (xa, yTop - j * step),
        (xb, yTop - (j + 1) * step),
        mark: (end: ">", fill: acc.at(i)),
        stroke: (paint: acc.at(i), thickness: 0.8pt),
      )
    }
    // writes: triage -> this patient's trace (horizontal)
    line(
      (xTri + ahw, ys.at(i)),
      (xTrc - thw, ys.at(i)),
      mark: (end: ">", fill: acc.at(i)),
      stroke: (paint: acc.at(i), thickness: 0.9pt),
    )
    // reads: trace -> reporter (fan-in, unchanged)
    line(
      (xTrc + thw, ys.at(i)),
      (xRep - ahw, 0),
      mark: (end: ">", fill: acc.at(i)),
      stroke: (paint: acc.at(i), thickness: 0.9pt),
    )
    // report: reporter -> nurse (one per patient, parallel)
    line(
      (xRep + ahw, ys.at(i)),
      (xNur - ahw, ys.at(i)),
      mark: (end: ">", fill: acc.at(i)),
      stroke: (paint: acc.at(i), thickness: 0.9pt),
    )
  }

  content(
    (1.9, 0.66),
    box(fill: white, inset: (x: 2pt, y: 0pt))[#text(size: 0.58em, fill: luma(70))[chat]],
  )
  glabel(6.68, [writes])
  glabel(10.53, [reads])
  glabel(15.25, [reports])

  // ── Patients (three, colour-coded) ──────────────────────────
  content((xPat, ys.at(0) + phh + 0.5), text(weight: "bold", size: 0.62em)[Patients])
  for i in range(3) {
    bnode(
      xPat,
      ys.at(i),
      phw,
      phh,
      box(width: 1.5cm)[#align(center)[#text(size: 1.4em)[🧑]]],
      fill: acc.at(i).lighten(86%),
      strk: acc.at(i),
    )
  }
  content((xPat, ys.at(2) - phh - 0.42), text(size: 0.5em, fill: luma(100))[on Telegram])

  // ── Triage Bot (KittenClaw) — tall; logo+name on top, title at bottom
  rect(
    (xTri - ahw, -trihh),
    (xTri + ahw, trihh),
    fill: g-fill,
    radius: 0.2,
    stroke: (paint: g-strk, thickness: 0.8pt),
  )
  content((xTri, trihh - 0.85), box(width: 2.5cm)[
    #v(3em)
    #set align(center)
    #image("../media/kittenclaw.png", width: 100%)
    #v(-1.0em)
    #text(size: 0.56em, fill: luma(90))[KittenClaw]
  ])
  content((xTri, -trihh + 0.45), text(weight: "bold", size: 0.82em)[Triage Bot])

  // ── Conversation traces (one per patient, colour-matched) ───
  content((xTrc, ys.at(0) + thh + 0.5), text(weight: "bold", size: 0.6em)[Conversation traces])
  for i in range(3) {
    for o in (0.14, 0.07) {
      rect(
        (xTrc - thw + o, ys.at(i) - thh - o),
        (xTrc + thw + o, ys.at(i) + thh - o),
        fill: white,
        radius: 0.1,
        stroke: (paint: acc.at(i), thickness: 0.6pt),
      )
    }
    bnode(
      xTrc,
      ys.at(i),
      thw,
      thh,
      box(width: 1.7cm)[#align(center)[
        #text(size: 0.95em)[🗒] \
        #text(size: 0.54em, fill: luma(80))[trace #(i + 1)]
      ]],
      fill: acc.at(i).lighten(91%),
      strk: acc.at(i),
      radius: 0.1,
    )
  }
  content((xTrc, ys.at(2) - thh - 0.42), text(size: 0.5em, fill: luma(100))[`.jsonl` on disk])

  // ── Reporter Bot (Copilot skill) — tall, spans all three rows ─
  bnode(
    xRep,
    0,
    ahw,
    trihh,
    box(width: 2.7cm)[
      #set align(center)
      #v(1em)
      #image("../media/copilot-icon.png", height: 1.5cm)
      #v(-.8em)
      #text(size: 0.5em, fill: luma(90))[Copilot skill]
      #v(-.1em)
      #text(weight: "bold", size: 0.8em)[Reporter Skill]
    ],
    fill: g-fill,
    strk: g-strk,
  )

  // ── Triage nurse — tall, receives one report per patient ────
  bnode(xNur, 0, ahw, trihh, box(width: 2.7cm)[
    #align(center)[
      #text(size: 1.2em)[🧑‍⚕️] \
      #text(weight: "bold", size: 0.7em)[Triage nurse] \
      #text(size: 0.5em, fill: luma(90))[one report each]
    ]
  ])
})

// Scale the diagram to fill the full width of the containing slide.
#layout(size => {
  let f = size.width / measure(diagram).width
  scale(x: f * 100%, y: f * 100%, reflow: true, diagram)
})
