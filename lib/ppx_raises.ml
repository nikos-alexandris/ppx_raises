open Ppxlib

let expand ~ctxt pat guard =
  let open Ast_builder.Default in
  let loc = Expansion_context.Extension.extension_point_loc ctxt in
  pexp_fun
    ~loc
    Nolabel
    None
    (ppat_var ~loc { txt = "f"; loc })
    (pexp_match
       ~loc
       (pexp_apply
          ~loc
          (pexp_ident ~loc { txt = Lident "f"; loc })
          [ Nolabel, pexp_construct ~loc { txt = Lident "()"; loc } None ])
       [ case ~lhs:(ppat_exception ~loc pat) ~guard ~rhs:(ebool ~loc true)
       ; case ~lhs:(ppat_any ~loc) ~guard:None ~rhs:(ebool ~loc false)
       ])
;;

let extension =
  Extension.V3.declare
    "raises"
    Extension.Context.expression
    Ast_pattern.(ppat __ __)
    expand
;;

let rule = Ppxlib.Context_free.Rule.extension extension
let () = Driver.register_transformation ~rules:[ rule ] "raises"
