class Question < ActiveRecord::Base
	belongs_to :discussion
	has_many :arguments
	
	validates :topic, presence:true
end
