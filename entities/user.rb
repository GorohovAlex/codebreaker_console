class User < BaseClass
  attr_reader :username

  def initialize(username_new)
    @username = username_new
    @errors = []
  end

  private

  def validate
    @errors << I18n.t('error_name_length') unless validate_length?(@username, USERNAME_LENGTH_RANGE)
  end
end
