class BaseUserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :role,
             :volunteer_type,
             :school_id,
             :director_id,
             :image_url,
             :total_time,
             :verified
end
