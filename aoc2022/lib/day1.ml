open! Core
open! Advent

let file = "1.txt"

let process_pack pack =
  let lines = String.split_lines pack in
  let ints = List.map ~f:Int.of_string lines in
  List.fold_left ints ~f:( + ) ~init:0
;;

let greater a b = if a > b then a else b

let task_start =
  read_input_file ~filename:file
  |> split_on_string ~delimiter:"\n\n"
  |> List.map ~f:process_pack
;;

let task_one () =
  task_start |> List.fold_left ~init:0 ~f:greater
;;

let task_two () =
  let start = task_start in
  let sorted = List.sort ~compare:(fun a b -> b - a) start in
  let three = List.take sorted 3 in
  List.fold_left ~init:0 ~f:( + ) three
;;
