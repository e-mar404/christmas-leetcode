open OUnit2

let test_case func expected file =
  "Test day" >:: (fun _ ->  
    let actual = func file in
    
    assert_equal ~printer:string_of_int actual expected)

let test func expected file =
  let suite = "Test Suite" >::: [test_case func expected file] in

  run_test_tt_main suite
