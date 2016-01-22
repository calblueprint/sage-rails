class SemesterSerializer < BaseSemesterSerializer
  has_many :users, each_serializer: UserListSerializer
  has_many :check_ins, each_serializer: CheckInListSerializer
end
