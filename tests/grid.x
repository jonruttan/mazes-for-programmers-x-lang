; grid -- the lattice is wired right, or this fails.
; Chapter 2's Cell and Grid: construction, neighbour wiring at edges and
; corners, bidirectional linking, iteration. Expect on stdout: #t
(import-version-once maze/grid "1.2.*")
(import x/num/random)

(def g (Grid new 4 4))
(def fails ())
(def check
  (fn (_ name ok)
    (if ok () (do (set! fails (pair name fails))
                  (display "FAIL: ") (display name) (newline)))))

; size and iteration
(check 'size (= (g size) 16))
(check 'each-cell (= (List length ((g each-cell) ->list)) 16))
(check 'each-row (= (List length ((g each-row) ->list)) 4))
(check 'row-width (= (List length (((g each-row) ->list) 0)) 4))

; corners: (0,0) has no north/west; (3,3) has no south/east
(check 'nw-corner (if ((g ref 0 0) north) #f (if ((g ref 0 0) west) #f #t)))
(check 'se-corner (if ((g ref 3 3) south) #f (if ((g ref 3 3) east) #f #t)))

; interior wiring is mutual: (1,1)'s east is (1,2), whose west is (1,1)
(check 'east-west (eq? ((g ref 1 1) east) (g ref 1 2)))
(check 'west-back (eq? ((g ref 1 2) west) (g ref 1 1)))
(check 'north-south (eq? ((g ref 2 1) north) (g ref 1 1)))

; out of bounds is nil, not an error
(check 'bounds (null? (g ref 4 0)))
(check 'bounds-neg (null? (g ref 0 -1)))

; a seeded rng picks a real cell, reproducibly
(def c1 (g random-cell (Random sw 1)))
(def c2 (g random-cell (Random sw 1)))
(check 'random-cell (if (null? c1) #f #t))
(check 'random-repro (eq? c1 c2))

; linking is bidirectional, unlinking too
(def a (g ref 1 1))
(def b (g ref 1 2))
(a link b)
(check 'linked (a linked? b))
(check 'linked-back (b linked? a))
(a unlink b)
(check 'unlinked (if (a linked? b) #f #t))
(check 'nil-never-linked (if (a linked? ()) #f #t))

(display (null? fails))
(newline)
