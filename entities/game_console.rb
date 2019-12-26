class GameConsole
  SYMBOL_GUESS = '+'.freeze
  SYMBOL_NOT_GUESS = '-'.freeze
  HINT_COMMAND = 'hint'.freeze

  def initialize(codebreaker_gem)
    @game_gem = codebreaker_gem
  end

  def difficulty_select
    print I18n.t('difficulty_change', difficulty: @game_gem.difficulties.map(&:name).join(', '))
    @game_gem.difficulty = CodebreakerConsole.input
    return true if @game_gem.errors.empty?

    puts I18n.t(@game_gem.errors[:difficulty])
    false
  end

  def start
    @game_gem.game_start
    puts I18n.t('about_hint_message')
    next_step
    @game_gem.game_stage.win
  end

  private

  def next_step
    game_stage = @game_gem.game_stage
    print I18n.t('step_message', step_number: game_stage.step_number, attempts: game_stage.attempts)
    user_code = CodebreakerConsole.input.strip

    hint_show if user_code == HINT_COMMAND
    next_step unless send_user_code(user_code) || game_stage.endgame
  end

  def send_user_code(user_code)
    compare_result = @game_gem.game_step(user_code.chars)
    unless compare_result
      puts I18n.t(@game_gem.errors[:match_code])
      return false
    end

    puts I18n.t('compare_result', result: result_format(compare_result))
    @game_gem.game_stage.endgame
  end

  def hint_show
    hint_code = @game_gem.hint_show
    if hint_code.nil?
      puts I18n.t('no_hints')
    else
      puts I18n.t('show_hint', hint: hint_code)
    end
  end

  def result_format(result)
    result.map { |value| value ? SYMBOL_GUESS : SYMBOL_NOT_GUESS }.join
  end
end
