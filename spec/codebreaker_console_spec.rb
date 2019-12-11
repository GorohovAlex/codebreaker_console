RSpec.describe CodebreakerConsole do
  let(:current_subject) { described_class.new }

  it 'generate_number return Array' do
    expect(current_subject).to be_a(CodebreakerConsole)
  end

  context 'when calling method' do
    after do
      current_subject.run
    end

    it 'start game input start' do
      allow(CodebreakerConsole).to receive_message_chain(:gets, :chomp) { 'start' }
      expect(current_subject).to receive(:start)
    end

    it 'start game input rules' do
      allow(CodebreakerConsole).to receive_message_chain(:gets, :chomp) { 'rules' }
      expect(current_subject).to receive(:rules)
    end

    it 'start game input stats' do
      allow(CodebreakerConsole).to receive_message_chain(:gets, :chomp) { 'stats' }
      expect(current_subject).to receive(:stats)
    end
  end

  context 'user_code' do
    it 'input not valid code' do
      commands = %w[start smile Hell 123]
      allow(CodebreakerConsole).to receive_message_chain(:gets, :chomp).and_return(*commands)
      expect(current_subject).to receive(:game_end).with(false)
      current_subject.run
    end
  end

  describe 'game' do
    before do
      commands = %w[start smile Hell 1234 1234 1234 1234 1234]
      allow(CodebreakerConsole).to receive_message_chain(:gets, :chomp).and_return(*commands)
    end

    context 'when play game' do
      it 'lose endgame' do
        expect(current_subject).to receive(:game_end).with(false)
      end

      it 'win endgame' do
        game = current_subject.instance_variable_get(:@game_console)
        allow(game).to receive(:start).and_return(true)
        expect(current_subject).to receive(:game_end).with(true)
      end

      after { current_subject.run }
    end
  end


end
