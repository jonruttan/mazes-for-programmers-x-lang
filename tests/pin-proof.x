; The pins are armed, or this fails. Run from anywhere in the repo: the
; wrapper finds pin.xon, boots the pinned amalgam, arms the overlay.
; Expect on stderr: the `pinned:` and `pinned boot:` notices. Stdout: #t
(display #t)
(newline)
