class Ability
  include CanCan::Ability

  def initialize(user)
    # # #
    # Anonymous

    can [ :new, :create, :new_customer ], User
    return unless user


    # # #
    # User has no survey, yet

    if user.is_proband? && !user.has_survey?
      cannot :manage, :all
      can [ :new, :create ], Survey
      return
    end

    # # #
    # User is admin

    if user.is_admin?
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard
      can :manage, :all
      return
    end

     

    # # #
    # Every user

    can :manage, User, id: user.id

    #TODO: improve rights for Contacts
    can [ :manage ], Contact

    can [ :create, :read ], Argument do |argument|
      user.discussions.to_a.include? argument.discussion
    end
    cannot [ :invite ], User
    cannot :manage, Discussion

    can [ :leave, :show, :execute ], Discussion do |discussion|
      user.discussions.to_a.include?(discussion) && discussion.discussions_user_for(user).confirmed
    end

    can :manage, DiscussionsUser do |discussion_user|
      discussion_user.user.id == user.id
    end

    can [ :create ], Vote

    # # #
    # User is customer

    if user.is_customer?
      can [ :new, :create ], Discussion
    end
    
    # # #
    # Moderator

    if user.is_moderator?
      can :manage, Discussion do |discussion|
        user.id == discussion.moderator.id if discussion.moderator
      end

      can [ :new, :create ], Discussion

      can :manage, DiscussionsUser do |discussions_user|
        discussions_user.discussion.moderator.id == user.id if discussions_user.discussion.moderator
      end

      can :create, Question

      can :manage, VisualAid do |visual_aid|
        visual_aid.discussion.moderator.id == user.id
      end
      can [ :manage ], Company

      can [ :execute, :show ], User do |other_user|
        user.moderated_discussions.map(&:users).flatten.include? other_user
      end
    end

  end
end
