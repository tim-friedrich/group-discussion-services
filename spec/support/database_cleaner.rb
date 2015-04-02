RSpec.configure do |config|
  config.before(:suite) do
    # DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.strategy = [:truncation, pre_count: true]
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      load Rails.root + "db/seeds.rb"
      example.run
    end
  end
end