class Discussion < ActiveRecord::Base

	has_many :questions
	has_many :arguments
  has_many :discussions_users
	has_many :users, through: :discussions_users
  has_many :visual_aids
	belongs_to :company

	validates :company_id, presence:true
	validates :due_date, presence:true

  def research_institute
    self.moderator.research_institutes.first
  end
  def current_question
    self.questions.last
  end

  def moderator
    for user in self.discussions_users do
      if user.role == Role.where(name: 'moderator').first()
        return user.user
      end
    end
    return nil
  end
end