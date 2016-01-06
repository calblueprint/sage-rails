class Api::V1::AnnouncementsController < Api::V1::BaseController
  load_and_authorize_resource

  # Scopes
  has_scope :school_id
  has_scope :user_id
  has_scope :category
  has_scope :default
  has_scope :current_semester, type: :boolean

  def index
    render json: apply_scopes(Announcement).all, each_serializer: AnnouncementListSerializer
  end

  def show
    render json: @announcement, serializer: AnnouncementSerializer
  end
end
