defmodule Day3.Part2 do
  def parse_input(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.to_charlist(&1) |> List.to_tuple))
  end

  def o2(rows) do
    get_rating(rows, 0, fn zeros, ones -> 
      if zeros > ones, do: ?0, else: ?1
    end)
    |> Tuple.to_list 
    |> List.to_integer(2)
  end

  def co2(rows) do
    get_rating(rows, 0, fn zeros, ones ->
      if zeros > ones, do: ?1, else: ?0
    end)
    |> Tuple.to_list 
    |> List.to_integer(2)
  end

  defp get_rating([x], _pos, _fun), do: x
  defp get_rating(rows, pos, fun) do
    zeros = rows |> Enum.count(&(elem(&1, pos) == ?0))
    ones = length(rows) - zeros
    num = fun.(zeros, ones)
    filtered_rows = Enum.filter(rows, &(elem(&1, pos) == num))
    get_rating(filtered_rows, pos+1, fun)
  end
 
  def sol(path) do
    rows = path |> parse_input()
    o2(rows) * co2(rows)
  end

end

