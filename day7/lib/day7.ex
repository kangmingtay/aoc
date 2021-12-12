defmodule Day7 do
  def parse_input(path) do
    path
    |> File.read!
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp recur([], acc, _target, _cost_fn), do: acc
  defp recur([head | tail], acc, target, cost_fn), do: recur(tail, acc + cost_fn.(target, head), target, cost_fn)

  defp cost_p1(target, curr), do: abs(target - curr)
  defp cost_p2(target, curr), do: Enum.sum(1..abs(target - curr))

  def sol(path) do
    positions = path |> parse_input()
    start_p = Enum.min(positions)
    end_p = Enum.max(positions)

    start_p..end_p
    |> Enum.map(&recur(positions, 0, &1, fn target, curr -> cost_p1(target, curr) end))
    |> Enum.min
  end 

  def sol2(path) do
    positions = path |> parse_input()
    start_p = Enum.min(positions)
    end_p = Enum.max(positions)

    start_p..end_p
    |> Enum.map(&recur(positions, 0, &1, fn target, curr -> cost_p2(target, curr) end))
    |> Enum.min
  end 
end
