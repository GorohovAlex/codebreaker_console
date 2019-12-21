class Menu
  FAIL_MENU_MESSAGE = 'fail_menu_message'

  def initialize
    @items = %w[start rules stats exit]
  end

  def menu_to_s
    I18n.t('menu_message') % @items.join(', ')
  end

  def change(item)
    @items.include?(item) ? { status: true, value: item.to_sym } : { status: false, value: FAIL_MENU_MESSAGE }
  end
end
