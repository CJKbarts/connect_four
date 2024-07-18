require_relative '../lib/game/display'
require_relative '../lib/game/player'

describe Player do
  describe '#player_input' do
    subject(:player_input) { described_class.new(1) }
    let(:prompt) { 'Player 1 choose a column to play: ' }
    let(:error_message) { 'Invalid input. Please input something valid: ' }

    context 'when the player enters valid input' do
      before do
        valid_input = '4'
        allow(player_input).to receive(:gets).and_return(valid_input)
        allow(player_input).to receive(:print)
      end

      it 'does not print an error message' do
        expect(player_input).to_not receive(:print).with(error_message)
        player_input.player_input(prompt, error_message)
      end
    end

    context 'when the player enters invalid input once' do
      before do
        invalid_input = '20'
        valid_input = '4'
        allow(player_input).to receive(:gets).and_return(invalid_input, valid_input)
        allow(player_input).to receive(:print)
      end

      it 'prints an error message once' do
        expect(player_input).to receive(:print).with(error_message).once
        player_input.player_input(prompt, error_message)
      end
    end
  end
end
