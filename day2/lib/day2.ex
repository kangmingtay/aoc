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
  end


  # Part 2
  def make_cmd([ _direction = "forward", distance ], { h, d, a }), do: { h + distance, d + a*distance, a } 
  def make_cmd([ _direction = "up" , distance ], { h, d, a }), do: { h, d, a - distance } 
  def make_cmd([ _direction = "down" , distance ], { h, d, a }), do: { h, d, a + distance } 
  
  def sol2(path) do
    path
    |> parse_input
    |> Enum.reduce({0, 0, 0}, fn move, acc -> make_cmd(move, acc) end)
  end

end
