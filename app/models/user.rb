class User < ActiveRecord::Base
  include HasRole

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         # :lockable, :timeoutable and :omniauthable

  after_initialize :set_default_role
  has_many :votes
  has_many :discussions_users
  has_many :arguments
  has_many :discussions, through: :discussions_users

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

  has_attached_file :avatar, styles: { discussion: ["60x60#", :png] }
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]


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
  # class Methods

  def self.probands
    User.where(role: Role.find_by_name('proband'))
  end

  def self.moderators
    User.where(role: Role.find_by_name('moderator'))
  end

  # # #
  # Assocs

  def in_discussions
    discussions_users.includes(:discussion)
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
