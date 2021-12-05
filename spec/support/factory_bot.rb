require 'capybara/rspec'

# ...

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end
