class UserSerializer < BaseUserSerializer
  has_one :school, serializer: SchoolNameSerializer
end
