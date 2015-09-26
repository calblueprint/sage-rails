class SessionSerializer < BaseSessionSerializer
  has_one :user, serializer: UserSessionSerializer

  def user
    object
  end
end
