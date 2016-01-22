class SchoolSerializer < BaseSchoolSerializer
  has_many :users, serializer: UserNameSerializer
  has_many :check_ins, serializer: CheckInListSerializer
  has_one :director, serializer: UserNameSerializer

  def users
    object.users.director_id(nil)
  end
end
