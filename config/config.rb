SYMBOL_GUESS = '+'.freeze
SYMBOL_NOT_GUESS = '-'.freeze

HINT_COMMAND = 'hint'.freeze

STAT_FILE_PATH = 'store/statistic.yml'.freeze
STAT_HEADER_LIST = %w[rating name difficulty attempts_total attempts_used hints_total hints_used].freeze

USERNAME_LENGTH_RANGE = (3..20).freeze

I18n.load_path = Dir[File.join('config', 'locales', '*.{rb,yml}')]
I18n.locale = :en
