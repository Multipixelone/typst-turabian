# typst-turabian

A [Typst](https://typst.app/) template for papers formatted in
[Chicago/Turabian](https://www.chicagomanualofstyle.org/turabian/citation-guide.html) style.

## Features

- US Letter page size with 1-inch margins
- Times New Roman, 12pt
- Double-spaced paragraphs with 0.5-inch first-line indent
- Automatic title page with author, class, professor, and date
- Page numbers in the header (starting from the first page of body text)
- Chicago/Turabian full-note bibliography style

## Usage

Import the package and call the `turabian` function:

```typst
#import "@preview/turabian:0.4.1": turabian

#show: turabian.with(
  title: "The Role of Architecture in Urban Identity",
  author: "Jane Doe",
  class: "ARCH 301: Urban Studies",
  professor: "Dr. John Smith",
  date: datetime(year: 2026, month: 1, day: 15),
)

This is the body of the paper. The first page will automatically include a
centered title, and paragraphs are double-spaced with a half-inch indent.

== Section Heading

More content goes here.
```

## Parameters

| Parameter    | Type       | Default        | Description                                       |
| ------------ | ---------- | -------------- | ------------------------------------------------- |
| `title`      | `string`   | `none`         | Title of the paper (displayed on the title page)  |
| `author`     | `string`   | `none`         | Author name                                       |
| `date`       | `datetime` | `none`         | Date displayed on the title page                  |
| `class`      | `string`   | `none`         | Course name and number                            |
| `professor`  | `string`   | `none`         | Professor / instructor name                       |
| `paper-size` | `string`   | `"us-letter"`  | Page size (any Typst-supported paper size)        |

## Local Development

This project uses a [Nix flake](https://nixos.wiki/wiki/Flakes) for
development. Enter the development shell to get `typst`, `typstyle`, and
`git-cliff`:

```sh
nix develop
```

### Formatting

Format Nix files:

```sh
nix fmt
```

Format Typst files:

```sh
typstyle format-all .
```

### Checks

Run all checks (Nix formatting and Typst formatting):

```sh
nix flake check
```

### Changelog

Generate a changelog with [git-cliff](https://git-cliff.org/):

```sh
git cliff -o CHANGELOG.md
```

## Installation

### Typst Universe (recommended)

```typst
#import "@preview/turabian:0.4.1": turabian
```

### Nix

Add the flake as an input and use the `turabian` package:

```nix
{
  inputs.typst-turabian.url = "github:Multipixelone/typst-turabian";
}
```

The package installs to `$out/lib/typst-packages/turabian/<version>`, which can
be added to `TYPST_PACKAGE_PATH`.

## License

[MIT](LICENSE)
