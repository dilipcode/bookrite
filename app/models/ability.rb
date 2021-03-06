class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    ##############
    # Authorship #
    ##############

    can :create, Authorship do |authorship|
        user.contributing_to(authorship.book)
    end

    can [:update, :destroy], Authorship do |authorship|
        authorship.invitee == user
    end
    can :destroy, Book do |book|
        book.owner == user
    end

    #########
    # Book #
    #########

    can :read, Book do |book|
        user.contributing_to(book)
    end
    can :create, Book do |book|
        true
    end

    can [:update, :destroy], Book do |book|
        book.owner == user
    end

    ###########
    # Chapter #
    ###########

    can :manage, Chapter do |chapter|
        chapter.book.owner == user
    end

    can :read, Chapter do |chapter|
        user.contributing_to(chapter.book)
    end

    ###########
    # Section #
    ###########

    can [:create, :destroy], Section do |section|
        section.chapter.book.owner == user
    end

    can [:read, :update], Section do |section|
        user.contributing_to(section.chapter.book)
    end


  end
end
