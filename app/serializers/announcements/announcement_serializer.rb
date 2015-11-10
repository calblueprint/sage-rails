class AnnouncementSerializer < BaseAnnouncementSerializer
  has_one :user, serializer: UserListSerializer
  has_one :school, serializer: SchoolListSerializer

  def user
    object.user
  end

  def school
    object.school
  end
end
