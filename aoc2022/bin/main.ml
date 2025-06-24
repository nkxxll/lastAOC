open Core

(* Define the command for running Advent of Code tasks *)
let command =
  Command.basic
    ~summary:"Run a task for a specific day"
    (let%map_open.Command day = flag "-day" (required int) ~doc:"INT Day number"
     and task =
       flag
         "-task"
         (optional int)
         ~doc:"INT Task number (optional, runs both if omitted)"
     in
     fun () ->
       (match task with
        | Some t ->
          Printf.printf
            "=== Welcome to AOC ===\nThis is task %d of day %d:\n"
            t
            day
        | None ->
          Printf.printf
            "=== Welcome to AOC ===\nRunning all tasks for day %d:\n"
            day);
       match day, task with
       (* Day 1 *)
       | 1, Some 1 -> Advent.print_res Day1.task_one
       | 1, Some 2 -> Advent.print_res Day1.task_two
       | 1, None ->
         Printf.printf "\n--- Day 1, Task 1 ---\n";
         Advent.print_res Day1.task_one;
         Printf.printf "\n--- Day 1, Task 2 ---\n";
         Advent.print_res Day1.task_two
       (* Day 2 *)
       | 2, Some 1 -> Advent.print_res Day2.task_one
       | 2, Some 2 -> Advent.print_res Day2.task_two
       | 2, None ->
         Printf.printf "\n--- Day 2, Task 1 ---\n";
         Advent.print_res Day2.task_one;
         Printf.printf "\n--- Day 2, Task 2 ---\n";
         Advent.print_res Day2.task_two
       (* Day 3 *)
       | 3, Some 1 -> Advent.print_res Day3.task_one
       | 3, Some 2 -> Advent.print_res Day3.task_two
       | 3, None ->
         Printf.printf "\n--- Day 3, Task 1 ---\n";
         Advent.print_res Day3.task_one;
         Printf.printf "\n--- Day 3, Task 2 ---\n";
         Advent.print_res Day3.task_two
       (* Day 3 *)
       | 4, Some 1 -> Advent.print_res Day4.task_one
       | 4, Some 2 -> Advent.print_res Day4.task_two
       | 4, None ->
         Printf.printf "\n--- Day 4, Task 1 ---\n";
         Advent.print_res Day4.task_one;
         Printf.printf "\n--- Day 4, Task 2 ---\n";
         Advent.print_res Day4.task_two
       (* Handle unknown combinations *)
       | day, Some t -> printf "Unknown combination: day=%d task=%d\n" day t
       | day, None -> printf "Unknown day for all tasks: day=%d\n" day)
;;

let () = Command_unix.run ~version:"1.0" ~build_info:"RWO-style" command
