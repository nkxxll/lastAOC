(** This library is a collection of Advent of Code 2025 utilities.

It is not intended to be used directly by users, but rather as a
dependency of other libraries. It is not a part of the Advent of Code
2025 challenge. Every day should have its own library.

*)

val directions : (int * int) array

(** Read an input file and return its contents as a string. *)
val read_input_file : filename:string -> string

(** Read an input file and return its contents as a list of lines.
Each line is stripped of leading/trailing whitespace. *)
val read_input_file_lines : filename:string -> string list

(** Read an input file and return its contents *n*ot *t*rimmed as a list of lines.
Each line is *not* stripped of leading/trailing whitespace. *)
val read_input_file_lines_nt : filename:string -> string list

(** [do_on_list ~f ~init ~dirs] folds over a list of directions ([dirs]),
applying function [f] to an accumulator [acc] and each direction.
The initial accumulator value is [init]. *)
val do_on_list : f:('a -> 'b -> 'a) -> init:'a -> dirs:'b list -> 'a

(** Print list of strings to stdout, each on a new line, and return the original list. *)
val print_list : string list -> string list

(** [split_on_string ~delimiter string] splits the input [string]
into a list of substrings using the provided multi-character [delimiter].
This function uses the [Str] module for regular expression splitting. *)
val split_on_string : delimiter:string -> string -> string list

(** [print_res res] prints an integer result to stdout, formatted as "Result: %d". *)
val print_res : int -> unit

(** [sum list] calculates the sum of all integers in the given [list]. *)
val sum : int list -> int

(** [aass ~exp input ~msg] Runtime asserts that [exp] is true, otherwise raises [Failure msg]. *)
val aass : exp:('a -> bool) -> ?msg:string -> 'a -> 'a

(** print a char array (for day 5) *)
val print_char_array : char array -> unit
