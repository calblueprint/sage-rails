class UserListSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolNameSerializer

  def school
    object.school
  end
end
