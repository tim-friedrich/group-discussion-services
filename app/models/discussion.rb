class Discussion < ActiveRecord::Base

  has_many :questions
  has_many :arguments
  has_many :discussions_users
  has_many :users, through: :discussions_users
  has_many :visual_aids
  belongs_to :company


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

  def moderator=(user)
    users << user
    discussions_user = discussions_users.select{ | obj | obj.user.id == user.id }.first
    #discussions_user.save
    discussions_user.role = Role.where(name: 'moderator').first()
    discussions_user.confirmed = true
    discussions_user.save
  end

end