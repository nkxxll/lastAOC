open! Core

let file = "2.txt"

type rps =
  | Rock
  | Paper
  | Scissors
[@@deriving equal]

let rps_of_string = function
  | "A" | "X" -> Rock
  | "B" | "Y" -> Paper
  | "C" | "Z" -> Scissors
  | _ -> failwith "this is not a game here"
;;

type end_ =
  | Lose
  | Draw
  | Win
[@@deriving equal]

let end_of_string = function
  | "X" -> Lose
  | "Y" -> Draw
  | "Z" -> Win
  | _ -> failwith "this is not a game here"
;;

let bonus = function
  | Rock -> 1
  | Paper -> 2
  | Scissors -> 3
;;

let score first second =
  match first, second with
  | x, y when equal_rps x y -> 3 + bonus second
  | Rock, Scissors -> 0 + bonus second
  | Scissors, Rock -> 6 + bonus second
  | Paper, Rock -> 0 + bonus second
  | Rock, Paper -> 6 + bonus second
  | Scissors, Paper -> 0 + bonus second
  | Paper, Scissors -> 6 + bonus second
  | _ -> failwith "this is not a game here"
;;

let line_result line =
  let split = String.split ~on:' ' line in
  let first = List.nth_exn split 0 |> rps_of_string in
  let second = List.nth_exn split 1 |> rps_of_string in
  score first second
;;

let start_task ~f =
  Advent.read_input_file_lines ~filename:file |> List.map ~f |> Advent.sum
;;

let needs first res =
  match first, res with
  | Rock, Lose -> Scissors
  | Rock, Win -> Paper
  | Paper, Lose -> Rock
  | Paper, Win -> Scissors
  | Scissors, Lose -> Paper
  | Scissors, Win -> Rock
  | x, y when equal_end_ y Draw -> x
  | _ -> failwith "this is not a game here"
;;

let line_result2 line =
  let split = String.split ~on:' ' line in
  let first = List.nth_exn split 0 |> rps_of_string in
  let res = List.nth_exn split 1 |> end_of_string in
  let second = needs first res in
  score first second
;;

let task_one = start_task ~f:line_result
let task_two = start_task ~f:line_result2
