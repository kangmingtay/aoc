defmodule Day8 do
  def parse_input(path) do
    path
    |> File.read!
    |> String.split(["\n", " | "], trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [inputs, outputs] -> 
      { String.split(inputs), String.split(outputs) }
    end)
  end

  def sol(path) do
    parsed = path |> parse_input()

    parsed
    |> Enum.map(fn { _, outputs } ->
      Enum.count(outputs, fn output -> byte_size(output) in [2, 4, 3, 7] end) 
    end)
    |> Enum.sum()

  end 

  def parse_input_p2(path) do
    path
    |> File.read!
    |> String.split(["\n", " | "], trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [inputs, outputs] -> 
      { String.split(inputs), String.split(outputs) }
    end)
  end

  def sol2(path) do
    parsed = path |> parse_input_p2()
   
    parsed
    |> Enum.map(fn { inputs, outputs } ->
      map = Enum.map(inputs, &String.to_charlist/1) |> Enum.group_by(&length/1)

      %{
        2 => [one],
        3 => [seven],
        4 => [four],
        5 => two_three_five,
        6 => zero_six_nine,
        7 => [eight],
      } = map

      [nine] = Enum.filter(zero_six_nine, &match?([], four -- &1))
      [three] = Enum.filter(two_three_five, &match?([], one -- &1))
      [zero] = Enum.filter(zero_six_nine, &match?([], seven -- &1)) -- [nine]
      [six] = zero_six_nine -- [zero, nine]
      [five] = Enum.filter(two_three_five, &match?([_], six -- &1)) 
      [two] = two_three_five -- [three, five] 

      # { zero, one, two, three, four, five, six, seven, eight, nine }
      mapping = %{
        Enum.sort(zero) => 0,
        Enum.sort(one) => 1,
        Enum.sort(two) => 2,
        Enum.sort(three) => 3,
        Enum.sort(four) => 4,
        Enum.sort(five) => 5,
        Enum.sort(six) => 6,
        Enum.sort(seven) => 7,
        Enum.sort(eight) => 8,
        Enum.sort(nine) => 9,
      }

      Enum.map(outputs, fn output ->
        output
        |> String.to_charlist()
        |> Enum.sort()
        |> then(fn digit -> mapping[digit] end)
      end)
      |> Integer.undigits()
    end)
    |> Enum.sum()
  end

end

