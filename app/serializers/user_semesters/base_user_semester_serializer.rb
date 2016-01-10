class BaseUserSemesterSerializer < ActiveModel::Serializer
  attributes :total_time, :completed, :status, :semester_id

  def status
    object[:status]
  end
end
