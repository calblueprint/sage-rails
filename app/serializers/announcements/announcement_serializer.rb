class AnnouncementSerializer < BaseAnnouncementSerializer
  has_one :user, serializer: UserNameSerializer
  has_one :school, serializer: SchoolNameSerializer
end
