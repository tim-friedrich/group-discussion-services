class Discussion < ActiveRecord::Base
	belongs_to :moderator, :class_name => "User", :foreign_key => "moderator_id"
	belongs_to :current_question, :class_name => "Question", :foreign_key => "current_question_id"
	has_many :questions
	has_many :arguments
end
