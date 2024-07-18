class Board
  include Display
  attr_reader :grid, :default_value

  def initialize
    @default_value = '  '
    @grid = create_grid
  end

  def full?(column_index)
    return true if column_index == -1

    grid[0][column_index] != default_value
  end

  def depth(column_index)
    count = 0
    grid.each do |row|
      break unless row[column_index] == default_value

      count += 1
    end
    count
  end

  def row_complete?(column_index, symbol)
    row = grid[depth(column_index)]
    left_array = row[0...column_index]
    right_array = row[column_index..]
    count = num_equal(left_array.reverse, symbol) + num_equal(right_array, symbol)
    count == 4
  end

  def num_equal(array, symbol)
    count = 0
    array.each do |elm|
      break unless elm == symbol

      count += 1
    end
    count
  end

  def column_complete?(column_index, symbol)
    column = grid.map { |row| row[column_index] }
    column = column[depth(column_index)..]
    count = num_equal(column, symbol)
    count == 4
  end

  def diagonal_complete?(column_index, symbol)
    increasing_diagonal_complete?(column_index, symbol) || decreasing_diagonal_complete?(column_index, symbol)
  end

  def increasing_diagonal_complete?(column_index, symbol)
    row_index = depth(column_index)
    left_array = increasing_side(row_index, column_index, 1)
    right_array = increasing_side(row_index, column_index, -1)
    count = num_equal(left_array, symbol) + num_equal(right_array, symbol) + 1
    count == 4
  end

  def increasing_side(row_index, column_index, increment_multiplier)
    array = []
    increment = increment_multiplier
    while (0...grid.length).include?(row_index + increment) && (0...grid[0].length).include?(column_index - increment)
      array << grid[row_index + increment][column_index - increment]
      increment += 1 * increment_multiplier
    end
    array
  end

  def decreasing_diagonal_complete?(column_index, symbol)
    row_index = depth(column_index)
    left_array = decreasing_side(row_index, column_index, -1)
    right_array = decreasing_side(row_index, column_index, 1)
    count = num_equal(left_array, symbol) + num_equal(right_array, symbol) + 1
    count == 4
  end

  def decreasing_side(row_index, column_index, increment_multiplier)
    array = []
    increment = increment_multiplier
    while (0...grid.length).include?(row_index + increment) && (0...grid[0].length).include?(column_index + increment)
      array << grid[row_index + increment][column_index + increment]
      increment += 1 * increment_multiplier
    end
    array
  end

  def update(column_index, symbol)
    row_index = depth(column_index) - 1
    grid[row_index][column_index] = symbol
  end

  private

  def create_grid
    Array.new(6) { create_row }
  end

  def create_row
    Array.new(7, default_value)
  end
end
