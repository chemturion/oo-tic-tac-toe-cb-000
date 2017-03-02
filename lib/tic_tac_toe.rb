class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, player_token = "X") #two args, not three (index and token)
    @board[index] = player_token
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      player_token = current_player
      move(index, player_token)
      display_board
    else
      turn
    end
  end

  def won?
    if won_empty?
      false
    elsif draw_first_row
      false
    else
      determine_win
    end
  end

  def won_empty?
    @board.all? do | token |
      token == " "
    end
  end

  def won_draw?
    @board.none? do | token |
      token == " "
    end
  end

  def determine_win
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        return combo
      end
    end
  end

  def full?
    @board.all? do | token |
      token == "X" || token == "O"
    end
  end

  def draw?
    if won?
      false
    elsif full?
      true
    end
  end

  def draw_false?
    return true if (draw_first_row && @board.none?{|token| token == " "})
  end

  def draw_first_row
    if (@board[0] == "X" && @board[1] == "X" && @board[2] == "X") || (@board[0] == "O" && @board[1] == "O" && @board[2] == "O")
      return false
    elsif (@board[3] == "X" && @board[4] == "X" && @board[5] == "X") || (@board[3] == "O" && @board[4] == "O" && @board[5] == "O")
      return false
    elsif (@board[6] == "X" && @board[7] == "X" && @board[8] == "X") || (@board[6] == "O" && @board[7] == "O" && @board[8] == "O")
      return false
    elsif (@board[0] == "X" && @board[3] == "X" && @board[6] == "X") || (@board[0] == "O" && @board[3] == "O" && @board[6] == "O")
      return false
    elsif (@board[1] == "X" && @board[4] == "X" && @board[7] == "X") || (@board[1] == "O" && @board[4] == "O" && @board[7] == "O")
      return false
    elsif (@board[2] == "X" && @board[5] == "X" && @board[8] == "X") || (@board[2] == "O" && @board[5] == "O" && @board[8] == "O")
      return false
    elsif (@board[0] == "X" && @board[4] == "X" && @board[8] == "X") || (@board[0] == "O" && @board[4] == "O" && @board[8] == "O")
      return false
    elsif (@board[2] == "X" && @board[4] == "X" && @board[6] == "X") || (@board[2] == "O" && @board[4] == "O" && @board[6] == "O")
      return false
    else
      return true
    end
  end

  def over?
    if draw_false?
      true
    elsif !draw_first_row
      true
    else
      false
    end
  end

  def winner(board=nil)
    if (@board[0] == "X" && @board[1] == "X" && @board[2] == "X") ||
       (@board[3] == "X" && @board[4] == "X" && @board[5] == "X") ||
       (@board[6] == "X" && @board[7] == "X" && @board[8] == "X") ||
       (@board[0] == "X" && @board[3] == "X" && @board[6] == "X") ||
       (@board[1] == "X" && @board[4] == "X" && @board[7] == "X") ||
       (@board[2] == "X" && @board[5] == "X" && @board[8] == "X") ||
       (@board[0] == "X" && @board[4] == "X" && @board[8] == "X") ||
       (@board[2] == "X" && @board[4] == "X" && @board[6] == "X")
       return "X"
    elsif (@board[0] == "O" && @board[1] == "O" && @board[2] == "O") ||
          (@board[3] == "O" && @board[4] == "O" && @board[5] == "O") ||
          (@board[6] == "O" && @board[7] == "O" && @board[8] == "O") ||
          (@board[0] == "O" && @board[3] == "O" && @board[6] == "O") ||
          (@board[1] == "O" && @board[4] == "O" && @board[7] == "O") ||
          (@board[2] == "O" && @board[5] == "O" && @board[8] == "O") ||
          (@board[0] == "O" && @board[4] == "O" && @board[8] == "O") ||
          (@board[2] == "O" && @board[4] == "O" && @board[6] == "O")
          return "O"
    end
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left column
    [1,4,7], # Middle column
    [2,5,8], # Right column
    [0,4,8], # Left-to-right diagonal
    [2,4,6]  # Right-to-left diagonal
  ]

  def play
    round = 0
    while (round < 9 && over? == false && !won? && !draw?) do
      turn
      round += 1
    end
    if won?
      puts "Congratulations #{winner(@board)}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
