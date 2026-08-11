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
    boot/            the pinned language: a verified amalgam from a release
    deps/            the module overlay (empty until the code imports something)

## Requirements

[x-lang](https://github.com/jonruttan/x-lang) — install the `x` command from the
[release tarball](https://github.com/jonruttan/x-lang/releases) for the version
in `deps.lock.xon` (no toolchain needed).

The language itself is pinned: `pin.xon` boots a verified amalgam committed
under `boot/`, and `deps.lock.xon` records the release it came from, that
release's ISA fingerprint, and the amalgam's digest. An amalgam runs on the
engine from its own release, so install the tarball for the tag the lock names.

Run a test with `x -f tests/smoke.x` — you should see the `pinned:` and
`pinned boot:` notices on stderr.

## Licence

[MIT No Attribution](LICENSE), matching x-lang.
