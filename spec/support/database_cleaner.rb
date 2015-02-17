RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    #DatabaseCleaner.clean_with(:truncation)
    #DatabaseCleaner.strategy = :deletion
    #DatabaseCleaner.clean_with(:deletion)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      load Rails.root + "db/seeds.rb"
      example.run
    end
  end
end