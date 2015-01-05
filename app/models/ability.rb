class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :manage, User, id: user.id
    can [ :new, :create ], ResearchInstitute
    can [ :new, :create ], User

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

    if !user.is_guest?

      #TODO: improve rights for Contacts
      can [ :manage ], Contact

      can [ :create, :read ], Argument do | argument |
        user.discussions.all.include? argument.discussion
      end

      can [ :leave, :show, ], Discussion do | discussion |
        user.discussions.all.include? discussion
      end

      can [ :create ], Vote

      can [ :manage ], ResearchInstitute do | research_institute |
        research_institute.deputy = user
      end
    end

    cannot :index, User

  end
end
