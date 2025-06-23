(** This library is a collection of Advent of Code 2025 utilities.

    It is not intended to be used directly by users, but rather as a
    dependency of other libraries. It is not a part of the Advent of Code
    2025 challenge. Every day should have its own library. 
   *)
open! Core

(** Read an input file and return its contents as a string. *)
let read_input_file ~filename =
  In_channel.with_file filename ~f:In_channel.input_all
;;

(** Read an input file and return its contents as a list of lines. *)
let read_input_file_lines ~filename =
  In_channel.with_file filename ~f:(fun ic ->
    In_channel.input_lines ic |> List.map ~f:String.strip)
;;

(** Do something on something with a list of directions. *)
let do_on_list ~f ~init ~dirs =
  List.fold dirs ~init ~f:(fun acc dir -> f acc dir)
;;
