require_relative 'dependencies.rb'

I18n.load_path = Dir[File.join('config', 'locales', '*.{rb,yml}')]
I18n.locale = :en

puts I18n.t('hello')
