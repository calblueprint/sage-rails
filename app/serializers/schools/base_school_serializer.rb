class BaseSchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :address, :student_count

  def student_count
    object.users.size
  end
end
