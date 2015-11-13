class CheckInListSerializer < BaseCheckInSerializer
  has_one :user, serializer: UserNameSerializer
  has_one :school, serializer: SchoolNameSerializer

  def user
    object.user
  end

  def school
    object.school
  end
end
