(*Note: this will return the list in reverse order, since we do not care about initial order in day 1 part 1 this is fine for now*)

let split_columns_from_file file = 
  let split_line line =
    match String.split_on_char ' ' (String.trim line)
    |> List.filter (fun s -> s <> "") with
    | [left; right] -> (int_of_string left, int_of_string right)
    | _ -> failwith "wrong input"
  in
  let file_channel = open_in file in
  let rec read_lines left_list right_list = 
    try
      let line = input_line file_channel in
      let left, right = split_line line in
      read_lines (left :: left_list) (right :: right_list)
    with End_of_file ->
      close_in file_channel;
      (left_list, right_list)
  in
  read_lines [] []

let find_differences file = 
  let (left_col, right_col) = split_columns_from_file file in
  let left_col_sorted = List.sort compare left_col in
  let right_col_sorted = List.sort compare right_col in
  let distances = List.map2 (fun val1 val2 -> abs(val1 - val2)) left_col_sorted right_col_sorted in
  let total = List.fold_left (fun sum num -> sum + num) 0 distances in 

  Printf.printf "%d\n" total;

