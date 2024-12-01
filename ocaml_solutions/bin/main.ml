open Ocaml_solutions.Day1

let day_1_answers () =
  print_endline "Day 1:";

  let day_1_file = "inputs/day_1.input" in
  let day_1_1 = find_differences day_1_file in
  let day_1_2 = find_similarity day_1_file in

  Printf.printf "Part 1 answer: %d\n" day_1_1;
  Printf.printf "Part 2 answer: %d\n" day_1_2

let () = day_1_answers ()
