class Like < ActiveRecord::Base
	belongs_to :argument
	belongs_to :user
	validates :user_id, presence:true
	validates :argument_id, presence:true
  	validates :user, uniqueness: { scope: :argument }
end
