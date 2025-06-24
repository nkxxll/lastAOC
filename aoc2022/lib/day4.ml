open! Core

let file = "4.txt"

let process (base_list : int list list) =
  (* should look like this: [[9; 10]; [8; 11]] *)
  let first_range = List.nth_exn base_list 0 in
  let second_range = List.nth_exn base_list 1 in
  match first_range, second_range with
  | [ x; y ], [ a; b ] when (x <= a && y >= b) || (x >= a && y <= b) -> 1
  | [ x; y ], [ a; b ] when not ((x <= a && y >= b) || (x >= a && y <= b)) ->
    0 (* check that the format is right *)
  | _ -> failwith "wrong format"
;;

let task_one =
  Advent.read_input_file_lines ~filename:file
  |> List.map ~f:(String.split ~on:',')
  |> List.map
       ~f:
         (List.map ~f:(fun s ->
            String.split s ~on:'-' |> List.map ~f:Int.of_string))
  |> List.map ~f:process
  |> Advent.sum
;;

let score (list : int list list) =
  (* should look like this [[9; 8]; [10; 11]; [11; 12]] *)
  let rec aux acc rest =
    match rest with
    | [] -> acc
    | x :: tail ->
      let count =
        List.map tail ~f:(fun item ->
          match item, x with
          | [ a; b ], [ c; d ] when (a <= c && b >= d) || (a >= c && b <= d) ->
            1
          | [ a; b ], [ c; d ]
            when not ((a <= c && b >= d) || (a >= c && b <= d)) -> 0
          | _ -> failwith "this is the wrong format and should not happen")
        |> Advent.sum
      in
      aux (acc + count) tail
  in
  aux 0 list
;;

let _task_three =
  let base_pairs =
    Advent.read_input_file_lines ~filename:file
    |> List.map ~f:(String.split ~on:',')
  in
  let flatten = List.concat base_pairs in
  let list_pairs =
    List.map flatten ~f:(fun s ->
      String.split s ~on:'-' |> List.map ~f:Int.of_string)
  in
  score list_pairs
;;

let process_two (base_list: int list list) = 
  let first_range = List.nth_exn base_list 0 in
  let second_range = List.nth_exn base_list 1 in
  let overlap x y a b = (x <= a && y >= b) || (x >= a && y <= b) || (x <= a && y >= a) || (x <= b && y >= b) in
  match first_range, second_range with
  | [ x; y ], [ a; b ] when overlap x y a b  -> 1
  | [ x; y ], [ a; b ] when not (overlap x y a b)->
    0 (* check that the format is right *)
  | _ -> failwith "wrong format"

  let task_two = 
  Advent.read_input_file_lines ~filename:file
  |> List.map ~f:(String.split ~on:',')
  |> List.map
       ~f:
         (List.map ~f:(fun s ->
            String.split s ~on:'-' |> List.map ~f:Int.of_string))
  |> List.map ~f:process_two
  |> Advent.sum
;;
