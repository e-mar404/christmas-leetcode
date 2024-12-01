(*Note: this will return the list in reverse order, since we do not care about initial order in day 1 part 1 this is fine for now*)

let read_file file = 
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
  let (left_col, right_col) = read_file file in
  let left_col_sorted = List.sort compare left_col in
  let right_col_sorted = List.sort compare right_col in
  let distances = List.map2 (fun val1 val2 -> abs(val1 - val2)) left_col_sorted right_col_sorted in

  List.fold_left (fun sum num -> sum + num) 0 distances

let get_frequency num list =
  let count = List.filter (fun x -> x = num) list in
  List.length count

let save_on_hashmap table num list =
  if not (Hashtbl.mem table num) then
    let frequency = get_frequency num list in
    Hashtbl.add table num frequency

let find_similarity file =
  let (left_col, right_col) = read_file file in
  let table = Hashtbl.create (List.length left_col) in

  List.iter (fun num -> (save_on_hashmap table num right_col)) left_col;

  let similarity_scores = List.map (fun num -> num * (Hashtbl.find table num)) left_col in

  List.fold_left (fun sum similarity -> sum + similarity) 0 similarity_scores

let day_1_answers () =
  print_endline "Day 1:";

  let day_1_file = "bin/inputs/day_1_1.txt" in
  let day_1_1 = find_differences day_1_file in
  let day_1_2 = find_similarity day_1_file in

  Printf.printf "Part 1 answer: %d\n" day_1_1;
  Printf.printf "Part 2 answer: %d\n" day_1_2;
