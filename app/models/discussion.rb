class Discussion < ActiveRecord::Base
	belongs_to :moderator, :class_name => "User", :foreign_key => "moderator_id"
	belongs_to :current_question, :class_name => "Question", :foreign_key => "current_question_id"
	has_many :questions
	has_many :arguments
	has_and_belongs_to_many :users

	validates :company_id, presence: true
	validates :moderator_id, presence: true
	validates :due_date, presence: true
	validates :current_question_id, presence: true

  	def research_institute
  		self.moderator.research_institutes.first
  	end
end
