class BaseCheckInSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish, :verified, :comment, :school_id, :user_id
end
