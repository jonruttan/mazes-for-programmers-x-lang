;; Cell class from Mazes for Programmers
;; Algorithm 2.1.0, p.18#alg.0
(import x/type/set)

(def-class Cell ()
  (doc "A Cell in a grid maze: it knows its (row, column), its four orthogonal neighbours, and the set of cells it is linked to (passages between cells)."
    (note "Construct positionally with (Cell new row column).")
    (see new)
    (example "(Cell new 0 1)" "#<Cell (0, 1)>"))
  row column
  (doc (links (Set make)) "Cells this one has a passage to (a Set; instances are identity members).")
  (doc north "Neighbouring cell to the north, or nil.")
  (doc south "Neighbouring cell to the south, or nil.")
  (doc east  "Neighbouring cell to the east, or nil.")
  (doc west  "Neighbouring cell to the west, or nil.")

  ; attr_reader: the getter method blocks the (self row v) setter path
  (method row (self)
    (doc "The cell's row index (read-only)."
      (returns INT "Row index"))
    (member 'row))
  (method column (self)
    (doc "The cell's column index (read-only)."
      (returns INT "Column index"))
    (member 'column))

  (method %repr (self)
    (doc "Render the cell as #<Cell (row, column)>."
      (returns STRING "Display string"))
    $"#<Cell ({(self row)}, {(self column)})>")

  (method linked? (self cell)
    (doc "Test whether this cell has a passage to `cell`; nil (a missing neighbour) is never linked."
      (param cell Cell "Cell to test, or nil")
      (returns BOOLEAN "t if linked, else f"))
    (if (null? cell) #f ((self links) has? cell)))

  (method neighbors (self)
    (doc "The existing orthogonal neighbours (non-nil north/south/east/west)."
      (returns LIST "List of neighbouring cells"))
    (List filter (fn (_ x) x)
      (list (self north) (self south) (self east) (self west))))

  (method link (self cell . opts)
    (doc "Carve a passage to `cell`, reciprocal unless (bi #f)."
      (param cell Cell "Cell to link to")
      (param opts LIST "Options: (bi #t) — link reciprocally (default t)")
      (returns Cell "self, for chaining")
      (example "(c1 link c2)" "c1, with c1 and c2 mutually linked")
      (see unlink))
    ((self links) add! cell)
    (let-opts opts ((bi #t))
      (if bi (cell link self 'bi #f)))
    self)

  (method unlink (self cell . opts)
    (doc "Remove the passage to `cell`, reciprocal unless (bi #f)."
      (param cell Cell "Cell to unlink from")
      (param opts LIST "Options: (bi #t) — unlink reciprocally (default t)")
      (returns Cell "self, for chaining")
      (see link))
    ((self links) del! cell)
    (let-opts opts ((bi #t))
      (if bi (cell unlink self 'bi #f)))
    self))

(provide maze/cell Cell)
