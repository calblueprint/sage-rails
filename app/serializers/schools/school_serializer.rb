class SchoolSerializer < BaseSchoolSerializer
  has_many :users, serializer: UserListSerializer
  has_one :director, serializer: UserListSerializer

  def users
    object.users.director_id(nil)
  end
end
