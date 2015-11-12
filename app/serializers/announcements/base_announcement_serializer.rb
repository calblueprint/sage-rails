class BaseAnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :school_id, :user_id, :title, :body, :created_at

  def created_at
    object.created_at.in_time_zone("Pacific Time (US & Canada)")
  end
end
