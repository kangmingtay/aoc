defmodule Day1 do
  # TODO: add types

  def parse_input(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
  end

  def count_increments([]), do: 0
  def count_increments([_x]), do: 0
  def count_increments([f , s | t]) do
    cond do
      f >= s -> 0 + count_increments([ s | t ])
      f < s -> 1 + count_increments([ s | t ])
    end
  end

  def sol(input) do
    input # TODO: use a module attribute
    |> parse_input
    |> Enum.map(fn x -> String.to_integer(x) end) # TODO: make this cleaner!!
    |> count_increments
  end
end
