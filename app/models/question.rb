class Question < ActiveRecord::Base
	belongs_to :group_discussion
	has_many :arguments
	validates :topic, presence:true
end
