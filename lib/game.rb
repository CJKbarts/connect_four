class Game
  include Display
  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
  end

  def play_round
    intro
    round_winner = winner
    board.display
    round_results(round_winner)
  end

  def winner
    42.times do |count|
      board.display
      puts
      current_player = count.even? ? player1 : player2
      choice = current_player.choice(board)
      board.update(choice, current_player.symbol)
      return current_player if game_over?(choice, current_player.symbol)
    end
  end

  def game_over?(column_index, symbol)
    board.row_complete?(column_index, symbol) ||
      board.column_complete?(column_index, symbol) ||
      board.diagonal_complete?(column_index, symbol)
  end

  def round_results(winner)
    if winner.nil?
      puts 'This round was a draw'
    else
      puts "#{winner} won this round"
    end
  end
end
