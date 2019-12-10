RSpec.describe GameConsole do
  before { @game_console = GameConsole.new(Codebreaker::CodebreakerGem.new) }

  it 'set usercode' do
    @game_console.user_code = '1234'
    expect(@game_console.user_code).to eq([1, 2, 3, 4])
  end

  it 'when difficulty_change' do
    # expect(@game_console.difficulty_change("Hell")).to eq('11')
  end
end
