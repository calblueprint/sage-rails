class UserAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [
      :index,
      :show,
      :create,
      :update,
      :destroy,
      :state,
      :reset,
      :register,
    ], User, id: user.id

    can [
      :index,
      :show,
      :create,
    ], CheckIn, user_id: user.id

    can [
      :index,
    ], UserSemester, user_id: user.id

    can [
      :index,
      :show,
      :join,
    ], Semester

    can [
      :index,
      :show,
    ], Announcement

    can [
      :index,
      :show,
    ], School
  end
end
