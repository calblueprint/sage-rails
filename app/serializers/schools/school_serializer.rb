class SchoolSerializer < BaseSchoolSerializer
  has_many :users, serializer: UserListSerializer
  has_one :director, serializer: UserListSerializer
end
