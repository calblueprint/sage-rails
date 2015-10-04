class BaseAnnouncementSerializer < ActiveModel::Serializer
  attributes :school_id, :user_id, :title, :body
end
