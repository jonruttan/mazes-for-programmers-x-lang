; pin-proof -- the pins are armed and functional, or this fails.
; Run from anywhere: the wrapper finds pin.xon beside this repo's root,
; boots the pinned amalgam (boot/he.x), and arms the deps/ overlay.
; Expect on stderr: the `pinned:` and `pinned boot:` notices.
; Expect on stdout: #t
(import x/type/set)
(def s (Set make))
(s add! 'pinned)
(display (s has? 'pinned))
(newline)
