open Test_day
open Ocaml_solutions.Day2

let () =
  let day_2_file = "../inputs/day_2.test" in

  test [
    ((find_safe_reports day_2_file), 2);
    ((find_safe_reports ~tolerant:true day_2_file), 4)
  ]
