RSpec.describe Menu do
  let(:menu) { described_class.new }

  it 'when menu_to_s' do
    expect(menu.menu_to_s).to eq(I18n.t('menu_message', menu_item: 'start, rules, stats, exit'))
  end

  it 'when change' do
    expect(menu.change('start')).to eq(status: true, value: :start)
  end

  it 'when change error' do
    expect(menu.change('start1111')).to eq(status: false, value: 'fail_menu_message')
  end
end
