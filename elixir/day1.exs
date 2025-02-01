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

      {[left_val | left], [right_val | right ]}
    end)
  end

  def sort_cols({left, right}) do
    left = Enum.sort(left)
    right = Enum.sort(right)

    {left, right}
  end
end

{left, right} = File.stream!("../inputs/day1.input")
|> Day1.line_list()
|> Day1.split_cols()

# Part 1
{desc_left, desc_right} = Day1.sort_cols({left, right})

Enum.with_index(desc_left)
|> Enum.reduce(0, fn {left_val, index}, total ->
  right_val = Enum.at(desc_right, index)

  abs(left_val - right_val) + total
end)
|> IO.puts
