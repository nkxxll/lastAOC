open! Core

let file = "5.txt"

type move = {
  from: int;
  to_: int;
  count: int;
}

let parse_create_line line =
let len = String.length line in
  let rec loop acc rest next position =
  if len > next then
      let character = String.nget rest next in
      loop (character :: acc) (String.sub line ~pos:next ~len:(len - next)) (next + 3) (position + 1)
    else 
List.rev acc
in loop [] line 1 1

let parse_first first =

;;

let parse_second second = 
;;

let task_base = 
  let split = Advent.read_input_file ~filename:file |> Advent.split_on_string ~delimiter:"\n\n" in
  let first = List.nth_exn split 0 |> String.split_lines in
  let second = List.nth_exn split 1 |> String.split_lines in
  let map = parse_first first in
  let commands = parse_second second in
  execute map commands

let task_one = 10
let task_two = 11
