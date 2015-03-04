class Role < ActiveRecord::Base
  has_many :users
  has_many :discussions_users

  rails_admin do
    configure :users do
      label 'Owner of this ball: '
    end
    configure :discussions_users do
      label 'Owner of this ball: '
    end
  end
end
