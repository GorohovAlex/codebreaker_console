class Menu
  def initialize
    @items = %w[start rules stats exit]
  end

  def menu_to_s
    I18n.t('menu_message') % @items.join(', ')
  end

  def change(item)
    @items.include?(item) ? { status: true, value: item.to_sym } : { status: false, value: 'error' }
  end
end
