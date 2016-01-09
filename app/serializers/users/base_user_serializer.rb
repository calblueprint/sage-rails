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
             :verified,
             :status

  def role
    object[:role]
  end

  def volunteer_type
    object[:volunteer_type]
  end

  def status
    object[:status]
  end
end
