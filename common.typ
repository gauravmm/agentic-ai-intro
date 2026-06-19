// Shared helpers for all slide decks in this repo.
// Import what you need, e.g.:  #import "/common.typ": gblock, lblock, big-section-slide
#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

// Custom section divider: mirrors metropolis' new-section-slide but with a
// larger title and the section number styled like the principle index
// (big, bold, grey). Wire in via the theme:
//   #show: metropolis-theme.with(config-common(new-section-slide-fn: big-section-slide), ...)
#let big-section-slide(config: (:), level: 1, numbered: true, body) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(x: 12%, y: 20%)
    set text(size: 1.9em)
    // Number hangs in its own column, to the left of the centred title block.
    let section-number = text(weight: "bold", size: 3em, fill: luma(160))[
      #utils.display-current-heading(
        level: level,
        numbered: numbered,
        style: (setting: body => body, numbered: true, current-heading) => setting({
          if numbered and current-heading.numbering != none {
            numbering(
              current-heading.numbering,
              ..counter(heading).at(current-heading.location()),
            )
          }
        }),
      )
    ]
    let section-title = utils.display-current-heading(
      level: level,
      numbered: numbered,
      style: (setting: body => body, numbered: true, current-heading) => setting(
        current-heading.body,
      ),
    )
    grid(
      columns: (1fr, 16cm, 1fr),
      column-gutter: .8em,
      align: (right + bottom, left + bottom),
      section-number,
      stack(
        dir: ttb,
        spacing: .3em,
        text(self.colors.neutral-darkest, section-title),
        block(
          height: 2pt,
          width: 100%,
          spacing: 0pt,
          components.progress-bar(height: 2pt, self.colors.primary, self.colors.primary-light),
        ),
      ),
    )
    text(self.colors.neutral-dark, body)
  }
  self = utils.merge-dicts(self, config-page(fill: self.colors.neutral-lightest))
  touying-slide(self: self, config: config, slide-body)
})

// Grey filled block — used for callouts / definition boxes.
#let gblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: luma(235),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]

// White bordered block — lighter-weight callout.
#let lblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: white,
  stroke: 0.5pt + luma(220),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]
