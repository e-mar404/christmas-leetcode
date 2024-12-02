open Test_day
open Ocaml_solutions.Day1

let () =
  let day_1_file = "../inputs/day_1.test" in

  test find_differences 11 day_1_file;
  test find_similarity 31 day_1_file
