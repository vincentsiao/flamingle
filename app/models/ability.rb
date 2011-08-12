class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.try(:role).try(:name) == 'administrator'
      can :manage, :all
    elsif user.try(:role).try(:name) == 'moderator'
      can :manage, Mission
    else
      can :create, Mission
      can :manage, Mission do |mission|
        # try if mission is nil
        mission.try(:user) == user
      end
      can :read, :all
    end
  end
end
