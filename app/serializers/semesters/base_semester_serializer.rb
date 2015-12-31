class BaseSemesterSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish
end
