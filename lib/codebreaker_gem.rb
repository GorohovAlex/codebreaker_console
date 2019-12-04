require_relative 'difficulty.rb'
require_relative 'game_stage.rb'

class CodebreakerGem
  include Validation

  attr_reader :user_code, :username, :difficulty, :difficulty_change, :game_stage
  CODE_LENGTH = 4
  CODE_MIN_VALUE = 0
  CODE_MAX_VALUE = 6

  def initialize

    @user_code = []
    @username = ''
    init_difficulty
  end

  def init_difficulty
    @difficulty = []
    @difficulty << Difficulty.new(name: 'Easy', attempts: 15, hints: 2, level: 0)
    @difficulty << Difficulty.new(name: 'Medium', attempts: 10, hints: 1, level: 1)
    @difficulty << Difficulty.new(name: 'Hell', attempts: 5, hints: 1, level: 2)
  end

  def generate_number(min_value = 0, max_value = 6, length = CODE_LENGTH)
    Array.new(length) { rand(min_value..max_value) }
  end

  def user_code=(new_user_code)
    raise LengthError, CODE_LENGTH if new_user_code.length != CODE_LENGTH
    raise DigitValidationError unless new_user_code.split('').all? { |value| valid_number?(value) }

    @user_code = new_user_code.split('').map(&:to_i)

    @user_code_positions = get_code_positions(@user_code)
  end

  def difficulty_change=(difficulty_change)
    @difficulty_change = @difficulty.select { |value| value.name == difficulty_change }.first
    raise NotFoundError, difficulty_change if @difficulty_change.nil?
    @hint_code = @secret_code.sample(@difficulty_change.hints) unless @secret_code.nil?
  end

  def compare_codes
    puts "Secret code: #{@secret_code.join}"
    crossing_values = @secret_code & @user_code
    crossing_values.each_with_object([]) { |value, cross_result| cross_result << get_cross_value(value) }.flatten
  end

  def game_start
    @secret_code = generate_number
    @secret_code_positions = get_code_positions(@secret_code)
    @game_stage = GameStage.new(CODE_LENGTH, @difficulty_change.attempts)
    @game_stage
  end

  def game_step
    @game_stage.step(compare_codes)
    @game_stage
  end

  def registration(username)
    @username = username
  end

  def username=(username_new)
    raise LengthError, '<3' if username_new.length < 3
    raise LengthError, '>20' if username_new.length > 20

    @username = username_new
  end

  def hint_show
    @game_stage.hint_used += 1
    @hint_code.shift unless @hint_code.empty?
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
