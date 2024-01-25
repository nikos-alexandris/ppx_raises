(lang dune 3.13)

(name ppx_raises)

(generate_opam_files true)

(source
 (github nikos-alexandris/ppx_raises))

(package
 (name ppx_raises)
 (synopsis "A ppx for matching exceptions")
 (depends ocaml dune ppxlib))
