require_relative 'dependencies.rb'

system('clear')
# game_codebreaker = CodeBreaker.new
# game_codebreaker.welcome

codebreaker_gem = CodebreakerGem.new

# puts codebreaker_gem.generate_number.inspect
codebreaker_gem.user_code = '5643'
puts "User code: #{codebreaker_gem.user_code.join}"

puts "compare_codes: #{codebreaker_gem.compare_codes}"
