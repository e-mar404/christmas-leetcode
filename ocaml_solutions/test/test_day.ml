open OUnit2

let test_case (func, expected, file) =
  "Test day" >:: (fun _ ->  
    let actual = func file in
    
    assert_equal ~printer:string_of_int expected actual)

let test cases =
  let suite = "Test Suite" >::: List.map test_case cases in

  run_test_tt_main suite
