class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_initialize :set_default_role

  has_many :discussions_users
  has_many :arguments
  has_many :likes
  has_many :dislikes
  has_many :discussions, through: :discussions_users
  has_and_belongs_to_many :research_institutes  

  has_one :research_institute
  
  belongs_to :role

  validates :email, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 50 }
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validates :username, uniqueness: true
  #validates :email, uniqueness: true

  accepts_nested_attributes_for :discussions


  def full_name
    "#{firstname} #{lastname}"
  end

  def enter_discussion(discussion)
    DiscussionsUser.where(discussion_id: discussion.id, user_id: self.id).first.enter_discussion
  end

  def leave_discussion(discussion)
    DiscussionsUser.where(discussion_id: discussion.id, user_id: self.id).first.leave_discussion
  end

  def is_present_in(discussion)
    DiscussionsUser.where(discussion_id: discussion.id, user_id: self.id).last.is_present?
  end

  def is_part_of_discussion?(discussion)
    !discussion.users.find_by_id(self.id).nil?
  end

  def is_staff?()
    self.role == Role.where(name: 'deputy').first || self.role == Role.where(name: 'moderator').first
  end

  def is_deputy?
    self.role == Role.where(name: 'deputy').first
  end

  def is_moderator?
    self.role == Role.where(name: 'moderator').first
  end

  def is_guest?
    self.role == nil
  end

  def set_default_role
    self.role ||= Role.where(name: 'proband').first
    #save
  end
end
