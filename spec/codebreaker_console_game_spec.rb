RSpec.describe CodebreakerConsole do
  let(:current_subject) { described_class.new }

  describe 'game' do
    context 'when play game' do
      let(:commands) { %w[start smile Hell 1234 1234 1234 1234 1234] }

      before { allow(described_class).to receive_message_chain(:gets, :chomp).and_return(*commands) }

      after { current_subject.run }

      it 'lose endgame' do
        expect(current_subject).to receive(:game_end).with(false)
      end

      it 'show message lose endgame' do
        allow(current_subject).to receive(:menu_select)
        expect { current_subject.send(:game_end, false) }.to output(/#{I18n.t('lose_message')}/).to_stdout
      end

      it 'win endgame' do
        game = current_subject.instance_variable_get(:@game_console)
        allow(game).to receive(:start).and_return(true)
        expect(current_subject).to receive(:game_end).with(true)
      end

      it 'show message win endgame' do
        allow(current_subject).to receive(:menu_select)
        expect { current_subject.send(:game_end, true) }.to output(/#{I18n.t('win_message')}/).to_stdout
      end
    end
  end
end
