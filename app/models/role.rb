class Role < ActiveRecord::Base
  has_many :users
  has_many :discussions_users


  def self.create_defaults!
    Role.create!(name: 'user',      level: 1) unless Role.find_by_name('user')
    Role.create!(name: 'proband',   level: 1) unless Role.find_by_name('proband')
    Role.create!(name: 'observer',  level: 2) unless Role.find_by_name('observer')
    Role.create!(name: 'moderator', level: 2) unless Role.find_by_name('moderator')
    Role.create!(name: 'deputy',    level: 3) unless Role.find_by_name('deputy')
    Role.create!(name: 'admin',     level: 4) unless Role.find_by_name('admin')
  end


  rails_admin do
    configure :users do
      label 'Owner of this ball: '
    end
    configure :discussions_users do
      label 'Owner of this ball: '
    end
  end
end
