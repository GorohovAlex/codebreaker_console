module Validation
  def valid_number?(number)
    /^[0-6]{1}$/.match number
  end
end
