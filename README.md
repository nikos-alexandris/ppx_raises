# ppx_raises

A ppx rewriter for checking if a function raises an exception pattern.

## Example usage

Consider an exception type

```ocaml
type err =
  | I of int
  | B of bool

exception E of err
```

Create a function that takes unit and test if it raises
an exception pattern

```ocaml
let f1 () = raise (E (I 42))
assert (f1 |> [%raises? E (I _)])
assert (f1 |> [%raises? E (I x) when x > 30])
```

Any valid pattern can be used on the right of `%raises?`
