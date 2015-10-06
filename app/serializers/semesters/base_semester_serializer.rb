class BaseSemesterSerializer < ActiveModel::Serializer
  attributes :start, :finish, :created_at
end
