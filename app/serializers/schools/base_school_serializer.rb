class BaseSchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :address
end
