class UserFieldOption < ActiveRecord::Base
  belongs_to :additional_user_field
  has_and_belongs_to_many :user_additional_user_fields

end
