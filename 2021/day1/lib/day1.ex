defmodule Day1 do
  # TODO: add types

  def parse_input(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def recur([left, right | tail], acc) when right > left, do: recur([right | tail], acc + 1)
  def recur([_left, right | tail], acc), do: recur([right | tail], acc)
  def recur([_], acc), do: acc

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
    |> count_increments
  end

  def count_sum_incr([_a, _b, _c]), do: 0
  def count_sum_incr([a, b, c, d | tail]) do
    sum1 = a + b + c
    sum2 = b + c + d
    cond do 
      sum1 >= sum2 -> 0 + count_sum_incr([b, c, d | tail])
      sum1 < sum2 -> 1 + count_sum_incr([b, c, d | tail])
    end
  end

  def sol2(input) do
    input
    |> parse_input
    |> count_sum_incr
  end

  # Implementation using pipelines only  
  def part1_pipeline(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> IO.inspect()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [left, right] -> right > left end)
  end

  def part2_pipeline(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.chunk_every(2, 1, :discard)
    # |> Enum.count(fn [left, right] -> Enum.sum(right) > Enum.sum(left) end)
    |> Enum.count(fn [[left, m1, m2], [m1, m2, right]] -> right > left end)  # Optimization: Use pattern matching instead of sum
  end

  # Using streams
  def part1_pipeline_streams(path) do
    path
    |> File.read!
    |> String.splitter("\n", trim: true)
    |> Stream.map(&String.to_integer/1)
    |> IO.inspect()
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [left, right] -> right > left end)
  end

  def part2_pipeline_streams(path) do
    path
    |> File.read!
    |> String.splitter("\n", trim: true)
    |> Stream.map(&String.to_integer/1)
    |> IO.inspect()
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [left, right] -> Enum.sum(right) > Enum.sum(left) end)
  end

end

