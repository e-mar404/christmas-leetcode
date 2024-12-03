let split_line line convertion =
  String.split_on_char ' ' (String.trim line)
  |> List.filter (fun s -> s <> "")
  |> List.map convertion 

let read_file file =
  let file_channel = open_in file in
  let rec read_lines list =
    try
      let line = input_line file_channel in
      let line_list = split_line line int_of_string in

      read_lines (line_list::list)
    with End_of_file ->
      close_in file_channel;

      list
  in
  read_lines []

let rec check_decreasing_safety report =
  match report with
  | hd1::hd2::tl ->
      let diff = hd1 - hd2 in
      if diff >= 1 && diff <= 3 then check_decreasing_safety (hd2::tl)
      else false
  | _ -> true

let rec check_increasing_safety report =
  match report with
  | hd1::hd2::tl ->
      let diff = hd2 - hd1 in
      if diff >= 1 && diff <= 3 then check_increasing_safety (hd2::tl)
      else false
  | _ -> true

let is_safe report =
  check_increasing_safety report || check_decreasing_safety report

let safe_with_tolerance report =
  List.exists
    (fun i ->
      let report_without_i = List.filteri (fun idx _ -> idx <> i) report in
      is_safe report_without_i)
    (List.init (List.length report) (fun i -> i))

let find_safe_reports ?(tolerant=false) file =
  let reports = read_file file in
  List.fold_left
    (fun acc report ->
      if is_safe report || (safe_with_tolerance report && tolerant) then acc + 1
      else acc)
    0 reports
