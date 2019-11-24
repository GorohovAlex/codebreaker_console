class CodebreakerGem
  attr_reader :user_code

  def initialize
    @secret_code = generate_number
    @secret_code_positions = get_code_positions(@secret_code)
    @user_code = Array.new(4, nil)
    puts "Secret code: #{@secret_code.join}"
  end

  def generate_number(min_value = 0, max_value = 6, length = 4)
    Array.new(length) { rand(min_value..max_value) }
  end

  def user_code=(new_user_code)
    @user_code = new_user_code.split('').map(&:to_i)
    @user_code_positions = get_code_positions(@user_code)
  end

  def compare_codes
    crossing_values = @secret_code & @user_code
    crossing_values.each_with_object([]) { |value, cross_result| cross_result << get_cross_value(value) }.flatten
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
    user_code_positions = @user_code_positions
    secret_code_positions = @secret_code_positions

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
