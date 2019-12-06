require_relative 'difficulty.rb'
require_relative 'game_stage.rb'

class CodebreakerGem
  include Validator

  attr_reader :user_code, :difficulty, :game_stage, :difficulty_change
  attr_accessor :username, :secret_code

  VALIDE_CODE_LENGTH = 4
  VALIDE_CODE_NUMBERS = (1..6).freeze

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

  def user_code=(new_user_code)
    @user_code = new_user_code
    @user_code_positions = get_code_positions(@user_code)
  end

  def difficulty_change=(difficulty_change)
    @difficulty_change = difficulty_change
    generate_hints
  end

  def game_start
    generate_secret_code
    @game_stage = GameStage.new(VALIDE_CODE_LENGTH, @difficulty_change.attempts)
    @game_stage
  end

  def game_step
    @game_stage.step(compare_codes)
    @game_stage
  end

  def registration(username)
    @username = username
  end

  def hint_show
    return if @hint_code.empty?

    @game_stage.hint_used += 1
    @hint_code.shift
  end

  private

  def compare_codes
    puts "Secret code: #{@secret_code.join}"
    crossing_values = @secret_code & @user_code
    crossing_values.each_with_object([]) { |value, cross_result| cross_result << get_cross_value(value) }
                   .flatten
                   .sort_by { |item| item ? 0 : 1 }
  end

  def generate_number(min_value: VALIDE_CODE_NUMBERS.min,
                      max_value: VALIDE_CODE_NUMBERS.max,
                      length: VALIDE_CODE_LENGTH)
    Array.new(length) { rand(min_value..max_value) }
  end

  def generate_secret_code
    @secret_code = generate_number
    @secret_code_positions = get_code_positions(@secret_code)
    generate_hints
  end

  def generate_hints
    @hint_code = @secret_code.nil? ? [] : @secret_code.sample(@difficulty_change.hints)
  end

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
