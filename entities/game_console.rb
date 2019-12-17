class GameConsole
  include Validator

  attr_reader :user_code, :difficulty_change

  VALIDE_CODE_LENGTH = 4
  VALIDE_CODE_NUMBERS = (1..6).freeze

  def initialize(codebreaker_gem)
    @game_gem = codebreaker_gem
  end

  def difficulty_select
    print format(I18n.t('difficulty_change'), @game_gem.difficulty.map(&:name).join(', '))
    @difficulty_change = CodebreakerConsole.input
    @game_gem.difficulty_change = @difficulty_change
  end

  def start
    @game_stage = @game_gem.game_start
    puts I18n.t('about_hint_message')
    next_step
    @game_stage.win
  end

  def user_code=(code_new)
    return unless validate_length?(code_new, VALIDE_CODE_LENGTH..VALIDE_CODE_LENGTH)

    unless code_new.split('').all? { |val| validate_number?(val) && validate_number_range?(val, VALIDE_CODE_NUMBERS) }
      return
    end

    @user_code = code_new.chars.map(&:to_i)
  end

  private

  def next_step
    print format(I18n.t('step_message'), @game_stage.step_number, @game_stage.attempts)
    @user_code = CodebreakerConsole.input.strip
    @user_code == HINT_COMMAND ? hint_show : (next_step unless send_user_code)
    next_step unless @game_stage.endgame
  end

  def send_user_code
    compare_result = @game_gem.game_step(user_code.chars)
    unless compare_result
      puts I18n.t(@game_gem.errors[:user_code])
      return false
    end

    puts I18n.t('compare_result') % compare_result(compare_result)
    @game_stage.endgame
  end

  def hint_show
    hint_code = @game_gem.hint_show
    if hint_code.nil?
      puts I18n.t('no_hints')
    else
      puts format(I18n.t('show_hint'), hint_code)
    end
  end

  def compare_result(result)
    result.map { |value| value ? SYMBOL_GUESS : SYMBOL_NOT_GUESS }.join
  end
end
