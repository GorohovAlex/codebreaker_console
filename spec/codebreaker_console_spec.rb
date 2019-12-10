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

  describe '#game' do
    context 'when play game' do
      it 'lose endgame' do
        commands = %w[start smile Hell 1234 1234 1234 1234 1234]
        allow(CodebreakerConsole).to receive_message_chain(:gets, :chomp).and_return(*commands)
        expect(current_subject).to receive(:game_end).with(false)
        current_subject.run
      end

      # it 'win endgame' do
      #   commands = %w[start smile Hell 1234 1234 1234 1234 1234]
      #   allow(CodebreakerConsole).to receive_message_chain(:gets, :chomp).and_return(*commands)
      #   expect(current_subject).to receive(:game_end).with(true)
      #   current_subject.run
      # end
    end
  end
end
