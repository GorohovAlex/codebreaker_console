class CodeBreaker
  def initialize; end

  def menu_select
    print I18n.t('menu_message').light_blue
    item = gets.chomp
    case item
    when 'exit'
      goodbye
    when 'rules'
      rules
    else
      fail_menu_message
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
    menu_select
  end

  def goodbye
    print I18n.t('goodbye_message')
  end

  def rules
    system('clear')
    print I18n.t('rules_message')
    menu_select
  end
end
