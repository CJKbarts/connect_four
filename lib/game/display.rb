module Display
  BLACK_CIRCLE = "\u26AB"
  WHITE_CIRCLE = "\u26AA"

  BOX_CHARACTERS = {
    horizontal_line: "\u2500" * 4,
    vertical_line: "\u2502",
    top_cross: "\u252C",
    middle_cross: "\u253C",
    bottom_cross: "\u2534",
    left_cross: "\u251C",
    right_cross: "\u2524",
    top_left: "\u250C",
    top_right: "\u2510",
    bottom_left: "\u2514",
    bottom_right: "\u2518"
  }

  BOX_LINES = {
    top_line: BOX_CHARACTERS[:top_left] + (BOX_CHARACTERS[:horizontal_line] + BOX_CHARACTERS[:top_cross]) * 6 +
              BOX_CHARACTERS[:horizontal_line] + BOX_CHARACTERS[:top_right],

    middle_line: BOX_CHARACTERS[:left_cross] + (BOX_CHARACTERS[:horizontal_line] + BOX_CHARACTERS[:middle_cross]) * 6 +
                 BOX_CHARACTERS[:horizontal_line] + BOX_CHARACTERS[:right_cross],

    bottom_line: BOX_CHARACTERS[:bottom_left] + (BOX_CHARACTERS[:horizontal_line] + BOX_CHARACTERS[:bottom_cross]) * 6 +
                 BOX_CHARACTERS[:horizontal_line] + BOX_CHARACTERS[:bottom_right]
  }

  def intro
    puts <<~INTRO
      Welcome to Connect Four
      This is a two player game
      To win, a player must form a horizontal, vertical#{' '}
      or diagonal line of 4 of their own tokens
      Let the game begin!!


    INTRO
  end

  def display
    puts
    puts BOX_LINES[:top_line]
    @grid.each_with_index do |row, row_index|
      row.each do |cell|
        print "#{BOX_CHARACTERS[:vertical_line]} #{cell} "
      end
      puts BOX_CHARACTERS[:vertical_line]
      puts row_index == 5 ? BOX_LINES[:bottom_line] : BOX_LINES[:middle_line]
    end
    print '   '
    (1..7).each { |num| print "#{num}    " }
    puts
  end
end
