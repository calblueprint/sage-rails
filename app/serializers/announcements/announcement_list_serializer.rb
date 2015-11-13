class AnnouncementListSerializer < BaseAnnouncementSerializer
  has_one :user, serializer: UserNameSerializer
  has_one :school, serializer: SchoolNameSerializer

  def user
    object.user
  end

  def school
    object.school if object.school
  end
end
