open Str

let read_file file =
  let file_channel = open_in file in
  let rec read_lines list =
    try
      read_lines ((input_line file_channel) :: list)
    with End_of_file ->
      close_in file_channel;

      list
  in
  read_lines []

let get_product str =
  let product_regexp = regexp "mul(\\([0-9]+\\),\\([0-9]+\\))" in
  let _ = string_match product_regexp str 0 in
  
  int_of_string (matched_group 1 str) * int_of_string (matched_group 2 str)

let process_line_strict line =
  let regexp_delim = regexp "do()\\|don't()\\|mul(\\([0-9]+\\),\\([0-9]+\\))" in
  let results = full_split regexp_delim line in

  let process_results results is_enabled acc =
  List.fold_left (fun (is_enabled, acc) res ->
    match res with
    | Text _ -> (is_enabled, acc)
    | Delim s ->
        (*Printf.printf "Delimiter: %s, is_enabled: %b\n" s is_enabled;*)
        if s = "do()" then
          (true, acc)
        else if s = "don't()" then
          (false, acc)
        else if is_enabled then
          let product = get_product s in
          (*Printf.printf "Multiplying: %s -> %d\n" s product;*)
          (is_enabled, acc + product)
        else
          (is_enabled, acc)
  ) (is_enabled, acc) results
  in
  snd (process_results results true 0)

let process_line_non_strict line =
  let regexp_mul = regexp "mul(\\([0-9]+\\),\\([0-9]+\\))" in
  full_split regexp_mul line
  |> List.filter_map (function
         | Delim s -> Some (get_product s)
         | Text _ -> None)
  |> List.fold_left ( + ) 0

let find_multiples ?(strict=false) file =
  let process_line = if strict then process_line_strict else process_line_non_strict in

  read_file file
  |> List.map process_line
  |> List.fold_left ( + ) 0
