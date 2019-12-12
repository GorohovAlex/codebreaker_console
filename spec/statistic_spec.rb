RSpec.describe Statistic do
  before { @statistic = Statistic.new }

  it 'when statistic_get' do
    expect(@statistic.statistic_get).to be_a(Array)
  end

  it 'when statistic_add_item' do
    length_prev = @statistic.statistic_get.length
    difficulty = Difficulty.new(name: 'Easy', attempts: 15, hints: 2, level: 0)
    game_stage = GameStage.new(4, 10)
    stat = @statistic.statistic_add_item(name: '111', difficulty: difficulty, game_stage: game_stage)
    expect(stat.size).to eq(length_prev.next)
  end
end
