require './lib/codebreaker_gem'

describe CodebreakerGem do
  it 'generate_number return Array' do
    codebreaker_gem = CodebreakerGem.new
    expect(codebreaker_gem.generate_number).to be_a(Array)
  end
end
