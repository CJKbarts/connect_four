class Player
  include Display
  attr_reader :symbol

  def initialize(player_num)
    @player_num = player_num
    @symbol = assign_symbol
  end

  def choice(board)
    index = -1
    index = player_input("#{self} choose a column to play: ",
                         'Invalid input. Please enter again: ') while board.full?(index)
    index
  end

  def player_input(prompt, error_message)
    print prompt
    input = gets.chomp.to_i
    until (1..7).include?(input)
      print error_message
      input = gets.chomp.to_i
    end
    input - 1
  end

  def to_s
    "Player #{@player_num}"
  end

  def assign_symbol
    @player_num == 1 ? BLACK_CIRCLE : WHITE_CIRCLE
  end
end
