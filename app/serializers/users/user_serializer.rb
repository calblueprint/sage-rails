class UserSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolListSerializer
  has_one :current_semester, serializer: UserSemesterSerializer

  def current_semester
    semester = Semester.current_semester.first
    return nil if semester
    UserSemesterSerializer.find_by(user_id: object.id, semester_id: semester.id)
  end
end
