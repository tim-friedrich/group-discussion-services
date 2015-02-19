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
  has_one :survey

  belongs_to :role

  validates :email, presence: true, length: { maximum: 50 }
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validates :gender, presence: true, length: { maximum: 50 }
  #validates :email, uniqueness: true
  validates :birthday, presence: true

  accepts_nested_attributes_for :discussions


  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((
       now.month > birthday.month ||
       (now.month == birthday.month && now.day >= birthday.day)
    ) ? 0 : 1)
  end

  def age_category
    case age
    when 0..20
      "child"
    when 20..50
      "young"
    else
      "old"
    end
  end

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

  def has_survey?
    !!survey
  end

  def survey_required?
    is_proband?
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

  def is_proband?
    self.role == Role.where(name: 'proband').first
  end

  def is_guest?
    self.role == nil
  end

  def set_default_role
    self.role ||= Role.where(name: 'proband').first
    #save
  end
end
