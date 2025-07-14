(** This library is a collection of Advent of Code 2025 utilities.

   It is not intended to be used directly by users, but rather as a
    dependency of other libraries. It is not a part of the Advent of Code
    2025 challenge. Every day should have its own library. 
   *)
open! Core

let directions = [| 1, 0; -1, 0; 0, 1; 0, -1 |]
let input_file file = "./inputs/" ^ file

(** Read an input file and return its contents as a string. *)
let read_input_file ~filename =
  In_channel.with_file (input_file filename) ~f:In_channel.input_all
  |> String.strip
;;

(** Read an input file and return its contents as a list of lines. *)
let read_input_file_lines ~filename =
  In_channel.with_file (input_file filename) ~f:(fun ic ->
    In_channel.input_lines ic |> List.map ~f:String.strip)
;;

(** Read an input file and return its contents as a list of lines. *)
let read_input_file_lines_nt ~filename =
  In_channel.with_file (input_file filename) ~f:(fun ic ->
    In_channel.input_lines ic)
;;

(** Do something on something with a list of directions. *)
let do_on_list ~f ~init ~dirs =
  List.fold dirs ~init ~f:(fun acc dir -> f acc dir)
;;

(** Print list of int to stdout and return the list *)
let print_list list =
  List.iter list ~f:print_endline;
  list
;;

(** Split string on string *)
let split_on_string ~delimiter string = Str.split (Str.regexp delimiter) string

(** Print the res *)
let print_res res = Printf.printf "\tResult: %d\n" res

(** Sum of int list *)
let sum = List.fold_left ~init:0 ~f:( + )

(** Runtime assert and expression and return the input afterwards *)
let aass ~exp ?(msg = "Assertion failed") input =
  if not (exp input) then failwith msg else input
;;

let print_char_array array =
  Array.iter ~f:(fun c -> Printf.printf "%c" c) array;
  Printf.printf "\n"
;;
