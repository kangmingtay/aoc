defmodule Day1 do
  def parse_input(path) do
    path
    |> File.read!()
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn x ->
      x
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # Day 1 part 1
  def get_calories(path) do
    path
    |> parse_input()
    |> Enum.reduce(0, fn cals, acc ->
      cals
      |> Enum.sum()
      |> max(acc)
    end)
  end

  # Day 1 part 2
  def get_top_3(path) do
    path
    |> parse_input()
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
