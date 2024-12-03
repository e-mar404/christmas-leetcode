open Test_day
open Ocaml_solutions.Day1

let () =
  let day_1_file = "../inputs/day_1.test" in

  test [
    ((find_differences day_1_file), 11);
    ((find_similarity day_1_file), 31)
  ]
