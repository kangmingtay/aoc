defmodule Day2 do

  def parse_input(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(fn move -> String.split(move, " ", trim: true) end)
    |> Enum.map(fn [direction, distance] -> [direction, String.to_integer(distance)] end) 
  end

  def make_move([ _direction = "forward", distance ], { h, d }), do: { h + distance, d } 
  def make_move([ _direction = "up" , distance ], { h, d }), do: { h, d - distance } 
  def make_move([ _direction = "down" , distance ], { h, d }), do: { h, d + distance } 

  def sol1(path) do
    path
    |> parse_input
    |> Enum.reduce({0, 0}, fn move, acc -> make_move(move, acc) end)
    |> then(fn {h, d} -> h*d end)
  end


  # Part 2
  def make_cmd([ _direction = "forward", distance ], { h, d, a }), do: { h + distance, d + a*distance, a } 
  def make_cmd([ _direction = "up" , distance ], { h, d, a }), do: { h, d, a - distance } 
  def make_cmd([ _direction = "down" , distance ], { h, d, a }), do: { h, d, a + distance } 
  
  def sol2(path) do
    path
    |> parse_input
    |> Enum.reduce({_horizontal = 0, _depth = 0, _aim = 0}, fn move, acc -> make_cmd(move, acc) end)
    |> then(fn {h, d, _} -> h*d end)
  end

  # Using Nx Part 1
  def solnx(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(fn move -> 
      [direction, distance] = String.split(move, " ", trim: true)
      distance_int = String.to_integer(distance)
      case direction do
        "forward" -> {distance_int, 0}
        "down" -> {0, distance_int}
        "up" -> {0, -distance_int}
      end
    end)
    |> Enum.unzip
    |> then(fn {hs, ds} ->
      Nx.multiply(Nx.sum(Nx.tensor(hs)), Nx.sum(Nx.tensor(ds)))
    end)
    |> IO.inspect

  end

end
