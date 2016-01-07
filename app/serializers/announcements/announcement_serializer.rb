class AnnouncementSerializer < BaseAnnouncementSerializer
  has_one :user, serializer: UserListSerializer
  has_one :school, serializer: SchoolNameSerializer
end
