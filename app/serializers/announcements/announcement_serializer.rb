class AnnouncementSerializer < BaseAnnouncementSerializer
  has_one :user, serializer: UserListSerializer

  # TODO: Add this back when Kelsey fills in the school serializer
  # has_one :school, serializer: SchoolSerializer

  def user
    object.user
  end
end
