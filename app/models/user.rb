class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_initialize :set_default_role
  has_many :votes
  has_many :discussions_users
  has_many :arguments
  has_many :discussions, through: :discussions_users
  has_and_belongs_to_many :research_institutes

  has_one :survey

  belongs_to :role

  validates :email, presence: true, length: { maximum: 100 }
  validates :firstname, presence: true, length: { maximum: 100 }
  validates :lastname, presence: true, length: { maximum: 100 }
  validates :gender, presence: true, length: { maximum: 10 }
  validates :country, presence: true, length: { maximum: 100 }
  validates :city, presence: true, length: { maximum: 100 }
  validates :phone, length: { maximum: 100 }
  validates :industry, length: { maximum: 100 }
  #validates :email, uniqueness: true
  validates :birthday, presence: true
  validates :zipcode, presence: true, length: { maximum: 10 }
  validates :pseudonym_policy, presence: true

  accepts_nested_attributes_for :discussions


  def age
    if birthday
      now = Time.now.utc.to_date
      now.year - birthday.year - ((
         now.month > birthday.month ||
         (now.month == birthday.month && now.day >= birthday.day)
      ) ? 0 : 1)
    else
      return 0
    end
  end

  def username(discussion)
    discussion.discussions_users.where(user_id: self.id).first.name
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

  def moderated_discussions
    # TODO do things like this on SQL level
    is_moderator? ? discussions.select{ |d| d.moderator == self } : []
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

  def is_admin?
    self.role == Role.where(name: 'admin').first
  end

	def is_staff?()
		self.role == Role.where(name: 'deputy').first || self.role == Role.where(name: 'moderator').first
  end

  def is_deputy?
    for research_institute in self.research_institutes
      return true if deputy_institute
    end
    return false
  end

  def deputy_institute
    for research_institute in self.research_institutes
      return research_institute if research_institute.deputy.id == self.id
    end
    return false
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


  def has_chart_image?
    ChartImage.exists?(self, Rails.env.test? && 'test')
  end

  def chart_image_path
    ChartImage.path_for(self, Rails.env.test? && 'test')
  end

  def ensure_chart_image!
    if !has_chart_image? && has_survey?
      generate_chart_image!
    end
  end

  def generate_chart_image!
    ChartImage.new(self, Rails.env.test? && 'test').generate!
  end
end
