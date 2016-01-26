class SessionSerializer < BaseSessionSerializer
  has_one :user, serializer: UserSerializer
  has_one :school, serializer: SchoolSessionSerializer
  has_one :current_semester, serializer: SemesterListSerializer

  def user
    object
  end

  def school
    object.school
  end

  def current_semester
    Semester.current_semester.first
  end
end
