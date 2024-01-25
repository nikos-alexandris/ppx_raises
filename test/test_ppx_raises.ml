type err =
  | I of int
  | B of bool

exception E of err

let f1 () = raise (E (I 42))
let f2 () = raise (E (B true));;

assert (f1 |> [%raises? E (I 42)]);;
assert (f1 |> [%raises? E (I x) when x > 30]);;
assert (f2 |> [%raises? E (B _)]);;
assert ((fun () -> raise (E (I 42))) |> [%raises? E (I _)])
