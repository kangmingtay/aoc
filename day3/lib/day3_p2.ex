defmodule Day3.Part2 do
  def parse_input(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.to_charlist(&1) |> List.to_tuple))
  end

  def get_majority_in_col(rows, pos, num_rows, type) do
    half = div(num_rows, 2)

    zeros =
      rows 
      |> Enum.count_until(&(elem(&1, pos) == ?0), half+1)
    
    get_majority_by_type(zeros, half, type)
  end

  def get_majority_by_type(zeros, half, _type = :oxygen) when zeros > half, do: ?0
  def get_majority_by_type(zeros, half, _type = :oxygen) when zeros <= half, do: ?1
  def get_majority_by_type(zeros, half, _type = :co2) when zeros <= half, do: ?0
  def get_majority_by_type(zeros, half, _type = :co2) when zeros > half, do: ?1

  def handle_tiebreaker(_val = :tiebreaker, _type = :oxygen), do: 1
  def handle_tiebreaker(_val = :tiebreaker, _type = :co2), do: 0

  def get_rating([x], _pos, _type), do: x
  def get_rating(rows, pos, type) do
    num = get_majority_in_col(rows, pos, length(rows), type)
    rows 
      |> Enum.filter(&(elem(&1, pos) == num))
      |> get_rating(pos+1, type)
  end

  def sol(path) do
    rows = 
      path
      |> parse_input()

    oxygen_rating = rows |> get_rating(0, :oxygen) |> Tuple.to_list |> List.to_integer(2)
    co2_rating = rows |> get_rating(0, :co2) |> Tuple.to_list |> List.to_integer(2)
    oxygen_rating * co2_rating
  end

end

