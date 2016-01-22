class BaseUserSemesterSerializer < ActiveModel::Serializer
  attributes :id, :total_time, :completed, :status, :semester_id, :hours_required

  def status
    object[:status]
  end
end
