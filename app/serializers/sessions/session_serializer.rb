class SessionSerializer < BaseSessionSerializer
  has_one :user, serializer: UserSerializer
  has_one :school, serializer: SchoolSessionSerializer
  has_one :user_semester, serializer: UserSemesterSerializer
  has_one :current_semester, serializer: SemesterListSerializer

  def user
    object
  end

  def school
    object.school
  end

  def user_semester
    semester = Semester.current_semester.first
    return nil unless semester
    UserSemester.find_by(user_id: object.id, semester_id: semester.id)
  end

  def current_semester
    Semester.current_semester.first
  end
end
