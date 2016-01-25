class BaseUserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :role,
             :volunteer_type,
             :school_id,
             :director_id,
             :image_url,
             :verified

  has_one :user_semester, serializer: UserSemesterSerializer

  def role
    object[:role]
  end

  def volunteer_type
    object[:volunteer_type]
  end

  def user_semester
    current_semester = Semester.current_semester.first

    return nil unless serialization_options[:semester_id] || current_semester

    UserSemester.find_by(user_id: object.id,
                         semester_id: serialization_options[:semester_id] || current_semester.id)
  end
end
