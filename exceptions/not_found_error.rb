class NotFoundError < StandardError
  def initialize(variable_name = 'Variable')
    super("#{variable_name} is not found")
  end
end
