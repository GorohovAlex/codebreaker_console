class User < BaseClass
  attr_reader :username

  VALIDE_NAME_RANGE = (3..20).freeze

  def initialize(username_new)
    @username = username_new
    @errors = []
  end

  private

  def validate
    @errors << I18n.t('error_name_length') unless validate_length?(@username, VALIDE_NAME_RANGE)
  end
end
