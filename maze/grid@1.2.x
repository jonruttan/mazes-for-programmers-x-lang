;; Grid class from Mazes for Programmers
;; Introducing Our Basic Grid, p.17
(import-version-once maze/cell "1.2.*")

(import x/num/random)

; Pure-INT lattice math: fetch the machine ops once.  Under a tower dialect
; (xe/rn) the ambient / promotes two INTs to a RATIONAL -- (/ 5 4) is 5/4,
; not 1 -- so cell coordinates computed with ambient / are wrong everywhere
; but helium (the tower-division trap; same pattern as the stdlib's Date).
(def %grid-div (prim-ref 'int '/))
(def %grid-mod (prim-ref 'int '%))

(def-class Grid ()
  (doc "A rectangular grid of Cells wired into a 4-neighbour lattice."
    (note "Construct with (Grid new rows columns); cells are wired automatically.")
    (see new)
    (see ref)
    (example "(Grid new 4 4)" "a 4x4 grid"))
  (doc rows    "Number of rows in the grid.")
  (doc columns "Number of columns in the grid.")
  (doc grid    "Flat, row-major vector of Cells; cell (r,c) is at index r*columns+c.")

  (static
    (method prepare-grid (self rows columns)
      (doc "Build the flat, row-major vector of rows*columns Cells (cell (r,c) at index r*columns+c)."
        (param rows INT "Number of rows")
        (param columns INT "Number of columns")
        (returns VECTOR "A flat vector of Cells in row-major order"))
      (Vector build (* rows columns)
        (fn (_ i) (Cell new (%grid-div i columns) (%grid-mod i columns)))))

    (method new (self rows columns)
      (doc "Construct a rows-by-columns grid of Cells, wiring each cell's neighbours."
        (param rows INT "Number of rows")
        (param columns INT "Number of columns")
        (returns Grid "A new, fully wired grid")
        (example "(Grid new 4 4)" "a 4x4 grid")
        (see ref)
        (see configure-cells))
      (let ((obj (new-from self (list 'rows rows 'columns columns 'grid (self prepare-grid rows columns)))))
        (obj configure-cells)
        obj)))

  (method %repr (self)
    (doc "Render the grid as #<Grid ROWSxCOLUMNS> -- the compact form (write) uses."
      (returns STRING "Inspection string"))
    $"#<Grid {(self rows)}x{(self columns)}>")

  ; attr_readers
  (method rows    (self)
    (doc "The number of rows (read-only)."
      (returns INT "Row count"))
    (member 'rows))
  (method columns (self)
    (doc "The number of columns (read-only)."
      (returns INT "Column count"))
    (member 'columns))

  (method size (self)
    (doc "The total number of cells (rows * columns)."
      (returns INT "Cell count")
      (example "((Grid new 3 4) size)" "12"))
    (* (self rows) (self columns)))

  (method ref (self row column)
    (doc "The cell at (row, column), or nil if the coordinates are off the grid."
      (param row INT "Row index (0-based)")
      (param column INT "Column index (0-based)")
      (returns Cell "The cell there, or nil if out of bounds")
      (see each-cell))
    (if (and (>= row 0) (< row (self rows)) (>= column 0) (< column (self columns)))
      (Vector ref (+ (* row (self columns)) column) (self grid))
      ()))

  (method random-cell (self rng)
    (doc "A uniformly random cell of the grid."
      (note "Takes the random source explicitly so a seeded RNG gives a reproducible choice; import x/num/random for the Random class.")
      (param rng Random "A random source, e.g. (Random sw) / (Random sw seed) / (Random hw)")
      (returns Cell "A randomly chosen cell")
      (example "(grid random-cell (Random sw 1))" "some cell of grid")
      (see ref))
    (self ref (rng int (self rows)) (rng int (self columns))))

  (method %row-cells (self r)
    (doc "The cells of row r, left to right, as a list."
      (param r INT "Row index (0-based)")
      (returns LIST "The row's cells"))
    (((Gen range 0 (self columns)) map (fn (_ c) (self ref r c))) ->list))

  (method each-row  (self)
    (doc "An iterator over the rows, each a list of Cells."
      (returns Iter "Iterator yielding each row (a list of Cells)")
      (see each-cell))
    (iter (((Gen range 0 (self rows)) map (fn (_ r) (self %row-cells r))) ->list)))

  (method each-cell (self)
    (doc "An iterator over every cell, row by row."
      (returns Iter "Iterator yielding each Cell")
      (see each-row))
    (iter (self grid)))

  (method configure-cells (self)
    (doc "Wire every cell's north/south/east/west to its neighbour (nil at the edges)."
      (returns Grid "self, for chaining")
      (note "Called automatically by `new`; safe to re-run if the grid changes.")
      (see new))
    (Iter for-each
      (fn (_ cell)
        (let (
            (row (cell row)) (column (cell column)))
            (cell north (self ref (- row 1) column))
            (cell south (self ref (+ row 1) column))
            (cell west  (self ref row (- column 1)))
            (cell east  (self ref row (+ column 1)))))
      (self each-cell))
    self))

(provide maze/grid Grid)
