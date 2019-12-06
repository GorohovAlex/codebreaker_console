class BaseClass
  include Validator

  def valide?
    validate
    @errors.empty?
  end

  private

  def validate
    raise NoImpementatedError
  end
end
