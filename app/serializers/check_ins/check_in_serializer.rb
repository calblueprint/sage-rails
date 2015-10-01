class CheckInSerializer < BaseCheckInSerializer
  has_one :user, serializer: UserListSerializer
  # TODO: Put this back in when Kelsey finishes schools
  # has_one :school, serializer: SchoolListSerializer

  def user
    object.user
  end
end
