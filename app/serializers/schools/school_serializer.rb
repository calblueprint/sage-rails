class SchoolSerializer < BaseSchoolSerializer
  has_many :users, serializer: UserListSerializer
end
