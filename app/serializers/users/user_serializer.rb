class UserSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolNameSerializer
  has_many :check_ins, each_serializer: CheckInSerializer

  def check_ins
    return [] unless serialization_options &&
                     serialization_options[:params][:semester_id] &&
                     serialization_options[:params][:check_ins]

    CheckIn.where(semester_id: serialization_options[:params][:semester_id])
           .sort('created_at', 'desc')
  end
end
