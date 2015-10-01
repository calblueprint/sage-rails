class BaseCheckInSerializer < ActiveModel::Serializer
  attributes :start, :finish, :verified, :comment, :school_id, :user_id
end
