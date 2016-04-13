class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin? || user.president?
      can :manage, :all
    end
  end
end
