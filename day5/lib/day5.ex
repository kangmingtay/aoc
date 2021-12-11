defmodule Day5 do
  def parse_input(path) do
    path
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> 
      row 
      |> String.split([",", " -> "], trim: true)
      |> Enum.map(&String.to_integer/1)
      |> then(fn coordinates -> 
        case coordinates do
          [y1, x1, y1, x2 ] -> {{y1, x1}, {y1, x2}}
          [y1, x1, y2, x1 ] -> {{y1, x1}, {y2, x1}}
          _ -> {}
        end
      end)
    end)
    |> Enum.filter(fn t -> t != {} end)
  end

  def grid_size(lines) do
    lines
    |> Enum.map(fn { {y1, x1}, {y2, x2} } -> { max(y1, y2), max(x1, x2) } end)
    |> Enum.reduce({-1, -1}, fn {y, x}, {max_y, max_x} ->
      { max(y, max_y), max(x, max_x) }
    end)
  end

  def new_grid({y, x} = _size) do
    Tuple.duplicate(Tuple.duplicate(0, y+1), x+1)
  end 

  def sol(path) do
    lines = parse_input(path)
    size = grid_size(lines)
    grid = new_grid(size)
    IO.inspect(size)
    # IO.inspect(lines)
    lines 
    |> Enum.reduce(grid, fn {{y1, x1}, {y2, x2}}, grid ->
      start_x = min(x1, x2)
      end_x = max(x1, x2)

      start_y = min(y1, y2)
      end_y = max(y1, y2)
      
      Enum.reduce(start_x..end_x, grid, fn row, acc ->
        Enum.reduce(start_y..end_y, acc, fn col, cacc ->
          val = cacc |> elem(row) |> elem(col)
          put_in(cacc, [Access.elem(row), Access.elem(col)], val+1) 
        end)
      end)
    end)
    |> Tuple.to_list()
    |> Enum.map(fn row ->
      row 
      |> Tuple.to_list()
      |> Enum.count(fn x -> x > 1 end)
    end)
    |> Enum.sum()
  end 
end

