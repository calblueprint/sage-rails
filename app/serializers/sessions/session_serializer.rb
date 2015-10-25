class SessionSerializer < BaseSessionSerializer
  has_one :user, serializer: UserSessionSerializer
  has_one :school, serializer: SchoolSessionSerializer

  def user
    object
  end

  def school
    object.school
  end
end
