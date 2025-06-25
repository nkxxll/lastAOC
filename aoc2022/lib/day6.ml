open! Core

let input = Advent.read_input_file ~filename:"6.txt"

let process_list list =
  let rec loop acc rest =
    match rest with
    | [] -> acc
    | w :: x :: y :: z :: tail ->
      if
        not
          (Char.equal w x
           || Char.equal w y
           || Char.equal w z
           || Char.equal x y
           || Char.equal x z
           || Char.equal y z)
      then acc + 4
      else loop (acc + 1) (x :: y :: z :: tail)
    | _ -> failwith "cannot happen"
  in
  loop 0 list
;;

let process_list_two list =
  let rec loop acc rest =
    List.iter rest ~f:(Printf.printf "%c");
    Printf.printf "\n";
    if List.length rest > 14
    then (
      let take = List.take rest 14 in
      if
        not
          (List.contains_dup
             ~compare:(fun a b -> Char.to_int a - Char.to_int b)
             take)
      then acc + 14
      else loop (acc + 1) (List.sub ~pos:1 ~len:(List.length rest - 1) rest))
    else failwith "should not happen not even 14 rest"
  in
  loop 0 list
;;

let task_one = String.to_list input |> process_list
let task_two = String.to_list input |> process_list_two
