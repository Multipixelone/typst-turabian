// Turabian Template for Typst
// Chicago/Turabian style formatting

#let turabian(
  title: none,
  author: none,
  date: none,
  class: none,
  professor: none,
  paper-size: "us-letter",
  body,
) = {
  set page(
    paper: paper-size,
    margin: 1in,
    header: none,
  )

  set document(title: title, author: author, date: date)
  set text(
    font: "Times New Roman",
    size: 12pt,
  )
  set bibliography(style: "turabian-fullnote-8")

  set par(
    justify: false,
    leading: 2em,
    first-line-indent: 0.5in,
    spacing: 2.5em,
  )

  // Title page
  if title != none {
    v(1fr)
    align(center)[
      #block(spacing: 0em)[
        *#title*
      ]
    ]
    v(1fr)
    align(center)[
      #block(spacing: 0em)[
        #author \
        #class \
        #professor \
        #date.display("[month repr:long] [day], [year]")
      ]
      #v(1fr)
    ]
  }
  pagebreak()
  counter(page).update(1)
  set page(
    header: context {
      h(1fr)
      counter(page).display("1")
    },
    header-ascent: 0.5in,
  )

  // title on first page
  align(center)[#title]

  set par(first-line-indent: 0.5in)

  body
}
