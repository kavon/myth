Myth: ML Synthesizer
====================

Requirements
------------

Ocaml > 4.01.0

Quick and Dirty Installation Instructions
-----------------------------------------

    opam pin add myth https://github.com/psosera/myth.git

Example Execution
-----------------

    >$ myth tests/pldi-2015-benchmarks/list_stutter.ml
    let stutter : list -> list =
      let rec f1 (l1:list) : list =
        match l1 with
          | Nil -> []
          | Cons (n1, l2) -> Cons (n1, Cons (n1, f1 l2))
      in
        f1
    ;;

Test Locations
--------------

    tests/pldi-2015-benchmarks
    tests/pldi-2015-extended
    tests/pldi-2015-contexts

.ml files = test
.out file = baseline output
