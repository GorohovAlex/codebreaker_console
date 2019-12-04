class LengthError < StandardError
  def initialize(length)
    super('The length of the variable must be %d' % [length])
  end
end
