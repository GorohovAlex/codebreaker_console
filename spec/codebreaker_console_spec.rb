STATS_EMPTY_TABLE = 'Rating.+Name.+Difficulty.+Attempts Total.+Attempts Used.+Hints Total.+Hints Used'.freeze

RSpec.describe CodebreakerConsole do
  let(:current_subject) { described_class.new }

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

    it 'fail menu message' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'ssss' }
      allow(current_subject).to receive(:menu_select)
      message = 'fail_menu_message'
      expect { current_subject.send(:fail_menu_message, message) }.to output(/#{I18n.t(message)}/).to_stdout
    end
  end

  context 'when show rules' do
    it 'show rules' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'rules' }
      allow(current_subject).to receive(:menu_select)
      expect { current_subject.send(:rules) }.to output(I18n.t('rules_message')).to_stdout
    end
  end

  context 'when show statistic' do
    it 'statistic show' do
      allow(described_class).to receive_message_chain(:gets, :chomp) { 'stats' }
      allow(current_subject).to receive(:menu_select)
      expect { current_subject.send(:stats) }.to output(/#{STATS_EMPTY_TABLE}/).to_stdout
    end
  end
end
