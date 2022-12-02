defmodule Day6 do
  def parse_input(path) do
    path
    |> File.read!
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end 

  def sol(path) do
    ages =
      path 
      |> parse_input()

    Enum.reduce(1..80, ages, fn _day, ages ->
      new_ages =
        Enum.map(ages, fn 
          0 -> 6
          age -> age - 1
        end)

      new_fishes = Enum.count(ages, fn age -> age == 0 end)

      new_ages ++ List.duplicate(8, new_fishes)
    end)
    |> length
  end

  # index in tuple represents the internal timer, value represents the number of fish with that timer value
  def recur({d0, d1, d2, d3, d4, d5, d6, d7, d8}) do
    {d1, d2, d3, d4, d5, d6, d7+ d0, d8, d0} 
  end 

  def sol2(path) do
    fishes = path |> parse_input()
    frequencies = Enum.frequencies(fishes)
    amounts = Enum.map(0..8, fn i -> frequencies[i] || 0 end) |> List.to_tuple()

    1..256
    |> Enum.reduce(amounts, fn _, acc -> recur(acc) end)
    |> Tuple.sum()
    
  end 

end
