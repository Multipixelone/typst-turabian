#import "@preview/turabian:0.4.1": turabian

// Get Version from Flake
#let version = sys.inputs.at("version", default: none)
#let date = if version != none {
  let parts = version.split("-")
  datetime(year: int(parts.at(0)), month: int(parts.at(1)), day: int(
    parts.at(2),
  ))
} else {
  datetime.today()
}

#show: turabian.with(
  title: [Title],
  author: "Finn Rutis",
  date: date,
  class: "ENG 1100: 05 College Comp",
  professor: "Dr. Nicholas Fargnoli",
)

#lorem(100)
