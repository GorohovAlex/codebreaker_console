describe CodebreakerGem do
  before { @codebreaker_gem = CodebreakerGem.new }

  context 'compare code' do
    it 'verificate code' do
      [
        [[6, 5, 4, 1], [6, 5, 4, 1], [true, true, true, true]],
        [[1, 2, 2, 1], [2, 1, 1, 2], [false, false, false, false]],
        [[6, 2, 3, 5], [2, 3, 6, 5], [true, false, false, false]],
        [[1, 2, 3, 4], [4, 3, 2, 1], [false, false, false, false]],
        [[1, 2, 3, 4], [1, 2, 3, 5], [true, true, true]], [[1, 2, 3, 4], [5, 4, 3, 1], [true, false, false]],
        [[1, 2, 3, 4], [1, 5, 2, 4], [true, true, false]], [[1, 2, 3, 4], [4, 3, 2, 6], [false, false, false]],
        [[1, 2, 3, 4], [3, 5, 2, 5], [false, false]], [[1, 2, 3, 4], [5, 6, 1, 2], [false, false]],
        [[5, 5, 6, 6], [5, 6, 0, 0], [true, false]], [[1, 2, 3, 4], [6, 2, 5, 4], [true, true]],
        [[1, 2, 3, 1], [1, 1, 1, 1], [true, true]], [[1, 1, 1, 5], [1, 2, 3, 1], [true, false]],
        [[1, 2, 3, 4], [4, 2, 5, 5], [true, false]], [[1, 2, 3, 4], [5, 6, 3, 5], [true]],
        [[1, 2, 3, 4], [6, 6, 6, 6], []], [[1, 2, 3, 4], [2, 5, 5, 2], [false]]
      ].each do |item|
        @codebreaker_gem.difficulty_change = Difficulty.new(name: 'Easy', attempts: 15, hints: 2, level: 0)
        @codebreaker_gem.should_receive(:generate_number).and_return(item[0])
        @codebreaker_gem.game_start
        @codebreaker_gem.user_code = item[1]
        @codebreaker_gem.game_step
        expect(@codebreaker_gem.game_stage.compare_result).to eq(item[2])
      end
    end
  end
end
