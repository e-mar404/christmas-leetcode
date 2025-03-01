defmodule Day3 do
  def read_line(file_contents) do
    file_contents
    |> Stream.map(&(String.split(&1, "\n", trim: true)))
  end
  
  def clean_line(line_stream) do
    line_stream
    |> Stream.map(fn [line] -> Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)|don\'t\(\)|do\(\)/, line) end) 
    |> Enum.to_list()
    |> List.flatten()
  end

  def evaluate_mul_list([head | tail], acc, status) do
    case head do
      "do()" -> 

        evaluate_mul_list(tail, acc, :enabled)

      "don't()" ->
        evaluate_mul_list(tail, acc, :disabled)

      _ ->
        case status do
          :enabled ->
            value = extract_mul_value(head)
            evaluate_mul_list(tail, acc + value, status)

          :disabled ->
            evaluate_mul_list(tail, acc, status)
        end
    end
  end

  def evaluate_mul_list(_, acc, _status), do: acc

  def extract_mul_value(mul_string) do
    [[left], [right]] = Regex.scan(~r/\d{1,3}/, mul_string)
    
    String.to_integer(left) * String.to_integer(right)
  end
end

_test_file_1 = "../inputs/day3.test"
_test_file_2 = "../inputs/day3_2.test"
input_file = "../inputs/day3.input"

File.stream!(input_file)
|> Day3.read_line()
|> Day3.clean_line()
|> Day3.evaluate_mul_list(0, :enabled)
|> IO.inspect()
