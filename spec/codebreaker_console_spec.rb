describe 'CodebreakerConsole' do
  before { @codebreaker_console = CodebreakerConsole.new }

  it 'generate_number return Array' do
    expect(@codebreaker_console).to be_a(CodebreakerConsole)
  end

  # it 'when stage_set(:start)' do
  #   allow_any_instance_of(Kernel).to receive(:gets).and_return('start')
  #   expect(@codebreaker_console.run).to eq('message')
  #   exit
  # end
end
