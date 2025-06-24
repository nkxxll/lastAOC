open! Core

let file = "3.txt"

let score letter =
  match letter with
  | 'a' .. 'z' -> Char.to_int letter - Char.to_int 'a' + 1
  | 'A' .. 'Z' -> Char.to_int letter - Char.to_int 'A' + 27
  | _ -> failwith "duck you"
;;

let score_from_list (first : char list) (second : char list) =
  let rec aux rest =
    match rest with
    | [] -> failwith "there is no double"
    | x :: rest ->
      if List.mem second x ~equal:Char.equal then score x else aux rest
  in
  aux first
;;

let score_from_lists (first : char list) (second : char list list) =
  let rec aux rest =
    match rest with
    | [] -> failwith "there is no double"
    | x :: rest ->
      let bool =
        let bools =
          List.map second ~f:(fun l -> List.mem l x ~equal:Char.equal)
        in
        (* Printf.printf *)
        (*   "%s\n" *)
        (*   (List.to_string ~f:(fun a -> if a then "true" else "false") bools); *)
        List.fold_left ~init:true ~f:( && ) bools
      in
      if bool then score x else aux rest
  in
  aux first
;;

let eval_rucksack line =
  let length : int =
    String.length line |> Advent.aass ~exp:(fun a -> a mod 2 = 0)
  in
  let half = length - (length / 2) in
  let first = String.sub line ~pos:0 ~len:half |> String.to_list in
  let second = String.sub line ~pos:half ~len:half |> String.to_list in
  score_from_list first second
;;

let task_one_base ~func =
  Advent.read_input_file_lines ~filename:file |> List.map ~f:func |> Advent.sum
;;

let eval_three_rucksack (a : string) (b : string) (c : string) =
  let al, bl, cl = String.to_list a, String.to_list b, String.to_list c in
  score_from_lists al [ al; bl; cl ]
;;

let task_two_base =
  let lines = Advent.read_input_file_lines ~filename:file in
  let chunks = List.chunks_of ~length:3 lines in
  List.map chunks ~f:(fun group ->
    match group with
    | [ a; b; c ] -> eval_three_rucksack a b c
    | _ -> failwith "this should not happen the list has to be divisible by 3")
  |> Advent.sum
;;

let task_one = task_one_base ~func:eval_rucksack
let task_two = task_two_base
