class Ability
  include CanCan::Ability

  def initialize(user)
    # # #
    # Anonymous

    can [ :new, :create ], ResearchInstitute
    can [ :new, :create ], User

    return unless user


    # # #
    # User has no survey, yet

    if user.is_proband? && !user.has_survey?
      cannot :manage, :all
      can [ :new, :create ], Survey
      return
    end


    # # #
    # Every user

    can :manage, User, id: user.id
    cannot :index, User
    cannot :index, ResearchInstitute

    #TODO: improve rights for Contacts
    can [ :manage ], Contact

    can [ :create, :read ], Argument do | argument |
      user.discussions.to_a.include? argument.discussion
    end

    can [ :leave, :show, ], Discussion do | discussion |
      user.discussions.to_a.include? discussion
    end
    can :manage, DiscussionsUser do | discussion_user |
      discussion_user.user.id == user.id
    end

    can [ :create ], Vote

    can [ :manage ], ResearchInstitute do | research_institute |
      research_institute.deputy = user
    end


    # # #
    # Moderator

    if user.is_moderator?
      can :manage, Discussion do | discussion |
        user.id == discussion.moderator.id
      end

      can [ :new, :create ], Discussion

      can :manage, DiscussionsUser do | discussion_user |
        discussion_user.discussion.moderator.id == user.id
      end

      can :create, Question

      can :manage, VisualAid do | visual_aid |
        visual_aid.discussion.moderator.id == user.id
      end
      can [ :manage ], Company
    end


  end
end
