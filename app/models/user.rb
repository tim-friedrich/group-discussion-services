class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         # :lockable, :timeoutable and :omniauthable

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
  # validates :pseudonym_policy, presence: true

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

  def username_in(discussion)
    discussions_users.find_by(discussion: discussion).name
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

  def discussion_user_for(discussion)
    discussions_users.find_by(discussion_id: discussion.id)
  end

  def enter_discussion(discussion)
    discussion_user_for(discussion).enter_discussion
  end

  def leave_discussion(discussion)
    discussion_user_for(discussion).leave_discussion
  end

  def is_present_in(discussion)
    discussion_user_for(discussion).is_present?
  end

  def is_part_of_discussion?(discussion)
    !!discussion.users.find_by_id(self.id)
  end

  def has_survey?
    !!survey
  end

  def survey_required?
    is_proband?
  end

  # TODO use cancan for this
  def can_manage_discussion?(discussion)
    self.id == discussion.moderator.id
  end

  # # #
  # Assocs

  def in_discussions
    discussions_users.includes(:discussion)
  end

  def preferred_research_institute
    research_institutes.first # FIXME why
  end

  def deputy_institute
    for research_institute in self.research_institutes
      return research_institute if research_institute.deputy.id == self.id
    end
    return false
  end


  # # #
  # Roles

  def is_moderator?
    self.role == Role.find_by_name('moderator')
  end

  def is_proband?
    self.role == Role.find_by_name('proband')
  end

  def is_guest?
    self.role == nil
  end

  def is_admin?
    self.role == Role.find_by_name('admin')
  end

  def is_staff?
    self.role == Role.find_by_name('deputy') || self.role == Role.find_by_name('moderator')
  end

  def is_deputy?
    for research_institute in self.research_institutes
      return true if deputy_institute # FIXME that does not work as it should
    end
    return false
  end

  def set_default_role
    self.role ||= Role.find_by_name('proband')
    #save
  end


  # # #
  # Chart

  def has_chart_image?
    UserChartImage.exists?(self, Rails.env.test? && 'test')
  end

  def chart_image_path
    UserChartImage.path_for(self, Rails.env.test? && 'test')
  end

  def ensure_chart_image!
    if !has_chart_image? && has_survey?
      generate_chart_image!
    end
  end

  def generate_chart_image!
    UserChartImage.new(self, Rails.env.test? && 'test').generate!
  end
end
