RSpec.describe CodebreakerConsole do
  let(:current_subject) { described_class.new }

  context 'when create user' do
    it 'when wrong user name' do
      allow(described_class).to receive_message_chain(:gets, :chomp).and_return('na')
      expect { current_subject.send(:input_username) }.to output(/#{I18n.t('error_name_length')}/).to_stdout
    end
  end
end
