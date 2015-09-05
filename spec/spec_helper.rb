ENV["RAILS_ENV"] = 'test'

require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'rspec/rails'
require 'sidekiq/testing'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    ActionMailer::Base.deliveries.clear

    DatabaseCleaner.cleaning do
      example.run
    end
  end


end
