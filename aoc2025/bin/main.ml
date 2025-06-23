open Core

let command =
  Command.basic
    ~summary:"Run a task for a specific day"
    (let%map_open.Command day = flag "-day" (required int) ~doc:"INT Day number"
     and task = flag "-task" (required int) ~doc:"INT Task number" in
     fun () ->
       match day, task with
       | _ -> printf "Unknown combination: day=%d task=%d\n" day task)
;;

let () = Command_unix.run ~version:"1.0" ~build_info:"RWO-style" command
