$:.unshift File.expand_path("./../lib", __FILE__)

require 'bundler'
Bundler.require

require 'app'

# require File.expand_path("../../config/environment", __FILE__)
require 'capybara/rspec'
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Capybara::DSL
  config.color = true
  config.pattern    = 'spec/*_spec.rb'

 #  config.include Rails.application.routes.url_helpers
 #
 #  config.before(:suite) do
 #   DatabaseCleaner.clean_with(:truncation)
 # end
 #
 # config.before(:each) do
 #   DatabaseCleaner.strategy = :transaction
 # end
 #
 # config.before(:each) do
 #   DatabaseCleaner.start
 # end
 #
 # config.after(:each) do
 #   DatabaseCleaner.clean
 # end
  # ## Mock Framework
  
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  # config.order = "random"
end

Capybara.app = SliceWorksApp
