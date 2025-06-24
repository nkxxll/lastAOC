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

let eval_rucksack line =
  let length : int =
    String.length line |> Advent.aass ~exp:(fun a -> a mod 2 = 0)
  in
  let half = length - (length / 2) in
  let first = String.sub line ~pos:0 ~len:half |> String.to_list in
  let second = String.sub line ~pos:half ~len:half |> String.to_list in
  score_from_list first second
;;

let task_base ~func =
  Advent.read_input_file_lines ~filename:file |> List.map ~f:func |> Advent.sum
;;

let task_one = task_base ~func:eval_rucksack
let task_two = 11
