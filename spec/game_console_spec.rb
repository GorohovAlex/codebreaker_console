RSpec.describe GameConsole do
  let(:current_subject) { described_class.new(Codebreaker::CodebreakerGem.new) }
  let(:game_gem) { instance_double('Codebreaker::CodebreakerGem') }
  let(:hint_number) { '0' }

  context 'when show hint' do
    it 'show hint success' do
      allow(game_gem).to receive(:hint_show).and_return(hint_number)
      current_subject.instance_variable_set(:@game_gem, game_gem)
      output_message = format(I18n.t('show_hint'), hint_number)
      expect { current_subject.send(:hint_show) }.to output(/#{output_message}/).to_stdout
    end

    it 'show hint ended' do
      hint_number = nil
      allow(game_gem).to receive(:hint_show).and_return(hint_number)
      current_subject.instance_variable_set(:@game_gem, game_gem)
      expect { current_subject.send(:hint_show) }.to output(/#{I18n.t('no_hints')}/).to_stdout
    end
  end
end
