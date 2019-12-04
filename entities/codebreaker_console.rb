class CodeBreaker
  def initialize
    @state = :menu_select
    @codebreaker_game = CodebreakerGem.new
  end

  def input
    value = gets.chomp
    case value
    when 'exit'
      goodbye
    end
    value
  end

  def run
    welcome
    set_state(@state)
  end

  def menu_select
    print I18n.t('menu_message').light_blue
    item = input
    case item
    when 'start' then set_state(:start)
    when 'start_game' then set_state(:start_game)
    when 'rules' then set_state(:rules)
    when 'stats' then set_state(:stats)
    else
      fail_menu_message
    end
  end

  def set_state(state)
    case state
    when :welcome then welcome
    when :start then start
    when :start_game then start_game
    when :menu_select then menu_select
    when :rules then rules
    when :stats then statistic_show
    end
  end

  def statistic_show
    system('clear')
    statistic = YamlFile
                .load('store/statistic.yml')
                .sort_by { |stat| [stat.attempts_total + stat.hints_total, stat.attempts_used, stat.hints_used] }

    rows = statistic.each_with_index.map do |value, index|
      [index + 1, value.name, value.difficulty, value.attempts_total,
       value.attempts_used, value.hints_total, value.hints_used]
    end

    headings = %w[rating name difficulty attempts_total attempts_used hints_total hints_used]
    headings.map! { |value| I18n.t(value) }

    puts Terminal::Table.new(headings: headings, rows: rows)
    set_state(:menu_select)
  end

  def fail_menu_message
    system('clear')
    puts I18n.t('fail_menu_message').light_red
    menu_select
  end

  def welcome
    system('clear')
    puts I18n.t('introduction_message').light_white
    # set_state(:menu_select)
  end

  def goodbye
    print I18n.t('goodbye_message')
    exit
  end

  def rules
    system('clear')
    print I18n.t('rules_message')
    menu_select
  end

  def start
    @codebreaker_game.username.empty? ? registration : game_start
  end

  def game_start
    game_stage = @codebreaker_game.game_start
    puts "Attempts count: #{game_stage.attempts}"
    puts "Enter your answer or 'hint' to get a hint"

    until game_stage.endgame
      begin
        print format('[%d/%d]: ', game_stage.step_number, game_stage.attempts)
        answer = input.strip

        case answer
        when 'hint'
          hint_code = hint
          if hint_code.nil?
            puts I18n.t('no_hints')
          else
            puts format(I18n.t('show_hint'), hint_code)
          end
        else

          @codebreaker_game.user_code = answer
          game_stage = @codebreaker_game.game_step
          puts "compare_result: #{compare_result(game_stage.compare_result)}"
        end
      rescue LengthError => e
        puts e.message
        retry
      rescue DigitValidationError => e
        puts e.message
        retry
      end
    end
    game_end(game_stage.win)
  end

  def compare_result(result)
    result.map { |value| value ? SYMBOL_GUESS : SYMBOL_NOT_GUESS }.join
  end

  def hint
    @codebreaker_game.hint_show
  end

  def game_end(win)
    if win
      puts I18n.t('win_message')
      statistic_save
    else
      puts I18n.t('lose_message')
    end

    set_state(:menu_select)
  end

  def statistic_save
    print 'Do you want to save the result? [y/n]: '
    answer = input
    return unless answer == 'y'

    @statistic = YamlFile.load('store/statistic.yml')
    stat = Statistic.new(name: @codebreaker_game.username, difficulty: @codebreaker_game.difficulty_change, game_stage: @codebreaker_game.game_stage)
    @statistic << stat
    YamlFile.save('store/statistic.yml', @statistic)
  end

  def registration
    system('clear')
    puts I18n.t('game_registration')
    @codebreaker_game.registration(username_input)

    begin
      @codebreaker_game.difficulty_change = difficulty_change
    rescue NotFoundError => e
      puts e.message
      retry
    end
    game_start
  end

  def username_input
    print I18n.t('input_username')
    input
  end

  def difficulty_change
    print format(I18n.t('difficulty_change'), @codebreaker_game.difficulty.map(&:name).join(', '))
    input
  end
end
