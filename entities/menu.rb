class Menu
  FAIL_MENU_MESSAGE = 'fail_menu_message'.freeze
  MENU_ITEMS = %w[start rules stats exit].freeze

  def menu_to_s
    I18n.t('menu_message', menu_item: MENU_ITEMS.join(', '))
  end

  def change(item)
    MENU_ITEMS.include?(item) ? { status: true, value: item.to_sym } : { status: false, value: FAIL_MENU_MESSAGE }
  end
end
