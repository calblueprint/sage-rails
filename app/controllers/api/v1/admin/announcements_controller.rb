class Api::V1::Admin::AnnouncementsController < Api::V1::Admin::BaseController
  load_and_authorize_resource

  def create
    if @announcement.save
      render json: @announcement, serializer: AnnouncementSerializer
    else
      error_response(@announcement)
    end
  end

  def update
    if @announcement.update_attributes(announcements_params)
      render json: @announcement, serializer: AnnouncementSerializer
    else
      error_response(@announcement)
    end
  end

  def destroy
    if @announcement.destroy
      render json: @announcement, serializer: AnnouncementSerializer
    else
      error_response(@announcement)
    end
  end

  private

  def announcements_params
    params.require(:announcement).permit(:title, :body, :school_id, :user_id, :category)
  end
end
