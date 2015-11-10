class BaseAnnouncementSerializer < ActiveModel::Serializer
  attributes :school_id, :user_id, :title, :body, :created_at, :user_name, :school_name

  def created_at
    object.created_at.in_time_zone("Pacific Time (US & Canada)")
  end

  def user_name
    object.user.name
  end

  def school_name
    object.school.name if object.school
  end
end
