let split_line line =
  String.split_on_char ' ' (String.trim line)
  |> List.filter (fun s -> s <> "")

let read_file file = 
  let file_channel = open_in file in

  let rec read_lines list = 
    try
      let line = input_line file_channel in
      let line_list = split_line line |> List.map int_of_string in

      read_lines (line_list :: list)
    with End_of_file ->
      close_in file_channel;
      list
  in
  read_lines []

let rec check_decreasing_safety report_entry = match report_entry with
  | hd::hd2::tl -> if ((hd - hd2) < 4 && (hd - hd2) > 0) then check_decreasing_safety (hd2::tl) else false
  | _ -> true
  
let rec check_increasing_safety report_entry = match report_entry with
  | hd::hd2::tl -> if ((hd2 - hd) < 4 && (hd2 - hd) > 0) then check_increasing_safety(hd2::tl) else false
  | _ -> true

let are_safe report_entry = match report_entry with
  | hd::hd2::_  when hd > hd2 -> check_decreasing_safety report_entry
  | _ -> check_increasing_safety report_entry

let find_safe_reports file = 
  let reports = read_file file in

  List.map (fun report_entry -> are_safe report_entry) reports
  |> List.fold_left (fun sum is_safe -> if is_safe then sum + 1 else sum) 0
