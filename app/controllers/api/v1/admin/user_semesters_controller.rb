class Api::V1::Admin::UserSemestersController < Api::V1::Admin::BaseController
  load_and_authorize_resource

  def update
    if @user_semester.update_attributes(user_semester_params)
      render json: @user_semester, serializer: UserSemesterSerializer
    else
      error_response(nil, "Something went wrong, try again later.")
    end
  end

  private

  def user_semester_params
    params.require(:user_semester).permit(:status)
  end
end
