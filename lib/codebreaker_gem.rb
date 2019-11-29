require_relative 'difficulty.rb'

class CodebreakerGem
  attr_reader :user_code, :username, :difficulty, :difficulty_change

  def initialize
    @secret_code = generate_number
    @secret_code_positions = get_code_positions(@secret_code)
    @user_code = Array.new(4, nil)
    @username = ''
    init_difficulty
  end

  def init_difficulty
    @difficulty = []
    @difficulty << Difficulty.new(name: 'Easy', attempts: 15, hints: 2)
    @difficulty << Difficulty.new(name: 'Medium', attempts: 10, hints: 1)
    @difficulty << Difficulty.new(name: 'Hell', attempts: 5, hints: 1)
  end

  def generate_number(min_value = 0, max_value = 6, length = 4)
    Array.new(length) { rand(min_value..max_value) }
  end

  def user_code=(new_user_code)
    @user_code = new_user_code.split('').map(&:to_i)
    @user_code_positions = get_code_positions(@user_code)
  end

  def difficulty_change=(difficulty_change)
    @difficulty_change = @difficulty.select { |value| value.name == difficulty_change }.first
  end

  def compare_codes
    # puts "Secret code: #{@secret_code.join}"
    crossing_values = @secret_code & @user_code
    crossing_values.each_with_object([]) { |value, cross_result| cross_result << get_cross_value(value) }.flatten
  end

  def start_game
    game = []
    game[:attempts] = @attempts
  end

  def registration(username_new)
    @username = username_new
  end

  private

  def get_cross_value(value)
    guess_position(value) + guess_value(value)
  end

  def guess_position(value)
    crossing_positions = @user_code_positions[value] & @secret_code_positions[value]
    crossing_positions.empty? ? [] : Array.new(crossing_positions.size, true)
  end

  def guess_value(value)
    user_code_positions = @user_code_positions.dup
    secret_code_positions = @secret_code_positions.dup

    crossing_positions = user_code_positions[value] & secret_code_positions[value]
    secret_code_positions[value] -= crossing_positions
    user_code_positions[value] -= crossing_positions

    size_no_cross_code = [secret_code_positions[value].size, user_code_positions[value].size].min
    crossing_positions.empty? && size_no_cross_code.zero? ? [] : Array.new(size_no_cross_code, false)
  end

  def get_code_positions(code_array)
    code_array
      .each_with_object(Hash.new([]))
      .with_index { |(value, code), index| code[value] += [index] }
  end
end
