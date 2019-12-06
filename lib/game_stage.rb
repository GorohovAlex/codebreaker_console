class GameStage
  attr_reader :step_number, :endgame, :attempts, :compare_result, :win
  attr_accessor :hint_used

  def initialize(user_code_length, attempts)
    @step_number = 1
    @endgame = false
    @attempts = attempts
    @compare_result = []
    @user_code_length = user_code_length
    @hint_used = 0
  end

  def step(compare_result)
    @compare_result = compare_result
    @step_number += 1
    @win = @compare_result.length == @user_code_length && @compare_result.all?
    @endgame = true if @step_number > @attempts || @win
  end
end
