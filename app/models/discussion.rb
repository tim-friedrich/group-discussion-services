class Discussion < ActiveRecord::Base
  STATES = %w[open closed]

  has_many :questions
  has_many :arguments
  has_many :discussions_users
  has_many :users, through: :discussions_users
  has_many :visual_aids
  belongs_to :company


  validates :due_date, presence: true
  validates :state, inclusion: { in: STATES }


  def discussions_user_for(user)
    discussions_users.find_by(user: user)
  end

  def discussions_users_with_users
    discussions_users.includes(:role, user: [:role])
  end

  def research_institute
    self.moderator.preferred_research_institute
  end
  def current_question
    self.questions.last
  end

  def moderator
    discussions_users_with_users.find{ |user|
      user.role == Role.find_by_name('moderator')
    }.try(:user)
  end

  def moderator=(user)
    discussions_user = discussions_users.build(
      user: user,
      role: Role.find_by_name('moderator'),
      confirmed: true,
    )
    discussions_user.save!
    discussions_user.set_name
  end

  def open?
    state == 'open'
  end

  def closed?
    state == 'closed'
  end

  def open(message)
    self.state_message = message
    self.state = 'open'
    self.save!
  end

  def close(message)
    self.state_message = message
    self.state = 'closed'
    self.save!
  end
end