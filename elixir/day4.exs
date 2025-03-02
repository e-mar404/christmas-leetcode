defmodule Day4 do
  def read_grid(file) do
    file
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "", trim: true))
    |> Enum.to_list()
  end

  def grid_to_map(list) do
    grid = %{}
    
    list
    |> Enum.with_index()
    |> add_coordinates(grid)
  end  

  defp add_coordinates([{head, row} | tail], grid) do
    coordinates = 
      head
      |> Enum.with_index()
      |> Enum.map(fn {letter, col} -> 
        {row, col, letter}
      end)


    new_grid = 
      for {row, col, letter} <- coordinates, into: grid do
        {{row, col}, letter}
      end

    add_coordinates(tail, new_grid)
  end

  defp add_coordinates(_, grid), do: grid

  def find_xmas(grid, map) do
    for {line, row} <- Enum.with_index(grid) do
      for {letter, col} <- Enum.with_index(line) do
        IO.puts("letter at: #{row} #{col} is #{Map.get(map, {row, col})}")
      end
    end
  end
end

test_input = "../inputs/day4.test"

grid =
  File.stream!(test_input)
  |> Day4.read_grid()

map =
  grid
  |> Day4.grid_to_map()

Day4.find_xmas(grid, map)
