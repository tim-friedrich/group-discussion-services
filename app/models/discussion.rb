class Discussion < ActiveRecord::Base
  STATES = %w[open closed]

  has_many :questions
  has_many :arguments
  has_many :discussions_users
  has_many :users, through: :discussions_users
  has_many :visual_aids

  validates :due_date, presence: true
  validates :state, inclusion: { in: STATES }


  def probands
    DiscussionsUser.where(discussion: self, role: Role.proband)
  end

  def observers
    DiscussionsUser.where(discussion: self, role: Role.observer)
  end

  def customer
    DiscussionsUser.where(discussion: self, role: Role.customer).first.user if DiscussionsUser.where(discussion: self, role: Role.customer).first
  end

  def customer=(user)
    if self.customer
      DiscussionsUser.where(discussion: self, role: Role.customer).first.delete
    end
    discussions_user = discussions_users.build(
      user: user,
      discussion: self,
      role: Role.customer,
      confirmed: true,
    )
    discussions_user.save!
    discussions_user.set_name
  end

  def discussions_user_for(user)
    discussions_users.find_by(user: user)
  end

  def discussions_users_with_users
    discussions_users.includes(:role, user: [:role])
  end

  def current_question
    self.questions.last
  end

  def moderator
    discussions_users_with_users.find{ |user|
      user.role == Role.moderator
    }.try(:user)
  end

  def customer
    discussions_users_with_users.find{ |user|
      user.role == Role.customer
    }.try(:user)
  end

  def confirmed_discussions_users
    confirmed_users = []
    discussions_users.each do |discussions_user|
      if discussions_user.confirmed?
        confirmed_users << discussions_user
      end
    end
    return confirmed_users
  end

  def moderator=(user)
    moderator = discussions_user_for(moderator)
    moderator.delete if moderator
    if user
      discussions_user = discussions_users.build(
        user: user,
        role: Role.moderator,
        confirmed: true,
      )
      discussions_user.save!
      discussions_user.set_name
    end
  end

  def moderator_avatar
    moderator.avatar.present? ? moderator.avatar.url(:discussion) : 'Unknown-person.gif'
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