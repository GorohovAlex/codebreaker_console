class GameConsole < BaseClass
  attr_reader :difficulty_change

  VALIDE_CODE_LENGTH = 4
  VALIDE_CODE_NUMBERS = (1..6).freeze

  def initialize
    @game_gem = CodebreakerGem.new
  end

  def start
    @game_stage = @game_gem.game_start
    puts "Attempts count: #{@game_stage.attempts}"
    puts "Enter your answer or 'hint' to get a hint"

    next_step
    @game_stage.win
  end

  def next_step
    print format('[%<number>d/%<attempts>d]: ', number: @game_stage.step_number, attempts: @game_stage.attempts)

    answer = input.strip
    answer == 'hint' ? hint_show : (next_step unless send_user_code(answer))

    next_step unless @game_stage.endgame
  end

  def send_user_code(code)
    return unless validate_length?(code, VALIDE_CODE_LENGTH..VALIDE_CODE_LENGTH)
    unless code.split('').all? { |val| validate_number?(val) && validate_number_range?(val, VALIDE_CODE_NUMBERS) }
      return
    end

    @game_gem.user_code = code
    @game_stage = @game_gem.game_step
    puts "compare_result: #{compare_result(@game_stage.compare_result)}"
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

  def difficulty_change=(difficulty)
    @difficulty_change = @game_gem.difficulty.select { |value| value.name == difficulty }.first
    @game_gem.difficulty_change = @difficulty_change
  end
end
