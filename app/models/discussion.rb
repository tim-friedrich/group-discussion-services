class Discussion < ActiveRecord::Base
	belongs_to :moderator, :class_name => "User", :foreign_key => "moderator_id"

	has_many :questions
	has_many :arguments
  has_many :discussions_users
	has_many :users, through: :discussions_users
	belongs_to :company

	validates :company_id, presence:true
	validates :moderator_id, presence:true
	validates :due_date, presence:true

  def research_institute
    self.moderator.research_institutes.first
  end
  def current_question
    self.questions.last
  end
end