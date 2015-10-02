class Api::V1::AnnouncmentsController < Api::V1::BaseController
  load_and_authorize_resource param_method: :announcements_params

  def index
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def announcements_params
    params.require(:announcment).permit(:title, :body, :school_id, :user_id)
  end
end
