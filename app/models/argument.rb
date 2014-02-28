class Argument < ActiveRecord::Base
	belongs_to :question
	belongs_to :user
	belongs_to :argument_type
	belongs_to :discussion
	has_many :likes
	has_many :dislikes
	
	#validates :content, presence:true
	#validates :user_id, presence:true
	#validates :question_id, presence:true
	#validates :argument_type, presence:true
end
