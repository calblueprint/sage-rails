class UserSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolSessionSerializer
  has_many :check_ins, each_serializer: CheckInSerializer

  def check_ins
    return [] unless serialization_options[:params] &&
                     serialization_options[:params][:semester_id] &&
                     serialization_options[:params][:check_ins]

    CheckIn.where(user_id: object.id,
                  semester_id: serialization_options[:params][:semester_id])
           .sort('created_at', 'desc')
  end
end
