defmodule Day4 do
  def parse_input(path) do
    [ input_list | boards_list ] = path
      |> File.read!
      |> String.split("\n", trim: true)

    inputs = 
      input_list
      |> String.split(",", trim: true)
      |> Enum.map(&(String.to_integer(&1)))

    boards = 
      boards_list 
      |> Enum.chunk_every(5)
      |> Enum.map(fn rows ->
        Board.new(
          for {line, row} <- Enum.with_index(rows), {number, col} <- Enum.with_index(String.split(line), 0), into: %{} do 
            {String.to_integer(number), { row, col }}
          end
        )
      end)

    { inputs, boards }
  end

  def sol(path) do
    { inputs, boards } = parse_input(path)

    inputs
    |> Enum.reduce_while(boards, fn number, boards ->
      boards = Enum.map(boards, &Board.mark(&1, number))

      if board = Enum.find(boards, &Board.won?/1) do
        {:halt, {number, board}}
      else
        {:cont, boards}
      end
    end)
    |> then(fn { number, board } -> 
      number * Board.unmarked_sum(board)
    end)
  end

  def sol2(path) do
    { inputs, boards } = parse_input(path)

    inputs
    |> Enum.reduce_while(boards, fn number, boards ->
      boards = Enum.map(boards, &Board.mark(&1, number))

      if Enum.count(boards, &(!Board.won?(&1))) == 1 do
        board = Enum.find(boards, &(!Board.won?(&1)))

        # return when there is only 1 incomplete board left
        {:halt, board}
      else
        {:cont, boards}
      end
    end)
    |> then(fn board ->
      # go through all inputs on the last board
      inputs 
      |> Enum.reduce_while(board, fn number, board ->
        next_board = Board.mark(board, number)

        if Board.won?(next_board) do
          {:halt, { number, next_board }}
        else
          {:cont, next_board}
        end
      end)
      |> then(fn { number, board } ->
        number * Board.unmarked_sum(board)
      end)
    end)
  end

  def sol2_improved(path) do
    { inputs, boards } = parse_input(path)

    inputs
    |> Enum.reduce_while(boards, fn number, boards ->
      boards = Enum.map(boards, &Board.mark(&1, number))

      case boards_left = Enum.reject(boards, &Board.won?/1) do 
        # when all boards have won, there should be no more boards left
        [] ->
          # assume that there will always be 1 board that wins last
          [board] = boards
          {:halt, {number, board}}

        _ -> {:cont, boards_left}
      end
    end)
    |> then(fn { number, board } ->
      number * Board.unmarked_sum(board)
    end)
  end 

end
