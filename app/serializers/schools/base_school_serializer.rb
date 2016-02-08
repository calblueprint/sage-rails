class BaseSchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :address, :student_count

  def student_count
    semester_id = serialization_options[:params].presence &&
                  serialization_options[:params][:semester_id].presence
    current_semester = Semester.current_semester.first
    semester_id = current_semester.id unless semester_id || !current_semester

    object.users.semester_id(semester_id).director_id(nil).size
  end
end
