defmodule Day5 do
  @moduledoc"""
  Store coordinates in a map
  {
    (0, 9) => 1,
    (1, 9) => 0,
    (2, 9) => 2,
    ...
  }
  """
  def parse_input(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> 
      row 
      |> String.split([",", " -> "], trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def sol(path) do
    lines = parse_input(path)
    grid = %{}
    lines
    |> Enum.reduce(grid, fn 
      [x, y1, x, y2], grid ->
        Enum.reduce(y1..y2, grid, fn y ,grid ->
          Map.update(grid, {x, y}, 1, & &1 + 1)
        end)
      [x1, y, x2, y], grid -> 
        Enum.reduce(x1..x2, grid, fn x, grid ->
          Map.update(grid, {x, y}, 1, & &1 + 1)
        end)
      _, grid -> grid
    end)
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  def sol2(path) do
    lines = parse_input(path)
    grid = %{}
    lines
    |> Enum.reduce(grid, fn 
      [x, y1, x, y2], grid ->
        Enum.reduce(y1..y2, grid, fn y ,grid ->
          Map.update(grid, {x, y}, 1, & &1 + 1)
        end)
      [x1, y, x2, y], grid -> 
        Enum.reduce(x1..x2, grid, fn x, grid ->
          Map.update(grid, {x, y}, 1, & &1 + 1)
        end)
      # handle diagonals 
      [x1, y1, x2, y2], grid ->
        Enum.zip_reduce(x1..x2, y1..y2, grid, fn x, y, grid ->
          Map.update(grid, {x, y}, 1, & &1 + 1) 
        end)
      _, grid -> grid
    end)
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end
end

