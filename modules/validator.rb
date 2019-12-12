module Validator
  def validate_number?(number)
    number.to_i.to_s == number
  end

  def validate_number_range?(number, range)
    range.to_a.include?(number.to_i)
  end

  def validate_length?(username, range)
    range.include?(username.length)
  end
end
