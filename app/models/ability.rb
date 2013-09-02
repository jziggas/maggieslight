class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    #if user.admin?
    #  can :manage, :all
    #else

    # Users
    # A user can update an account if he owns it.
    can :update, User do |p|
      p.try(:user) == user
    end

    # Profiles
    # A user can create a profile if he is logged in.
    if User.exists?(user)
      can :create, [CareProviderProfile, CareReceiverProfile]
    end

    # Anyone can read profiles whether logged in or not
    # (hence User.new guest)
    can :read, :all

    # A user can update a profile if he owns it.
    can :update, CareProviderProfile do |p|
      p.try(:user) == user
    end
    can :update, CareReceiverProfile do |p|
      p.try(:user) == user
    end

    # A user can destroy a profile if he owns it.
    can :destroy, CareProviderProfile do |p|
      p.try(:user) == user
    end
    can :destroy, CareReceiverProfile do |p|
      p.try(:user) == user
    end

    # A user can flag a profile as inappropriate if he does not own it.
    can :flag, CareProviderProfile do |p|
      p.try(:user) != user
    end
    can :flag, CareReceiverProfile do |p|
      p.try(:user) != user
    end

    # Connections

    # A user can view a request if he is a part of it.
    can :read, Connection do |p|
      p.try(:care_receiver_profile_id) == user. || p.try(:requested) == user
    end

    # A user can make a request if he is logged in.
    if User.exists?(user)
      can :create, Connection
    end

    # A user can approve a request if he is the requested.
    can :update, Connection do |p|
      p.try(:requested) == user
    end

    # A user can destroy a request if he owns it (the requestor).
    can :destroy, Connection do |p|
      p.try(:requestor) == user
    end

    #end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
