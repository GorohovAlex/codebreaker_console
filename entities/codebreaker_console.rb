class CodebreakerConsole < BaseClass
  CONSOLE_STAGE_LIST = %w[welcome start start_game menu_select rules statistic_show].freeze

  def initialize
    @stage = :menu_select
    @game_console = GameConsole.new
    @codebreaker_gem = CodebreakerGem.new
    @statistic = Statistic.new
  end

  def run
    welcome
    stage_set(@stage)
  end

  def menu_select
    print I18n.t('menu_message').light_blue
    item = CodebreakerConsole.input

    case item
    when 'start' then stage_set(:start)
    when 'start_game' then stage_set(:start_game)
    when 'rules' then stage_set(:rules)
    when 'stats' then stage_set(:stats)
    else
      fail_menu_message
    end
  end

  def stage_set(stage)
    send(stage) if CONSOLE_STAGE_LIST.include?(stage.to_s)
  end

  def self.input
    value = gets.chomp
    goodbye if value == 'exit'
    value
  end

  def statistic_show
    system('clear')
    headings = @statistic.headings.map! { |value| I18n.t(value) }
    rows = @statistic.statistic_get
    puts Terminal::Table.new(headings: headings, rows: rows)
    stage_set(:menu_select)
  end

  def statistic_save
    print I18n.t('statistic_save_question')
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

    stage_set(:menu_select)
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
    @user = User.new(CodebreakerConsole.input)
    username_input unless @user.valide?
  end

  def difficulty_change
    print format(I18n.t('difficulty_change'), @codebreaker_gem.difficulty.map(&:name).join(', '))
    @game_console.difficulty_change = CodebreakerConsole.input
    difficulty_change if @game_console.difficulty_change.nil?
  end
end
