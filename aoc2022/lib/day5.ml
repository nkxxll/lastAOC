open! Core

let result = Advent.read_input_file_lines_nt ~filename:"5.txt"
let empty = ' '

let push_row_on_stacks row stacks =
  let transform_idx idx = (idx * 4) + 1 in
  let f idx stack =
    match transform_idx idx |> String.get row with
    | s when Char.equal s empty -> ()
    | s -> Stack.push stack s
  in
  Array.iteri ~f stacks
;;

module Move = struct
  type t =
    { amount : int
    ; src : int
    ; dest : int
    }

  let of_string move =
    let split = String.split ~on:' ' move |> Array.of_list in
    let amount = split.(1) |> int_of_string in
    let src = (split.(3) |> int_of_string) - 1 in
    let dest = (split.(5) |> int_of_string) - 1 in
    { amount; src; dest }
  ;;
end

let move_part_1 stacks move =
  let move = Move.of_string move in
  for _ = 0 to move.amount - 1 do
    let index = move.src in
    let stack = stacks.(index) in
    let pop = Stack.pop stack in
    match pop with
    | Some x -> Stack.push stacks.(move.dest) x
    | None -> failwith "will not happen"
  done
;;

let move_part_2 stacks move =
  let move = Move.of_string move in
  let arr = Array.create ~len:move.amount empty in
  for idx = 0 to move.amount - 1 do
    Stack.pop stacks.(move.src) |> Option.value_exn |> Array.set arr idx
  done;
  for idx = 0 to move.amount - 1 do
    Stack.push stacks.(move.dest) arr.(move.amount - idx - 1)
  done
;;

let find_number_row input =
  List.findi
    ~f:(fun _ s ->
      if String.length s >= 2 then Char.equal (String.get s 1) '1' else false)
    input
  |> Option.value_exn
;;

let solve f input =
  let rows, columns = find_number_row input in
  let num_stacks = (1 + String.length columns) / 4 in
  let stacks = Array.init num_stacks ~f:(fun _ -> Stack.create ()) in
  for i = rows - 1 downto 0 do
    push_row_on_stacks (List.nth_exn input i) stacks
  done;
  let moves = List.drop input (rows + 2) in
  List.iter ~f:(f stacks) moves;
  stacks
;;

let get_tops stacks =
  Advent.aass ~exp:(fun i -> not (Array.is_empty i)) stacks |>
  Array.map ~f:(fun stack -> Stack.top stack |> Option.value_exn)
;;

let task_one = solve move_part_1 result |> get_tops
let task_two = solve move_part_2 result |> get_tops
