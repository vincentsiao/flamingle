class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.role? :administrator
      can :manage, :all
    elsif user.role? :moderator
      can :manage, Mission
    else
      can [:read, :create, :accept], Mission
      can :manage, Mission, :user_id => user.id
    end
   
    cannot :abandon, Mission
    can :abandon, Mission do |mission|
      mission.attempting_users.exists? user
    end
    cannot :accept, Mission do |mission|
      (mission.attempting_users.exists? user) || (mission.user == user)
    end
  end
end
