class Statistic
  attr_reader :name, :difficulty, :attempts_total, :attempts_used, :hints_total, :hints_used
  def initialize(name:, difficulty:, game_stage:)
    @rating = 0
    @name = name
    @difficulty = difficulty.name
    @attempts_total = game_stage.attempts
    @attempts_used = game_stage.step_number
    @hints_total = difficulty.hints
    @hints_used = game_stage.hint_used
  end
end
