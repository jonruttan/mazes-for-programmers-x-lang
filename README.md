# Mazes for Programmers, in x-lang

Companion code for a blog series working through the algorithms in *Mazes for
Programmers* (Jamis Buck) in [x-lang](https://github.com/jonruttan/x-lang).

The code is built up **as the series is written** — one book-addressed commit at
a time — so `git log` tracks the book. This repo starts as a scaffold and grows
post by post. The series lives at
[jonruttan.github.io](https://jonruttan.github.io/) (category
`mazes-for-programmers`).

## Layout

    maze/            source, namespace `maze/…` — the grid model, and
      algorithm/     the maze-generation algorithms under maze/algorithm/…
    tests/           per-chapter examples with expected output

## Requirements

[x-lang](https://github.com/jonruttan/x-lang) (the `x` command).

## Licence

[MIT No Attribution](LICENSE), matching x-lang.
