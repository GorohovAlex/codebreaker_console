class WrongCodeError < StandardError
  def initialize(variable_name = 'Variable')
    super("#{variable_name} is not valide")
  end
end
