class Ability
  include CanCan::Ability

  def initialize(user)
    can :view, :all
  end
end
