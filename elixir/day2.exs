defmodule Day2 do
  def number_line_list(file) do
    file
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&String.split(&1, " "))
    |> Stream.map(fn list -> Enum.map(list, &String.to_integer/1) end)
  end

  def valid_report(list) do
    case list do
      [hd | tl] -> check_increasing([hd | tl]) or check_decreasing([hd | tl])
      [] -> true
      _ -> false
    end
  end

  def check_increasing (list) do
    case list do
      [] -> true
      [_] -> true
      [hd, tl | rest] when (tl - hd) in 1..3 -> check_increasing([tl | rest]) 
      _ -> false
    end
  end

  def check_decreasing (list) do
    case list do
      [] -> true
      [_] -> true
      [hd, tl | rest] when (hd - tl) in 1..3 -> check_decreasing([tl | rest]) 
      _ -> false
    end
  end
end

File.stream!("../inputs/day2.input")
|> Day2.number_line_list()
|> Stream.filter(&Day2.valid_report/1)
|> Enum.count()
|> IO.puts()
# |> Enum.each(&IO.inspect()/1)
