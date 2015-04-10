class Role < ActiveRecord::Base
  has_many :users
  has_many :discussions_users

  ROLES = {
    user: 1,
    proband: 1,
    observer: 2,
    moderator: 2,
    admin: 4,
  }

  def self.create_defaults!
    ROLES.each{ |role, level|
      Role.create!(name: role.to_s, level: level) unless Role.public_send(role)
    }
  end

  ROLES.each{ |role,_|
    self.define_singleton_method role do
      Role.find_by_name(role.to_s)
    end
  }


  rails_admin do
    configure :users do
      label 'Owner of this ball: '
    end
    configure :discussions_users do
      label 'Owner of this ball: '
    end
  end
end
