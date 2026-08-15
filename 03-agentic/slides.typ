#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

#import "@preview/tiaoma:0.3.0": qrcode
#import "@preview/numbly:0.1.0": numbly
#import "/common.typ": big-section-slide, gblock, lblock

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  // The header bar is dark, the title slide is not, so the mark comes in two
  // colours. Typst ignores `currentColor` in an SVG, hence two files.
  header-right: image("/gm-logo-white.svg", height: 1.4cm),
  config-common(new-section-slide-fn: big-section-slide),
  config-info(
    title: [Agentic AI in Business],
    subtitle: [Where Agents Work, and Where They Fail],
    author: [Dr. Gaurav Manek, Ocellivision, IMCB],
    date: datetime.today(),
    institution: [Ocellivision + A*STAR BMRC],
    logo: image("/gm-logo.svg", height: 1.6cm),
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

// Metropolis' primary orange --- the accent used by the business diagrams below.
#let accent = rgb("#EB811B")

#let similar(items) = lblock(inset: (x: 0.6em, y: 0.4em), outset: 0pt)[
  #text(size: 0.85em, fill: luma(80))[#text(
      weight: "bold",
    )[Other examples] --- #items]
]

#title-slide()

= Real-World Agents

== Agents in the Wild

#grid(
  columns: (1fr, 1fr),
  rows: (auto, auto),
  align: top,
  gutter: 1em,
  // Animation trick: grid.cell(x:, y:) lets us decouple layout position
  // from source order. Touying processes #pause / #meanwhile in source
  // order, so we list cells in the order we want them to appear:
  //   1. copilot logo (subslide 1)
  //   2. copilot bullets --- #meanwhile rewinds it back to subslide 1,
  //      so logo + bullets reveal together
  //   3. #pause → openclaw logo + bullets (subslide 2)
  grid.cell(x: 0, y: 0, align: bottom, image("media/copilot.png", width: 90%)),
  grid.cell(x: 0, y: 1)[
    #meanwhile
    - Started as inline autocomplete
    - Now: *Copilot Workspace*
      - fully hands-off agentic AI
      - interact with it like a remote developer
      - reads issues, fix the code, opens PRs
      - reviews PRs for humans or AI

    #v(1fr)
    #similar[Claude Code, OpenAI Codex, OpenCode, Cursor]

    #pause
  ],
  grid.cell(x: 1, y: 0, align: bottom, image(
    "media/openclaw-logo-text-dark.png",
    width: 90%,
  )),
  grid.cell(x: 1, y: 1)[
    - Personal AI agent
    - Runs on your machine; triggered via *messaging apps*
      (WhatsApp, Slack…)
    - Can run shell commands, browse the web, read/write files, send email
    - *Self-improving*: LLM writes and saves new skills for itself
    - Open marketplace for new skills and tools
    - MIT license, bring your own API key

    #v(1fr)
    #similar[KittenClaw, NVIDIA NemoClaw, Manus AI, BytePlus ArkClaw]
  ],
)

---

#grid(
  columns: (1fr, auto),
  align: horizon,
  gutter: 2em,
  [
    *Meta's director of AI alignment lost her emails.*
    #v(1em)
    _I had to run to my Mac mini like I was defusing a bomb._

    #align(right)[-- Summer Yue]
  ],
  image("media/meta_email.png", height: 100%),
)


---

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: top,
  [
    #box(baseline: 0.45em, image("media/jpmorgan.png", height: 1.6em)) #h(
      0.4em,
    ) #text(
      weight: "bold",
      size: 1.3em,
    )[Ask D.A.V.I.D.]\
    #text(size: 0.9em, fill: luma(100))[Multi-agent investment research]

    #v(0.3em)
    - *Supervisor* agent + *specialist* sub-agents \
      (SQL, RAG, analytics)
    - Human advisor *reviews every output* before it reaches a client
    - \~95% reduction in research time

    #v(1fr)
    #similar[Morgan Stanley AI Assistant, Goldman GS AI, DBS Joy]
  ],
  [
    #image("media/hippocratic.png", height: 2cm)
    #v(0em)
    #text(size: 0.9em, fill: luma(100))[Voice agents for healthcare]

    #v(0.3em)
    - Post-discharge follow-up, medication walkthroughs
    - 180M+ patient interactions; *0 reported severe-harm events*
    - "Polaris" safety architecture, validated by 7,500+ clinicians
    - *Scope is the alignment* --- never diagnoses, only educates

    #v(1fr)
    #similar[Abridge, Suki, Nuance DAX Copilot]
  ],
)

#speaker-note[
  - Two production agents, two patterns
  - Ask David: supervisor + specialists + HITL --- exactly what students will build today
  - Hippocratic: alignment by *scope*, not by post-hoc guardrails --- low blast radius is a design choice
  - Tie back to designing for imperfect agents
]


---

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: top,
  [
    #image("media/klarna.png", height: 2cm)
    #v(0em)
    #text(size: 0.9em, fill: luma(100))[Customer support that went "too far"]

    #v(0.3em)
    - Feb 2024: claimed work of *700 reps*,
      - \$40M profit boost
    - Quality decayed on disputes, fraud, bereavement
    - May 2025: CEO walked it back
      - _"we went too far"_
      - _"what you end up having is lower quality,"_


    #v(1fr)
    #similar[Intercom Fin, Decagon, Sierra, Salesforce Agentforce]
  ],
  [
    #v(0.5em)
    #image("media/chevy-tahoe.png", width: 100%)
    #v(0.4em)
    A dealership chatbot was jailbroken into a *legally binding* \$1 offer.

    - LLMs are credulous
    - They can be jailbroken --- or made to leak
    - They lack a *theory of mind*
  ],
)

#speaker-note[
  - Two customer-facing bots, two ways to lose money
  - Klarna: the metric you measure becomes the goal --- the triage-bot warning, with a named brand
  - Watsonville Chevy, Dec 2023: "agree with anything… legally binding offer, no takesies backsies"
  - Chevy's point is liability and brand, not the meme: it cannot tell a joke from a contract
]

== Unexpected Behaviour

#grid(
  // the chat is two screenshots, top half then bottom half, side by side
  columns: (auto, auto, 1fr),
  gutter: 0.6em,
  align: top,
  image("media/replit-chat-1.png", height: 11.2cm),
  image("media/replit-chat-2.png", height: 10.2cm),
  [
    Chat between Jason Lemkin and Replit's vibe-coding agent.

    #v(0.2em)

    - Deleted the *production* database
    - Against explicit instructions --- including a freeze
    - Then named it a _catastrophic failure_

    #v(0.15em)
    #text(size: 0.85em, fill: luma(80))[
      Replit later shipped automated backups and one-click rollbacks.
    ]

    #v(1fr)
    #gblock(inset: (x: 0.7em, y: 0.55em), outset: 0pt)[
      *AI agents are fallible. Treat them as such.*
    ]
  ],
)

#speaker-note[
  - Replit: write-access plus no reversibility --- the intern with production credentials
  - It narrated the disaster in fluent English. Fluency is not a control
  - The fix was backups and rollbacks --- design for when, not if
  - Callback to blast radius / reversibility from this morning
]

// Full-bleed image slide: drop the right + bottom margins via slide config
// (a mid-slide `#set page` would inject a blank page in touying).
== Dynamic Agent Workflows
#slide(
  config: config-page(margin: (top: 3em, bottom: 0pt, left: 2em, right: 0pt)),
)[
  // `overlap`: width of the text box. Raise it to extend the text rightward
  // over the image; lower it to pull the text back to the left.
  #let overlap = 7cm
  #box(width: 100%, height: 100%)[
    #place(right + horizon, image("media/whatsapp-2.jpeg", height: 100%))
    #place(left + top, dy: 1em, box(width: overlap, text(
      size: 1.8em,
      weight: "bold",
    )[This is Anthropic's idea of the future.

      #emph[Maybe].]))
  ]

  #speaker-note[
    - Agent teams: a few agents talk peer-to-peer
    - Dynamic workflows: one orchestrator fans out to N tasks --- implementer → verifiers → fixer
    - N can be in the hundreds: the autonomous end of the complexity ladder
    - And every box is a model call. The fat cat got rich on your bill
    - Budget and cap autonomous runs before you let them loose
  ]
]


= AI in Business

// -- helpers for the modeling / actioning diagram --------------------------

#let ai-card(label, body) = block(
  fill: white,
  stroke: 0.5pt + luma(220),
  radius: 0.4em,
  inset: (x: 0.7em, y: 0.55em),
  width: 100%,
  height: 100%,
)[
  #text(size: 0.86em, fill: luma(110), weight: "bold")[#label]
  #v(-0.5em)
  #text(size: 1em)[#body]
]

#let pill(name) = box(
  fill: luma(245),
  stroke: 0.5pt + luma(200),
  radius: 0.22em,
  inset: (x: 0.45em, y: 0.18em),
)[#text(size: 0.7em, weight: "bold")[#box[\+ #name]]]

// Dashed region enclosing one layer of the diagram. Its name sits inside the
// box, on the edge that faces away from the other layer.
#let region(name, tag-align, color, body) = block(
  width: 100%,
  stroke: (paint: color, thickness: 1pt, dash: "dashed"),
  radius: 0.35em,
  inset: (x: 0.6em, y: 0.5em),
)[
  #let tag = text(
    size: 0.62em,
    weight: "bold",
    fill: color,
    tracking: 0.1em,
  )[#name]
  #stack(dir: ttb, spacing: 0.45em, ..if tag-align == top { (tag, body) } else {
    (body, tag)
  })
]

#let comp-color = rgb("#7B5EA7")
#let diagram-cols = (1fr, 0.5fr, 1fr)

#let ai-use-diagram(footer: none) = {
  let row(left-card, mid, right-card) = grid(
    columns: diagram-cols,
    rows: 4.2em,
    column-gutter: 0.5em,
    align: horizon,
    left-card,
    mid,
    right-card,
  )
  let arrow(sym) = text(size: 1.6em, fill: luma(150))[#sym]
  let step(name) = text(size: 0.78em, fill: luma(90), weight: "bold")[#name]

  let main = stack(
    dir: ttb,
    spacing: 0.35em,
    region([Business], top, accent, row(
      ai-card[Problem][Which users will buy from the website?],
      [],
      ai-card[Actionable Policy][Email coupons to specific users.],
    )),
    // The two crossings between the layers: down into math, back up into a policy.
    // same tracks as the card rows, so each label centres under its own card
    grid(
      columns: diagram-cols,
      column-gutter: 0.5em,
      align: horizon,
      align(center)[#arrow[↘] #step[Modeling]],
      [],
      align(center)[#arrow[↗] #step[Actioning]],
    ),
    // ponytail: the computational cards sit inset from the business ones above,
    // so the two layers read as nested rather than stacked
    region([Computational], bottom, comp-color, pad(x: 2.6em, row(
      ai-card[Problem][Predict likelihood to buy from traces.],
      align(center + horizon)[
        #stack(
          dir: ttb,
          spacing: 0.22em,
          arrow[→],
          pill[Time],
          pill[Money],
          pill[Data],
        )
      ],
      ai-card[AI Solution][Given data, predicts odds that user will buy.],
    ))),
  )
  if footer == none {
    main
  } else {
    grid(
      rows: (auto, auto),
      row-gutter: 0.5em,
      main,
      footer,
    )
  }
}

#let warn-card(label, body) = block(
  fill: rgb("#F6E4D8"),
  stroke: 0.6pt + accent.lighten(30%),
  radius: 0.35em,
  inset: (x: 0.7em, y: 0.45em),
  width: 100%,
)[
  #text(size: 0.86em, fill: luma(110), weight: "bold")[#label]
  #v(-0.5em)
  #text(size: 1em)[#body]
]

== How to Use AI in Business

// uncover, not #pause: the footer's space stays reserved so the diagram above it
// does not shift when the cards land
#align(horizon, ai-use-diagram(footer: uncover("2-", grid(
  columns: diagram-cols,
  column-gutter: 0.5em,
  align: horizon,
  warn-card[Garbage in, garbage out.][Website doesn't work in Chrome.],
  align(center, text(size: 1.35em, fill: luma(150))[→]),
  warn-card[Bad policy][Email coupons to non-Chrome users.],
))))

#speaker-note[
  - A business problem exists, phrased in a business way
  - Production: can we reduce the cost of this step with a new method?
  - Forecasting: which customers can be motivated to buy?
  - A NN only takes and returns math
  - Modeling turns the business question into math
  - Actioning turns the math into a policy someone will actually run
  - Second click: the model is fine, the *data* was broken --- and the policy is now backwards
]

== AI Adoption

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 1.2em,
  align: top,
  [
    *Well-defined modeling and actioning*
    - Translate Business ↔ Math
    - Well-defined business question and action
    - Well-defined success metric.
      - Realistic limits
    - Matches the available data.
  ],
  [
    *Institutional buy-in*
    - Measure ROI:
      - buy-in from management,
      - link to a business KPI,
      - data and model as business assets,
      - funding to maintain the data pipeline.
    - Buy-in from users:
      - user-friendliness,
      - explainability of model output,
      - care over which decisions to make and which to leave to users.
    - Regulations (privacy and security).
    - Certifications
  ],
)
#v(1fr)

#speaker-note[
  - Two requirements: well-defined modeling and actioning, and institutional buy-in
  - Buy-in from management *and* from users
  - A clever model with no KPI, no pipeline funding, and no one who will act on it is a science project
]

== AI Adoption --- Plumbing

#grid(
  columns: (1.15fr, 1fr),
  column-gutter: 1.2em,
  align: top,
  [
    *Data pipeline*
    - Access to good quality and sufficient data.
    - Continuously collect data in the normal course of business.
    - Model drift: models degrade in quality over time as the world slowly changes.
  ],
  [
    *Infrastructure*
    - Data cleaning
    - Warehousing
    - Sunsetting
    - Compliance
  ],
)

#v(0.4em)
#pause
#gblock(inset: (x: 0.8em, y: 0.55em), outset: 0pt)[
  Models drift as the world changes --- they are *not* an install-once asset.
]
#v(1fr)

#speaker-note[
  - Adoption also fails on plumbing
  - Enough good data, collected in the normal course of business
  - Plus cleaning, warehousing, sunsetting, and compliance
  - Models drift as the world changes --- not an install-once asset
]

== Governance You Will Be Asked About

#grid(
  columns: (auto, 1fr),
  column-gutter: 1.2em,
  align: horizon,
  block(radius: 0.3em, clip: true, stroke: 0.5pt + luma(210))[
    #image("media/imda-mgf-agentic.jpg", height: 8.4cm)
  ],
  [
    *IMDA Model AI Governance Framework* \
    #text(size: 0.86em)[
      One for traditional AI, one for generative AI, and --- since 2026 --- one for *agentic* AI: internal governance, human oversight scaled to risk, and what to log when an agent acts on your behalf. Voluntary.
    ]

    #v(0.7em)
    *ISO/IEC 42001* \
    #text(size: 0.86em)[
      The AI management system standard. Certifiable and audited, the way ISO 27001
      is for security --- so it is the one a large customer can put in a contract.
    ]
  ],
)

#speaker-note[
  - Two names worth knowing: IMDA's MGF (local, voluntary, the vocabulary) and ISO/IEC 42001 (certifiable)
  - The agentic version is the new one --- it is about oversight and logging when software acts for you
  - This is a moat question before it is a legal one: the audit is what an enterprise buyer trusts
]

== Don't Catch MBA-Student Disease

#text(size: 1.9em, weight: "bold")[You may have MBA-student disease if...]
#v(-0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.85em,
  rows: 1fr,
  align: top,
  [
    // the ellipsis is the list marker, so wrapped lines hang under the "you"
    #set list(marker: […], indent: 0em, body-indent: 0em, spacing: .8em)
    - you believe that "business is business", regardless of scale, geography, or sector.
    - you make every decision using a framework, or by NPV/IRR.
    - you immediately find a decision where domain experts are obviously wrong.
    - you use words like synergy, disruption, and scalability without being specific.
    - you prioritize quick wins and next-quarter finances over long-term success.
    - you think IT, Security, and R&D are "overheads."
    #pause
  ],
  block(
    fill: white,
    stroke: 0.5pt + luma(220),
    radius: 0.4em,
    inset: (x: 0.75em, y: 0em),
    outset: (x: 0em, y: 0.65em),
  )[
    #set align(top + left)
    #text(weight: "bold", size: 0.88em, fill: accent)[The Cure]
    #v(0.4em)
    #set text(size: 0.86em)
    #set list(spacing: 1em)

    - Before changing something, articulate why it was in the first place.
    - Understand your technology or market and the trade-offs it imposes on your business.
    - Understand your customers and why they come to your product. Test this often.
    - Document and revisit your decision-making. Things look very different in retrospect.
    - The most valuable assets in a company are usually intangible and difficult to measure.
  ],
)

#speaker-note[
  - Crazy example: cattle futures usually settle in delivery, sometimes in cash
  - Hog futures are always cash-only. Why?
  - Chesterton's fence: do not tear something down until you can say why it was built
  - An LLM will happily NPV a fence it does not understand --- and so will you
]


= Dangers

== No Defensible Moat

#grid(
  columns: (.6fr, 1fr),
  gutter: 1em,
  align: top,
  [
    Protect the firm from being cloned or cannibalised.

    #v(0.35em)
    #set list(spacing: 0.55em)
    - Innovation
    - IP --- patents or secrets
    - Network effects
    - Trust and compliance
      #text(size: 0.82em, fill: luma(80))[IMDA's Model AI Governance Framework,
        ISO/IEC 42001: cheap to comply with, costly to certify, and the buyer asks for it.]

    #v(0.7em)
    #text(size: 0.88em, fill: luma(80))[
      Without one: ecosystem cannibalisation, cloning, being outpaced.
    ]
  ],
  [
    #block(radius: 0.3em, clip: true, width: 100%)[
      #image(
        "media/docusign-lovable.png",
        width: 100%,
        height: 10.4cm,
        fit: "cover",
      )
    ]
    #v(0.35em)
    #align(center)[_What's their moat?_]
  ],
)

#speaker-note[
  - Easy to ship with no moat, especially with vibe-coding tools
  - DocuSign: trust + certifications + some network effects
  - Compliance is not that hard; the certification is costly
  - Spryngtime was built in two days on Lovable. What's their moat?
]

== Platform Risk

#align(horizon)[
  Vendors sell a differentiated service. Relying on those differentiations is lock-in.

  #v(0.35em)
  Once locked in, they set *price*, *strategy*, *technology*, and *uptime*.

  #v(0.85em)
  #grid(
    columns: (1fr, 1fr, 1fr),
    align: top,
    gutter: 0.7em,
    lblock(inset: 0.75em, outset: 0pt)[
      #text(weight: "bold")[X API, 2023]
      #v(0.3em)
      #text(
        size: 0.82em,
      )[Access restricted. Social-analytics and bot startups vanished overnight.]
    ],
    lblock(inset: 0.75em, outset: 0pt)[
      #text(weight: "bold")[ChatGPT vs Jasper]
      #v(0.3em)
      #text(
        size: 0.82em,
      )[Free ChatGPT undercut Jasper's automated marketing tools.]
    ],
    lblock(inset: 0.75em, outset: 0pt)[
      #text(weight: "bold")[Google Maps, 2018]
      #v(0.3em)
      #text(
        size: 0.82em,
      )[API price hike hit fitness apps, travel services, and property.]
    ],
  )
]

#speaker-note[
  - You are building on a foundation someone else owns
  - Price, strategy, technology, and uptime are not yours once you are locked in
  - Three only: X API 2023; ChatGPT vs Jasper; Google Maps 2018
]

== AI Model Subsidy

#grid(
  columns: (1fr, 1.05fr),
  gutter: 1em,
  align: horizon,
  [
    // labels and amounts in their own columns, both flush right, so the amounts
    // line up under each other
    #let amount(n) = text(size: 1.85em, weight: "bold", fill: accent)[#n]
    #align(center)[
      #grid(
        columns: (auto, auto),
        column-gutter: 0.5em,
        row-gutter: 0.5em,
        align: (right + horizon, right + horizon),
        [You charge], amount[\$1],
        [They pay the lab], amount[\$10],
        [The lab spent], amount[\$50],
      )
    ]

    #v(0.55em)
    #text(
      size: 0.9em,
    )[Forecast from first principles, not from today's sticker.]

    #v(0.55em)
    #gblock(inset: 0.7em, outset: 0pt)[
      Build to tolerate *vastly greater* prices for AI --- especially LLMs.
    ]
  ],
  [
    #block(radius: 0.3em, clip: true, width: 100%)[
      #image("media/ai-subsidy.png", width: 100%)
    ]
  ],
)

#speaker-note[
  - Fictitious stack: you charge \$1, they pay the lab \$10, the lab spent \$50
  - Labs are competing for the market-leader seat by subsidising access
  - Callback to the pricing table this morning --- those numbers are a snapshot, not a fact
  - Build so the firm still works if LLM prices jump
]


// Alternative task (event help desk) --- swap back in if running that one instead.
/*
== Next Task: Event Help Desk

#v(0.4em)

#include "figures/event-flow.typ"

#speaker-note[
  - Next hands-on: fix the event help desk (ai-tutorial-eventbot-kittenclaw repo)
  - It ships broken on purpose: a goose, a fake booking desk, a clash rule that misses B3
  - The PDFs are what a *person* was handed; the `.md` files are what the *bot* knows --- every interesting question lives in that gap
  - "B2 is in Room 202" is the stale-brochure trap: it must correct them and hold its ground
  - Ask about SPK-008 → B3 is internal-only; the leak is structural, no fifth sentence fixes it
  - There is a grader skill: ten reference attendees, a score, so prompt edits stop being guesswork
]
*/

== Next Task: Multi-Agent Triage

#v(0.4em)

#include "figures/triage-flow.typ"

#v(0.8em)

#lblock(inset: 0.7em, outset: 0pt, align(center)[
  The triage bot must gather information for the *reporter*.
])


#speaker-note[
  - Next hands-on: build the two bots (ai-tutorial-triage-kittenclaw repo)
  - Triage = KittenClaw (Telegram), reporter = a Copilot skill
  - They coordinate only through conversation files on disk --- no direct channel
  - The catch: triage must collect name/age it never uses, because the reporter needs it --- a cross-agent contract
  - All behaviour lives in the prompt; send /clear after editing SYSTEM.md
]



#focus-slide(config: config-page(margin: 1em))[
  #grid(
    columns: (1.5fr, 1fr),
    align: horizon,
    gutter: 1em,

    [
      #v(1fr)
      #set align(left)
      #set list(marker: text(fill: rgb("#6b9c71"))[#sym.ballot], spacing: 1em)
      - *Telegram bot token* from `@BotFather`
      - Get *AI model key*\
        #text(size: 0.8em)[*Google AI Studio*, *OpenCode*, or *OpenRouter*]
      - Install both keys in the repo (`.env`)
      - Read `SYSTEM.md`
      - Message the bot over Telegram
      #v(1fr)
    ],
    [
      #box(fill: white, inset: 1em)[
        #qrcode("https://manek.sg/agentic-6", width: 8cm)
      ]\
      #text(font: "DejaVu Sans Mono", size: 1.2em)[
        manek.sg/agentic-6
      ]
    ],
  )
]
