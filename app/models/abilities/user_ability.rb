class UserAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, User, id: user.id
    can :manage, CheckIn, user_id: user.id
    can :manage, UserSemester, user_id: user.id
    can :read, Semester
    can :read, Announcement
    can :read, School
  end
end
