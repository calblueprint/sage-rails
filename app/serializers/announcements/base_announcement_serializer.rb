class BaseAnnouncementSerializer < ActiveModel::Serializer
  attributes :school_id, :user_id, :title, :body, :created_at, :name

  def name
    object.user.name
  end
end
