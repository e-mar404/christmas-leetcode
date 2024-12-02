open OUnit2

let test_case func file expected =
  "Test day" >:: (fun _ ->  
    let actual = func file in
    
    assert_equal ~printer:string_of_int actual expected)

let run_test func file cases =
  let suite = "Test Suite" >::: List.map (test_case func file) cases in

  run_test_tt_main suite
