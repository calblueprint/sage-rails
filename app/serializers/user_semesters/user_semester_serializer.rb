class UserSemesterSerializer < BaseUserSemesterSerializer
  has_many :check_ins, each_serializer: CheckInListSerializer

  def check_ins
    CheckIn.semester_id(object.semester_id)
           .user_id(object.user_id)
           .sort('created_at', 'desc')
  end
end
