require_relative '../lib/game/display'
require_relative '../lib/game/board'
include Display

describe Board do
  describe '#full?' do
    subject(:board_full) { described_class.new }
    let(:grid) { board_full.grid }
    let(:column_index) { 3 }

    context 'when the column is full' do
      before do
        grid[0][column_index] = BLACK_CIRCLE
      end

      it 'returns true' do
        expect(board_full.full?(column_index)).to eql(true)
      end
    end

    context 'when the column has space' do
      it 'returns false' do
        expect(board_full.full?(column_index)).to eql(false)
      end
    end
  end

  describe '#depth' do
    subject(:board_depth) { described_class.new }
    let(:grid) { board_depth.grid }
    let(:column_index) { 3 }

    context 'when the column is empty' do
      it 'returns 6' do
        expect(board_depth.depth(column_index)).to eql(6)
      end
    end

    context 'when the column has 2 spaces full' do
      before do
        grid[4][column_index] = BLACK_CIRCLE
        grid[5][column_index] = BLACK_CIRCLE
      end

      it 'returns 4' do
        expect(board_depth.depth(column_index)).to eql(4)
      end
    end

    context 'when the column is full' do
      before do
        grid[0][column_index] = BLACK_CIRCLE
      end

      it 'returns 0' do
        expect(board_depth.depth(column_index)).to eql(0)
      end
    end
  end

  describe '#row_complete?' do
    subject(:board_row) { described_class.new }
    let(:grid) { board_row.grid }
    let(:column_index) { 3 }
    let(:symbol) { BLACK_CIRCLE }

    context 'when last play completes a row of 4 at start' do
      before do
        grid[2][column_index] = symbol
        grid[2][4] = symbol
        grid[2][5] = symbol
        grid[2][6] = symbol
      end

      it 'returns true' do
        expect(board_row.row_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when last play completes a row of 4 at end' do
      before do
        grid[2][0] = symbol
        grid[2][1] = symbol
        grid[2][2] = symbol
        grid[2][column_index] = symbol
      end

      it 'returns true' do
        expect(board_row.row_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when last play completes a row of 4 in the middle' do
      before do
        grid[2][2] = symbol
        grid[2][column_index] = symbol
        grid[2][4] = symbol
        grid[2][5] = symbol
      end

      it 'returns true' do
        expect(board_row.row_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when completed row is at the end of the row' do
      before do
        column_index = 6
        grid[2][3] = symbol
        grid[2][4] = symbol
        grid[2][5] = symbol
        grid[2][column_index] = symbol
      end

      it 'returns true' do
        expect(board_row.row_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when completed row is at the beginning of the row' do
      before do
        column_index = 0
        grid[2][column_index] = symbol
        grid[2][1] = symbol
        grid[2][2] = symbol
        grid[2][3] = symbol
      end

      it 'returns true' do
        expect(board_row.row_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when last play does not complete a row of 4' do
      before do
        grid[2][column_index] = symbol
        grid[2][4] = WHITE_CIRCLE
        grid[2][5] = symbol
        grid[2][6] = symbol
      end

      it 'returns false' do
        expect(board_row.row_complete?(column_index, symbol)).to eql(false)
      end
    end
  end

  describe '#column_complete?' do
    subject(:board_column) { described_class.new }
    let(:grid) { board_column.grid }
    let(:column_index) { 3 }
    let(:symbol) { BLACK_CIRCLE }

    context 'when the column is complete' do
      before do
        grid[2][column_index] = symbol
        grid[3][column_index] = symbol
        grid[4][column_index] = symbol
        grid[5][column_index] = symbol
      end

      it 'returns true' do
        expect(board_column.column_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when the column is not complete' do
      it 'returns false' do
        expect(board_column.column_complete?(column_index, symbol)).to eql(false)
      end
    end
  end

  describe '#increasing_diagonal_complete?' do
    subject(:board_i_diagonal) { described_class.new }
    let(:grid) { board_i_diagonal.grid }
    let(:column_index) { 3 }
    let(:symbol) { BLACK_CIRCLE }

    context 'when last play completes diagonal at bottom' do
      before do
        grid[5][column_index] = symbol
        grid[4][4] = symbol
        grid[3][5] = symbol
        grid[2][6] = symbol
      end

      it 'returns true' do
        expect(board_i_diagonal.increasing_diagonal_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when the last play completes diagonal at top' do
      before do
        grid[0][column_index] = symbol
        grid[1][2] = symbol
        grid[2][1] = symbol
        grid[3][0] = symbol
      end

      it 'returns true' do
        expect(board_i_diagonal.increasing_diagonal_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when the last play completes diagonal in the middle' do
      before do
        grid[0][5] = symbol
        grid[1][4] = symbol
        grid[2][column_index] = symbol
        grid[3][2] = symbol
      end

      it 'returns true' do
        expect(board_i_diagonal.increasing_diagonal_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when the diagonal is incomplete' do
      it 'returns false' do
        expect(board_i_diagonal.increasing_diagonal_complete?(column_index, symbol)).to eql(false)
      end
    end
  end

  describe '#decreasing_diagonal_complete?' do
    subject(:board_d_diagonal) { described_class.new }
    let(:grid) { board_d_diagonal.grid }
    let(:column_index) { 3 }
    let(:symbol) { BLACK_CIRCLE }

    context 'when last play completes diagonal at top' do
      before do
        grid[2][column_index] = symbol
        grid[3][4] = symbol
        grid[4][5] = symbol
        grid[5][6] = symbol
      end

      it 'returns true' do
        expect(board_d_diagonal.decreasing_diagonal_complete?(column_index, symbol)).to eql(true)
      end
    end
    context 'when last play completes diagonal at bottom' do
      before do
        grid[2][0] = symbol
        grid[3][1] = symbol
        grid[4][2] = symbol
        grid[5][column_index] = symbol
      end

      it 'returns true' do
        expect(board_d_diagonal.decreasing_diagonal_complete?(column_index, symbol)).to eql(true)
      end
    end
    context 'when last play completes diagonal in the middle' do
      before do
        grid[2][2] = symbol
        grid[3][column_index] = symbol
        grid[4][4] = symbol
        grid[5][5] = symbol
      end

      it 'returns true' do
        expect(board_d_diagonal.decreasing_diagonal_complete?(column_index, symbol)).to eql(true)
      end
    end

    context 'when diagonal is incomplete' do
      it 'returns false' do
        expect(board_d_diagonal.decreasing_diagonal_complete?(column_index, symbol)).to eql(false)
      end
    end
  end
end
