class BaseSessionSerializer < ActiveModel::Serializer
  attributes :email, :authentication_token
end
