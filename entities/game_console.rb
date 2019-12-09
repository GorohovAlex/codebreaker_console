class GameConsole < BaseClass
  attr_reader :difficulty_change, :user_code

  VALIDE_CODE_LENGTH = 4
  VALIDE_CODE_NUMBERS = (1..6).freeze

  def initialize
    @game_gem = CodebreakerGem::CodebreakerGem.new
  end

  def difficulty_change=(difficulty)
    @difficulty_change = @game_gem.difficulty.detect { |value| value.name == difficulty }
    @game_gem.difficulty_change = @difficulty_change
  end

  def start
    @game_stage = @game_gem.game_start
    puts I18n.t('attempts_count') % @game_stage.attempts
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
    self.user_code = CodebreakerConsole.input.strip
    @user_code == HINT_COMMAND ? hint_show : (next_step unless send_user_code)
    next_step unless @game_stage.endgame
  end

  def send_user_code
    puts @user_code.inspect
    @game_gem.user_code = @user_code
    @game_stage = @game_gem.game_step
    puts I18n.t('compare_result') % compare_result(@game_stage.compare_result)
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
