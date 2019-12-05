class CodeBreakerConsole < BaseClass
  def initialize
    @state = :menu_select
    @game_console = GameConsole.new
    @codebreaker_gem = CodebreakerGem.new
    @statistic = Statistic.new
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

  def input
    value = gets.chomp
    goodbye if value == 'exit'
    value
  end

  def statistic_show
    system('clear')
    headings = @statistic.headings.map! { |value| I18n.t(value) }
    rows = @statistic.statistic_get
    puts Terminal::Table.new(headings: headings, rows: rows)
    set_state(:menu_select)
  end

  def statistic_save
    print 'Do you want to save the result? [y/n]: '
    return unless input == 'y'

    @statistic.statistic_add_item(name: @codebreaker_gem.username, difficulty: @codebreaker_gem.difficulty_change,
                                  game_stage: @codebreaker_gem.game_stage)
  end

  def fail_menu_message
    system('clear')
    puts I18n.t('fail_menu_message').light_red
    menu_select
  end

  def welcome
    system('clear')
    puts I18n.t('introduction_message').light_white
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
    @user.nil? ? registration : game_start
  end

  def game_start
    win = @game_console.start
    game_end(win)
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

  def registration
    system('clear')
    puts I18n.t('game_registration')
    username_input
    @codebreaker_gem.registration(@user.username)
    difficulty_change
    game_start
  end

  def username_input
    print I18n.t('input_username')
    @user = User.new(input)
    username_input unless @user.valide?
  end

  def difficulty_change
    print format(I18n.t('difficulty_change'), @codebreaker_gem.difficulty.map(&:name).join(', '))
    @game_console.difficulty_change = input
    difficulty_change if @game_console.difficulty_change.nil?
  end
end
