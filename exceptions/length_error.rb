class LengthError < StandardError
  def initialize(length)
    super('The length of the variable must be %s' % [length])
  end
end
