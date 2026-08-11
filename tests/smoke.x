; smoke -- the toolchain is present and the modules the series uses import.
; Not a pin check: this asserts only what the README promises, that a
; recent enough x-lang is on PATH. Expect on stdout: #t
(import x/type/dict)
(import x/num/random)
(def d (Dict make 8))
(d set! 'ok #t)
(display (d get 'ok))
(newline)
