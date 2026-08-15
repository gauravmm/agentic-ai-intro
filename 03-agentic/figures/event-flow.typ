#import "@preview/cetz:0.3.4": canvas, draw

#let diagram = canvas(length: 1cm, {
  import draw: *

  let g-fill = rgb("#c7d9c4") // sage green — the LLM agent
  let g-strk = rgb("#6b9c71")
  let gr-fill = luma(232) // grey — human endpoints
  let acc = rgb("#3b7dd8") // the paper trail

  let bnode(x, y, hw, hh, body, fill: gr-fill, strk: luma(160), radius: 0.2) = {
    rect(
      (x - hw, y - hh),
      (x + hw, y + hh),
      fill: fill,
      radius: radius,
      stroke: if strk == none { none } else { (paint: strk, thickness: 0.8pt) },
    )
    content((x, y), body)
  }

  let glabel(x, y, txt) = content(
    (x, y),
    box(fill: white, inset: (x: 2pt, y: 0pt))[#text(
      size: 0.5em,
      fill: luma(70),
    )[#txt]],
  )

  // ── Attendees: one block per question, stacked ──────────────
  let asks = (
    ("🧑", [What's on after lunch?]),
    ("👩‍🔬", [I work on imaging AI --- what should I go to?]),
    ("🧑‍💼", [Who is Dr. Amir Hassan, and what does he do?]),
    ("🧔", [B2 is in Room 202, right? See you there.]),
    ("👩‍💻", [Book me a seat in C1.]),
    ("🧓", [Plan my whole day.]),
    ("👴", [Is A4 still happening?]),
    ("🧕", [Where's the cloakroom?]),
  )
  let uhw = 4.2 // attendee block half width
  let uhh = 0.44
  let ugap = 0.18
  let xUsr = 0
  let xBot = 7.1
  let xDoc = 13.15

  let n = asks.len()
  let pitch = 2 * uhh + ugap
  let ytop = (n - 1) * pitch / 2

  for (i, a) in asks.enumerate() {
    let y = ytop - i * pitch
    bnode(
      xUsr,
      y,
      uhw,
      uhh,
      box(width: (2 * uhw - 0.5) * 1cm)[
        #std.grid(
          // cetz's `draw.grid` shadows the built-in here
          columns: (auto, 1fr),
          gutter: 0em,
          align: horizon,
          text(size: 0.9em)[#a.at(0)],
          text(size: 0.5em, style: "italic")[“#a.at(1)”],
        )
      ],
      radius: 0.15,
      strk: none,
    )
    // chat: attendee ↔ help desk
    line(
      (xUsr + uhw + 0.06, y),
      (xBot - 1.7, y),
      mark: (start: ">", end: ">", fill: luma(110), scale: 0.7),
      stroke: (paint: luma(110), thickness: 0.8pt),
    )
  }
  content(
    (xUsr, ytop + uhh + 0.42),
    text(weight: "bold", size: 0.58em)[Attendees, on Telegram],
  )
  glabel((xUsr + uhw + xBot - 1.7) / 2, ytop + uhh + 0.42, [chat])

  // ── The help desk (KittenClaw), spanning every conversation ─
  bnode(
    xBot,
    0,
    1.7,
    ytop + uhh,
    box(width: 3.0cm)[
      #set align(center)
      #image("../media/kittenclaw.png", height: 1.6cm)
      #v(-0.7em)
      #text(size: 0.44em, fill: luma(90))[KittenClaw]
      #v(-0.2em)
      #text(weight: "bold", size: 0.62em)[Event Help Desk]
    ],
    fill: g-fill,
    strk: g-strk,
  )

  // ── The event's paperwork: real page-1 thumbnails ───────────
  let th = 2.4 // thumbnail height
  let tw = 0.707 * th
  let tgap = 0.2
  let docs = (
    "01-event-overview",
    "03-programme-update-email",
    "04-venue-guide-a2-poster",
    "05-organiser-chat",
    "06-session-brief-a1-medical-images",
    "07-session-brief-b1-shared-platforms",
    "11-session-brief-c4-poster-networking",
    "12-closing-minutes-attachment",
    "14-breakout-2-imaging-ai",
  )
  let cols = 3
  let gw = cols * tw + (cols - 1) * tgap
  let rows = calc.ceil(docs.len() / cols)
  let gh = rows * th + (rows - 1) * tgap

  for (i, d) in docs.enumerate() {
    let cx = xDoc - gw / 2 + tw / 2 + calc.rem(i, cols) * (tw + tgap)
    let cy = gh / 2 - th / 2 - int(i / cols) * (th + tgap)
    content(
      (cx, cy),
      box(
        width: tw * 1cm,
        stroke: (paint: luma(160), thickness: 0.5pt),
        image("../media/event-docs/" + d + ".png", width: 100%),
      ),
    )
  }
  content(
    (xDoc, gh / 2 + 0.34),
    text(weight: "bold", size: 0.58em)[The event on paper --- 15 PDFs],
  )
  content(
    (xDoc, -gh / 2 - 0.36),
    text(
      size: 0.44em,
      fill: luma(100),
    )[what the attendee was handed at the door],
  )

  // the paperwork is what the bot's files were written from
  line(
    (xDoc - gw / 2 - 0.15, 0),
    (xBot + 1.75, 0),
    mark: (end: ">", fill: acc),
    stroke: (paint: acc, thickness: 0.9pt),
  )
})

// Fill the slide, but never overflow it: scale to whichever of width/height binds.
// (Overflowing pushes the whole block onto a second, otherwise-blank page.)
#layout(size => {
  let m = measure(diagram)
  let f = calc.min(size.width / m.width, size.height / m.height)
  align(center, scale(x: f * 100%, y: f * 100%, reflow: true, diagram))
})
