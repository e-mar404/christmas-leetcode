defmodule Day1 do
  def line_list(file) do
    file
    |> Stream.map(&String.trim/1)
    |> Stream.reject(fn x -> x == "" end)
    |> Stream.map(&String.split(&1, " "))
    |> Enum.to_list()
  end

  def split_cols(lines) do
    lines
    |> Enum.reduce({[], []}, fn line, {left, right} ->
      left_val = String.to_integer(Enum.at(line, 0))
      right_val = String.to_integer(Enum.at(line, 3))

      {[left_val | left], [right_val | right]}
    end)
  end

  def sort_cols({left, right}) do
    left = Enum.sort(left)
    right = Enum.sort(right)

    {left, right}
  end

  def sum_distances(list1, list2) do
    list1
    |> Enum.with_index()
    |> Enum.reduce(0, fn {left_val, index}, total ->
      right_val = Enum.at(list2, index)

      abs(left_val - right_val) + total
    end)
  end

  def freq_acc(list, map) do
    list
    |> Enum.reduce(0, fn left_value, acc ->
      acc + left_value * Map.get(map, left_value, 0)
    end)
  end
end

{left, right} =
  File.stream!("../inputs/day1.input")
  |> Day1.line_list()
  |> Day1.split_cols()

# Part 1
{desc_left, desc_right} = Day1.sort_cols({left, right})

desc_left
|> Day1.sum_distances(desc_right)
|> IO.puts()

# Part 2
freq_right = Enum.frequencies(right)

left
|> Day1.freq_acc(freq_right)
|> IO.puts()
