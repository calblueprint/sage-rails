class UserStateSerializer < ActiveModel::Serializer
  has_one :user, serializer: UserSerializer
  has_one :school, serializer: SchoolNameSerializer
  has_one :user_semester, serializer: SemesterListSerializer

  def user
    object
  end

  def school
    object.school
  end

  def user_semester
    Semester.current_semester
  end
end
