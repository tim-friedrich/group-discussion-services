class UserRelation < ActiveRecord::Base
  include HasRole

  belongs_to :user
  belongs_to :institute, polymorphic: true
  belongs_to :role
end
