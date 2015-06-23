class UsersAdditionalUserField < ActiveRecord::Base
  belongs_to :user
  belongs_to :additional_user_field
  has_and_belongs_to_many :user_field_options

  
end
