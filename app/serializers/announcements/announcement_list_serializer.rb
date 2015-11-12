class AnnouncementListSerializer < BaseAnnouncementSerializer
  has_one :user, serializer: UserAnnouncementSerializer
  has_one :school, serializer: SchoolAnnouncementSerializer

  def user
    object.user
  end

  def school
    object.school if object.school
  end
end
