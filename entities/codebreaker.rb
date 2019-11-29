class CodeBreaker
  def initialize
    @state = :welcome
    @codebreaker_game = CodebreakerGem.new
  end

  def run
    welcome
    loop do
      set_state(@state)
    end
    goodbye
  end

  def menu_select
    print I18n.t('menu_message').light_blue
    item = gets.chomp
    case item
    when 'start' then set_state(:start)
    when 'start_game' then set_state(:start_game)
    when 'exit' then set_state(:exit)
    when 'rules' then set_state(:rules)
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
    end
  end

  def fail_menu_message
    system('clear')
    puts I18n.t('fail_menu_message').light_red
    menu_select
  end

  def welcome
    system('clear')
    puts I18n.t('introduction_message').light_white
    set_state(:menu_select)
  end

  def goodbye
    print I18n.t('goodbye_message')
  end

  def rules
    system('clear')
    print I18n.t('rules_message')
    menu_select
  end

  def start
    @codebreaker_game.username.empty? ? registration : start_game
  end

  def start_game
    game_stage = @codebreaker_game.start_game

    puts "Attempts count: #{game_stage[:attempts]}"

    attempts.times do |number|
      print "[%d/%d]: " % [number, game_stage[:attempts]]
      @codebreaker_game.user_code = gets.chomp
      puts "compare_codes: #{@codebreaker_game.compare_codes}"
    end

    gets
  end

  def registration
    system('clear')
    puts I18n.t('game_registration')
    print I18n.t('input_username')
    @codebreaker_game.registration(gets.chomp)
    difficulty_change
    # set_state(menu_select)
  end

  def difficulty_change
    print I18n.t('difficulty_change') % [@codebreaker_game.difficulty.map(&:name).join(', ')]
    @codebreaker_game.difficulty_change = gets.chomp
    start_game
  end
end
