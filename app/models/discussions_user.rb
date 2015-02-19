class DiscussionsUser < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user
  has_many :presences, :class_name => "DiscussionPresence"
  belongs_to :role

  validates :user, uniqueness: { scope: :discussion }
  after_create :set_defaults
  

    def set_color
      colors = [  "#759399", "#cc6d6a", "#FFFCE8", "#ffb1ad", "#a6a6a6",
            "#CCC1A3", "#C2CCA5", "#FFF29B", "#bbff99", "#c6bdd1"]
      user_colors = []

      DiscussionsUser.where(discussion_id: discussion.id).each do | discussions_user |
        user_colors.push(discussions_user.color)  
      end

      colors.each do | color |
        if not user_colors.include? color
          self.color = color 
          self.save
          return self.color
        end
      end
      self.color = '#FFFFFF'
      self.save
      return self.color
    end

  def enter_discussion
    DiscussionPresence.create(discussions_user_id:self.id, present:true)
  end

  def leave_discussion
    DiscussionPresence.create(discussions_user_id:self.id, present:false)
  end

  def is_present?
    if !self.presences.last.nil? && self.presences.last.present
      return self.presences.last.present == true
    else
      return false
    end
  end

  def set_default_role
    self.role ||= Role.where(name: 'proband').first
  end

  def set_name
    if self.role.name == 'moderator'
      self.name = 'moderator'
    else
      male_names = ['Till', 'Ben', 'Paul', 'Karl', 'Leon', 'Felix', 'Max', 'Jan', 'Tom', 'Emil', 'Alex', 'Noah', 'Luis', 'Nick']
      female_names = ['Lena', 'Mira', 'Jana', 'Anna', 'Marie', 'Pia', 'Tina', 'Nele', 'Klara', 'Sofia', 'Zoe', 'Greta', 'Viki', 'Julia']
      other_gender = male_names + female_names
      if user.gender == "male"
        self.name = select_name_from(male_names)
      elsif user.gender == "female"
        self.name = select_name_from(female_names)
      elsif user.gender == "other"
        self.name = select_name_from(other_gender)
      else
        self.name = "Unbekannt"
      end
    end
    self.save
  end

  def select_name_from(names)
    while !names.empty?
      name = names[Random.rand(names.length)]
      if !discussion.discussions_users.where(name: name).first.nil?
        names.delete(name)
      else
        return name
      end
    end
    return names[Random.rand(names.length)]
  end
  def set_defaults
    set_color
    set_default_role
    set_name
  end
end
