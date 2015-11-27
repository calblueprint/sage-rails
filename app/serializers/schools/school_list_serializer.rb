class SchoolListSerializer < BaseSchoolSerializer
  has_one :director, serializer: UserNameSerializer
end
