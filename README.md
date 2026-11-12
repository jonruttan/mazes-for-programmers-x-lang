# Mazes for Programmers, in x-lang

Companion code for a blog series working through the algorithms in *Mazes for
Programmers* (Jamis Buck) in [x-lang](https://github.com/jonruttan/x-lang).

The code is built up **as the series is written** — one book-addressed commit at
a time — so `git log` tracks the book. This repo starts as a scaffold and grows
post by post. The series lives at
[jonruttan.github.io/mazes-for-programmers](https://jonruttan.github.io/mazes-for-programmers/).

## Layout

    maze/            source, namespace `maze/…` — the grid model, and
      algorithm/     the maze-generation algorithms under maze/algorithm/…
    tests/           per-chapter examples with expected output
    boot/            the pinned language: a verified amalgam from a release
    deps/            the module overlay (empty until the code imports something)

## Requirements

[x-lang](https://github.com/jonruttan/x-lang) **v0.5.1** — install the `x`
command from [that release's
tarball](https://github.com/jonruttan/x-lang/releases/tag/v0.5.1) (no toolchain
needed). `deps.lock.xon` is where the version is recorded.

The code is written for that release. x-lang has moved since, and some
spellings here differ from the current ones: string interpolation is `$"…"`
here and `#"…"` now.

The language itself is pinned: `pin.xon` boots a verified amalgam committed
under `boot/`, and `deps.lock.xon` records the x-lang release it came from,
the engine build it pairs with (`engine-release`), their fingerprints, and the
amalgam's digest. The release tarball for the tag the lock's `(release …)`
line names carries that engine, so one download covers both. Run against a
release or engine that doesn't match the lock and the wrapper refuses with
both sides named rather than booting a mismatched pair.

Run a test with `x -f tests/smoke.x` — you should see the `pinned:` and
`pinned boot:` notices on stderr.

## Licence

[MIT No Attribution](LICENSE), matching x-lang.
