class DiscussionsUser < ActiveRecord::Base
  COLORS       = ["#759399", "#cc6d6a", "#FFFCE8", "#ffb1ad", "#a6a6a6",
                  "#CCC1A3", "#C2CCA5", "#FFF29B", "#bbff99", "#c6bdd1"]
  MALE_NAMES   = ['Till', 'Ben', 'Paul', 'Karl', 'Leon', 'Felix', 'Max',
                  'Jan', 'Tom','Emil', 'Alex', 'Noah', 'Luis', 'Nick']
  FEMALE_NAMES = ['Lena', 'Mira', 'Jana', 'Anna', 'Marie', 'Pia', 'Tina',
                  'Nele', 'Klara', 'Sofia', 'Zoe', 'Greta', 'Viki', 'Julia']
  OTHER_NAMES  = MALE_NAMES + FEMALE_NAMES

  belongs_to :discussion
  belongs_to :user
  has_many :presences, :class_name => "DiscussionPresence"
  belongs_to :role

  validates :user, uniqueness: { scope: :discussion }
  after_create :set_defaults


  def set_color
    user_colors = DiscussionsUser.where(discussion_id: discussion.id).map{ |discussions_user|
      discussions_user.color
    }

    COLORS.each do |color|
      unless user_colors.include? color
        self.color = color
        self.save
        return self.color
      end
    end

    self.color = '#FFFFFF'
    self.save

    self.color
  end

  def enter_discussion
    DiscussionPresence.create(discussions_user_id: self.id, present: true)
  end

  def leave_discussion
    DiscussionPresence.create(discussions_user_id: self.id, present: false)
  end

  def is_present?
    if self.presences.last && self.presences.last.present
      return self.presences.last.present == true # FIXME what does that say?
    else
      return false
    end
  end

  def set_default_role
    self.role ||= Role.find_by_name('proband')
  end

  def set_name
    if self.role.name == 'moderator'
      self.name = 'Moderator'
    else
      if user.gender == "male"
        self.name = select_name_from(MALE_NAMES)
      elsif user.gender == "female"
        self.name = select_name_from(FEMALE_NAMES)
      elsif user.gender == "other"
        self.name = select_name_from(OTHER_NAMES)
      else
        self.name = "Unbekannt"
      end
    end
    self.save
  end

  def select_name_from(names)
    names = names.dup
    until names.empty?
      name = names.sample
      if discussion.discussions_users.find_by(name: name)
        names.delete(name)
      else
        return name
      end
    end
  end

  def set_defaults
    set_color
    set_default_role
    set_name
  end
end
