class UserSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolNameSerializer
  has_one :current_semester, serializer: UserSemesterListSerializer

  def current_semester
    semester = Semester.current_semester.first
    return nil unless semester
    UserSemester.find_by(user_id: object.id, semester_id: semester.id)
  end
end
