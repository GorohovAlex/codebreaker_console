class CodebreakerConsole
  CONSOLE_STAGE_LIST = %w[welcome start start_game menu_select rules stats].freeze

  def initialize
    @stage = :menu_select
    @codebreaker_gem = Codebreaker::CodebreakerGem.new
    @game_console = GameConsole.new(@codebreaker_gem)
    @menu = Menu.new
  end

  def run
    welcome
    stage_set(@stage)
  end

  def self.goodbye
    print I18n.t('goodbye_message')
    exit
  end

  def self.input
    value = gets.chomp
    value == 'exit' ? goodbye : value
  end

  private

  def welcome
    puts I18n.t('introduction_message').light_white
  end

  def stats
    headings = @codebreaker_gem.statistic.headings.map { |value| I18n.t(value) }
    rows = @codebreaker_gem.statistic.statistic_get
    puts Terminal::Table.new(headings: headings, rows: rows)
    stage_set(:menu_select)
  end

  def statistic_save
    print I18n.t('statistic_save_question')
    return unless CodebreakerConsole.input == 'y'

    @codebreaker_gem.statistic_save
  end

  def rules
    print I18n.t('rules_message')
    menu_select
  end

  def menu_select
    print @menu.menu_to_s
    menu_response = @menu.change(CodebreakerConsole.input)
    menu_response[:status] ? stage_set(menu_response[:value]) : fail_menu_message
  end

  def stage_set(stage)
    system('clear')
    send(stage) if CONSOLE_STAGE_LIST.include?(stage.to_s)
  end

  def fail_menu_message
    puts I18n.t('fail_menu_message').light_red
    menu_select
  end

  def start
    puts I18n.t('game_registration')
    start unless input_username
    @game_console.difficulty_select
    game_start
  end

  def input_username
    print I18n.t('input_username')
    result = @codebreaker_gem.registration(CodebreakerConsole.input)
    if result[:status]
      @username = result[:value]
    else
      puts I18n.t(result[:value])
    end

    result[:status]
  end

  def game_start
    game_end(@game_console.start)
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
end
