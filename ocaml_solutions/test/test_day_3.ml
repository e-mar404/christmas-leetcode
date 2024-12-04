open Test_day
open Ocaml_solutions.Day3


let () = 
  let file_1 = "../inputs/day_3_1.test" in
  let file_2 = "../inputs/day_3_2.test" in

  test [
    ((find_multiples file_1), 161);
    ((find_multiples file_2 ~strict:true), 48)
  ]
