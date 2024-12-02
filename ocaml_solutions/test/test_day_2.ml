open OUnit2
open Ocaml_solutions.Day2

let part_1_test _ = 
  let safe_reports = find_safe_reports "../inputs/day_2.test" in
  let expected = 2 in

  assert_equal ~printer:string_of_int expected safe_reports

let suite =
  "suite" >::: [
      "part_1_test" >:: part_1_test;
    ]

let () =
  run_test_tt_main suite
