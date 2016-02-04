class SchoolSerializer < BaseSchoolSerializer
  has_many :users, serializer: UserNameSerializer
  # has_many :check_ins, serializer: CheckInListSerializer
  has_one :director, serializer: UserNameSerializer

  def users
    semester_id = serialization_options[:params].presence &&
                  serialization_options[:params][:semester_id].presence
    current_semester = Semester.current_semester.first
    semester_id = current_semester.id unless semester_id || !current_semester

    object.users.semester_id(semester_id).director_id(nil).sort_name
  end

  def check_ins
    semester_id = serialization_options[:params].presence &&
                  serialization_options[:params][:semester_id].presence
    current_semester = Semester.current_semester.first
    semester_id = current_semester.id unless semester_id || !current_semester

    object.check_ins.semester_id(semester_id).sort("created_at", "desc")
  end
end
