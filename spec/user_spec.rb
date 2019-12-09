describe User do
  it 'when create user' do
    user = User.new('smile')
    expect(user.username).to eq('smile')
  end

  it 'when validate user' do
    user = User.new('smile')
    expect(user.valide?).to eq(true)
  end
end
