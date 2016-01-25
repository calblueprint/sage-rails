class UserSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolNameSerializer
  has_one :semester, serializer: UserSemesterSerializer

  def semester
    current_semester = Semester.current_semester.first

    return nil unless serialization_options[:semester_id] || current_semester

    UserSemester.find_by(user_id: object.id,
                         semester_id: serialization_options[:semester_id] || current_semester.id)
  end
end
