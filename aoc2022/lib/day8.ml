open! Core

let file = "8.txt"
let lines = Advent.read_input_file_lines ~filename:file

let grid =
  lines
  |> List.map ~f:(fun line ->
    line
    |> String.to_list
    |> List.map ~f:(fun ch -> Char.to_int ch - Char.to_int '0'))
;;

let get_opt grid x y =
  Option.bind (List.nth grid y) ~f:(fun row -> List.nth row x)
;;

let rec visible current direction grid x y =
  let dirx, diry = direction in
  let new_x = x + dirx in
  let new_y = y + diry in
  let item_opt = get_opt grid new_x new_y in
  match item_opt with
  | Some item ->
    if item >= current then false else visible current direction grid new_x new_y
  | None -> true
;;

let task_one () =
  grid |> List.mapi ~f:(fun y row ->
    List.mapi row ~f:(fun x item ->
      Array.fold Advent.directions ~init:false ~f:(fun acc dir -> acc || visible item dir grid x y)))
  |> List.map ~f:(fun row ->
    row |> List.fold_left ~init:0 ~f:(fun a b -> if b then a + 1 else a))
  |> Advent.sum
;;

let task_two () = -1
