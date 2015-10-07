class Api::V1::AnnouncementsController < Api::V1::BaseController
  load_and_authorize_resource

  def index
    render json: @announcements, each_serializer: AnnouncementListSerializer
  end

  def show
    render json: @announcement, serializer: AnnouncementSerializer
  end
end
