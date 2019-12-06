require 'i18n'
require 'colorize'
require 'terminal-table'

require_relative 'modules/yaml_file'
require_relative 'modules/validator'

# require_relative 'exceptions/not_found_error.rb'
# require_relative 'exceptions/length_error.rb'
# require_relative 'exceptions/digit_validation_error.rb'

require_relative 'config/config.rb'

require_relative 'entities/base_class.rb'
require_relative 'entities/statistic.rb'
require_relative 'entities/user.rb'
require_relative 'entities/game_console.rb'
require_relative 'entities/codebreaker_console.rb'

require_relative 'lib/codebreaker_gem'
