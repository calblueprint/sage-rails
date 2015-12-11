class BaseAnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :school_id, :user_id, :title, :body, :created_at, :category

  def category
    object[:category]
  end
end
