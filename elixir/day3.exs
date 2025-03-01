defmodule Day3 do
  def read_lines(file_contents) do
    file_contents
    |> Stream.map(&(String.split(&1, "\n", trim: true)))
  end

  def clean_line(line_stream) do
    line_stream
    |> Stream.map(fn [line] -> Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)/, line) end) 
  end

  def evaluate_mul(values_stream) do
    values_stream
    |> Stream.map(fn values -> Enum.map(values, &(extract_mul_values/1)) end)
    |> Enum.to_list()
    |> List.flatten()
    |> Enum.sum()
  end

  def extract_mul_values([expression]) do
    Regex.scan(~r/\d{1,3}/, expression)
    |> List.flatten()
    |> Enum.reduce(1, fn expression_value, acc ->
      String.to_integer(expression_value) * acc 
    end)
  end
end

_test_file = "../inputs/day3.test"
input_file = "../inputs/day3.input"

File.stream!(input_file)
|> Day3.read_lines()
|> Day3.clean_line()
|> Day3.evaluate_mul()
|> IO.inspect()
