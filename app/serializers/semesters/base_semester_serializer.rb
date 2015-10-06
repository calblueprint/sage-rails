class BaseSemesterSerializer < ActiveModel::Serializer
  attributes :start, :finish, :create_at
end
