class Api::V1::AnnouncmentsController < Api::V1::BaseController
  load_and_authorize_resource param_method: :announcements_params

  def index
    render json: @announcements, each_serializer: AnnouncementListSerializer
  end

  def show
    render json: @announcement, serializer: AnnouncementSerializer
  end

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
    params.require(:announcment).permit(:title, :body, :school_id, :user_id)
  end
end
