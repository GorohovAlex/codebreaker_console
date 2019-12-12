class CodebreakerConsole
  CONSOLE_STAGE_LIST = %w[welcome start start_game menu_select rules stats].freeze

  def initialize
    @stage = :menu_select
    @codebreaker_gem = Codebreaker::CodebreakerGem.new
    @game_console = GameConsole.new(@codebreaker_gem)
    @statistic = Statistic.new
    @menu = Menu.new
  end

  def run
    welcome
    stage_set(@stage)
  end

  def welcome
    system('clear')
    puts I18n.t('introduction_message').light_white
  end

  def stats
    system('clear')
    headings = @statistic.headings.map { |value| I18n.t(value) }
    rows = @statistic.statistic_get
    puts Terminal::Table.new(headings: headings, rows: rows)
    stage_set(:menu_select)
  end

  def statistic_save
    print I18n.t('statistic_save_question')
    return unless CodebreakerConsole.input == 'y'

    @statistic.statistic_add_item(name: @codebreaker_gem.user.username, difficulty: @codebreaker_gem.difficulty_change,
                                  game_stage: @codebreaker_gem.game_stage)
    @statistic.statistic_save
  end

  def self.goodbye
    print I18n.t('goodbye_message')
    exit
  end

  def self.input
    value = gets.chomp
    self.goodbye if value == 'exit'
    value
  end

  private

  def menu_select
    print @menu.menu_to_s
    item = CodebreakerConsole.input
    menu_response = @menu.change(item)
    menu_response[:status] ? stage_set(menu_response[:value]) : fail_menu_message
  end

  def stage_set(stage)
    send(stage) if CONSOLE_STAGE_LIST.include?(stage.to_s)
  end

  def fail_menu_message
    system('clear')
    puts I18n.t('fail_menu_message').light_red
    menu_select
  end

  def rules
    system('clear')
    print I18n.t('rules_message')
    menu_select
  end

  def start
    system('clear')
    puts I18n.t('game_registration')
    print I18n.t('input_username')

    result = @codebreaker_gem.registration(CodebreakerConsole.input)
    result[:status] ? @username = result[:value] : registration

    @game_console.difficulty_select
    game_start
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
end
