open OUnit2
open Ocaml_solutions.Day1

let part_1_test _ = 
  let differences = find_differences "../inputs/day_1.test" in
  let expected = 11 in

  assert_equal differences expected

let part_2_test _ = 
  let similarity = find_similarity "../inputs/day_1.test" in
  let expected = 31 in
  
  assert_equal similarity expected

let suite =
  "suite" >::: [
      "part_1_test" >:: part_1_test;
      "part_2_test" >:: part_2_test;
    ]

let () =
  run_test_tt_main suite
