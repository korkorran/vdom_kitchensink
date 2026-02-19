open Vdom

type model = unit

let update () = function
  | `Unit -> ()

let init = ()

let select ?key  l = elt "select" ?key ~a:[onchange ~prevent_default:() ~stop_propagation:() (fun _ -> (`Unit)) ] l
let option ?(selected=false) txt =
  match selected with
  | true -> elt "option" ~a:[value txt; attr "selected" "selected"] [text txt]
  | _ -> elt "option" ~a:[value txt] [text txt]

let view () =
  select [ option "foo"; option "bar" ~selected:true; option "baz"]

let app = simple_app ~init ~view ~update ()

open Js_browser
let run () = Vdom_blit.run app |> Vdom_blit.dom |> Element.append_child (Document.body document)
let () = Window.set_onload window run