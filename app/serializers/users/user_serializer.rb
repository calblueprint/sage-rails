class UserSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolListSerializer
end
