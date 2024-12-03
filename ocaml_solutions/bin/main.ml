open Ocaml_solutions

let _day_1_answers () =
  print_endline "Day 1:";

  let day_1_file = "inputs/day_1.input" in
  let day_1_1 = Day1.find_differences day_1_file in
  let day_1_2 = Day1.find_similarity day_1_file in

  Printf.printf "Part 1 answer: %d\n" day_1_1;
  Printf.printf "Part 2 answer: %d\n" day_1_2

let _day_2_answers () =
  print_endline "Day 2:";

  let day_2_file = "inputs/day_2.input" in
  let day_2_1 = Day2.find_safe_reports day_2_file in
  let day_2_2 = Day2.find_safe_reports day_2_file ~tolerant:true in

  Printf.printf "Part 1 answer: %d\n" day_2_1;
  Printf.printf "Part 2 answer: %d\n" day_2_2

let () = 
  _day_1_answers ();
  _day_2_answers ()
