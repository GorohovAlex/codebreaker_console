STATS_EMPTY_TABLE = 'Rating.+Name.+Difficulty.+Attempts Total.+Attempts Used.+Hints Total.+Hints Used'.freeze

RSpec.describe CodebreakerConsole do
  let(:current_subject) { described_class.new }

  it 'generate_number return Array' do
    expect(current_subject).to be_a(described_class)
  end

  context 'when calling method' do
    after do
      current_subject.run
    end

    it 'start game input start' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'start' }
      expect(current_subject).to receive(:start)
    end

    it 'start game input rules' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'rules' }
      expect(current_subject).to receive(:rules)
    end

    it 'start game input stats' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'stats' }
      expect(current_subject).to receive(:stats)
    end
  end

  context 'when show rules' do
    it 'show rules' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'rules' }
      allow(current_subject).to receive(:menu_select)
      expect { current_subject.rules }.to output(/Codebreaker is a logic game in which a code-breaker/).to_stdout
    end
  end

  context 'when show statistic' do
    it 'statistic show' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'stats' }
      allow(current_subject).to receive(:menu_select)
      expect { current_subject.stats }.to output(/#{STATS_EMPTY_TABLE}/).to_stdout
    end
  end

  describe 'game' do
    before do
      commands = %w[start smile Hell 1234 1234 1234 1234 1234]
      allow(described_class).to receive_message_chain(:gets, :chomp).and_return(*commands)
    end

    after { current_subject.run }

    context 'when play game' do
      it 'lose endgame' do
        expect(current_subject).to receive(:game_end).with(false)
      end

      it 'win endgame' do
        game = current_subject.instance_variable_get(:@game_console)
        allow(game).to receive(:start).and_return(true)
        expect(current_subject).to receive(:game_end).with(true)
      end
    end
  end
end
