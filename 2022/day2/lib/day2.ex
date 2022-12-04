defmodule Day2 do
  def parse_input(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, " ", trim: true) |> List.to_tuple()))
  end

  # Day 2 part 1
  def get_score(path) do
    # { rock, paper, scissors }
    values = %{:X => 1, :Y => 2, :Z => 3}
    scores = %{:won => 6, :lost => 0, :draw => 3}

    path
    |> parse_input()
    |> Enum.map(fn round ->
      case round do
        {"A", val} when val == "X" -> {val, :draw}
        {"A", val} when val == "Y" -> {val, :won}
        {"A", val} when val == "Z" -> {val, :lost}
        {"B", val} when val == "X" -> {val, :lost}
        {"B", val} when val == "Y" -> {val, :draw}
        {"B", val} when val == "Z" -> {val, :won}
        {"C", val} when val == "X" -> {val, :won}
        {"C", val} when val == "Y" -> {val, :lost}
        {"C", val} when val == "Z" -> {val, :draw}
      end
    end)
    |> Enum.reduce(0, fn {val, score}, acc ->
      acc + Map.get(values, String.to_atom(val)) + Map.get(scores, score)
    end)
  end

  # Day 2 part 2
  def calculate_score(path) do
    scenarios = %{
      {"A", "Y"} => 1,
      {"A", "X"} => 3,
      {"A", "Z"} => 2,
      {"B", "Y"} => 2,
      {"B", "X"} => 1,
      {"B", "Z"} => 3,
      {"C", "Y"} => 3,
      {"C", "X"} => 2,
      {"C", "Z"} => 1
    }

    results = %{:X => 0, :Y => 3, :Z => 6}

    path
    |> parse_input()
    |> Enum.reduce(0, fn {_, result} = scenario, acc ->
      Map.get(scenarios, scenario) + +Map.get(results, String.to_atom(result)) + acc
    end)
  end
end
