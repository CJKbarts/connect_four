class Player
  include Display
  attr_reader :symbol, :name, :num

  def initialize(num)
    @num = num
    @name = assign_name
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
    name
  end

  def assign_symbol
    symbol = num == 1 ? BLACK_CIRCLE : WHITE_CIRCLE
    puts "#{name} your symbol is #{symbol}"
    symbol
  end

  def assign_name
    print "Player #{num} please enter your name: "
    gets.chomp
  end
end
