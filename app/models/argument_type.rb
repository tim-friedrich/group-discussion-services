class ArgumentType < ActiveRecord::Base
  has_many :arguments


  def self.create_defaults!
    ArgumentType.create!(name: 'proband') unless ArgumentType.find_by_name('proband')
    ArgumentType.create!(name: 'moderator') unless ArgumentType.find_by_name('moderator')
    ArgumentType.create!(name: 'observer') unless ArgumentType.find_by_name('observer')
  end
end
