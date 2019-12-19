RSpec.describe GameConsole do
  let(:game_console) { described_class.new(Codebreaker::CodebreakerGem.new) }

  it 'set usercode' do
    # game_console.user_code = '1234'
    # expect(game_console.user_code).to eq(['1', '2', '3', '4'])
  end
end
