class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Admin and president abilities
    if !user.admin? && !user.president?
      return
    end

    can [
      :create,
      :update,
      :destroy,
    ], Announcement

    can [
      :update,
      :verify,
      :destroy,
    ], CheckIn

    can [
      :create,
      :update,
      :destroy,
    ], School

    can [
      :export,
    ], Semester

    can [
      :update,
    ], UserSemester

    can [:create,
      :verify,
      :promote,
      :status,
    ], User

    # President abilities only
    if !user.president?
      return
    end

    can [
      :create,
      :finish,
      :pause,
    ], Semester
  end
end
