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

    #This ability class gets instantiated and used automatically by the CanCanCan gem. There is an assumption that you have methods in the controller to get the current user. The method name is 'current_user'

    def initialize(user)
      user ||= User.new

      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end

      can :manage, Question do |q|
        user == q.user
      end

      can :manage, Answer do |a|
        #this enforces that the logged in user must be either the owner of the answer or the owner for the question that the answer references.
        user == a.user || user == answer.question.user
      end

    end
  end
end
